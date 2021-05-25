Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355BA38F8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhEYDlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:41:52 -0400
Received: from fallback22.m.smailru.net ([94.100.176.132]:49974 "EHLO
        fallback22.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhEYDlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=fIPFDXYHGcTfvl+ZG84a+6/PN5oKxbZvYA39/rfkXxQ=;
        b=C8Hk7NMc0TpvywsSpiTjTGMp7w+IDtP13CmQLpeUyzrF5AX0trvGc/fGR5veEET32ohgoADJ48WkRlRj1FNX7i1dpWJiNkPr0MZiFjbW9BhbG+a72He+W8ZpwAQAsskaRpoyMf9RZcKT0OKBJg8QmP67I61G/j0tOCElB4mk5ZM=;
Received: from [10.161.22.26] (port=35594 helo=smtp56.i.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1llNvY-0006Zw-P5; Tue, 25 May 2021 06:40:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=fIPFDXYHGcTfvl+ZG84a+6/PN5oKxbZvYA39/rfkXxQ=;
        b=pbkSUEwenywtBWfB/18bffCUyTy+DAX41KqSPf/NPUXtMGLnAKMTlqpHdpA1+YI0TLI4YceP5vA5mpxPy2cfv1lbLNoxiFm/JL9jm4UAJT8dlJOAMjr1W7I3k9nC9wxYBhuZZZSnqR48xMydyKk1+c2YEmoKUgQBAzSU0snnx7E=;
Received: by smtp56.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1llNvV-0004LS-Q2; Tue, 25 May 2021 06:40:18 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH v3 1/1] regmap-irq: Introduce inverted status registers support
Date:   Tue, 25 May 2021 06:42:03 +0300
Message-Id: <20210525034204.5272-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD91B019B01C53E51AF07EDA974EE11B688BBB65244C6A6BC9F00894C459B0CD1B93FAB5E8AA01EC0AC52DC7B811D04A1B0F5CFB2ACABB6ECAEE532DF24268A2C67
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7818460412E3A2163EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063716A4A39B750036BB8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8D2EB6F396D54F0158BED65A8840D75AD117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC292D688DDAD4E7BC389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8FA486DC37A503D0BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C91E4BF118115E49203F1AB874ED890284AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3437A22C6F51CB4CBBA3038C0950A5D36B5C8C57E37DE458B0BC6067A898B09E46D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE72F88032165008D51731C566533BA786AA5CC5B56E945C8DA
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A2368A440D3B0F6089093C9A16E5BC824A2A04A2ABAA09D25379311020FFC8D4ADE744582F89AD8FA33BD014F94441F1CD
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CDFB9373DB28FDDFB3C302B8DF196E7DA07677EC1A13C55069C2B6934AE262D3EE7EAB7254005DCED4ED5B231F855E8739510FB958DCE06DB6ED91DBE5ABE359ADBCB5631A0A9D21F69F8FEF10F1C2C2993EDB24507CE13387DFF0A840B692CF8
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D340B06C327CE4A70E8ADB5DA2325D2CEE09943C7716D796AECCBF96A009DFBA5AA7D53D78804F0ED3F1D7E09C32AA3244C78CE1C6E1B459FE9154378C35B525A1F97FE24653F78E66883B48618A63566E0
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojV3CWresp27eSx9m/NWTbiA==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB24979D7440600D10AAAB4BDBA1EF68E7C4E5869CE13471B385EE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4935A4DD83856F5F211EB3CDE1FDD2419C7D1DD68056FEF1C049FFFDB7839CE9E8461634FFA5C5E3C0048FE0EA3FE187169688285523EE8EF8BCD39E68083381A
X-7FA49CB5: 0D63561A33F958A5291AAACE5B0C6A09ED5A49D2FFF738EDF445D9A5C4CE3AF28941B15DA834481FA18204E546F3947CE3C0F74373B9C9F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006375D86F985788DC295389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063743349E7DCD42F854D81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CB0EC3B1FCAE4A06943847C11F186F3C59DAA53EE0834AAEE
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A2AD77751E876CB595E8F7B195E1C9783180C023A6094E95EBD5EE6400B98F466E
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CDFB9373DB28FDDFB7962899C8179946452674290E9BA65CA9C2B6934AE262D3EE7EAB7254005DCED4ED5B231F855E873DC48ACC2A39D04F89CDFB48F4795C241BDAD6C7F3747799A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojV3CWresp27fBkXED11NHBQ==
X-Mailru-MI: 1000000000800
X-Mailru-Sender: A5480F10D64C9005A1123343B97952344549C768E9BEC0CB97A190407312473B7E4B2607F94A247AC099ADC76E806A99D50E20E2BC48EF5A30D242760C51EA9CEAB4BC95F72C04283CDA0F3B3F5B9367
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
index 760296a4b606..d2656581a608 100644
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
+			d->status_buf[i] = ~d->status_buf[i];
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

