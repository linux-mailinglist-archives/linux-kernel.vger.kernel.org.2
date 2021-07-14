Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358163C86A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhGNPJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239533AbhGNPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:09:43 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E0C061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:06:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 42-20020a9d012d0000b02904b98d90c82cso2784613otu.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YiH8+P/GYggmS9FkGJgJ7JmHee/6ylMrnanql7uyQo=;
        b=LP05I3DgupzAgfL4J5btk9IhIEy02Yv9jrcfj9/XbgglJLC745V5qheogVfIs4Ow0Q
         hxlHqnYGaKKoMU+US66ZRH23IT7uBIQFjxJ4PFF4Fno1P3rrfY7lBBYbVNI2HyKTraAy
         H898D6Llhi15EGceNXC21s7ZwQE6C2YXv7Ku+RupGb5kAE2Wl0CTuRTiH7z/Ly1iQSfo
         jp5t6bnTJ2sEwzwUoZdOlLNhgfKGGPoWj0zVS0Ea1T/3ntzi5+q8JVtGQIIfL4Wh0IpN
         03DMNL3VYn55sQB8yv85ywC6VPv+7whiWHTpWXZxMJti315W++e3+7MPiE0Co6wfa/+c
         68Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YiH8+P/GYggmS9FkGJgJ7JmHee/6ylMrnanql7uyQo=;
        b=SyS8vwUY6lCYkyKoakOF3cAjhtcrSinXatKaYg9+kUW4D46r/EbUGjmPQOGan4vCfX
         qJATJKg4w7zykITwLMBAoBcmNWdmROWgsOUnWMJn1NommvTk1DmyV3qnJXy5ulF5xRI9
         CnGnLZ/FoLQytTW5gaweW4A5pl2VcpG5PNz9bmijGExg604rb4fIPzL6Z2EtALklyMYY
         1w8WykWuA8Ws/ayDSDPNr8wtJOYZJmOGrEM5xIaNyzT/aStOskZrU5X0XbFUqI9He9mm
         4DmC5ksH5HEZs4KS0a5kPYA5wOC9jjpoOs8/HdjLi2zcn+fkUtk9GatiFfs29WjzeHCN
         rtUA==
X-Gm-Message-State: AOAM533yknCurmX+44mhny3TcXzp+tp17/V9vmRbF3USrPEvl/7FUVfp
        IYINa8lAj/kky8TATm+vq4g54yaQ9lfMuaBD5z3oqq5XNPnEHg==
X-Google-Smtp-Source: ABdhPJxxWjFSbu10XUt6ENkGkcYIsqHhifAJ2KXMlLHv0EUApj91lhGmpBGjyb7d74F82HXlMaGXswhZJJ3WqsqIgRg=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr8898501oti.251.1626275210727;
 Wed, 14 Jul 2021 08:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210714143239.2529044-1-geert@linux-m68k.org> <CAMuHMdWv8-6fBDLb8cFvvLxsb7RkEVkLNUBeCm-9yN9_iJkg-g@mail.gmail.com>
In-Reply-To: <CAMuHMdWv8-6fBDLb8cFvvLxsb7RkEVkLNUBeCm-9yN9_iJkg-g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 14 Jul 2021 17:06:23 +0200
Message-ID: <CANpmjNO7reWQQCce+grJsfEjNcGzvrrsF2450DhE4CzCkvFt0w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc1
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        linux-um <linux-um@lists.infradead.org>,
        scsi <linux-scsi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 at 16:44, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
[...]
>   + /kisskb/src/include/linux/compiler_attributes.h: error:
> "__GCC4_has_attribute___no_sanitize_coverage__" is not defined
> [-Werror=undef]:  => 29:29

https://lkml.kernel.org/r/20210714150159.2866321-1-elver@google.com

Thanks for the report.
