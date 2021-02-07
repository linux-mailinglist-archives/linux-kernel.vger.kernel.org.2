Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE443126FC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBGSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBGSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:52:36 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C8C061786;
        Sun,  7 Feb 2021 10:51:56 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q7so12828954iob.0;
        Sun, 07 Feb 2021 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lao/8dVMMxg2ELG4j+qwkl089wdhke3/pYdIfPBdLfo=;
        b=O0cwzpizrlZSPCKCuNSoP1kXH6OWtvCoKEM7kZ4NZb1ArlLoBYChMZx7N4kqa72RFJ
         cgZi8ePgiLrDZJe9Vcnm6uM0cEFMv2DXDWs0oIv9os6lDheRLF7ylE+qTSu9CNgZ4MrY
         jXuTpwSZsfvd4Es2v8AoGheXlwXWgL12htHZ4ngL7QGK5Unx0ukJnnfYuI+s1DxI7Hqu
         iDvb4ul2TyaMq0oXH559RUuG8ajJn+3y8D22GdiV1VlwXZMa9tXW6CGQnTJLpF2aArVB
         mJfWPrau7e/BovTss4Rl6kkYS8/VDkn9TqB4GZ2jcgz0mRDcf6bS0gkEjiJeThBEmtE/
         84Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lao/8dVMMxg2ELG4j+qwkl089wdhke3/pYdIfPBdLfo=;
        b=dybLbGFpPOX/Pc/f3o4mSoBlyD/7Y4ROD1HepMpuAyr9LOJ5qZPX8fOv4Ogx5C/TOi
         aUxWJZVLO5IO+81DZzl8fP2Ii+5KHZabrxK0sqqheViGLZWRisvqfucIaS/32cKXNyxM
         FajsV0dha3h6c9qfnlX91dCOcV+Vb4pb3OciT/ChmbzlrRVFASKGXCdjQv3i4bEu007q
         aEymkvOj1HMBWDmNY3Ty/+O+vI+fGwM78yBCO8/2HAhbviwNUeKpobLXBZ2Tpwkc2gEK
         FBJyE2nbPNZwsCOJaREE40a2RuXUA+SxamgkRzUbiuiB4SZntLer8qyMniN612O+8yPz
         EwDA==
X-Gm-Message-State: AOAM53203ysGl2eyl11ZPUwl0j+5CWaOEdzY8VmjAbCSxzx5SK5BhYzL
        E0ix3HpYyxxxq7ATWL6gwTmOOHJjUv43Zg==
X-Google-Smtp-Source: ABdhPJytSj+ZW8OKdur+1M6Quv3kSDUJCAUC95ePXi2pp2dbjZlCcW0EEkZuHqv/Mqf88GA4LnOWgg==
X-Received: by 2002:a5d:934d:: with SMTP id i13mr12429926ioo.187.1612723915935;
        Sun, 07 Feb 2021 10:51:55 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:a6b4:a5d5:60b9:fff0])
        by smtp.gmail.com with ESMTPSA id e1sm7942738iol.31.2021.02.07.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 10:51:55 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] clk: vc5: Add support for optional load capacitance
Date:   Sun,  7 Feb 2021 12:51:39 -0600
Message-Id: <20210207185140.3653350-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210207185140.3653350-1-aford173@gmail.com>
References: <20210207185140.3653350-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two registers which can set the load capacitance for
XTAL1 and XTAL2. These are optional registers when using an
external crystal.  Parse the device tree and set the
corresponding registers accordingly.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Fix whitespace.  Use regmap_update_bits instead of performing
     a manual read-modify-write.
V2:  Make the math subtract 9000 since we have a DIV_ROUND_CLOSEST
     This also allows us to remove the check for 9430 since values
     between 9000 and 9430 will round up and down.
     Make write VC5_XTAL_X1_LOAD_CAP and VC5_XTAL_X2_LOAD_CAP
     a read-modify-write to not worry about the contents of
     bits[1:0].
     
diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 43db67337bc0..344cd6c61188 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -759,6 +759,63 @@ static int vc5_update_power(struct device_node *np_output,
 	return 0;
 }
 
+static int vc5_map_cap_value(u32 femtofarads)
+{
+	int mapped_value;
+
+	/*
+	 * The datasheet explicitly states 9000 - 25000 with 0.5pF
+	 * steps, but the Programmer's guide shows the steps are 0.430pF.
+	 * After getting feedback from Renesas, the .5pF steps were the
+	 * goal, but 430nF was the actual values.
+	 * Because of this, the actual range goes to 22760 instead of 25000
+	 */
+	if (femtofarads < 9000 || femtofarads > 22760)
+		return -EINVAL;
+
+	/*
+	 * The Programmer's guide shows XTAL[5:0] but in reality,
+	 * XTAL[0] and XTAL[1] are both LSB which makes the math
+	 * strange.  With clarfication from Renesas, setting the
+	 * values should be simpler by ignoring XTAL[0]
+	 */
+	mapped_value = DIV_ROUND_CLOSEST(femtofarads - 9000, 430);
+
+	/*
+	 * Since the calculation ignores XTAL[0], there is one
+	 * special case where mapped_value = 32.  In reality, this means
+	 * the real mapped value should be 111111b.  In other cases,
+	 * the mapped_value needs to be shifted 1 to the left.
+	 */
+	if (mapped_value > 31)
+		mapped_value = 0x3f;
+	else
+		mapped_value <<= 1;
+
+	return mapped_value;
+}
+static int vc5_update_cap_load(struct device_node *node, struct vc5_driver_data *vc5)
+{
+	u32 value;
+	int mapped_value;
+
+	if (!of_property_read_u32(node, "idt,xtal-load-femtofarads", &value)) {
+		mapped_value = vc5_map_cap_value(value);
+		if (mapped_value < 0)
+			return mapped_value;
+
+		/*
+		 * The mapped_value is really the high 6 bits of
+		 * VC5_XTAL_X1_LOAD_CAP and VC5_XTAL_X2_LOAD_CAP, so
+		 * shift the value 2 places.
+		 */
+		regmap_update_bits(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, ~0x03, mapped_value << 2);
+		regmap_update_bits(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, ~0x03, mapped_value << 2);
+	}
+
+	return 0;
+}
+
 static int vc5_update_slew(struct device_node *np_output,
 			   struct vc5_out_data *clk_out)
 {
@@ -884,6 +941,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -EINVAL;
 	}
 
+	/* Configure Optional Loading Capacitance for external XTAL */
+	if (!(vc5->chip_info->flags & VC5_HAS_INTERNAL_XTAL)) {
+		ret = vc5_update_cap_load(client->dev.of_node, vc5);
+		if (ret)
+			goto err_clk_register;
+	}
+
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.mux", client->dev.of_node);
 	init.ops = &vc5_mux_ops;
 	init.flags = 0;
-- 
2.25.1

