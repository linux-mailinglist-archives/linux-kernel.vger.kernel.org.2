Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59B8456F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhKSNPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbhKSNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:15:06 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09BCC061748
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:12:04 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id j14so11311913uan.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YM8iEZkWj09QdZV0IaAS62/GEXCOf5MjgxwudLjy2dY=;
        b=cAE33cfo/0N63eGgp8XbsF1lNvSCLdfZ1+2RAHHG4RaBBsTG0gitWfyd/tOn+UlXeK
         q0fSYiClNmlpIxW80wl8/1ziXRzBUdaZ6/JDoFb8RP4KfycfDQIdQvvNBvHrqVTYNaXW
         KT+I/Khok9hk9K03fe9/iYTO36bYC08uzLHs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YM8iEZkWj09QdZV0IaAS62/GEXCOf5MjgxwudLjy2dY=;
        b=DPm08BT+f6a4fCLYieS+chTSE1RGdw+21Q0fpNRI7F2FXMyB6Jnn3i0KteTolHzppM
         Ptjx5ltJnK3FyS7EUUY7MDR7Ntg8alBIEnmsfGwajFHdb2vutb+gzZm+bYsQilaSRqmg
         qwQjVJ+xF7fR2ff7DgGob015kpC0HV4Mt3bRQCVx6f1NetssHIrBU5vN6HyFKdnbYHMT
         RHqVDSwbjSNkEpaULWyzO2lNgTN10b/iqwCpICWS6gW/phTj8FFUT3nmcp9nSgn8/kSa
         GZREaOaLu1VWU9SkMdnFRCal/yERD/STlTUTJgSWLHBgpXP9sfeGD7BqtJQ4HJue2Gez
         UpSQ==
X-Gm-Message-State: AOAM532yN1TH67W3aK8J4ldXPEa174CarnsqoXy20arHKVwqAOEiFo6D
        sZQ4hTpQcc59Nb21gJsww/uzqOi4NCW2+wII2Kls3Q==
X-Google-Smtp-Source: ABdhPJx8ZxQW/Y4NgqCFDWKYKJOnuOnviKck4eVR5XbNzsqnkFWtVWE2YsNzXL/5+5sd4UipCMXMaZBVMVKVdagJ3lo=
X-Received: by 2002:a05:6102:38c7:: with SMTP id k7mr87839688vst.45.1637327522660;
 Fri, 19 Nov 2021 05:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20210923065500.2284347-1-daniel@0x0f.com>
In-Reply-To: <20210923065500.2284347-1-daniel@0x0f.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 19 Nov 2021 22:11:52 +0900
Message-ID: <CAFr9PXmPE_vRcHgPkJp3o=d5HnAV52TFuBe-2hf=hKY8y2=BhA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] gpio: msc313: Add gpio support for ssd20xd
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        pavel@ucw.cz, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org, Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Thu, 23 Sept 2021 at 15:55, Daniel Palmer <daniel@0x0f.com> wrote:

> Daniel Palmer (11):
>   dt-bindings: gpio: msc313: Add compatible for ssd20xd
>   dt-bindings: gpio: msc313: Add offsets for ssd20xd
>   gpio: msc313: Code clean ups
>   gpio: msc313: Add support for SSD201 and SSD202D

Would it be possible to get some comment on these commits and/or get
them picked up?
We (Romain and I) have a few bits that are blocked on this.

Thanks,

Daniel
