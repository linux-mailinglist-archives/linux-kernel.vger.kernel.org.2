Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDFC4545C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 12:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbhKQLlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhKQLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:41:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5927FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 03:38:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b12so4057868wrh.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PPCU7hY5WIQpQEUBCTOBPlcTnTVqbXfggMSZDrcXGo=;
        b=wAHi71g4DWv/y4nDbYi9yPhR6KhEWjDt7Q7MxvJWrggp6qwev3aMkLhWMn6Y7fCGfX
         LeQyhwa3nERI1Nf10F5pocT3g92TskczoPsqkkopD1HIRhdxtf59scoxwsi39ICcQIMC
         SWc9vX1P+9Eu61vW2+p8K/o+XqTdaNeKkAluTuo7aJ4rtCSvHM9HDgiYKptkS02wLY0m
         nW8vEaRDaoqloH39vRt8vcuME7+EAlKMZcRBH8mtHs2qy63r2baJEX+pV05d1YSac/HV
         sQBz8KIv0hotj3YR/gzL6o9qplH8QGUR4YKCiFBxdDFSqFmlJ7dZ4W1daBXrPEWnTFjZ
         WmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PPCU7hY5WIQpQEUBCTOBPlcTnTVqbXfggMSZDrcXGo=;
        b=YpZ+6baQntwTPgORVUpkEUhe6GAO+b+nno2TxZGSFDOmVxcsEZfmO+dBVbKoxPE2e7
         z8chQHN49BnFKlic6cGm1NeWhkHGAlZo55lQqMtk8ZOsT6ILd0fmVCykAl0caVcIq8r9
         aXguqX4Ph6ldgxqgmdRMjRzCCKzCCDyhHop66cg2hIb0cXkrVzOzjwckW6yOrK9Qn6CG
         /f2QfHVE83u+Xi984E1sywO2wD1lrS8vCRL3o5PR81nPKTcesXxkeJIrT0MdTJmNgyAf
         yIdfu3sKLmHW7lN27rj0uHYP0lkxcy2CkkGVIt0BrPaRT2r+/5/CkkrUeR6bUfl8AUDU
         qapg==
X-Gm-Message-State: AOAM532koSTZfv/pcu7LcvD8vEpkQqgQZ5chNYeBJ+0MVG0eGY6Xd1V2
        2/0quIZtuob/5A8yY/3f0fypsw==
X-Google-Smtp-Source: ABdhPJwKutddFipsem3C62zoVs/+c0JqVpN/0ghC52n5be0TtqM/R4/Y/s4lPWATlUwwtgECOCwzsA==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr18836154wri.250.1637149084841;
        Wed, 17 Nov 2021 03:38:04 -0800 (PST)
Received: from xps7590.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id t8sm6560453wmq.32.2021.11.17.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:38:04 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v2 0/4] Remove clock-lanes DT property from CAMSS
Date:   Wed, 17 Nov 2021 12:37:56 +0100
Message-Id: <20211117113800.260741-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 - Rob: Instead of documenting and fixing the use of the clock-lanes
   property, remove it, since it is is not programmable and
   therefore shouldn't be exposed in the DT.

Robert Foss (4):
  media: camss: csiphy: Move to hardcode CSI Clock Lane number
  media: dt-bindings: media: camss: Remove clock-lane property
  arm64: dts: qcom: msm8916: Remove clock-lanes property from &camss
    node
  arm64: dts: qcom: sdm845-db845c: Remove clock-lanes property from
    &camss node

 .../bindings/media/qcom,msm8916-camss.yaml    | 10 ---------
 .../bindings/media/qcom,msm8996-camss.yaml    | 20 ------------------
 .../bindings/media/qcom,sdm660-camss.yaml     | 20 ------------------
 .../bindings/media/qcom,sdm845-camss.yaml     | 17 ---------------
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi     |  2 --
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  3 ---
 .../qcom/camss/camss-csiphy-2ph-1-0.c         | 19 +++++++++++++++--
 .../qcom/camss/camss-csiphy-3ph-1-0.c         | 17 ++++++++++++++-
 .../media/platform/qcom/camss/camss-csiphy.c  | 21 +------------------
 .../media/platform/qcom/camss/camss-csiphy.h  |  7 +++++++
 10 files changed, 41 insertions(+), 95 deletions(-)

-- 
2.32.0

