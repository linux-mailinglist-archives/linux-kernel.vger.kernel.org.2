Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80C38E085
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 06:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhEXE60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 00:58:26 -0400
Received: from fallback19.mail.ru ([185.5.136.251]:36572 "EHLO
        fallback19.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhEXE6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 00:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=E4SV/E5/xZmWucWbdEz7YwHfkofKV/Bk3gdTVPTIsDE=;
        b=fEFT7wiruHm8cV91sLodRf0PUrlA+L9lRTDY0DVCx5jb6FLkJnh99BKHsh/2/NC5frhndoD7Jb+5yZZaP7rRqwcganRSPniGyVZ0s5ZbBO9TgDYx3fOnZrmpcUeaIYgUg9YwyNf+MCdUcdexjMg5bTvxTAT4GRKjIbCveEqI9bo=;
Received: from [10.161.64.50] (port=55932 helo=smtp42.i.mail.ru)
        by fallback19.m.smailru.net with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1ll2e8-0005pl-9Q
        for linux-kernel@vger.kernel.org; Mon, 24 May 2021 07:56:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=E4SV/E5/xZmWucWbdEz7YwHfkofKV/Bk3gdTVPTIsDE=;
        b=TIuSWkvaX4JoUc/xl0f0RjKyu/bMouZBjymw4c0yTPxiz/3mfm5bgBMSp5tpgsJwrow6l2U1cR/YM9sqZ6107CcCYYBQSyC1i5HDrVPi0AE8pW/HfnswNsrGmc8bsWl2+5kY5+YIEbLufZa8b7vIQclnN44dDkT7QJivU2PzOvM=;
Received: by smtp42.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1ll2e4-0002av-G6; Mon, 24 May 2021 07:56:52 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH v2 1/1] regmap-irq: Introduce inverted status registers support
Date:   Mon, 24 May 2021 07:58:36 +0300
Message-Id: <20210524045837.8398-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD91B019B01C53E51AF9418A6087D01078917D63D7C0371164600894C459B0CD1B91E8EBD2A864D4C7AF488C00512664FAC4B892B989E8D734678349C59DB273874
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7195F30236A8D43B4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637C8BD49B17AF1FC7C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8BE603DD0DFC0AE14DD3F6AAE9D8761AC117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC55B19328CBC4F849A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10F2CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE9647ADFADE5905B1CE99E4F20BAF2718D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE35E3BF8C76DC23F74BA3038C0950A5D36B5C8C57E37DE458B0BC6067A898B09E46D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE79E9721B410A3B6ED731C566533BA786AA5CC5B56E945C8DA
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A24209795067102C07E8F7B195E1C97831FF0D0A59C958CB1EB56C7EC614AE688F
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CDFB9373DB28FDDFBE2FEFDD4A370697EDBA75D574363B6D29C2B6934AE262D3EE7EAB7254005DCED4ED5B231F855E8739510FB958DCE06DB6ED91DBE5ABE359ADBCB5631A0A9D21F69F8FEF10F1C2C2993EDB24507CE13387DFF0A840B692CF8
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34CA9B3B5DE5D383E636582A55A02B0640B66CACE974C7C2A1A3B93B910B52DCF77E8DD3E9DCBA21CC1D7E09C32AA3244C9CBBB3F598D67A7E6E1C990AB32429ACCE0B41342B755BCD83B48618A63566E0
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj+gjVyQcIK6KCn6ArdCyhjg==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB249E90EEB8FA56827F4EA1ED0080055C49BA08A835A0801BDEEE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4935A4DD83856F5F211EB3CDE1FDD241959A27BADEA93D033049FFFDB7839CE9E8461634FFA5C5E3CC4536F55A72C6A6F082FDECA7BCF944773A2D4DED9579D78
X-7FA49CB5: 0D63561A33F958A59CA805705F15E6E895EE4A8A17D59FFFCBA3E76DB2D4AD918941B15DA834481FA18204E546F3947CE3C0F74373B9C9F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006375D86F985788DC295389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006372B9F00E91062B600D81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7C2C2559B29ED8195043847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CDFB9373DB28FDDFBAD5277C9B919146A8EC2667B871C76229C2B6934AE262D3EE7EAB7254005DCED4ED5B231F855E873DC48ACC2A39D04F89CDFB48F4795C241BDAD6C7F3747799A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj+gjVyQcIK6JI5eJmjfOTuA==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005CC619DDFF34CA75F553274EEE194C0843DBAFC2265DADA6C617D5758B347092CC099ADC76E806A99D50E20E2BC48EF5A30D242760C51EA9CEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some interrupt controllers have inverted status register:
cleared bits is active interrupts and set bits is inactive interrupts,
so add inverted status support to the framework.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/base/regmap/regmap-irq.c | 7 +++++++
 include/linux/regmap.h           | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 760296a4b606..0797f41153d9 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -531,6 +531,10 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		}
 	}
 
+	if (chip->status_invert)
+		for (i = 0; i < data->chip->num_regs; i++)
+			data->status_buf[i] = ~data->status_buf[i];
+
 	/*
 	 * Ignore masked IRQs and ack if we need to; we ack early so
 	 * there is no race between handling and acknowleding the
@@ -800,6 +804,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			goto err_alloc;
 		}
 
+		if (chip->status_invert)
+			data->status_buf[i] = ~data->status_buf[i];
+
 		if (d->status_buf[i] && (chip->ack_base || chip->use_ack)) {
 			reg = sub_irq_reg(d, d->chip->ack_base, i);
 			if (chip->ack_invert)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index bf5a834d1774..f5f08dd0a116 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1449,6 +1449,7 @@ struct regmap_irq_sub_irq_map {
  * @not_fixed_stride: Used when chip peripherals are not laid out with fixed
  * 		      stride. Must be used with sub_reg_offsets containing the
  * 		      offsets to each peripheral.
+ * @status_invert: Inverted status register: cleared bits are active interrupts.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
  * @num_regs:    Number of registers in each control bank.
@@ -1501,6 +1502,7 @@ struct regmap_irq_chip {
 	bool type_in_mask:1;
 	bool clear_on_unmask:1;
 	bool not_fixed_stride:1;
+	bool status_invert:1;
 
 	int num_regs;
 
-- 
2.31.1

