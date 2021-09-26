Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A9418AA1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 21:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhIZTHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 15:07:55 -0400
Received: from mail-4324.protonmail.ch ([185.70.43.24]:25579 "EHLO
        mail-4324.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhIZTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 15:07:55 -0400
Date:   Sun, 26 Sep 2021 19:06:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1632683176;
        bh=lTmKN+WNUyYt6gy0Mw6k/pJmZMjur5+0ACFflivi3Z4=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=k7RnTLj7WfrdTiPaJ35j0ZgEodtPtNE8CsmH+Kx7CebVv8fveGv/PSCpYK/JwANCz
         cmw9JnqlMFI6N2uHSk/lGEkMiYqyEDMqySPALiTobmz6z97Mj6ikeTN1LNVf2Gmqtf
         47K3woLhCBa8TThLc0HO+6u19V4w0J0ZNWuKMwmI=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 0/5] msm8996: Enable support for MSS and SLPI
Message-ID: <20210926190555.278589-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes reserved memory regions, adds a missing power domain
for SLPI in qcom_q6v5_pas, and enables support for MSS and SLPI in DTS.

Changes since v1:
 - Rebase on latest linux-next
 - Rewrite MSS node
 - Enable MSS and SLPI in some devices
Changes since v1 (2/5 remoteproc: qcom: pas: Use the same init resources fo=
r MSM8996 and MSM8998):
 - Rename msm8998_adsp_resource to msm8996_adsp_resource
 - Add power domains to slpi_resource_init and use that instead of msm8998_=
slpi_resource

Yassine Oudjana (5):
  arm64: dts: qcom: msm8996: Revamp reserved memory
  remoteproc: qcom: pas: Use the same init resources for MSM8996 and
    MSM8998
  arm64: dts: qcom: msm8996: Unify smp2p naming
  arm64: dts: qcom: msm8996: Add MSS and SLPI
  arm64: dts: qcom: msm8996-xiaomi-*: Enable MSS and SLPI

 .../dts/qcom/msm8996-sony-xperia-tone.dtsi    |  18 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |  30 ++-
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |   9 +
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts  |   9 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 195 ++++++++++++++----
 drivers/remoteproc/qcom_q6v5_pas.c            |  27 +--
 6 files changed, 209 insertions(+), 79 deletions(-)

--=20
2.33.0


