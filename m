Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8491132C4D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354283AbhCDAR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388584AbhCDAMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF6C0604DE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 16:04:41 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id jx13so5261271pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 16:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=0PUvshgyVV4yWXxlheOB25MFRUTSbA7Lvy0ujbZz2vg=;
        b=E+pwGENB6dDKUN2ROFUd6OO3el01AwHnn4uae6vdXnNKWDL+N2lIiNQSViHnR2EJ2f
         c2mkD9hHhGUdXzz1+/sEfbhILwJi5IE5ye4AtiOFUD2IDbU7P/PLKYol+kvsCbNTgKGL
         ivhEyzG/QM4elkE+zynEP97E79AfUnh8qVri0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=0PUvshgyVV4yWXxlheOB25MFRUTSbA7Lvy0ujbZz2vg=;
        b=QibwDt6jnCiVtDhVlYmdhF466HaML1J69wromCv56gO0GE26cQmRCbnRbQnA+GIwus
         0IywzQvzyNALbHIhpRWkuFKXK5HkG5pbtRNQuh4uTXimog2Jm/iPzL+cvlLLBK2/Ud5A
         cSU+tkIBpexo2WLPJ+eJX4CG98Fm0SomgM+bEPd1xc0mg0KmMeUuZTOTg1Zoygdwi3AR
         jXmaB5h/ssseD7DjJt29/PvdAuovFsvgfshyV6X/hfJDvyWPGMaVQOrwCqkjLoAqc/tH
         2UUh5ga0N0bTIHXN/SRBVpJrX6ZiEiZa05jyAbKIv5wQqUjffK83hTPVTj91xM+76PZh
         gFUg==
X-Gm-Message-State: AOAM531mFgzMh5HfZt7ZG/zekErXiUwYIAUjqDJ5RFHFJVczDujBk+oY
        Lj/0uklA/r/3QWxdQckagCr9uA==
X-Google-Smtp-Source: ABdhPJy79CrkE5sjucekWVe0rzqDt6c/YxGJBccarSbwczdrr09l6Phnh+rnH0CugNa6WEs/Cu4UxQ==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr1548946pji.178.1614816281461;
        Wed, 03 Mar 2021 16:04:41 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id g7sm23253034pgb.10.2021.03.03.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 16:04:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1614773878-8058-7-git-send-email-rnayak@codeaurora.org>
References: <1614773878-8058-1-git-send-email-rnayak@codeaurora.org> <1614773878-8058-7-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH v2 06/14] arm64: dts: qcom: SC7280: Add rpmhcc clock controller node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Wed, 03 Mar 2021 16:04:39 -0800
Message-ID: <161481627947.1478170.131797678703607798@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-03-03 04:17:50)
> Add rpmhcc clock controller node for SC7280. Also add references to
> rpmhcc clocks in gcc.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
