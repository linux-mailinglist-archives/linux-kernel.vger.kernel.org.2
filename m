Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1C327D58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhCALd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233754AbhCALbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:31:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9757C64E22;
        Mon,  1 Mar 2021 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614598252;
        bh=XJHueoW65vLj+4kVOT6u/yTzg+bSjpuQ9NtCeZkqWGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EE4LqhTL0kSe1iVAk++5zkvFgXmp//BQRPuzNsxqY8miqRT2Q0wLWzHggHaaQZ4CR
         9BW1BjOOfa5XTDzT+xyTN0j9uhXCWobMGzcRUNi4Jo6BcmlWbaa9+D3FC5KVC8un3N
         yF0bTRD5neVc+YxhDpu5KDuAbR1BNqTsUTz+4dbw=
Date:   Mon, 1 Mar 2021 12:30:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     huangshaobo <huangshaobo6@huawei.com>
Cc:     linux@arm.linux.org.uk, mhiramat@kernel.org, tixy@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zengweilin@huawei.com, young.liuyang@huawei.com,
        nixiaoming@huawei.com, chenzefeng2@huawei.com,
        liucheng32@huawei.com, kepler.chenxin@huawei.com,
        xiaoqian9@huawei.com
Subject: Re: [PATCH 4.4.y] arm: kprobes: Allow to handle reentered kprobe on
 single-stepping
Message-ID: <YDzQaT6zTUb43LFt@kroah.com>
References: <20210227091701.23944-1-huangshaobo6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210227091701.23944-1-huangshaobo6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 05:17:01PM +0800, huangshaobo wrote:
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

What about the 4.9.y tree as well?

thanks,

greg k-h
