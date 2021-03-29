Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CFC34D0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhC2NBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:01:41 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:65326 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhC2NBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1617022865; x=1619614865;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mcGLyeBHbHupbAzJ265cZuqLpTgtNeH2jrUrGG5QqJw=;
        b=Gfg980jPc9TeG767ZGBxH5NNlsTcb8cC04EmLZiCVnZvQ++yjIOh+iuewGUG//cB
        3wfAM2xTuP6APDNv+YWqqnpGMBiRvm+l99yp5lwIm6P2mGPxaAABc1wNKvEGypOB
        /F9238lZi434M8rJXznABRttYhNd3NGTykW6ycUaFk8=;
X-AuditID: c39127d2-85cb770000001c91-38-6061cf917edf
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4F.4B.07313.19FC1606; Mon, 29 Mar 2021 15:01:05 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021032915010554-253809 ;
          Mon, 29 Mar 2021 15:01:05 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH v2 2/3] ARM: dts: imx6: pbab01: Set USB OTG port to peripheral
Date:   Mon, 29 Mar 2021 15:01:02 +0200
Message-Id: <20210329130103.65857-2-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329130103.65857-1-s.riedmueller@phytec.de>
References: <20210329130103.65857-1-s.riedmueller@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 15:01:05,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 15:01:05
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWyRoCBS3fi+cQEg+bdehbzj5xjtXh41d9i
        1dSdLBabHl9jtej6tZLZ4vKuOWwWrXuPsFv83b6JxeLFFnEHTo+ds+6ye2xa1cnmsXlJvcfG
        dzuYPPr/Gnh83iQXwBbFZZOSmpNZllqkb5fAlXF+5mK2gitsFTv+NDA1MB5n7WLk5JAQMJFo
        WHseyObiEBLYxiix7MwdZgjnGqPEkd53zCBVbAJGEgumNTKB2CICORKnNm5mAbGZBTqZJH6f
        DO5i5OAQFvCT+L2EDyTMIqAqMfn+GbAFvAI2Ejd2rGWCWCYvMfPSd3YQm1PAVuLSkXdsILYQ
        UM3TKy8YIeoFJU7OfMICcoOEwBVGiafHljJCNAtJnF58lhlir7bEsoWvmScwCsxC0jMLSWoB
        I9MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjMDwPjxR/dIOxr45HocYmTgYDzFKcDArifAKH0hM
        EOJNSaysSi3Kjy8qzUktPsQozcGiJM67gbckTEggPbEkNTs1tSC1CCbLxMEp1cBYfDK66C9z
        b/M6v0M7Llz9pLJ+zcYtX8o+VXH3356ts+e715rtNtO1lL9YtYmduvBqdUeCZlG2VG7p3xaj
        QFM13qjI/WyF+2ey7+68NeWtVh13tveuD7feTLdkePfK8ldFW9CMeTE7OpfmL1NMFfyj/r/v
        SEv4/WqbDqYtvFlCIpOyDyY9PWytxFKckWioxVxUnAgAeh5BB10CAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a hardware bug preventing the correct detection if the ID pin
the USB OTG port cannot be used in otg mode. It can either be set to
host or peripheral. Set it to peripheral so vbus is disabled by default.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes in v2:
 - Added reviewed-by

 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/d=
ts/imx6qdl-phytec-pbab01.dtsi
index d434868e870a..b2f78b4362cb 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -164,6 +164,7 @@ &usbh1 {
=20
 &usbotg {
 	status =3D "okay";
+	dr=5Fmode =3D "peripheral";
 };
=20
 &usdhc2 {
--=20
2.25.1

