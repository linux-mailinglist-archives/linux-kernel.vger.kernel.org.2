Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81963C23FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhGINJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhGINJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:09:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CDBA61377;
        Fri,  9 Jul 2021 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625836019;
        bh=bppPLBlGq3MRWU4+6plXC5MiNOmAXncZ5ZS65JOB/+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcIgpMSwgMQxE8HZr/IAB0tkDVQi0vrNSEV9MKmc6czxSprh5N/fYARhUTrQ9CJq6
         /X2WYGG0qIRx54h27ze20nJKYgBethoiWFAbEd3TqiGN3ZjiLRIWdVDB7znv9y3dkc
         +nrnwzPMHiu3Ok2zK7HXuAp46zoPAUy8aY+vHEZM=
Date:   Fri, 9 Jul 2021 15:06:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     chenzefeng2@huawei.com, kepler.chenxin@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@arm.linux.org.uk, liucheng32@huawei.com, mhiramat@kernel.org,
        nixiaoming@huawei.com, tixy@linaro.org, xiaoqian9@huawei.com,
        young.liuyang@huawei.com, zengweilin@huawei.com
Subject: Re: [PATCH 4.4.y] arm: kprobes: Allow to handle reentered kprobe on
 single-stepping
Message-ID: <YOhJ8KaoH4BU3ej1@kroah.com>
References: <YOcOcNBRou5KlbOR@kroah.com>
 <20210709024630.22268-1-huangshaobo6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709024630.22268-1-huangshaobo6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 10:46:30AM +0800, Shaobo Huang wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> commit f3fbd7ec62dec1528fb8044034e2885f2b257941 upstream
> 
> This is arm port of commit 6a5022a56ac3 ("kprobes/x86: Allow to
> handle reentered kprobe on single-stepping")
> 
> Since the FIQ handlers can interrupt in the single stepping
> (or preparing the single stepping, do_debug etc.), we should
> consider a kprobe is hit in the NMI handler. Even in that
> case, the kprobe is allowed to be reentered as same as the
> kprobes hit in kprobe handlers
> (KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE).
> 
> The real issue will happen when a kprobe hit while another
> reentered kprobe is processing (KPROBE_REENTER), because
> we already consumed a saved-area for the previous kprobe.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Fixes: 24ba613c9d6c ("ARM kprobes: core code")
> Cc: stable@vger.kernel.org #v2.6.25~v4.11
> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> ---
>  arch/arm/probes/kprobes/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Now queued up, thanks.

greg k-h
