Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6D23E7DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhHJQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:46:10 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:49981 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbhHJQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:45:02 -0400
Date:   Tue, 10 Aug 2021 16:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1628613875;
        bh=Ll0u5Co5TwfTM61G+RgZrA/gi2M1Kdi6N1rb5eGP1qg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=sAOoVWZvDuBdxZDUClA2qKnX4K2YrS2XK0D7JR+DeAAOgN9P45ePyndVl28wWTXlZ
         4mBEzdYy4Iklx2z8yhZele9MsfB+JUU2IfDN3oY2/J9OoDTYx9kfD/jFipYEkSgsB/
         1nC+Rt9tMxttJkgLeOyd1gqizQc+1ds25eF2Ocao=
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        jassisinghbrar@gmail.com
From:   Sireesh Kodali <sireeshkodali@protonmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        sivaprak@codeaurora.org, Vladimir Lypak <junak.pub@gmail.com>,
        Sireesh Kodali <sireeshkodali@protonmail.com>
Reply-To: Sireesh Kodali <sireeshkodali@protonmail.com>
Subject: [PATCH 1/4] dt-bindings: mailbox: Add compatible for the MSM8953
Message-ID: <20210810164347.45578-2-sireeshkodali@protonmail.com>
In-Reply-To: <20210810164347.45578-1-sireeshkodali@protonmail.com>
References: <20210810164347.45578-1-sireeshkodali@protonmail.com>
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

From: Vladimir Lypak <junak.pub@gmail.com>

Add the mailbox compatible for the MSM8953 SoC.

Signed-off-by: Vladimir Lypak <junak.pub@gmail.com>
Signed-off-by: Sireesh Kodali <sireeshkodali@protonmail.com>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-globa=
l.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.ya=
ml
index 8878ec00820e..58e7250a41be 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -20,6 +20,7 @@ properties:
       - qcom,ipq8074-apcs-apps-global
       - qcom,msm8916-apcs-kpss-global
       - qcom,msm8939-apcs-kpss-global
+      - qcom,msm8953-apcs-kpss-global
       - qcom,msm8994-apcs-kpss-global
       - qcom,msm8996-apcs-hmss-global
       - qcom,msm8998-apcs-hmss-global
--=20
2.32.0


