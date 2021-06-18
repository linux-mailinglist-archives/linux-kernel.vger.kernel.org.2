Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F51D3ACD51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhFROSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:18:33 -0400
Received: from fallback20.mail.ru ([185.5.136.252]:47708 "EHLO
        fallback20.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFROSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=As/vTvEDvAEfJf63ojCbMbiXJJ3v3EFv3dCOx9D7Dw0=;
        b=VoEeXCH390P/H+veFV1NqKgvqPkmGSAD/MCU24R9N+bJMcK0rw+b+XvMkOCtlSlVV3yiEi5oacMBkRziyAVInu0W23qEaQioTXyqX5spdxY6b7DsqX0uUvmP8rkTc7wnUCtL0xZnT30hYXWX2keB1eSgWhfZdjFqKRvWCJvpY60=;
Received: from [10.161.64.51] (port=56998 helo=smtp43.i.mail.ru)
        by fallback20.m.smailru.net with esmtp (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1luFID-00022j-EL; Fri, 18 Jun 2021 17:16:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=As/vTvEDvAEfJf63ojCbMbiXJJ3v3EFv3dCOx9D7Dw0=;
        b=mgnYyKsaF2Bu89Y4knxwUDH598l/vVxqyp8ZHPpTf8OyyWzbtH1kx4YyzFMGiPjZ+8yLav2HEduG6sa+lmZITjXsTNzcuXUiyMhJKYy+amUkqXkXC3poMyXInmUB9O4SP7Bu0VpvtLnUOBGj9w+9WGCYTk8ciMwOZBXsAeIOlFw=;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1luFIB-0002kG-5N; Fri, 18 Jun 2021 17:16:19 +0300
From:   Sergey Larin <cerg2010cerg2010@mail.ru>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sergey Larin <cerg2010cerg2010@mail.ru>
Subject: [PATCH 2/2] dt-bindings: regulator: Add MAX8893 bindings
Date:   Fri, 18 Jun 2021 17:16:07 +0300
Message-Id: <20210618141607.884-2-cerg2010cerg2010@mail.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618141607.884-1-cerg2010cerg2010@mail.ru>
References: <20210618141607.884-1-cerg2010cerg2010@mail.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD91C2C07775F13263AD4A2A3BFBC817E640615893838B9A94F00894C459B0CD1B9A8B1D1F4FBDCA47B30039653E01B451B6789E044FBA7F352036170912EE13762
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A548C5E803E75135EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063716A4A39B750036BB8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D80D157CCF8DE095AA3419C7FA6739A9AC6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7985FEE833124D2D39FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18BDFBBEFFF4125B51D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B5FC25ED3FCEC3375A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FCF5CE31487DA1EA653AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F79006376291A7C6AF2C4E0DD81D268191BDAD3D698AB9A7B718F8C4D1B931868CE1C5781A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F06F6F51F7D3AE627156CCFE7AF13BCA4B5C8C57E37DE458BEDA766A37F9254B7
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A24209795067102C07E8F7B195E1C978319F67E0D6866C04F89BB839037DF3A6B5
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C128C1281A48FD13C2E7C0033156B2A5AC2694DDFA6E2B3C99C2B6934AE262D3EE7EAB7254005DCED7532B743992DF240BDC6A1CF3F042BAD6DF99611D93F60EFE954A0C70C50C109699F904B3F4130E343918A1A30D5E7FCCB5012B2E24CD356
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34829444FF2D8CB89BC5B97CFFBA1E4503E1EF885E4FFB62936CCF59603FBF49FC5FD17E396BDFC8E71D7E09C32AA3244C60A2FE5A489729F357A93E90A765DF2369B6CAE0477E908D8D5DD81C2BAB7D1D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj0Roc5o5ut96wsJfFAVRJIA==
X-Mailru-Sender: 24CCEAA761B392C83D438B890C7CDC3CE26F97FF314E09DDBC955AB78116E7FEB9A8FEFFB5F7F2D5CAD91EC71FC00F3837D2A27E1A8065646C7A2150F6097340301919DCEDD5454186FA049C4F996C4B5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B410D8DD6B135161BAFC90430016EC523401FCB9473BF3B5D168F3CF0E9FE49B696761BFB32D813BC3A5E4381656CCBEFA2E670876A05F62B6F8A5A49CC0CDFE28
X-7FA49CB5: 0D63561A33F958A54FD6A6400BACFE1D69E817751AF3AF556CC0208515C7B3E7CACD7DF95DA8FC8BD5E8D9A59859A8B66EA1BA7CA28B4A74CC7F00164DA146DAFE8445B8C89999728AA50765F790063791D79894A16EF398389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC84DEEA6AF2480AC03F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C1DAA61796BF5227B302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C442539A7722CA490CD5E8D9A59859A8B6F8BE7BC64EC55971089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C128C1281A48FD13CDD6BC16DD2BCA7BC0AE2348143C136D29C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj0Roc5o5ut975AJ6Cvis7Tg==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C900579012F43D24554B06719AC17826602C3FF6CD54EFBE61E13825871508D9F3970CAD91EC71FC00F3837D2A27E1A8065646C7A2150F6097340301919DCEDD5454186FA049C4F996C4B5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Maxim MAX8893 PMIC device tree bindings. The example is also
provided.

Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
---
 .../bindings/regulator/max8893.yaml           | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/max8893.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max8893.yaml b/Documentation/devicetree/bindings/regulator/max8893.yaml
new file mode 100644
index 000000000000..2b5e977bf409
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max8893.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/max8893.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator driver for MAX8893 PMIC from Maxim Integrated.
+
+maintainers:
+  - Sergey Larin <cerg2010cerg2010@mail.ru>
+
+description: |
+  The device has 5 LDO regulators and a single BUCK regulator.
+  Programming is done through I2C bus.
+
+properties:
+  compatible:
+    const: maxim,max8893
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^(ldo[1-5]|buck)$":
+        $ref: "regulator.yaml#"
+
+    additionalProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+examples:
+  - |
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            pmic@3e {
+                    compatible = "maxim,max8893";
+                    reg = <0x3e>;
+
+                    regulators {
+                            /* Front camera - s5k6aafx, back - m5mo */
+                            /* Numbers used to indicate the sequence */
+                            front_1_back_1: buck {
+                                    regulator-name = "cam_isp_core_1v2";
+                                    regulator-min-microvolt = <1200000>;
+                                    regulator-max-microvolt = <1200000>;
+                            };
+
+                            front_4_back_5: ldo1 {
+                                    regulator-name = "vt_io_1v8,cam_isp_1v8";
+                                    regulator-min-microvolt = <1800000>;
+                                    regulator-max-microvolt = <1800000>;
+                            };
+
+                            front_3_back_4: ldo2 {
+                                    regulator-name = "vt_core_1v5";
+                                    regulator-min-microvolt = <1500000>;
+                                    regulator-max-microvolt = <1500000>;
+                            };
+
+                            front_5_back_6: ldo3 {
+                                    regulator-name = "vt_cam_1v8,vt_sensor_io_1v8";
+                                    regulator-min-microvolt = <1800000>;
+                                    regulator-max-microvolt = <1800000>;
+                            };
+
+                            ldo4 {
+                                    /* not used */
+                            };
+
+                            back_7: ldo5 {
+                                    regulator-name = "cam_sensor_io_1v8";
+                                    regulator-min-microvolt = <1800000>;
+                                    regulator-max-microvolt = <1800000>;
+                            };
+                    };
+            };
+    };
+...
-- 
2.32.0

