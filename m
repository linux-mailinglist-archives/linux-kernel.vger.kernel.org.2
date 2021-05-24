Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CE038E379
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhEXJlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhEXJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:41:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB7DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:39:35 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a2so39745791lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGm9nC/YgcmbqxzpvBWjpUtAJKwOssYYI8J3jxnf330=;
        b=zMvpWaU4Itd5zJ/WVUvirNVWXdECMwaUw1CBrQvU/0z15NlUT3RT46kPEaFIAW8NGA
         7iaEHMx46rJg7ZKOaDb7t0mcCib4jx70AsLdV4c4ESnQyaGMpXi4VULXZzYMDYrs8qhJ
         9qYXh6vUFOskcQr/NJo7nDGEPKMJQmc9D4aLyIYWKM8Wh4u5dIiuSyLD2GoP54k/MRVB
         3chy7yusxBFgrlVLvAmLZv8mtmiKvrPa0zJsH8jJFRkNyVNEWLNzLrk+p/T5S/jaBAlG
         YrxfuzncxOfSR1MU/vqw6eo3jxJAA82tqVos+28Qhup+KvZqLOPE1ZkotQeA5qucjsf4
         /E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGm9nC/YgcmbqxzpvBWjpUtAJKwOssYYI8J3jxnf330=;
        b=BUbrX6zPeu0+emNlg5wiyyy5wUoNBpZ5ifLN4NcyABrXbU14qLaWBgYyriaanUiQbb
         o0rTze+UwAZvsv+zAq0CULNUzO9GljHALAWXI9DxNFExg6PdTfL5AkVo5USa4i3JZiQv
         MfT+prIu6ov8nlKxWSyoO5isQbZeMhXgfNA/0p87jYjGSFx1ujr4hQNU+2s5F6HZSxu2
         exUbs9qGFwGkwCQr0QrMoaQr0F0Va+rctUE4ituOHfkw10NrgOg7I7EQHqPhhx54E5cU
         9kWNf2XuoHkaYCmZXJ8t42irucgXrlqPmOXXaasrmOCaORP4Y6x8f9wnnIzZPZS9AzBu
         cV4g==
X-Gm-Message-State: AOAM530HtHOfpdKXIPLINwpM96jSIn6BQ2m5sD6cNzqBby2JHoTFTrtJ
        HU24GGFmpWD0GvWIEYZ6P4y4VmnxeENER3QzfX2UJQ==
X-Google-Smtp-Source: ABdhPJww+H3F2iKD4dUCB/7pje0njSOu2FZuNUd1YncHJz4nA7vZziC8uW1lw9V+GcscmxVezKwgxPaDrfn8NNqSV0Q=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr10458954lfq.29.1621849173427;
 Mon, 24 May 2021 02:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210520163751.27325-1-maz@kernel.org> <CACRpkdZpn3x-P9rsoMUE0uG_19aG5jHWvv7FD7srtmW92Q1oag@mail.gmail.com>
 <87sg2cwm17.wl-maz@kernel.org>
In-Reply-To: <87sg2cwm17.wl-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 May 2021 11:39:22 +0200
Message-ID: <CACRpkdbH3DAMc66jTSw2nM4ONUYWRGpV1XAjYRRHmKqRrguVgA@mail.gmail.com>
Subject: Re: [PATCH 00/39] irqdomain: Simplify interrupt handling
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 10:53 AM Marc Zyngier <maz@kernel.org> wrote:

> > Or a base to be pulled in and then each subsystem can
> > apply the bulk conversion to their subsystem only.
>
> This last option is my preferred approach for busy subsystems. I'm
> happy to take care of irqchip and of the quieter architectures such as
> NIOS2 and SH, and leave the rest to their respective maintainers.

OK once the dust settles on the series just send a pull request to
me for pin control and to Bartosz for GPIO and we can pull that
in and do the bulk conversion on top.

Thanks!
Linus Walleij
