Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E863FDD4E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbhIANcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbhIANcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:32:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203D0C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K3tF+rChzBAy3/zQjofFRGa93sGagjdwDcqwfVIhtBA=; b=NBMAiW8XbPBAhNYPVye4c642hu
        13noUHhGzgX2NeJ0DZum8mClFRQ0vkJ+wahg/Nnckq+2E0HcU1imic37nyVOiqG34orLUlLseqbup
        RXHNo1o30on3KtKPik7GspWK6nhqbffjMsiFA7/06jj/ah/6NnSFEGHJ6ZWKcpxyKO3XAzE0eCI16
        I3l3lyma85vdOgIcXBuSUiN0YdRcjng7tFzMJH2KPQd1CcXcQcaGm19XY8XKrGPjy5tdX2jU1s/hO
        BIjrdg0oonRNZFymghl1I+g2XSRUtCv1ZRnAXgzZX5Z8YjwYf3TLq6KkIo+6AkpdjbX+YEId5Ty6C
        mz/Ar+OQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLQJc-002OQv-FL; Wed, 01 Sep 2021 13:30:17 +0000
Date:   Wed, 1 Sep 2021 14:30:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v1] nvme: avoid race in shutdown namespace removal
Message-ID: <YS+AYA+5/o8Qj08Q@infradead.org>
References: <20210830093618.97657-1-dwagner@suse.de>
 <20210830100443.b2zkdp4l3vi2gz42@carbon.lan>
 <742108c3-7c76-0bc3-fc13-06acf975c25c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <742108c3-7c76-0bc3-fc13-06acf975c25c@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 07:14:02PM +0200, Hannes Reinecke wrote:
> On 8/30/21 12:04 PM, Daniel Wagner wrote:
> > On Mon, Aug 30, 2021 at 11:36:18AM +0200, Daniel Wagner wrote:
> > > Though one thing I am not really sure how it interacts with
> > > nvme_init_ns_head() as we could be in running nvme_init_ns_head()
> > > after we have set last_path = true. I haven't really figured
> > > out yet what this would mean. Is this a real problem?
> > 
> > I suspect it will regress the very thing 5396fdac56d8 ("nvme: fix
> > refcounting imbalance when all paths are down") tried to fix.
> > 
> Most likely. Do drop me a mail on how to create a reproducer for that; it's
> not exactly trivial as you need to patch qemu for that
> (and, of course, those patches will not go upstream as they again hit a
> section which the maintainer deemed to be reworked any time now. So of
> course he can't possibly apply them.)
> (I seem to have a particular spell of bad luck, seeing that it's the _third_
> time this happened to me :-( )

Soo.  What is the problem in simply checking in nvme_find_ns_head that
h->list is non-empty?  E.g. this variant of the patch from Daniel:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d535b00d65816..ce91655fa29bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3523,7 +3523,9 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (h->ns_id == nsid && nvme_tryget_ns_head(h))
+		if (h->ns_id != nsid)
+			continue;
+		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
 			return h;
 	}
 
@@ -3835,7 +3837,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	mutex_unlock(&ns->ctrl->subsys->lock);
+	if (list_empty(&ns->head->list)) {
+		list_del_init(&ns->head->entry);
+		last_path = true;
+	}
+	mutex_unlock(&ns->head->subsys->lock);
 
 	/* guarantee not available in head->list */
 	synchronize_rcu();
@@ -3855,13 +3861,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	list_del_init(&ns->list);
 	up_write(&ns->ctrl->namespaces_rwsem);
 
-	/* Synchronize with nvme_init_ns_head() */
-	mutex_lock(&ns->head->subsys->lock);
-	if (list_empty(&ns->head->list)) {
-		list_del_init(&ns->head->entry);
-		last_path = true;
-	}
-	mutex_unlock(&ns->head->subsys->lock);
 	if (last_path)
 		nvme_mpath_shutdown_disk(ns->head);
 	nvme_put_ns(ns);
