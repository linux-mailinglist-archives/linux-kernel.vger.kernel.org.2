Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B613518EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhDARsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:48:12 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:44978 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhDARjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:12 -0400
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-10.nifty.com with ESMTP id 131GRVSH004859
        for <linux-kernel@vger.kernel.org>; Fri, 2 Apr 2021 01:27:31 +0900
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 131GRFvs001514
        for <linux-kernel@vger.kernel.org>; Fri, 2 Apr 2021 01:27:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 131GRFvs001514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617294436;
        bh=az0WDP5Hb3e5bZjQn72crx3TkUPqqKGWwcCXVDzFsC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ucx22InScTdWk9dSVP6OgZX5Zn9LaSliqzos4dlyC6Hnboo+Cg9mO5tvoBnucCv3v
         VB0xQKSeQJYnFkIiQWyAgdeMgyvAtz4wGm5ESUPIvD/f4+7lnG8fJL8J9oBTxii4Wx
         faSWYXANXS8cbqTwifRxWbOyzxhYaZQUWSRnrWzA0OJmGJjEx59SWO6GO/yYq9vygG
         nqA+3noKxVN5/0ZsC+2jcpS4MDfzDQVl7hrnPuDiOS313RJejZku/TewAaiNBBLMW1
         yy3RRYWWFveRmSCUYjIGG4/alYsgjsy/rheo4SWzvJvd8/hTX/9lDqRj6OSmRXIHxS
         0oMgA01kAcelg==
X-Nifty-SrcIP: [209.85.210.178]
Received: by mail-pf1-f178.google.com with SMTP id x126so1808873pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 09:27:16 -0700 (PDT)
X-Gm-Message-State: AOAM531JiJZqGOi9Zoxwy8elGOHhv3Z9c0puLuNOZCXGP/4yfzCQKrSU
        wOdH/w9Ad3bDR2+S2ebIVK/lkz0KifJPc+Q3u0Y=
X-Google-Smtp-Source: ABdhPJyiJUPgNyeul8sm7rrkPe52zxBrzeKUV+U3CWGwtcSB1uTWGlIEFXywP43lIm71riNLNn7aiV3QEYFp5U17lw0=
X-Received: by 2002:aa7:8d84:0:b029:1f8:3449:1bc6 with SMTP id
 i4-20020aa78d840000b02901f834491bc6mr8081418pfr.76.1617294435339; Thu, 01 Apr
 2021 09:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210401123944.GJ15381@kitsune.suse.cz>
In-Reply-To: <20210401123944.GJ15381@kitsune.suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 2 Apr 2021 01:26:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQwi=Nd+OfHrXBMJtC=f262K+=XFqeYBUz=Qx2Bjbg+yg@mail.gmail.com>
Message-ID: <CAK7LNAQwi=Nd+OfHrXBMJtC=f262K+=XFqeYBUz=Qx2Bjbg+yg@mail.gmail.com>
Subject: Re: allmodconfig not working with dummy-tools
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Philipp Rudo <prudo@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 9:39 PM Michal Such=C3=A1nek <msuchanek@suse.de> wro=
te:
>
> Hello,
>
> running allmodconfig with dumy-tools I get:
>
> which: no elfedit in (./scripts/dummy-tools)
> scripts/dummy-tools/gcc: unknown assembler invoked
> scripts/Kconfig.include:50: Sorry, this assembler is not supported.
> scripts/kconfig/Makefile:77: recipe for target 'allmodconfig' failed
> make[1]: *** [allmodconfig] Error 1
> Makefile:648: recipe for target 'allmodconfig' failed
> make: *** [allmodconfig] Error 2
>
> I use allmodconfig to enable any unknown options on new kernel version
> automaticallly so it can be build-tested.
>
> Can this be fixed or is there some other way of automatically udating
> the config after new options are added?
>
> Thanks
>
> Michal


Thanks for the report.
I squashed the following. Please wait for tomorrow's linux-next.



diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
index 39e65fee59bd..f6d543725f1e 100755
--- a/scripts/dummy-tools/gcc
+++ b/scripts/dummy-tools/gcc
@@ -67,6 +67,12 @@ if arg_contain -E "$@"; then
  fi
 fi

+# To set CONFIG_AS_IS_GNU
+if arg_contain -Wa,--version "$@"; then
+ echo "GNU assembler (scripts/dummy-tools) 2.50"
+ exit 0
+fi
+
 if arg_contain -S "$@"; then
  # For scripts/gcc-x86-*-has-stack-protector.sh
  if arg_contain -fstack-protector "$@"; then



--=20
Best Regards
Masahiro Yamada
