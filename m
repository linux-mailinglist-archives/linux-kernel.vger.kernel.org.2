Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156B7342F03
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCTSds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTSdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:33:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5677C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IvAI5fW7NUyKvLhYK1h5YVBZ+5nIkDZ3p07mheREskg=; b=qEiZtHkCP8o4JfWBU2Vvr49QSU
        6+Pz6nK/AYq8VlF0X69cuQxiNpvTRHnwWCtvsaeHMmVSOwBRhDwvqcXn8v5MM98MzT6VRYIt8fCIa
        tpDVggB3jWPezBKawbdINhQnJrs/FNdpE3wtQ93gLBKNRSWlqwWK5lUxbtnthroTNZCVenF8u57vg
        KYEuiTyU3j0+mNdzPXssBomL75RffcGYkJpLxFgxdpKrxhlcVUzIL8R+r3/ZKuN5OgxkryQKTSFMl
        u9TUBC1s42v5W6Ho0PHHH5XjujP1Ba6FUtOvK4b+4ZGhJE5iZOtcJ0nDo+YTvMIo34BF9t7WJF0WP
        GEHoKxcw==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNgPu-001z0K-TR; Sat, 20 Mar 2021 18:33:44 +0000
Date:   Sat, 20 Mar 2021 11:33:42 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: [unixbhaskar@gmail.com: [PATCH] IA64: Trivial spelling fixes]
In-Reply-To: <YFY+9uwvNLeb/3Ab@Gentoo>
Message-ID: <396ec2ad-5387-70ff-8c51-4bce3267b9ab@bombadil.infradead.org>
References: <YFY+9uwvNLeb/3Ab@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_113342_973869_AE9558B2 
X-CRM114-Status: GOOD (  10.88  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote: > ----- Forwarded
    message from Bhaskar Chowdhury <unixbhaskar@gmail.com> ----- > > Date: Sat,
    20 Mar 2021 23:53:47 +0530 > From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
    > To: unixbhaskar@gmail.com, [...] 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:

> ----- Forwarded message from Bhaskar Chowdhury <unixbhaskar@gmail.com> -----
>
> Date: Sat, 20 Mar 2021 23:53:47 +0530
> From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> To: unixbhaskar@gmail.com, linux-ia64@vger.kernel.org, 
> linux-kernel@vger.kernel.org
> Subject: [PATCH] IA64: Trivial spelling fixes
> X-Mailer: git-send-email 2.26.2
>
>
> s/seralize/serialize/ .....three different places
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  arch/ia64/kernel/pal.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/ia64/kernel/pal.S b/arch/ia64/kernel/pal.S
> index d3e22c018b68..06d01a070aae 100644
> --- a/arch/ia64/kernel/pal.S
> +++ b/arch/ia64/kernel/pal.S
> @@ -86,7 +86,7 @@ GLOBAL_ENTRY(ia64_pal_call_static)
> 	 mov ar.pfs = loc1
> 	 mov rp = loc0
> 	 ;;
> -	srlz.d				// seralize restoration of psr.l
> +	srlz.d				// serialize restoration of psr.l
> 	 br.ret.sptk.many b0
>  END(ia64_pal_call_static)
>  EXPORT_SYMBOL(ia64_pal_call_static)
> @@ -194,7 +194,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_static)
> 	 mov rp = loc0
> 	 ;;
> 	 mov ar.rsc=loc4			// restore RSE configuration
> -	srlz.d				// seralize restoration of psr.l
> +	srlz.d				// serialize restoration of psr.l
> 	 br.ret.sptk.many b0
>  END(ia64_pal_call_phys_static)
>  EXPORT_SYMBOL(ia64_pal_call_phys_static)
> @@ -252,7 +252,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_stacked)
> 	 mov rp = loc0
> 	 ;;
> 	 mov ar.rsc=loc4			// restore RSE configuration
> -	srlz.d				// seralize restoration of psr.l
> +	srlz.d				// serialize restoration of psr.l
> 	 br.ret.sptk.many b0
>  END(ia64_pal_call_phys_stacked)
>  EXPORT_SYMBOL(ia64_pal_call_phys_stacked)
> --
> 2.26.2
>
>
> ----- End forwarded message -----
>
>
