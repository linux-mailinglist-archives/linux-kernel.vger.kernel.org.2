Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C893CC465
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGQQRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhGQQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:17:38 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86ADC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:14:40 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j184so11999806qkd.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GWmk/6Yg6G/wiV8hPSENTGAb03aKfobGAU5bm/AIcaE=;
        b=eEs06cLRffoRWR9geoOw9th4kL5gmdftURBoHo6blA+R9YhNLipFC3II6xCWFQX42o
         BK+anepFgOwGzwd1BqREZsllk1X9WYX8GXYzch2sKuk8QqV8gsBjoDBArINSzVhqknZ6
         OxtXR8gmkoCuB0P2UffTI9poHhO8TfBtT5FCYvHNlOQvlPP6ZS2tsXIOwcYUzjVFHRYv
         K3ztWUiADBaH6/fUTGRoAHu15wBHiLC2ANJY7aMVXbCPW4d0mTsXkF5L7Wj4lg4I7dLM
         AYTHDxDOAnpzXBQjtM6QsMSxDCrDNcB9C5Lnf5JK6q5aQkv5UGhENPnEML/mP3xC++h5
         WVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GWmk/6Yg6G/wiV8hPSENTGAb03aKfobGAU5bm/AIcaE=;
        b=nMmQ3lO8xXXYMcEcGvFYGLm4+5Eu3rdB5MoaBR/96Gg6rUZ9EhXNMNge8gVsDQTtTL
         gXWDhwUq1/T/308caUvt5QLkFFHjnN41C+FkWyHVGG12AUfsbY26aEPBEXJ0Vt+oUba6
         39Ks0jblRquqFZgz5gKoin+mcIYXVU89m8jF3Grpr+2ByZTo0IAnW03peYqPN6Tdcw0c
         eNHum75HF2gpJ2F56flqoKo542WelBGN5oAMp8+C9Xqdsqx5oI4nXGueZmadCF0AnIhT
         h55WFpDsEIhw7OnHKs5om0u1UoZ1DJuw6cWTnNh8BF/H+bkxdbKA8sGLWJ7dTdz+O6Xl
         8nRQ==
X-Gm-Message-State: AOAM5328ojw6KU41NXwl+Ey/9b9d0cff4E+1i8s2mUlDKvdcbVe/hBIA
        bMoClfXV9x85+5IabKmfKl0=
X-Google-Smtp-Source: ABdhPJyaBAIDIOkCzcWYABB3+yuo7e93WzdHJVFHG+WjSR5sqpxtH7ny/BDWD5e0Nk/Muq98ttpiGw==
X-Received: by 2002:a05:620a:573:: with SMTP id p19mr5200084qkp.99.1626538479989;
        Sat, 17 Jul 2021 09:14:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c16sm4456355qtv.32.2021.07.17.09.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 09:14:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jul 2021 09:14:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] powerpc/chrp: Revert "Move PHB discovery" and "Make
 hydra_init() static"
Message-ID: <20210717161438.GA3038659@roeck-us.net>
References: <20210716221159.3587039-1-linux@roeck-us.net>
 <CAOSf1CHuLhYO1rXiAhPz6xyQ-GgrjE-dj=Af6v7CWSH6QroEtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CHuLhYO1rXiAhPz6xyQ-GgrjE-dj=Af6v7CWSH6QroEtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 01:54:23AM +1000, Oliver O'Halloran wrote:
> On Sat, Jul 17, 2021 at 8:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > This patch reverts commit 407d418f2fd4 ("powerpc/chrp: Move PHB
> > discovery") and commit 9634afa67bfd ("powerpc/chrp: Make hydra_init()
> > static").
> >
> > Running the upstream kernel on Qemu's brand new "pegasos2" emulation
> > results in a variety of backtraces such as
> 
> ...and actually using it appears to require both manually enabling it
> in the qemu config and finding a random bios blob that is no longer
> distributed by the manufacturer. Cool.
> 
That is absolutely wrong. vof.bin provided by qemu in the linux root
directory works just fine, plus chrp32_defconfig minus SMP.

Guenter
