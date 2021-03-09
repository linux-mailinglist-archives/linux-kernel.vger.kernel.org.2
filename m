Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F97332F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhCIUF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhCIUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:05:18 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD968C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:05:17 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e20so3358766ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kohwRGgEQaCo3tkVZ/WeefWjMw7rUpI7M2Guk4ayfeY=;
        b=S13/iT8hpP3g4wvVRrgM3z+9NAV7Zn2ysUe5VpbU2RnXwT1e/Sw+vKdkSklZmdAUHL
         f/moaaV4N359aLcYjVPvLeF/igF3xPAQ1mpjjLQ2OabAW2f4RbnjdUEnrNVg3pua6/D7
         W6MegJ3ZDJ/ebxGGMA69l8lCNgL8k8g3/dMV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kohwRGgEQaCo3tkVZ/WeefWjMw7rUpI7M2Guk4ayfeY=;
        b=Y0LtQtcFgQyDZ20UzEC2cVHsbQRf19eihjVCeBEKhXgwhZZjeCsL4D+L/fo8XwJnJY
         jDApGGG1wKuktDF29fQwcFtMk3FRTMJx+dNqBRYET7RORc+4faGx4ICrbp0APBY5nPjM
         MornyGCsrP+GQeuRfhtWO+NhEbXbFFeL6MxXs714QUXh0h2/xpxKC7IobGsw6EuuuZHF
         mLOpPUcF1sxixaPBxULMIerAIKl+hfTAS8p1QuOQpx1to33PmAd1gKeePOf9C73J6VtO
         5L9q3inz4dU1rTOtWsgRTp32yAJ497CrmDc22AIz5Hu0k+qg0h2DjixzfWzSyxPN2J7H
         rWbQ==
X-Gm-Message-State: AOAM532BvOOmgB14zQQKV8OlVvioWQpWvTddOD30f9RnKJyOuohrY0wz
        TLEJ1mtBYyRgvjbwJPqOGFarK/UoqOlAug==
X-Google-Smtp-Source: ABdhPJyXFB8XTk1ocmu5HSLvIonz6dZ+7NC+te0FH/Vt3SgccaB9F37jm1Ro4Xuke/kWLcKPt1GXRg==
X-Received: by 2002:a2e:8987:: with SMTP id c7mr18203141lji.185.1615320315898;
        Tue, 09 Mar 2021 12:05:15 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f25sm2094563lfh.226.2021.03.09.12.05.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 12:05:14 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id q25so29308001lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:05:14 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr17726280lfu.40.1615320314276;
 Tue, 09 Mar 2021 12:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20210309153443.16647-1-brgl@bgdev.pl> <CAMRc=MfO7J1z8oGy+OiRR000dJAYg1LTynz33Kh6BMb1hUrg5g@mail.gmail.com>
In-Reply-To: <CAMRc=MfO7J1z8oGy+OiRR000dJAYg1LTynz33Kh6BMb1hUrg5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Mar 2021 12:04:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiiuSPZGh1ai_NuV8BHgXO36H_aQ28Bx1u82gE23S1u0g@mail.gmail.com>
Message-ID: <CAHk-=wiiuSPZGh1ai_NuV8BHgXO36H_aQ28Bx1u82gE23S1u0g@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v5.12-rc3
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 7:43 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> I realized only after I sent out this PR that I had rebased the branch
> on top of v5.12-rc2 (because of the v5.12-rc1 situation) without
> --rebase-merges and this caused git to drop the merge commit for
> Andy's pull-request. Please let me know if you can pull this as is or
> if I should rebuild my branch and resend.

This is fine - it's small, it's a one-time pain, and there's that reason for it.

So as long as Andy is aware of how his patches got rebased and don't
match his branch any more, I think it's not a big deal, and I've
pulled it as-is.

                    Linus
