Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45A39CDB9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhFFGyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 02:54:08 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:37863 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhFFGyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 02:54:07 -0400
Received: by mail-pf1-f174.google.com with SMTP id y15so10701262pfl.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lO02nVIA4gbpKup5dGYZ5/40UvIDgXPZESATu/o79d4=;
        b=krddmKI6j+IRGKHHDhtTY2bb3kzGqWkiZVFE+koAIwaF/J5EaGRzVfUBytIFQzyxzc
         fybATCIgUtSC4DF+MUNRts+Q+Vah1AJYgVF39Il9MWEEgOuH3WSFLqj2LZ+vzr9OdO6I
         ugCvXTQAvRqL0XdIA893mDK81D6AaeB3OKPG58arqzXp+6JUGJbV20+N0dhzbOrLyl2C
         y10BAmMSVTcYMPmYMG9Ezwfv95J+VrGNg2lt+EWF5VcQi7InWVM4Eui8OMno4Hi8TpRw
         9dvPjKv4zlGJ26m/1CX4MOspvHLueSwaurng0O0RGeIFqlPoJa382Ddt8U4wttwm9Xa0
         Fs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lO02nVIA4gbpKup5dGYZ5/40UvIDgXPZESATu/o79d4=;
        b=kUOURt6bDC3EHA1A47J0fkYBNfGZkJnbs2c+3WZB5GqwKxcWa39QE1jRFKEuRNLpdA
         HmBngqQByPpcjq65zBjo+WRW/cJG1f4RPhWlLCBVPw6+fsWBmdDqty8gHnUMjE/J9H1L
         FqdUUqPInBGvtEh1LR3MdPDLJhJoKh26VYiTPfiH/u4BTsAMY2rXfTT/2/mhftLL9UjZ
         h9cwnO6K91Hd1kknNQQjfDbz4/Phg5DD00btv8OVf3c5X2Nt5RYdBmQZqEtDxkqqyZXi
         Na4okPfssMV5BDIqYaMpBwUjBSSufMn0e58aTovW6gOAunEr5dp0lG48EC7IaEED7oCv
         Y8rw==
X-Gm-Message-State: AOAM531s2Y72aaAw77rdTFak02bW7tZOyJENo/5WbOfHWv05pMPU7U8+
        Nx5kX8Hz9RglWGThY/FR7yZaHw==
X-Google-Smtp-Source: ABdhPJw9IF2c7Sr2XlmM2WITFekccJ2j/f+DDKjkFNysFcGOn1WqnzPJqJAQYzTzym3E5J8JLndGXQ==
X-Received: by 2002:a63:c047:: with SMTP id z7mr12702080pgi.186.1622962269009;
        Sat, 05 Jun 2021 23:51:09 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id u21sm5324851pfh.163.2021.06.05.23.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 23:51:08 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Wen Su <wen.su@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: mt6359: Use unsigned int for volt_tables
Date:   Sun,  6 Jun 2021 14:50:51 +0800
Message-Id: <20210606065052.1417111-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606065052.1417111-1-axel.lin@ingics.com>
References: <20210606065052.1417111-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator_desc expects "const unsigned int *volt_table", thus use
unsigned int instead of u32.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6359-regulator.c | 36 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/mt6359-regulator.c b/drivers/regulator/mt6359-regulator.c
index 4f517c9fd6c4..8003c363cdfd 100644
--- a/drivers/regulator/mt6359-regulator.c
+++ b/drivers/regulator/mt6359-regulator.c
@@ -203,77 +203,77 @@ static const struct linear_range mt_volt_range8[] = {
 	REGULATOR_LINEAR_RANGE(506250, 0, 0x7f, 6250),
 };
 
-static const u32 vsim1_voltages[] = {
+static const unsigned int vsim1_voltages[] = {
 	0, 0, 0, 1700000, 1800000, 0, 0, 0, 2700000, 0, 0, 3000000, 3100000,
 };
 
-static const u32 vibr_voltages[] = {
+static const unsigned int vibr_voltages[] = {
 	1200000, 1300000, 1500000, 0, 1800000, 2000000, 0, 0, 2700000, 2800000,
 	0, 3000000, 0, 3300000,
 };
 
-static const u32 vrf12_voltages[] = {
+static const unsigned int vrf12_voltages[] = {
 	0, 0, 1100000, 1200000,	1300000,
 };
 
-static const u32 volt18_voltages[] = {
+static const unsigned int volt18_voltages[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1700000, 1800000, 1900000,
 };
 
-static const u32 vcn13_voltages[] = {
+static const unsigned int vcn13_voltages[] = {
 	900000, 1000000, 0, 1200000, 1300000,
 };
 
-static const u32 vcn33_voltages[] = {
+static const unsigned int vcn33_voltages[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 2800000, 0, 0, 0, 3300000, 3400000, 3500000,
 };
 
-static const u32 vefuse_voltages[] = {
+static const unsigned int vefuse_voltages[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1700000, 1800000, 1900000, 2000000,
 };
 
-static const u32 vxo22_voltages[] = {
+static const unsigned int vxo22_voltages[] = {
 	1800000, 0, 0, 0, 2200000,
 };
 
-static const u32 vrfck_voltages[] = {
+static const unsigned int vrfck_voltages[] = {
 	0, 0, 1500000, 0, 0, 0, 0, 1600000, 0, 0, 0, 0, 1700000,
 };
 
-static const u32 vrfck_voltages_1[] = {
+static const unsigned int vrfck_voltages_1[] = {
 	1240000, 1600000,
 };
 
-static const u32 vio28_voltages[] = {
+static const unsigned int vio28_voltages[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 2800000, 2900000, 3000000, 3100000, 3300000,
 };
 
-static const u32 vemc_voltages[] = {
+static const unsigned int vemc_voltages[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2900000, 3000000, 0, 3300000,
 };
 
-static const u32 vemc_voltages_1[] = {
+static const unsigned int vemc_voltages_1[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 2500000, 2800000, 2900000, 3000000, 3100000,
 	3300000,
 };
 
-static const u32 va12_voltages[] = {
+static const unsigned int va12_voltages[] = {
 	0, 0, 0, 0, 0, 0, 1200000, 1300000,
 };
 
-static const u32 va09_voltages[] = {
+static const unsigned int va09_voltages[] = {
 	0, 0, 800000, 900000, 0, 0, 1200000,
 };
 
-static const u32 vrf18_voltages[] = {
+static const unsigned int vrf18_voltages[] = {
 	0, 0, 0, 0, 0, 1700000, 1800000, 1810000,
 };
 
-static const u32 vbbck_voltages[] = {
+static const unsigned int vbbck_voltages[] = {
 	0, 0, 0, 0, 1100000, 0, 0, 0, 1150000, 0, 0, 0, 1200000,
 };
 
-static const u32 vsim2_voltages[] = {
+static const unsigned int vsim2_voltages[] = {
 	0, 0, 0, 1700000, 1800000, 0, 0, 0, 2700000, 0, 0, 3000000, 3100000,
 };
 
-- 
2.25.1

