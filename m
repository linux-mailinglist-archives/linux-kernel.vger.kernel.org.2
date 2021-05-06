Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8252737534D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhEFL5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhEFL5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:57:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA82C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 04:56:17 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso3827012ots.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6QseWDJD7yxOU5rG3+na4aQGSjg/EdTCgN17vCsxG6Y=;
        b=mlbBVVOHOhncgw4lopPiGHy6NNG+4vZNsw5TbuB+kL97hTTKGxe5M48hp1hvmqSvnF
         TSbCiiwh7InDzzaKZVtA3pjlysz37bVZGSCyJ5xA5NXZELSzieFVupzlCzENCfXyLVJ8
         lQ9ClTaR8Gyxc8SmKu694ilUnDrjFcHKBD5EfnDMKjtMldRlGlU6ijU33bbZRQ7i5eML
         dvNfjxZc8a2KIIzUY8fEf70ryxOfYQn5p1meuFhSQI+sR7voUjNDnM0cjo9fXGauaAkY
         tdgwC8B68IfrCM00egmCeciw+m5i3CcQKpiCdhAAe24DXvHylSzVuunNLT65gIvMce3o
         mJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QseWDJD7yxOU5rG3+na4aQGSjg/EdTCgN17vCsxG6Y=;
        b=Is/KUvHK8TarwzP6B4TrDpoNLaT6btIWb3W7oWHyt9sVplC75uD7+Kubg2KMc9ndwI
         0oAplbYwTRiTwVECG5sQKVql+ffki5HwIJqqwYgBLCAx5Yi9gTrgJczveBiSx0Z3Crzx
         XPL6e38S1unKWF+Nyx1V9XiB3tsfrNw3fKu8KGs6sOZm4txMkzsMRcQkH5Hi8dLG02aX
         DTVxet+Of4u1I4Rv7kS9Lve1w66Tu+fjIz37bIEr7rT7p7YQfcUieY0DTFkUXMDxz1Mp
         2uQManm93zSwKmHIDAG9/cXYu3cZYvoEqIZ2f5rzvnritT+Phd9mvChwE3dNOuSiGe1A
         W4Ng==
X-Gm-Message-State: AOAM532T5tl5V+lhVHuGX8Hk6XWjxk9Aps6FGPP1FVUkG/pvNqe7cvTJ
        bS8LZJLr/xcbOkBZhE4wbmY8UQ==
X-Google-Smtp-Source: ABdhPJw9TnD7fJ5mwyTc0krHc+cYRAlG0zHj8GY6A4eINag7hGLuvphIDB2gNYjb4J55cRecfnyT/g==
X-Received: by 2002:a9d:6242:: with SMTP id i2mr3187364otk.273.1620302176492;
        Thu, 06 May 2021 04:56:16 -0700 (PDT)
Received: from [192.168.101.238] ([172.58.96.242])
        by smtp.gmail.com with ESMTPSA id q2sm14055ool.3.2021.05.06.04.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 04:56:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] arch: use cross_compiling to check whether it is a
 cross build or not
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org
References: <20210501172437.156926-1-masahiroy@kernel.org>
 <20210501172437.156926-2-masahiroy@kernel.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <664383ae-8ab2-da1d-601d-365d507f47db@landley.net>
Date:   Thu, 6 May 2021 07:11:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210501172437.156926-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/21 12:24 PM, Masahiro Yamada wrote:
> 'cross_compiling' is defined by the top Makefile and available for
> arch Makefiles to check whether it is a cross build or not. A good
> thing is the variable name 'cross_compiling' is self-documenting.
> 
> This is a simple replacement for m68k, mips, sh, for which $(ARCH)
> and $(SRCARCH) always match.
> 
> No functional change is intended for xtensa, either.
> 
> This is rather a fix for parisc because arch/parisc/Makefile defines
> UTS_MATCHINE depending on CONFIG_64BIT, therefore cc-cross-prefix
> is not working in Kconfig time.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tried the patch in my sh build, the result built and booted.

Tested-by: Rob Landley <rob@landley.net>

Rob
