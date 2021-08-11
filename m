Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A43E8FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhHKMA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbhHKMA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:00:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96637C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:00:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d4so5098961lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QntYPwFND9ivHl8sCJvuIY4mpIehwKkRWinAMkSwKQI=;
        b=Q0Rl26bYxsSXpjb/CTuzjeMm5nCjftG0kx2CothuzSLlucNNJW0/NiYUD+62g5T/7F
         Z6Kfdw4iijdQB++sg5aqqT5FQ0Tb3T5im+W0cIQIlxEl/a066C0h+hS3qpvE4YxDcHjf
         6jBnQ1Rd6eFzB3xnkAlhaTdmU88Vw6bFzINRxoDxd0bGZTCqRQIG7K+by4B9VecmTBmd
         md+lPrseDhnPsickBg5Ex4+ZC+BL370H+N8yZipMuK1n/5klrHg5Zp8AdANs3POX0LYd
         KR8d5D3i3fl6Lev3XJrkthKG2Y/zZvfBJWQH7X8WGaIvMNexPiteMDzi85vfI244aZFe
         uaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QntYPwFND9ivHl8sCJvuIY4mpIehwKkRWinAMkSwKQI=;
        b=V3yrM7d5jy2dBlbBLNRn/yBfK6U0EGCJfXYGJoxlNxVomtdsnF8/TIq4WbKcdtq8eP
         DmJn8Jw/rMZGpU3AmN2gcEHYb/aaerauafbEJ8R+8+hKK+0RVLL4chgUSJXhT09R5yqa
         KJDHAefjDXFdgV3ve9BQP+A1dgDufDZe2i1G5mxko/TyfPLxZmeJn0q0+CkDe93WOgGY
         vQeFWTEeAo6dBGllCA2z1WcqjrzBrhPl2T2iwqwQ1pKx/VvH/gIywXbhHliYYXbcLeiY
         Xn+cpOg/7vesADZEXHQ/5JYHgEocuupqZ0a6R+8SVyxKwZIpyuUtYs5VdVIXh4JAeJoS
         QOPg==
X-Gm-Message-State: AOAM532QD2IHq9xEmjOeQXxE2xETXKhjmgNBfR1NGLfoUa72uElhnDRi
        cgzqpnumjM05D/cEC+hlamq7jxapXP0PKFtQbzLPSg==
X-Google-Smtp-Source: ABdhPJzqoMybmK8uaattKPYwTnFX/Xb8AOXz9OVi7tq94+ZUBT0mQ9v5TUujLzeL/jhAn7u4PSiH8KInRYVs+H4KkXk=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr25656028lfd.529.1628683201902;
 Wed, 11 Aug 2021 05:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <1627910464-19363-1-git-send-email-skakit@codeaurora.org> <1627910464-19363-4-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1627910464-19363-4-git-send-email-skakit@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 13:59:50 +0200
Message-ID: <CACRpkda6f0QTuW2p13OyPDer4B2NgAMWC5FMN3XrGx5NfL=zUQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V7 3/3] dt-bindings: pinctrl: qcom-pmic-gpio:
 Remove the interrupts property
To:     satya priya <skakit@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 3:22 PM satya priya <skakit@codeaurora.org> wrote:

> Remove the interrupts property as we no longer specify it.
>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied!

Yours,
Linus Walleij
