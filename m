Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D403752CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhEFLMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhEFLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:12:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C147C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 04:11:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z9so7182027lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMFathXdbsaDkowJoU81vrWO0kU+VvQ+Tmhu/CZVPVI=;
        b=bgCNsJYhW0+tuUuY3mc+Rp83PxkwaudgTpOEyZ7upVhDySB2D+rc0FjXEhxn2DdYy/
         CIHPZc1OG++JyD0ctna/+pypf3gxLlTy1g36xtiduhIJPcyQO+8Zrv7FFmw5/9laIfb0
         23F180/6IUwOMm8T+mR02+NBnKmPpS8hhqappwFgu+CXBQTiup0B2I3iKnrk7GVcOlOL
         OeNIyeW/43hcqYCVCWFKV6iq0xDT/ww+n1y279tcnLP7qY6uZiUOCeS82HfxM3YCrbOC
         vgXdLbW1f3qju1XR38L1nYKCv8TFZsVLcZVlbD5MedkNm3r9Oig9N2txhap5M6a2up2L
         U6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMFathXdbsaDkowJoU81vrWO0kU+VvQ+Tmhu/CZVPVI=;
        b=YNmNEAuNAxofeuni5lrvtBhlrNwBlwXT2QLKZ2luX4AOqj6+I010/5vPKkwW/hEIZd
         KHQGEHmseCHbYutQ8h0DQ9GRQtb0hafH32X7T6wMWXuQ2QkK5Rw3QeAL3hObX0kCKLk4
         DP2UY4s7hkMF0blfibW/X+jL59JrU4TNuf/boGsev5CJAYJeMxtGEfWNnzotWg8bYKde
         zIUhD6wpl1b04nFYu9FDbOHNw1UblaDjoJ1MhKIADAB39kck97R+lXSAT3hmFthK+8wU
         K3aT2HBoMw4MMn7sgQTzkxkbxZ9zIKQMuOEotQXb0B3P81m0p6H9LYp+B6KKlafHdmVD
         3xsg==
X-Gm-Message-State: AOAM533zF/L3ViKHILLUNwgF1sZmOh+DDYTDe5j8mzNsEx8+r72n8Y8S
        X8FW2pQii0XWNGsNNsDKyDecHNCPJ4NWFKcpLRAiPQ==
X-Google-Smtp-Source: ABdhPJzsuJP2WMZqZGx1KzuR34RFZ6qLuUWvvsfN2huPdEnPjyrItMtfHwqU/4mFSa/5hfhmJLQ+2fWn1Peuqhxn52A=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr2482110lfn.465.1620299478030;
 Thu, 06 May 2021 04:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210426095426.118356-1-tsbogend@alpha.franken.de>
 <20210426095426.118356-2-tsbogend@alpha.franken.de> <CACRpkda7n3VL-EpwdXDxt47azFo8Wkp67-urUy7--3D6TJs7iA@mail.gmail.com>
 <CAL_Jsq+48xVScx87WYD85Ty5CxqO3L8taMeQ7S9QwHew1+TjKA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+48xVScx87WYD85Ty5CxqO3L8taMeQ7S9QwHew1+TjKA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 13:11:07 +0200
Message-ID: <CACRpkdaftBRUw_m9GjrqMreAF98iNTF4807LwkY9Mt7Ceh6k=w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: gpio: Add devicetree binding for IDT
 79RC32434 GPIO controller
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 3:44 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Sat, May 1, 2021 at 7:13 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> > Why can't interrupt support be made optional?
(...)
>
> If the hardware has interrupts, then we should describe that. It's the
> OS driver that may or may not support interrupts.

You're right of course. What was I thinking.

Yours,
Linus Walleij
