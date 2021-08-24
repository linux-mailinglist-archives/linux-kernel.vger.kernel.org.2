Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E269B3F5F77
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhHXNtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:49:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55954 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbhHXNtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:49:15 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EBC942209E;
        Tue, 24 Aug 2021 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629812910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GT3SmtXIOdQpOv7U9TlSYCVsuxmf5fTKn+506gv5IZw=;
        b=GxyFEVtEhRzP9l/Wah4AwVdFN3Gcmr1GxywIjXTIdJIbfzapFiiY7kJE+Ucph4NrnJN/vb
        vAZUIEzYo1gAYOiK67TEI00TqbFuD7zutOxok96aK98MX/+UEGjjGs/fy0IxeoYv3G0MxL
        QlxGhLeVUAT1AuKX+MohJ6CBJnOngVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629812910;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GT3SmtXIOdQpOv7U9TlSYCVsuxmf5fTKn+506gv5IZw=;
        b=1XytS3pPNRH/C5ZKx25mGjTo5sNWOCpVKo4X7IPZ/WMFBt9YtfLR4fp0nxL4YgSG+qew1n
        OS8SJV/iO7dKlwCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DD01713A50;
        Tue, 24 Aug 2021 13:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YH2LNa74JGF9OAAAGKfGzw
        (envelope-from <dwagner@suse.de>); Tue, 24 Aug 2021 13:48:30 +0000
Date:   Tue, 24 Aug 2021 15:48:30 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <20210824134830.gdl4vojwhlsoypne@carbon.lan>
References: <20210811152803.30017-1-dwagner@suse.de>
 <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
 <20210824134457.x33n7ihoe23jhyfx@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824134457.x33n7ihoe23jhyfx@carbon.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 03:44:58PM +0200, Daniel Wagner wrote:
> On Mon, Aug 23, 2021 at 10:16:23AM -0700, Sagi Grimberg wrote:
> > > +void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
> > > +{
> > > +	struct nvme_ns_head *head = ns->head;
> > > +	sector_t capacity = get_capacity(head->disk);
> > > +	int node;
> > > +
> > > +	for_each_node(node)
> > > +		rcu_assign_pointer(head->current_path[node], NULL);
> > > +
> > > +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> > > +		if (capacity != get_capacity(ns->disk))
> > > +			clear_bit(NVME_NS_READY, &ns->flags);
> > > +	}
> > 
> > Shouldn't the null setting to current_path come after
> > we clear NVME_NS_READY on the ns? Otherwise we may still
> > submit and current_path will be populated with the ns
> > again...
> 
> Ahh, I got it this time! Yes, you are right. I think Christoph has
> dropped this patch from the nvme-5.15 queue anyway. I'll resend a new
> version with the order changed.

I am blind. The patch is queued up in nvme-5.15.

@Christoph, do you want me to send fix on top of this patch or do you
want an updated version of this patch?
