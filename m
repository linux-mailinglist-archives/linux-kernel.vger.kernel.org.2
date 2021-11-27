Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB53445FC26
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 03:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349916AbhK0CqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 21:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347044AbhK0CoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 21:44:22 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405FCC061D6E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:42:35 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so16244502otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQwGfAEQ9tTkCAn1f24DHbiIeo8rUmB7ddNKOWOUHJc=;
        b=BhPYaVeSbPbeQZ3GYS767JtM88thRsy5ViGN9+kQpAdWm2vakbw+WwL3fsPKcjQ4Dx
         hHCzZZmLOtSNgm/9pex8jzLpD1SJHhz+jvg0RQ3pCybSgC6pwPD/uY/BsOdlAWKSLOfA
         dDqKe97+sO0OFdzGMnsdBvc+m/c3SsdmoIG/iIeBiwZU68zHyy0CGEeZte1UAqgI78CV
         qblbyeA1gg5at5FF1pAeQhvyAMEzIpU09l7QSMWs2X3bzXRDR9mZiPCHo5TdxLV8XJGZ
         U3ydDEQnkdIWq5RnHXFIh0xenePht48PIIWOLIobWiOCiaadxJ0O5oDdxojfSlzORLBy
         EWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQwGfAEQ9tTkCAn1f24DHbiIeo8rUmB7ddNKOWOUHJc=;
        b=bqKr4+4l/QbyxKF/sEZY1FHwgXjhir4swO2ERxy8pelEOxLvBQkvRRQnHic+9grf1V
         VH66lhgchW4WDpwUoEltOl17wOPLIxYbUJq4ZfHvuXivnFJvkl4r/zBhHWJ0PsfklYoV
         g4MwjvyfcTB+0+tCX0QxMwu8r1bZmjhPh2a7DDuaRI/ogJvjUzSurzPXOXiFG9TjL0LL
         yHqeDQ5KrVREK7SW7zpWLHGwDAx4S0Ae/aJQbnXXtRAtgwi4+4o9WFdZGRHa1oSBPOdp
         UXSplN4lU8wqJIiR6VWWzTATsnjP2DAt1allNzsRRk+gMtVXY9j/oVYIB6IhT/sJ7mCr
         2XGw==
X-Gm-Message-State: AOAM533uognakU0dlQuSitqIZw4eHrouoCbVc/vj3nltxwLOV4SrfOYZ
        Sx/GUJTUDWPYCxBtbKnz4ebZHF0AmhdxxKFKKFrKbA==
X-Google-Smtp-Source: ABdhPJyCC0XKdwGnBDTnbE7V2N7wWV3Nunjr0LpiGCkTE7FCS6sKaP9wakfcDOMsNPjBcdsxqBqU0oSmw1A5/81D7vc=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr30461397otl.237.1637977354551;
 Fri, 26 Nov 2021 17:42:34 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdau+wHpoWa1JrLt35dnCHJejs8HZkkzZCrrcnRCx3SinQ@mail.gmail.com>
 <20211126163657.65471-1-dominikkobinski314@gmail.com> <CACRpkdYdOvpS0GgHw9UfMrfnUeEphKUk-y-0vKYSsS9dWc3r3g@mail.gmail.com>
In-Reply-To: <CACRpkdYdOvpS0GgHw9UfMrfnUeEphKUk-y-0vKYSsS9dWc3r3g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 27 Nov 2021 02:42:22 +0100
Message-ID: <CACRpkda9PkXZugE2vFnw+BhSrN-wJvX0Yu1Nffyd9qqg46ijoA@mail.gmail.com>
Subject: Re: [PATCH v2,1/5] pinctrl: qcom: spmi-gpio: Add pm8226 compatibility
To:     Dominik Kobinski <dominikkobinski314@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        ivo.ivanov.ivanov1@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominik Kobinski <dkobinski314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 2:37 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Nov 26, 2021 at 5:37 PM Dominik Kobinski
> <dominikkobinski314@gmail.com> wrote:
>
> > From: Dominik Kobinski <dkobinski314@gmail.com>
> >
> > Thank you for applying the patch. I believe the second one in this series (https://patchwork.kernel.org/project/linux-arm-msm/patch/20211125215626.62447-1-dominikkobinski314@gmail.com/) should be also applied to the pinctrl tree.
>
> Looks like the regulator tree should take this one?
> It is a regulator binding...

Oh no the one on the link, right :/
I have already applied that one?

Yours,
Linus Walleij
