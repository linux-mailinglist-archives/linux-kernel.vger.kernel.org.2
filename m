Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986783182FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 02:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhBKBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 20:16:34 -0500
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:55192 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229584AbhBKBQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 20:16:30 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E7C191802899B;
        Thu, 11 Feb 2021 01:15:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:979:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2568:2627:2682:2685:2693:2828:2859:2890:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4042:4250:4321:4383:5007:6119:7652:7903:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12555:12696:12737:12740:12895:12986:13069:13161:13229:13311:13357:13439:13846:13870:13894:14181:14659:14721:14777:14819:21080:21433:21450:21451:21611:21627:21740:21788:30001:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:203,LUA_SUMMARY:none
X-HE-Tag: crate00_180f44f27614
X-Filterd-Recvd-Size: 2512
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Feb 2021 01:15:47 +0000 (UTC)
Message-ID: <1abbf7dced75b9fa62e03ea9d199e98204ce23df.camel@perches.com>
Subject: Re: [PATCH] Documentation: Replace more lkml.org links with lore
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Feb 2021 17:15:46 -0800
In-Reply-To: <20210210234005.2236201-1-keescook@chromium.org>
References: <20210210234005.2236201-1-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-10 at 15:40 -0800, Kees Cook wrote:
> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> links with lore"), replace a few more scattered lkml.org links with
> lore to better use a single source that's more likely to stay available
> long-term.

The subject title seems odd as the modified files aren't
in the Documentation/ path, but the CREDIT change seems fine.

The Makefile.include bit maybe should be modified as
gcc 4.8 is no longer supported.

> diff --git a/CREDITS b/CREDITS
[]
> @@ -550,7 +550,7 @@ D: gadget layers, SPI subsystem, GPIO subsystem, and more than a few
>  D: device drivers.  His encouragement also helped many engineers get
>  D: started working on the Linux kernel.  David passed away in early
>  D: 2011, and will be greatly missed.
> -W: https://lkml.org/lkml/2011/4/5/36
> +W: https://lore.kernel.org/lkml/20110405034819.GA7872@kroah.com
>  
> 
>  N: Gary Brubaker
>  E: xavyer@ix.netcom.com
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
[]
> @@ -86,7 +86,8 @@ endif
>  # in newer systems.
>  # Needed for the __raw_cmpxchg in tools/arch/x86/include/asm/cmpxchg.h
>  #
> -# See https://lkml.org/lkml/2006/11/28/253 and https://gcc.gnu.org/gcc-4.8/changes.html,
> +# See https://lore.kernel.org/lkml/9a8748490611281710g78402fbeh8ff7fcc162dbcbca@mail.gmail.com/
> +# and https://gcc.gnu.org/gcc-4.8/changes.html,
>  # that takes into account Linus's comments (search for Wshadow) for the reasoning about
>  # -Wshadow not being interesting before gcc 4.8.


