Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559E83B704E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhF2JwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:52:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47200 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhF2JwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:52:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 499712266C;
        Tue, 29 Jun 2021 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624960179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SF0LHB5o9wZqoVi72ldF9j6uXPwn1FRh7Y6gGVVC+Ks=;
        b=vrSPJkcby5A+XnJDIJhzzP+odgK0LyzEhhz3EHjj6lOn5ML2AJsGVPOB+zuoKR/iRihoeD
        A/yAoMyzos8EGTnhzQQQdD0rdk0K/MDZy9ZNP6c5mfFt3TZkvc1UheYD+meZrStMuryI74
        +GgIlKXrFnD4pjyWQ86Py528zHTKirA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624960179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SF0LHB5o9wZqoVi72ldF9j6uXPwn1FRh7Y6gGVVC+Ks=;
        b=fErPY05CcmEkmHctSmVdmoKdmLjXz0ENDedhU/WLa9xaEz5WeVk0dAm8NATpYyIAJupwFk
        2H1YpUT35jMmZMCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 30AE111906;
        Tue, 29 Jun 2021 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624960179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SF0LHB5o9wZqoVi72ldF9j6uXPwn1FRh7Y6gGVVC+Ks=;
        b=vrSPJkcby5A+XnJDIJhzzP+odgK0LyzEhhz3EHjj6lOn5ML2AJsGVPOB+zuoKR/iRihoeD
        A/yAoMyzos8EGTnhzQQQdD0rdk0K/MDZy9ZNP6c5mfFt3TZkvc1UheYD+meZrStMuryI74
        +GgIlKXrFnD4pjyWQ86Py528zHTKirA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624960179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SF0LHB5o9wZqoVi72ldF9j6uXPwn1FRh7Y6gGVVC+Ks=;
        b=fErPY05CcmEkmHctSmVdmoKdmLjXz0ENDedhU/WLa9xaEz5WeVk0dAm8NATpYyIAJupwFk
        2H1YpUT35jMmZMCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 1u7gCrPs2mBubAAALh3uQQ
        (envelope-from <dwagner@suse.de>); Tue, 29 Jun 2021 09:49:39 +0000
Date:   Tue, 29 Jun 2021 11:49:38 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Wen Xiong <wenxiong@us.ibm.com>, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <20210629094938.r3h5cb7wwu2v3r3m@beryllium.lan>
References: <YNmdhqd+W3XbJCwd@T590>
 <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
 <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
 <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
 <YNqX6w8YHO61oqvY@T590>
 <20210629082542.vm3yh6k36d2zh3k5@beryllium.lan>
 <20210629083549.unco3f7atybqypw3@beryllium.lan>
 <YNrhXFgv/gEWbhbl@T590>
 <20210629092719.n33t2pnjiwwe6qun@beryllium.lan>
 <YNrpdy3pJ/3DIxpW@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNrpdy3pJ/3DIxpW@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 05:35:51PM +0800, Ming Lei wrote:
> With the two patches I posted, __nvme_submit_sync_cmd() shouldn't return
> error, can you observe the error?

There are still ways the allocation can fail:

        ret = blk_queue_enter(q, flags);
        if (ret)
                return ERR_PTR(ret);

        ret = -EXDEV;
        data.hctx = q->queue_hw_ctx[hctx_idx];
        if (!blk_mq_hw_queue_mapped(data.hctx))
                goto out_queue_exit;

No, I don't see any errors. I am still trying to reproduce it on real
hardware. The setup with blktests running in Qemu did work with all
patches applied (the once from me and your patches).

About the error argument: Later in the code path, e.g. in
__nvme_submit_sync_cmd() transport errors (incl. canceled request) are
handled as well, hence the upper layer will see errors during connection
attempts. My point is, there is nothing special about the connection
attempt failing. We have error handling code in place and the above
state machine has to deal with it.

Anyway, avoiding the if in the hotpath is a good thing. I just don't
think your argument about no error can happen is correct.
