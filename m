Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC73DC964
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 05:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhHADA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 23:00:59 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:20803 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhHADA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 23:00:58 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 17130LOM006884
        for <linux-kernel@vger.kernel.org>; Sun, 1 Aug 2021 12:00:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 17130LOM006884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627786822;
        bh=JLMXmFWJsvNubT3+ZUP/uEKw77wJzyXbzMGUgT1DCaw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XlsvPAzuXGoiILmIqWFaXZNh/N3RD1RwD85ttCtdEUKiFeUnTuXcjLn+eVhdMwlCc
         U+/HTKRo8Mb9YpxLbkgHN47w9RwHVh8fIgmWxyfOYsLdlyxc9VPRb1S7Wz+TgVWE8N
         K0/o6/vAYdRtJq8Ux13/TTfSwt9KXQFAkOWAIFfv20GpZV+f7JeRd2vrQTPddTJlK3
         9GPE9QFSPg/2hYZc7zr1Yy98H+v2Pstc7EluXiimJlR31lSsx+GMMNTp6Sc7n3646A
         ZSwgSZgYOrzeOrUAEibykxrDLOXA6/tfj/lCsykk79zf3NKd+WSPId9jkhgmfVPNts
         fm4uKd2CwxWOQ==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id nh14so8991322pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 20:00:22 -0700 (PDT)
X-Gm-Message-State: AOAM533J2eSpj8TNQUYTwBxnVRdCUlPhtvZ9/d2wcwNQNaldQ9iX0DHM
        THAHit3A/gIT9dc41EN3U+iblMRdBtqrCqBclcU=
X-Google-Smtp-Source: ABdhPJzk8RaUbGoJjQGFVokrKrkb8Jzkc2oo8E+bYjmdSF4akRNHuL1Qgw5N9WqGvl3trMT6yDjHOjJW7BwyVkeOOeA=
X-Received: by 2002:aa7:8593:0:b029:32b:c173:cd96 with SMTP id
 w19-20020aa785930000b029032bc173cd96mr10328541pfn.63.1627786821471; Sat, 31
 Jul 2021 20:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210727025737.30553-1-rdunlap@infradead.org>
In-Reply-To: <20210727025737.30553-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 1 Aug 2021 11:59:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVrJZgWe89dO+W=j+7TB+wTJuJTTp_sFBXD088-fZNsQ@mail.gmail.com>
Message-ID: <CAK7LNATVrJZgWe89dO+W=j+7TB+wTJuJTTp_sFBXD088-fZNsQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: checkversion: modernize linux/version.h search strings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:57 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Update scripts/checkversion.pl to recognize the current contents
> of <linux/version.h> and both of its current locations.
>
> Also update my email address.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  scripts/checkversion.pl |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)


Applied to linux-kbuild. Thanks.


> --- linux-next-20210723.orig/scripts/checkversion.pl
> +++ linux-next-20210723/scripts/checkversion.pl
> @@ -1,10 +1,10 @@
>  #! /usr/bin/env perl
>  # SPDX-License-Identifier: GPL-2.0
>  #
> -# checkversion find uses of LINUX_VERSION_CODE or KERNEL_VERSION
> -# without including <linux/version.h>, or cases of
> -# including <linux/version.h> that don't need it.
> -# Copyright (C) 2003, Randy Dunlap <rdunlap@xenotime.net>
> +# checkversion finds uses of all macros in <linux/version.h>
> +# where the source files do not #include <linux/version.h>; or cases
> +# of including <linux/version.h> where it is not needed.
> +# Copyright (C) 2003, Randy Dunlap <rdunlap@infradead.org>
>
>  use strict;
>
> @@ -13,7 +13,8 @@ $| = 1;
>  my $debugging;
>
>  foreach my $file (@ARGV) {
> -    next if $file =~ "include/linux/version\.h";
> +    next if $file =~ "include/generated/uapi/linux/version\.h";
> +    next if $file =~ "usr/include/linux/version\.h";
>      # Open this file.
>      open( my $f, '<', $file )
>        or die "Can't open $file: $!\n";
> @@ -41,8 +42,11 @@ foreach my $file (@ARGV) {
>             $iLinuxVersion      = $. if m/^\s*#\s*include\s*<linux\/version\.h>/o;
>         }
>
> -       # Look for uses: LINUX_VERSION_CODE, KERNEL_VERSION, UTS_RELEASE
> -       if (($_ =~ /LINUX_VERSION_CODE/) || ($_ =~ /\WKERNEL_VERSION/)) {
> +       # Look for uses: LINUX_VERSION_CODE, KERNEL_VERSION,
> +       # LINUX_VERSION_MAJOR, LINUX_VERSION_PATCHLEVEL, LINUX_VERSION_SUBLEVEL
> +       if (($_ =~ /LINUX_VERSION_CODE/) || ($_ =~ /\WKERNEL_VERSION/) ||
> +           ($_ =~ /LINUX_VERSION_MAJOR/) || ($_ =~ /LINUX_VERSION_PATCHLEVEL/) ||
> +           ($_ =~ /LINUX_VERSION_SUBLEVEL/)) {
>             $fUseVersion = 1;
>              last if $iLinuxVersion;
>          }



-- 
Best Regards
Masahiro Yamada
