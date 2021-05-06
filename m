Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017BE375CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhEFVTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 17:19:20 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:25311 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEFVTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 17:19:18 -0400
Received: from mail-02.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 4Fbmd3067jz4x786
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 21:17:43 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="tly7cjq4"
Date:   Thu, 06 May 2021 21:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620335858;
        bh=WbErNjctHFDeme6xYOOtYWUvtSVdvDm3QyjUvzqlOV8=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=tly7cjq45DGKYenjoeYa32Qj3TY8BscAKPwFP96TIc9zq8K5amMwzS2W8eeq8dbiq
         0k20FmTzwXoA8lZ19eR0DKzAMAt1ucePbuQFqy5fhWLDS836w4/A0CubZQLS8czTCN
         nBk6FPlNqfWuwQiCLQoQ7AhuhrPryyVCj4f8Defg=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 0/3] msm8996: Add qcom_q6v5_pas power domains
Message-ID: <5JzviCPueYdcC0mDxsTnsVrkpfSjvvZ1QR0o8bMMEs@cp4-web-040.plabs.ch>
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

This patchset adds power domains required by ADSP and SLPI.

Yassine Oudjana (3):
  remoteproc: qcom: pas: Use the same init resources for MSM8996 and
    MSM8998
  dt-bindings: remoteproc: qcom: pas: Add power domains for MSM8996
  arm64: dts: qcom: msm8996: Disable ADSP and add power domains

 .../devicetree/bindings/remoteproc/qcom,adsp.yaml |  2 ++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi      |  4 ++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi             |  6 ++++++
 drivers/remoteproc/qcom_q6v5_pas.c                | 15 ++-------------
 4 files changed, 14 insertions(+), 13 deletions(-)

--=20
2.31.1


