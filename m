Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5714D344C26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhCVQrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhCVQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:46:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F49C061762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:46:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v2so8985401pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8PazbWxeQpma3IK9jRB0TxFsaKkwjN5cuc0b0m+m2M=;
        b=UgV9kb14Gw4R34p5xUmBTt8q+u5oEX+RxwQbSY3HXJiRAlI45HxDtvI6W2fFQEQCtT
         6KbqheLyTBqYi+LLbOWxxy733aWQLMRdjh35a07EZqY4E42N8ZQ9qHTJ5A70871Hcydv
         ZnutsWYUz0d5kRb2wGRXbKuZcYnUvS8pQvfkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8PazbWxeQpma3IK9jRB0TxFsaKkwjN5cuc0b0m+m2M=;
        b=p+JObdwoTKmMNB4uwseBd00Y+Rq/5Cn8SFbRO6vvZtaZaXELnvk1jax8TzwzUW69bX
         ZU3YeSTgZTIBbh6ZFAJpaCtEimxh03K5RgXA7fXFcizBnJ1yAlzPYdtDfDk3UVmmw2pW
         17IcYo2Te2Ocxc5ck5GD6o4Zey7G5KTFGR1RWI0W+lnANcA0Qn96rW+5Ya+nyvvvThrU
         8053PgmyuIHXBLEFpNsrR02e1MnQ2uNUqyWHOTs3TUA7nRbhIvd2fdwLMCyx4onSTKIU
         sPLeBbDD0ir7YYz86L/AjRSWE6ras8zEH5WIVix0J9qivLpbCFAMitMikD0E02zuE5Db
         ozEA==
X-Gm-Message-State: AOAM530z1EGbvH/snI7nJ//+ia0zv3N3co79q3X0K4sqzpWQYnFdjQvV
        Wdm5iiK6AZ2HYY3waj8s03edpA==
X-Google-Smtp-Source: ABdhPJz690StCJPSqdkX0s46VJ/Ko2b34LTzJJ9tEsUh8AWx/L+1e2suCM3t197P1tuQ/7b4Cx8csw==
X-Received: by 2002:a62:380d:0:b029:218:66f7:f7cf with SMTP id f13-20020a62380d0000b029021866f7f7cfmr725421pfa.30.1616431599315;
        Mon, 22 Mar 2021 09:46:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:90a9:b908:f93a:2f78])
        by smtp.gmail.com with UTF8SMTPSA id a144sm15264716pfd.200.2021.03.22.09.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 09:46:38 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 0/3] arm64: dts: qcom: sc7180: Disable the charger thermal zone on more trogdor boards
Date:   Mon, 22 Mar 2021 09:46:32 -0700
Message-Id: <20210322164635.273729-1-mka@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already disabled the charger thermal zone for lazor to avoid
bogus temperature readings from an unsupported thermistor. Some
revisions of other trogdor boards that are added by Doug's
'arm64: dts: qcom: Update sc7180-trogdor variants from downstream'
series have the same problem. Disable the charger thermal zone for
them too.

This series is based on v2 of the 'arm64: dts: qcom: Update
sc7180-trogdor variants from downstream' series
(https://patchwork.kernel.org/project/linux-arm-msm/list/?series=440315)

(no changes since v1)

Matthias Kaehlcke (3):
  arm64: dts: qcom: sc7180: lazor: Simplify disabling of charger thermal
    zone
  arm64: dts: qcom: sc7180: Add pompom rev3
  arm64: dts: qcom: sc7180: Add CoachZ rev3

 arch/arm64/boot/dts/qcom/Makefile             |  6 ++-
 .../dts/qcom/sc7180-trogdor-coachz-r1-lte.dts |  4 +-
 .../dts/qcom/sc7180-trogdor-coachz-r1.dts     | 13 ++++++-
 ...e.dts => sc7180-trogdor-coachz-r3-lte.dts} |  6 +--
 ...hz-r2.dts => sc7180-trogdor-coachz-r3.dts} |  4 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts |  9 -----
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts |  9 -----
 .../boot/dts/qcom/sc7180-trogdor-lazor-r3.dts |  9 -----
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  9 +++++
 .../dts/qcom/sc7180-trogdor-pompom-r1.dts     | 12 ++++++
 .../dts/qcom/sc7180-trogdor-pompom-r2-lte.dts |  4 +-
 .../dts/qcom/sc7180-trogdor-pompom-r2.dts     | 38 +++++--------------
 .../dts/qcom/sc7180-trogdor-pompom-r3-lte.dts | 14 +++++++
 .../dts/qcom/sc7180-trogdor-pompom-r3.dts     | 15 ++++++++
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  | 29 ++++++++++++++
 15 files changed, 112 insertions(+), 69 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-coachz-r2-lte.dts => sc7180-trogdor-coachz-r3-lte.dts} (69%)
 rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-coachz-r2.dts => sc7180-trogdor-coachz-r3.dts} (75%)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dts

-- 
2.31.0.rc2.261.g7f71774620-goog

