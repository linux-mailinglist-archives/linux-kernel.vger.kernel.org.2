Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DD832A724
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575888AbhCBQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351093AbhCBNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:31:09 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE31C06121E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 05:16:28 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id r23so23860712ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7TMxO/D7a8csr+JUQ9kpEy7RKNnYl515YUs0lqH6AQ=;
        b=kpyPJ/xL4he3UejKB1Yg7LMDZ/4N3d/Jv8MsH0eBoX2a1nhUMsqMFENsdePu8i8v+I
         VKgI+BsBfJ3yjbJBWjTlGF1C+bUNJMKawxkz4QqEEA1+AM3gMTxKdknG+MszyKQ/E9kj
         luKyQvs0eSzodLiUNIqS0autQAuSluYfSKIE6+bQ+Fa7ZMqFvc10KYLCQrSxOQnD99Mn
         QYmkKscHuLjwB52OY073RDQS11o0xFLv5vodbmQMPkyMShWhBF2Z5OPFZJ3BzQplrQlI
         X2tBmvi975yCX94IjdKTQpTXQN+ouCCZhH5E2HwsyZhxuUfxYnNhUzshisz2/UYUqQpy
         yzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7TMxO/D7a8csr+JUQ9kpEy7RKNnYl515YUs0lqH6AQ=;
        b=oC9zNctohT21RwESTE+MTND5Nr8sH3iOd/Razi1V9mHoPlPkRMR6r1NtrhrTuAQo7D
         0e34vzYwewEJM/o6itWVBpaWWNbk7KHZj7kbwdPhC/ErM1kaw/Y8e47B+i1g8mkh8JAF
         CqlnuL3N8QndJxJJjagVqY1HTtG5PF82aej3z564cg6o9nF4qFS9w3/t3Z1LzCXbEWOM
         j7Ehh9q+3ICF8R65ehxo+fcuV/w0plnvOGdWLM2WyxeaejYjfcT1/y64CNVkvK7fO3PS
         MjfxBDz7VwEEbh8XFRuXaJ1HiOMSRmblTcCUhgXsouyaPryl8o3PLDjRth/yNMhuDQG8
         CbhQ==
X-Gm-Message-State: AOAM530Dnzi5/lO7fDHWiJt5PL7PbLxUYJZromUy1ZZ6M073an2W+qz+
        5VSX6N4+yCGZgqxcqT2Vf//3yW0zX2wJdus350aa6g==
X-Google-Smtp-Source: ABdhPJwLz47BG52rBTGPeD1OfU09SQGX018BFmLiaSkLzxHfaN66OaFtwRNIy6YfAjwqwAxOmn5sbqQHJadbpIbGXUI=
X-Received: by 2002:a2e:9754:: with SMTP id f20mr9797729ljj.200.1614690987196;
 Tue, 02 Mar 2021 05:16:27 -0800 (PST)
MIME-Version: 1.0
References: <1613105974-28181-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1613105974-28181-1-git-send-email-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 14:16:16 +0100
Message-ID: <CACRpkdbJ=4pctwDX9CSurkQC37TGF9KdUOkvTicspsqqS43kfA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sc7280: Add GPIO wakeup interrupt map
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 6:00 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> From: Maulik Shah <mkshah@codeaurora.org>
>
> GPIOs that can be configured as wakeup sources, have their
> interrupt lines routed to PDC interrupt controller.
>
> Provide the interrupt map of the GPIO to its wakeup capable
> interrupt parent.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Patch applied.

Yours,
Linus Walleij
