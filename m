Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724B9342768
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCSVHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:07:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36532 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCSVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:07:03 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 41F66209C3A4;
        Fri, 19 Mar 2021 14:07:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41F66209C3A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616188022;
        bh=q5AB1O3+WOrgB/Ote4fLERcdEW6A2Y4zo1h8LlTbdIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMh/7BHalJkXnaAsdeMCU8Vy5ERJDCDm2TQMq0oGUBUz6mRC4gICXKxMfrzu3oZON
         rcDw9M+rb19SoEcBC2Vfp3M8vXaCnh0DxydKf/3MY0Q0FjPDLRV+g8z1kmB+EhipKq
         zzzs5tl950MfN/HrJEuLOZ9wE/NdTjpyQukAfqBs=
Date:   Fri, 19 Mar 2021 16:07:00 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kdump: update ppos when reading elfcorehdr
Message-ID: <20210319210700.GB235401@sequoia>
References: <20210319205054.743368-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319205054.743368-1-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-19 16:50:54, Pavel Tatashin wrote:
> The ppos points to a position in the old kernel memory (and in case of
> arm64 in the crash kernel since elfcorehdr is passed as a segment). The
> function should update the ppos by the amount that was read. This bug is
> not exposed by accident, but other platforms update this value properly.
> So, fix it in ARM64 version of elfcorehdr_read() as well.
> 

Fixes: e62aaeac426a ("arm64: kdump: provide /proc/vmcore file")
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/kernel/crash_dump.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
> index e6e284265f19..58303a9ec32c 100644
> --- a/arch/arm64/kernel/crash_dump.c
> +++ b/arch/arm64/kernel/crash_dump.c
> @@ -64,5 +64,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>  {
>  	memcpy(buf, phys_to_virt((phys_addr_t)*ppos), count);
> +	*ppos += count;
> +
>  	return count;
>  }
> -- 
> 2.25.1
> 
