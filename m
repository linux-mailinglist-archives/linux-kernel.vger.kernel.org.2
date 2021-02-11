Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44475319401
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBKUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhBKUDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:03:53 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B41BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:02:42 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id f17so3231857qkl.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGWXC1tvxeiuqJ7onGaG0KHJFRjfviIJBFxWQD4b7Es=;
        b=skTDKy4orqOPgPVBqKJ3BzPDvrEJ9mDiyzaDcDzntnP5yOc16dAQWJzceNEXZN1kxB
         7wVrevqEc4DylfzG8bDoTl6Ca/pqULdHdilxM1Ss2m8ET1+v6otnmJwWli/gme9X0rt1
         YGB80vDKquq58WCTUXwOdIfcpfUucjfBT8aSh386xFj1LBdHe3Yf/8XGZUcD5JSqwKIW
         p8UCK+2BvC5Gg5lbvs6/ZP3S6rv/JQBexefYL3lEIoYOC1TB7bIHjm6X7jbZF/PM0KT9
         76VUkhvXov6BNr2cxS9vQhUyBz/zUZ/AdLYOk6YGtRZPyJaHkO5OWkNgx8JSBqfd0JxL
         yn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGWXC1tvxeiuqJ7onGaG0KHJFRjfviIJBFxWQD4b7Es=;
        b=n7LZQYneom9pLyQXmJDHyL/bABfJTmVfO1fR6+FB2oc/J2myiCb+26N6AzMsO8DrRI
         a/fa3adGjbCap32u/sdogGCPGmcxua6u/n3eUK7hKnZ3IoAfbm2BC+UbJcoigHQvmM8i
         z8XusNh9NlBTlQ+n9WAdn9u36bD+QvX/Qea/Vjl7B/9GtyB0RB42Or3uIBSA3Rptu1oH
         YkNBNhNNKORNVaI5UIcLUGkwSasfyhZ+HoVcqe8KyPU2UAh0GAx0OudKiktWbG2bXrJb
         2VhhGQez/wvoJit4o4YIp3g590JzZ9TLmUQZGbu1okGISptBgtLryBdsCCi4jzX8lChL
         Imfw==
X-Gm-Message-State: AOAM532BxzmLS7AmaMx926oF9SIl3yap1HM3438V9E2sarSkKML6VCPn
        6TSgU1ItDRJ3509BogO1QiwX8iibUIENfpzHMq6Guw==
X-Google-Smtp-Source: ABdhPJwriuEE8h6tPlFkxz6xc6fNn4uHZxsu9IWNBRkn6E5TgdCSuTg/FIf49sgv1o/VJnNT98KvFWeAbP8SUk4Bk3M=
X-Received: by 2002:a37:a9d6:: with SMTP id s205mr10559165qke.162.1613073761910;
 Thu, 11 Feb 2021 12:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20210211193637.9737-1-georgi.djakov@linaro.org>
In-Reply-To: <20210211193637.9737-1-georgi.djakov@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 11 Feb 2021 23:02:30 +0300
Message-ID: <CAA8EJpry+Nz_W9q00tsm9qNDNbeZOzyit_1KafP34PQH5LioAw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: Fix epss_l3 unit address
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, sibis@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 at 22:37, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> The unit address of the epss_l3 node is incorrect and does not match
> the address of its "reg" property. Let's fix it.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
