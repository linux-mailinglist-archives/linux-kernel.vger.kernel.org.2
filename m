Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D193B6F84
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhF2IiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 04:38:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33656 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhF2IiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 04:38:18 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47C7C2262F;
        Tue, 29 Jun 2021 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624955750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNcSddb7LkNOY2sD9BKB65RH0RpaihYrfM4k7wfrToQ=;
        b=GGWugPDZNZwpPFrqhF1+99WOyfPKwKo+L0jM62dplVe//uSkSm/u/05lYNeCYWVNxBllMF
        lHFa4yIf5BzEluR4WFQ/PY8IigjXRYvsx/WIhznJJwu+AWKQUw+m4dNPuxj9ydYw/tGx3w
        g6BM4kX4pknu06j9DoCpqqCOnEOVzDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624955750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNcSddb7LkNOY2sD9BKB65RH0RpaihYrfM4k7wfrToQ=;
        b=UWlP9iL+uC0wm5e09Aj0gKSVRrdD9aet1aXPRluMiz3CySvXtLqtCxo+5Po3k6oduxQlXQ
        6SAA+8LegHerPkCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2A4FB11906;
        Tue, 29 Jun 2021 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624955750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNcSddb7LkNOY2sD9BKB65RH0RpaihYrfM4k7wfrToQ=;
        b=GGWugPDZNZwpPFrqhF1+99WOyfPKwKo+L0jM62dplVe//uSkSm/u/05lYNeCYWVNxBllMF
        lHFa4yIf5BzEluR4WFQ/PY8IigjXRYvsx/WIhznJJwu+AWKQUw+m4dNPuxj9ydYw/tGx3w
        g6BM4kX4pknu06j9DoCpqqCOnEOVzDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624955750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNcSddb7LkNOY2sD9BKB65RH0RpaihYrfM4k7wfrToQ=;
        b=UWlP9iL+uC0wm5e09Aj0gKSVRrdD9aet1aXPRluMiz3CySvXtLqtCxo+5Po3k6oduxQlXQ
        6SAA+8LegHerPkCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id mQKvCWbb2mDJPwAALh3uQQ
        (envelope-from <dwagner@suse.de>); Tue, 29 Jun 2021 08:35:50 +0000
Date:   Tue, 29 Jun 2021 10:35:49 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Wen Xiong <wenxiong@us.ibm.com>, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <20210629083549.unco3f7atybqypw3@beryllium.lan>
References: <YNqL+3LDsIPKm1ol@T590>
 <YNp1Bho5yypHkPfW@T590>
 <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20210628090703.apaowrsazl53lza4@beryllium.lan>
 <YNmdhqd+W3XbJCwd@T590>
 <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
 <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
 <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
 <YNqX6w8YHO61oqvY@T590>
 <20210629082542.vm3yh6k36d2zh3k5@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629082542.vm3yh6k36d2zh3k5@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:25:43AM +0200, Daniel Wagner wrote:
> On Tue, Jun 29, 2021 at 11:47:55AM +0800, Ming Lei wrote:
> > >    >>data.ctx = __blk_mq_get_ctx(q, cpu);
> > >    cpu=2048 if hctx_idx = 4
> > 
> > Yeah, that is the issue I mentioned, any CPU in hctx->cpumask becomes
> > offline, please try the following patch and see if it makes a
> > difference:
> 
> Given that cpumask_first_and() will return nr_cpu_ids in this case,
> can't we just bail out here and have to caller handle the error?

To answer my own question, you want to avoid adding the if into the
hotpath.
