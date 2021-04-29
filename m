Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0129E36EC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbhD2OcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbhD2OcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:32:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0707C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:31:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a36so65826857ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/ZOVNlRhxFmEYzF2Ik6J2ysTebRw8SCFgIzSU8iqps=;
        b=ZQ7DF9jMv3hnR3yG6dTkKTbeT/pqZvN5dorx2KlKGQKQ4oJb+NsC2rHfCySOd1xxls
         vNUTqWvW9CIlE/2oAqSJzrYhJEOsIuyEJrBbmC8t0EVbJg7wnIw20KFQgorD0aDwW2f1
         fWt5rdweTrQaVZLCckzfP6Z2MgdnL77U2RqAC3IIy5T0doBLzim2uCG0GS4kPlahKxHb
         +Ff4u2+7XXsH+hD4GP+As7092HRBBykddICQw7BRQIjMW26ue0gpntdO8Qx4qBM+f0iy
         mUZpeQlMhOdtUCzYV28Q5ctWR+atomQtaB6CXFCn6sq2ZJFNZZ9uT6uS5rPrTYRGftaj
         32Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/ZOVNlRhxFmEYzF2Ik6J2ysTebRw8SCFgIzSU8iqps=;
        b=JV2116W/4QtunAnh+AgMLd/KLZWJT6OJPVpjXwuXYUPhDlgiwKSBFQ2KCcBUYrDdBj
         Nn3VdsWq2+GdJziz+IRGd6l5Zvq6YGLidtpCImfGwYG6M5xSxe7Wj1nLlqaK4NQ99UhB
         VaRFMWlprDSlOkDHP3spflCun0maHWayb7VvSj4T7lRuV8WnLpHBUKQ8p/OHvknFk2Yl
         uapeLcS4wi3sq+eDMojX672vg5aUTOm4E1NQIfoMBZ3YsBb/xdF6gOezru72/ChKlv2X
         JsHckIMVEdPb6X0zVhRML2JQiVATFBGRnkjRnZ61CmUyX64k4hGnzhknBv3eDpbRnA5z
         +GcA==
X-Gm-Message-State: AOAM530AesKZrUu08Q3pGWlzDSkGhPIMPITXa2Ghi/mG40Scr41cB6mM
        RN0tgnvrH3BGI+DrLSE15JX1nHRv0Wqy/BJA4o4oBA==
X-Google-Smtp-Source: ABdhPJyde99GYBwl+WESfRrFPvhMPTUJhOguLQxlOmj3C3Lz44PddihQ1xPhw1E1amoE+asCL2HSX7FoXdDuCvAWeSM=
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr24642291ljp.368.1619706689470;
 Thu, 29 Apr 2021 07:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <bug-212379-6385@https.bugzilla.kernel.org/> <bug-212379-6385-VMOjMpWM97@https.bugzilla.kernel.org/>
 <YIc40YXZh4plkhnc@zn.tnic> <CAHp75VfYKcYjiafFRmb8nBLeJ3VOs0wu6OxhysE31UStQNroiw@mail.gmail.com>
 <CAHp75VfMfghCWo_47FhtUGU_qt+Jzaz1kqY4+=oZgbzazyfPUA@mail.gmail.com>
In-Reply-To: <CAHp75VfMfghCWo_47FhtUGU_qt+Jzaz1kqY4+=oZgbzazyfPUA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Apr 2021 16:31:18 +0200
Message-ID: <CACRpkdbT-GD=45ViysGpNSXWN+i9QA9=J8zgtPDkxCRyLKxm3g@mail.gmail.com>
Subject: Re: [Bug 212379] AMD GPIO chip IRQs stops working (ELN4690, WCOM51C7, BMA250E)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Coiby Xu <coiby.xu@gmail.com>,
        Ken Xue <Ken.Xue@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Daniel Drake <drake@endlessm.com>,
        vectorflaredesigns@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Grepping through the tree, "amd_gpio" sounds like
> > > drivers/pinctrl/pinctrl-amd.c so maybe Linus might have an idea, CCed.
> > >
> > > @Linus, the bugzilla entry has some more info on what happens.

I have no clue, someone with deeper understanding of AMDs bridges
and stuff need to look at this. Since it dies after a while I would
suspect power management by the BIOS. (Off the top of my head.)
SInce I guess these systems use BIOS ACPI for all PM.

If someone from AMD could pick up this bug, that would be great.

Yours,
Linus Walleij
