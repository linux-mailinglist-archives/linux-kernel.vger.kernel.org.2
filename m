Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68C2416788
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243350AbhIWVg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbhIWVgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:36:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE6C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:34:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i25so32018596lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwjuFFEYUw6qLa4G4t6xm8xsFy3ftvS5x0wrGV04jCI=;
        b=jZRRTpXoykphrWtGlmCGTQm7+dQBcpLvtXMU5q9RLQM0B7ggtcFJa3+gDaU0MTRjXb
         qrf8++lzMfJ9Su9/48gHLCX+Xkj05jEIg6OM1kHpfLvAYl0CM6ADq1aMAY91cVUxdaOn
         teJAnWphmD6obyQ58pohl3myJKlJuw+X7RTja2JlOKjLePie59S9v83OuJpbvxgJOvGi
         cLV2/2rmV04Z7cOrtT7m1lM7q1zvh2DpQcH4FRVIWf8GEuo1zaI2QM4fyaP2y4PwuNGl
         fpAlC0iafp/00PEmOMRggaojTHb+O94Coa1B1TOkuCpsl4jYpyVH6W/eFHj/wzzR+WM/
         KTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwjuFFEYUw6qLa4G4t6xm8xsFy3ftvS5x0wrGV04jCI=;
        b=2MfNKuBbsLOmOIQp8GKlPWzSiGuB0bllH0ynhoaPdTk08egtk0ac7/s0TUPfPo/Jug
         hfQblsnhjcNBxNGO1SNKEkVtvAlyxXxr45ZdLThm+kb3KTGGtg5DVn6HdYFdyJKEDq9l
         yiMM0Oht/aat2z+hNCIqBV9Qj9LBWy7yvib0lOmL1vo/xhAhnR94LkGu7Sw7fiMtaJeC
         9rw35MpZqrCnvST0YbMsUlkFD67/B9gASjCrJ9QBbIi/waeCIdCrmOKDC2lQzaPK4UDk
         PFOBHqmGRvAK9hSKKjjWHawnYa3PbLw3/yhdwiktNNJaPa/VFeKIa/PTPS5fXo5JDADr
         hHUA==
X-Gm-Message-State: AOAM532Ny+B+5++3dykBHnXkNYhnzFEd1LxHZ5Z5UDZrfMyqvRRCTyFl
        8s3gt3oAv65sko6ZSBEiQZ3QkYj0Bl0JAqd8NHFS9g==
X-Google-Smtp-Source: ABdhPJyZtA3tDkqn1sMYlY6x+GteCF64qDi14tvZqfNnSjwpru/kvnvXoFyvMmItzPeo5xawCArcnw1gMI5lGq9oC0c=
X-Received: by 2002:a05:651c:4ca:: with SMTP id e10mr7854021lji.259.1632432887920;
 Thu, 23 Sep 2021 14:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <1631588246-4811-1-git-send-email-quic_subbaram@quicinc.com> <1631588246-4811-2-git-send-email-quic_subbaram@quicinc.com>
In-Reply-To: <1631588246-4811-2-git-send-email-quic_subbaram@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Sep 2021 23:34:37 +0200
Message-ID: <CACRpkdYiK+KPjz8RZKcS6sgTk6-RgB=zVtbim6vaQyVszhhk7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom-pmic-gpio: Add
 output-{enable,disable} properties
To:     Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 4:57 AM Subbaraman Narayanamurthy
<quic_subbaram@quicinc.com> wrote:

> Add support for the pinconf DT property output-enable, output-disable
> so that output can be enabled/disabled.
>
> Signed-off-by: Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>

Both patches applied! Thanks!

Yours,
Linus Walleij
