Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE46C37527C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhEFKhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbhEFKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:37:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A5C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:36:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x20so7096927lfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 03:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXbQKzDbxQwqwkLGFQ0kqzvk73zXrjdXLLcNMoTV+r8=;
        b=EKJwqQdW7hdH0N+0G7zzaqw0678I42oJOPhKbcaU+aiQY4MPMMVqbYl7Foc5QkbTBn
         qsQXlg+ekmi6DvvQjYFHEilJzBdtTL7juq0eEH3BwcjKXcyOmlhSk5o2a3fOJ4zgzj7l
         DTcu7Wk08bmdkLWeGxXU4XuEy4XYY4nOSLWqcsEHi6IOLAVuG/aAOLTiFEEDbTS4k2//
         8sX+vTfytXkSYIalpuMPo0jgHFZL3pulLLPeE02LYOAt6M84bgdy11RFgwXJnGA2z8ya
         P4b17+UBSCEvGJrfG0mcitA9IEwypQHKV1Xjjs/rMg6NHkK5xAi0ZztCRba73XQDn1cz
         uvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXbQKzDbxQwqwkLGFQ0kqzvk73zXrjdXLLcNMoTV+r8=;
        b=gyVITmqgRDgb9Z5X22LIT+0NhpCp4N6kiqz+cv5XnRvui75Xs9lvaTudHePgNVtvn4
         9xEiRwq8zh8U2qtqmHh7Jdi0r76srTKHwICErBB8Q+2ak3aKxyroTZIyvHYMvAswvEu4
         cjU4PwGR3Tgtp/6UBUhEvMkq6S5ZoyUGGM5zmT/XuZmKW4gZUXUEAi0NOb+6F4L2up/8
         6ivDe8YJbHPVxbJQyDOEMtT67qncaa5I+sNrJVL/LNp6LTpz5dan1iFS9yHTP3gBJcWc
         BoZwWIJsAg5pOf1xfzBq7MpwrJD5iDm6WWEc+SIdkltSop1fF9S8LzpNd3tU3YlzkgjW
         lgMQ==
X-Gm-Message-State: AOAM531ZYvFxFd3hYByRSG6qXgdYeI95jFUDFeU8nhlVql5jHdg9ejL0
        U6eRwpVFuk87SGvfztZOTISyTghCW4AUZ5X3jOd9QA==
X-Google-Smtp-Source: ABdhPJz6obQ5zFKGwi0WheVhpUVw5Y1L6DwEcdTp0kskObIxJm1918KFGbwHbcS6FYyobPFu0XY446QPjXd7AVCNTUg=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr2400667lfn.465.1620297398076;
 Thu, 06 May 2021 03:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210503195048.1575007-1-clabbe@baylibre.com> <20210503195048.1575007-2-clabbe@baylibre.com>
In-Reply-To: <20210503195048.1575007-2-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 12:36:26 +0200
Message-ID: <CACRpkdZeTfRHO9EQ0L_ZCiSmqBtjMt4Q9Zb3qHRFgKNMburHqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: gemini: use the right rtc compatible
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 9:50 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> The rtc compatible was not following the dt-binding.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied!

Yours,
Linus Walleij
