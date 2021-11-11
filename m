Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E99D44D026
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 03:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhKKC4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 21:56:41 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:38099 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbhKKC4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 21:56:39 -0500
Received: from hatter.bewilderbeest.net (97-113-240-219.tukw.qwest.net [97.113.240.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 76A00407;
        Wed, 10 Nov 2021 18:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1636599230;
        bh=UxlRwr40WBjszXqnUlD1ucaCTdcWrwtOkgrw3DJK1DA=;
        h=From:To:Cc:Subject:Date:From;
        b=iBDLSNOKN5rrtw+PCljwdjBmZ6hLpG+mIUtMjL4DDRQBM0YUSzOAwOuZ2pgk2E1bE
         dcdw4OPDTMDGiz7XGeiMNNOX9WE53tTY9jgj6/sLzSEyn+mmLWlp1+QIHnKi3YrK3c
         1o9qC+OWdsOebJrrT0xZ/wjYw9KS0ntNFwMHj2qM=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6775) mask out bank number in nct6775_wmi_read_value()
Date:   Wed, 10 Nov 2021 18:53:38 -0800
Message-Id: <20211111025339.27520-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first call to nct6775_asuswmi_read() in nct6775_wmi_read_value()
had been passing the full bank+register number instead of just the
lower 8 bits.  It didn't end up actually causing problems because the
second argument of that function is a u8 anyway, but it seems
preferable to be explicit about it at the call site (and consistent
with the rest of the code).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: 3fbbfc27f955 ("hwmon: (nct6775) Support access via Asus WMI")
---
 drivers/hwmon/nct6775.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 93dca471972e..57ce8633a725 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1527,7 +1527,7 @@ static u16 nct6775_wmi_read_value(struct nct6775_data *data, u16 reg)
 
 	nct6775_wmi_set_bank(data, reg);
 
-	err = nct6775_asuswmi_read(data->bank, reg, &tmp);
+	err = nct6775_asuswmi_read(data->bank, reg & 0xff, &tmp);
 	if (err)
 		return 0;
 
-- 
2.33.1

