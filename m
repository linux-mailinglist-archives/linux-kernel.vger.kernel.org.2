Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F7C430A26
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbhJQPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbhJQPdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:33:35 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF2C06176D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:26 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v77so16617418oie.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHs/CYcm2qKRKw2WotgRIQKXcOHYWF5rKMY3LC5HdnY=;
        b=kgg1PBx3V0Co2ywaEFgOub/6RanqM1JagwdUiSWUyPi53pXZV4POksFqGjkhWlTtW6
         WlKLJv8s24BwZhl+YdIPHm5CrneU7GcaVHpYABlcMsSyP7baKHWE/wB1b1BflLOFKc5/
         f69KUatQ7WWVDoINE9UZaganUHuGvm+uZ/tEgbKAnzSgeOTzdLy373gr67LIiJH4QOU4
         NYh8kFcKmyQzM8z03UbLz99AoGB2zbw3Kj78nhx/iMte/7ThAIW8JGsGMpBiFsTDa42S
         i1ByhkEP8iC24rZmVbB1nAGz3uzLOH60PkVAyvYOKy1x8RDDwhwGuUfftxxPtwJIwX0d
         1HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHs/CYcm2qKRKw2WotgRIQKXcOHYWF5rKMY3LC5HdnY=;
        b=bhU0Nme0lxMiXUtteemuAXzh/ro8rlI97+44sYgKjQNa1KUzE0MFwTjjIKO/usmTql
         kuva/ww1jgx0cAgRd05kuu9I1sQ4lo/AvI9AASPkGrF7npQOkYcaUlHCR8trJPwakNI7
         7obFNdVCnm9HgTRMD304orRAjqnqRQvUrPZgMd309nYdZcH5pw/0tfPNNwBQDiyHH4Jb
         FmPUfoeaK7je5PV9lQPkbgu/47GD2gbN+1jhFf0DXVlOgRBzSF7G6B2FKSCMpzvGFgzB
         LyGOWudj7jSUd3cnguA7Z+OnbMGGlUfFX/mI7II4xUi0uzqkRaKmA7OvDXtAHwcIe8MX
         gPUw==
X-Gm-Message-State: AOAM532yfLa1CNOLzks0JsjtDcptkGOvHgbaTuelFIiR3YngSkV+6xez
        8oMmjGdiuMJDPQX8uM2V0JpU1w==
X-Google-Smtp-Source: ABdhPJyoKBhysey+HUBoaspOx6durmCbGKIDzgFX90eJiuJCZ9vXUITaHoWQ9yrCq7T3kYPIEmbEqA==
X-Received: by 2002:aca:db8a:: with SMTP id s132mr25047575oig.119.1634484685445;
        Sun, 17 Oct 2021 08:31:25 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x6sm2565698otp.49.2021.10.17.08.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:31:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: (subset) [PATCH v7 0/6] clk: qcom: use power-domain for sm8250's clock controllers
Date:   Sun, 17 Oct 2021 10:31:11 -0500
Message-Id: <163448466184.410927.258014767858670421.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
References: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 18:47:49 +0300, Dmitry Baryshkov wrote:
> On SM8250 both the display and video clock controllers are powered up by
> the MMCX power domain. Handle this by linking clock controllers to the
> proper power domain, and using runtime power management to enable and
> disable the MMCX power domain.
> 
> Dependencies:
> https://lore.kernel.org/linux-pm/1628767642-4008-1-git-send-email-rnayak@codeaurora.org/
> (pending inclusion into 5.15)
> 
> [...]

Applied, thanks!

[6/8] arm64: dts: qcom: sm8250: remove mmcx regulator
      commit: 266e5cf39a0f25787cb66a36dde50799194062c6

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
