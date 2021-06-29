Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F73B6F60
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhF2I2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 04:28:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41596 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhF2I2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 04:28:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3582A203A0;
        Tue, 29 Jun 2021 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624955143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbMPs8lfp7DAJiGmeNL7OnW/w+tsl+PEThIBkrDu+7k=;
        b=YHP9hlZf73EaeJtsq0QyZRj9H8/sxB7yFhkQSY/r6pDGQ6cMuV6J6g8qGOmpdMJZ0TyPfG
        x0WfVJOvUY8E6qYWmI5TH/lqaNZiuqCMoxwZChETGI4dyNaANtLZdJmpwpWwuUAPfX841Z
        1yGBdNsBFno+hbqQ806FKwPXSX+dZh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624955143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbMPs8lfp7DAJiGmeNL7OnW/w+tsl+PEThIBkrDu+7k=;
        b=tvOENhi0+KLGkTfSsUJfsFXgjGlScE2I4+zjVokj1Ub1Vo0WAPlgO/YL8/Zn7PrrY5Y13w
        hhUNHmQKCdCubvDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1B4AA11906;
        Tue, 29 Jun 2021 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624955143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbMPs8lfp7DAJiGmeNL7OnW/w+tsl+PEThIBkrDu+7k=;
        b=YHP9hlZf73EaeJtsq0QyZRj9H8/sxB7yFhkQSY/r6pDGQ6cMuV6J6g8qGOmpdMJZ0TyPfG
        x0WfVJOvUY8E6qYWmI5TH/lqaNZiuqCMoxwZChETGI4dyNaANtLZdJmpwpWwuUAPfX841Z
        1yGBdNsBFno+hbqQ806FKwPXSX+dZh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624955143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbMPs8lfp7DAJiGmeNL7OnW/w+tsl+PEThIBkrDu+7k=;
        b=tvOENhi0+KLGkTfSsUJfsFXgjGlScE2I4+zjVokj1Ub1Vo0WAPlgO/YL8/Zn7PrrY5Y13w
        hhUNHmQKCdCubvDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id SU+wBQfZ2mD+OQAALh3uQQ
        (envelope-from <dwagner@suse.de>); Tue, 29 Jun 2021 08:25:43 +0000
Date:   Tue, 29 Jun 2021 10:25:42 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Wen Xiong <wenxiong@us.ibm.com>, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <20210629082542.vm3yh6k36d2zh3k5@beryllium.lan>
References: <YNqL+3LDsIPKm1ol@T590>
 <YNp1Bho5yypHkPfW@T590>
 <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20210628090703.apaowrsazl53lza4@beryllium.lan>
 <YNmdhqd+W3XbJCwd@T590>
 <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
 <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
 <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
 <YNqX6w8YHO61oqvY@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNqX6w8YHO61oqvY@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 11:47:55AM +0800, Ming Lei wrote:
> >    >>data.ctx = __blk_mq_get_ctx(q, cpu);
> >    cpu=2048 if hctx_idx = 4
> 
> Yeah, that is the issue I mentioned, any CPU in hctx->cpumask becomes
> offline, please try the following patch and see if it makes a
> difference:

Given that cpumask_first_and() will return nr_cpu_ids in this case,
can't we just bail out here and have to caller handle the error? I am
able to reproduce the crash you reported in [1] and the fix [2] here
works for me:

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -469,6 +469,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
        if (!blk_mq_hw_queue_mapped(data.hctx))
                goto out_queue_exit;
        cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+       if (cpu >= nr_cpu_ids)
+               goto out_queue_exit;
        data.ctx = __blk_mq_get_ctx(q, cpu);
 
        if (!q->elevator)

[1] https://lore.kernel.org/linux-block/20191117041233.GA30615@ming.t460p/
[2] https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/
