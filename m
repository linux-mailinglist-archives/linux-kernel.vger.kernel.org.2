Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234A934EA74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhC3Ocv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:32:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:53404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhC3Och (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:32:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617114756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7CnvuQlf2PKAQbilj1OnvsA2ZPz1Bt0Gk/Sc10xl1o8=;
        b=ZM1Y6cdTD5yhZ0by8G/PaXcIKoU9ebX0jXKZ56j8ZhSIxSwziN4VkBd0GrLMIU1yHGC0hV
        w+XICX8iQbCXCgxUp0H4UayZxd7ISwwkqjIPgSmCkShJpajnx5bZnV2Ywp2Xjj9/wqoS01
        N0cu+ao7vU6VIF9D5/y0TB67UTS7gdA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FC51B2FB;
        Tue, 30 Mar 2021 14:32:36 +0000 (UTC)
Date:   Tue, 30 Mar 2021 16:32:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] kernel/printk.c: Fixed mundane typos
Message-ID: <YGM2g4A1cnYZG8Bv@alley>
References: <20210328043932.8310-1-unixbhaskar@gmail.com>
 <YGMevQvltf/LnJP1@alley>
 <87mtuk4xb3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtuk4xb3.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-30 14:53:52, John Ogness wrote:
> On 2021-03-30, Petr Mladek <pmladek@suse.com> wrote:
> > On Sun 2021-03-28 10:09:32, Bhaskar Chowdhury wrote:
> >> 
> >> s/sempahore/semaphore/
> >> s/exacly/exactly/
> >> s/unregistred/unregistered/
> >> s/interation/iteration/
> >> 
> >> 
> >> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> > John,
> >
> > it conflicts with the patchset removing printk safe buffers[1].
> > Would you prefer to queue this into the patchset?
> > Or should I push it into printk/linux.git, printk-rework and you would
> > base v2 on top of it?
> 
> Go ahead and push it to printk-rework. I'll base v2 on top of it.

The patch is committed in printk/linux.git, branch printk-rework.
It is queued for 5.13.

Best Regards,
Petr
