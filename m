Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0993A45F942
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 02:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348023AbhK0B0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 20:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345428AbhK0BYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 20:24:06 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6149C0613F4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:19:26 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 70so7022669vkx.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8k8YIl0KwxKAbv7lkp1/Z1CPAjwJPHGhn37WWS+cww=;
        b=pAsmF4AZe+zj7BVgqLeISZmMILka+uPd6s6bh5BGMJbBV137R21fLSn6wnMCCJUBKw
         95s7resYPHBMAwnfgP6NXtH9NKDSxlNqSvWJYGVOPKGwaK6rcyr1yfutS9XdMi57bPJJ
         hfmwXKEOk/wXaTZM7hMs3wP/D0Jlb+DaoHKKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8k8YIl0KwxKAbv7lkp1/Z1CPAjwJPHGhn37WWS+cww=;
        b=2lsunTs3eLaKv2Nzz1im8hYOJG2bglPZRuSVfBYnYnEkZw6GZp76x+JRTqQ6uuOFyF
         zPw0kLata6/kTEUbpP6bBNTIKwONZk8zF+lcx+Kd32ImdWeDQpova2N+IxrDdgjH+hIo
         UqzmVLBkQGEpv/GNoC4btvIcJn4Yo3MzSVmqYGWXxEB+cXq74BMvkKbMwswM121k5e2j
         EjE2p7g+nwTo913/FTcUC5urq06xc+vPHvDmbDdEDeVYc+nx51UH0jJ/EejuNCEfUS5E
         soTASTDa1+j1TBQJB56eKAJkV/NsvXrh9ilCzF/krRNytuvyGBiOzzyO1/UjW4U1fyyO
         Cjng==
X-Gm-Message-State: AOAM530Dk+1ko2xFlCyiu43X47lx86Pls3jraeGXenqp9OP10cH9wIgj
        eFQKz+4HPdifqt+/6lF+SOxiLshUsJkYFPYA6GjKwQ==
X-Google-Smtp-Source: ABdhPJxRgc3fAgj4dzNgKTVTLJ/FU1/6MfnUJ6e2LyF0pw0WKfhsJzGdYT06JFaQrPnCg2sqUg2R+rJ0BQZG4DlTojU=
X-Received: by 2002:a05:6122:2ca:: with SMTP id k10mr19238644vki.39.1637975965759;
 Fri, 26 Nov 2021 17:19:25 -0800 (PST)
MIME-Version: 1.0
References: <20211126202144.72936-1-romain.perier@gmail.com> <20211126202144.72936-3-romain.perier@gmail.com>
In-Reply-To: <20211126202144.72936-3-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 27 Nov 2021 10:22:14 +0900
Message-ID: <CAFr9PXntRoxcJJThtxUGs-_URXr_LHwC8-FPDBzWehRKfuC5zQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: dts: mstar: Remove unused rtc_xtal
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Sat, 27 Nov 2021 at 05:22, Romain Perier <romain.perier@gmail.com> wrote:
>
> The rtc device node use an oscillator @12Mhz right now, namely
> xtal_div2. rtc_xtal is no longer used, remove it.

Drop this one. We will use rtc_xtal eventually.

Cheers,

Daniel
