Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2767B3FA585
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhH1LiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhH1LiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:38:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F814C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:37:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f2so16444269ljn.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yjSEFzv8kluOENILFvuHRCvSbNy9lHGaoFHd7/7ZFsQ=;
        b=S1DSOz6SVZnuHxCuMzaj0nTV+SF5vsYAC/4eUaN5HXXaMoyJb73AqM/OshZ4HzHAMc
         PpdVo2WqEawsU09HNnVWGdNDQJPc9D1PCDtO0m3/ixUMUuGjkv7WyWrKmcNQfn7cobkf
         yWfnBBn9rnKw9453F16PqpmvIOBs0IkMuwXTbU/r/FOVYLUn9nFb8+pFKz+CYP09xsUS
         NtfULXcwVvUO1GF3I9Ma1OCLY7tTHP7aFrJMqRgPPWRisqVhOvOlVrVrtPP1/dNAahdk
         hr4MeQBF5gKjJxdsjL3V86TVnApAcwJI+C8s1paDJl6L2D22QWpBE+gyDQuP/qjls5J2
         V00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yjSEFzv8kluOENILFvuHRCvSbNy9lHGaoFHd7/7ZFsQ=;
        b=iBaKFedUdYPpQ4JfNc+EhW55M4it469zvrqN7u6zJBbqlQkMPonz8rwrui81z1ouVG
         2ZnhnX+yjLVjOymr3nAoOvMh/Zehtfq6Jw6It7QQhPkQy/IeLhcfMIfFrbrF8d+y5x6N
         zbDQ8+TQjLKPSEpyMw5jqqbK7SsmKT7szH/GNnOunQRrQ7MYJfAUmIuwiSt4OuJ5R3W4
         M7VjZXUyFop/ymPd+kV4DYagz10wcJKsR2htWX5RXhnc/gFYGqjsfs8leXNcKm81lvhz
         4urkuNQUkqaDTZG2ES07Uk3NvoGepjBFhMsFI/Npc3k8O6wvF8XCtnFHvQ/apoHsEntu
         A0sg==
X-Gm-Message-State: AOAM530s0xrljRpZUD7sdKk6YYrai0pcT5xwk54Sy3SdaklLHSCGE2R6
        Hvb2oqxA2xjpHFA57CYfqfVQ4X4ZEDzzNQ==
X-Google-Smtp-Source: ABdhPJxcq/9sIBbo1oNHzb+12fxkefXkAK1GnD8rSXHhUSRuT2D+e9DMiO9QidG1zcE7gyv9N+BoqQ==
X-Received: by 2002:a2e:b605:: with SMTP id r5mr12033036ljn.283.1630150648852;
        Sat, 28 Aug 2021 04:37:28 -0700 (PDT)
Received: from kari-VirtualBox (87-95-21-3.bb.dnainternet.fi. [87.95.21.3])
        by smtp.gmail.com with ESMTPSA id n19sm856205lfu.68.2021.08.28.04.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:37:28 -0700 (PDT)
Date:   Sat, 28 Aug 2021 14:37:26 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging: r8188eu: incorrect type in
 csum_ipv6_magic
Message-ID: <20210828113726.v4tmknjosvgb7bke@kari-VirtualBox>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
 <0b7d6e92c79a6daf55a0c3a4961df6f33a9bcf37.1630148641.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7d6e92c79a6daf55a0c3a4961df6f33a9bcf37.1630148641.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH v5 2/3] staging: r8188eu: incorrect type in csum_ipv6_magic

Subject should start with imperative mood. Every patch in this series
needs this fix.

I actually check linux coding style and did not found mention about
this, but if you look kernel log then you see that it is at least
unwritten rule. You can check this if you want
https://chris.beams.io/posts/git-commit/#imperative

On Sat, Aug 28, 2021 at 04:40:45PM +0530, Aakash Hemadri wrote:
> Fix sparse warning:
> > rtw_br_ext.c:771:84:    got restricted __be16 [usertype] payload_len
> > rtw_br_ext.c:773:110: warning: incorrect type in argument 2
>     (different base types)
> > rtw_br_ext.c:773:110:    expected int len
> > rtw_br_ext.c:773:110:    got restricted __be16 [usertype] payload_len
> 
> csum_ipv6_magic and csum_partial expect int len not __be16, use
> be16_to_cpu()
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index aa56cd1a8490..38f1bd591da9 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -615,9 +615,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  						struct icmp6hdr  *hdr = (struct icmp6hdr *)(skb->data + ETH_HLEN + sizeof(*iph));
>  						hdr->icmp6_cksum = 0;
>  						hdr->icmp6_cksum = csum_ipv6_magic(&iph->saddr, &iph->daddr,
> -										iph->payload_len,
> +										be16_to_cpu(iph->payload_len),
>  										IPPROTO_ICMPV6,
> -										csum_partial((__u8 *)hdr, iph->payload_len, 0));
> +										csum_partial((__u8 *)hdr, be16_to_cpu(iph->payload_len), 0));
>  					}
>  				}
>  			}
> -- 
> 2.32.0
> 
