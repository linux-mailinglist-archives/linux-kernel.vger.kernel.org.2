Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346D93E8FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbhHKMBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhHKMBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:01:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BECC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:01:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so5169427lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3GJTHSzcRfHRR7rYGofO7K/3tvMaQU+g+vXNUrYfNc=;
        b=s8jSb/4Uxm7mLtCWQ2a4ZTfZNKh0PtCo+djrABMmW9bWNgE7UtV3CM2Nn+QNxReuga
         UaW/eQhPCJP6y6RUK1U2BdjaY3497uDkyKPiZXuyDtEY9oitBvzPhnvauHAbdfWA0Mwv
         PBW0sy6nkTx5NyMZu4n1vnT1YjISbuHLBQSfrSyiqFTmQCPqTwpEUuwldJvOObR8QPtg
         gj0Nngb6I2Si6VNexA/DIbO8AD1h6bpUl8qlVCay2qX3If2E1Jph3ZeWi+vLsF7aGVQy
         qm/KBlXngnTnojVwCGJc3n1phgHBkCKkXgBf9vjJGC9c+yUxu6R7h9RAaFSBmRbW5Okm
         iZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3GJTHSzcRfHRR7rYGofO7K/3tvMaQU+g+vXNUrYfNc=;
        b=rOjaVAHgqF2bpR2llm5Jk9UCOek9SAOAS7sifQlHL7DJgsBGV6Fsol2sYjRIFcVpz+
         HiDHbOhHkcRbKOlnVWMjsXTzPEjn1eGEMG6e2ZDNSpTsyy017AbD1nud3Fh8f4KU1RMo
         YbhlyZUk9u3zd2B+Rv9wFzOZUYdjGMHDSgDpUg8F+wAK9e0GK80Ts/dqwCtgZWEBKxdL
         v1W0dBGpOKRFUYfBk6MZoMKr3HBzn+I85p1zFS76zZYfl2cmB2OHURmBijrhzBEr+Qgr
         tyII4W4w7TE8gtAFO3/2Ae6f+YpySAOay2tV9l8z1qihqK5BnkP6gPC/QA1B7YnNzTvk
         aJcw==
X-Gm-Message-State: AOAM530Y8tMCeMUWLGVNt3r5udaJZEymFxmujh6JzQeo10O7JmCANc0P
        ej4tqnHl3SmX6/9ZlYU/eTrfTkPk7eLxuQw2lajQgw==
X-Google-Smtp-Source: ABdhPJxASVpzZF63UvkPFlBxtwrWbbdQ5itq42p8VSocVX8aKD/TLTr8NlFYMefpF+MYtCEpIEz1YBiNJfYM7nhiEsU=
X-Received: by 2002:a05:6512:32a3:: with SMTP id q3mr13681368lfe.157.1628683272677;
 Wed, 11 Aug 2021 05:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <1627910464-19363-1-git-send-email-skakit@codeaurora.org> <182fc9a13b78d114bd209f9658274f0c@codeaurora.org>
In-Reply-To: <182fc9a13b78d114bd209f9658274f0c@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 14:01:01 +0200
Message-ID: <CACRpkdYQ-r2Xw0BHt0Mu78FWemXWU0jjKixTSPpspH9wkEmtCA@mail.gmail.com>
Subject: Re: [RESEND PATCH V7 0/3] Convert qcom pmic gpio bindings to YAML
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

On Wed, Aug 11, 2021 at 8:17 AM <skakit@codeaurora.org> wrote:

> Can you pls merge these patches? I have rebased them on linux-next.

Yeah I tried, hope it worked. Sorry for the delay.

Yours,
Linus Walleij
