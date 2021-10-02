Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E6D41FE34
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 23:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhJBVLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhJBVLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:11:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68200C0613EF;
        Sat,  2 Oct 2021 14:09:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y26so53751756lfa.11;
        Sat, 02 Oct 2021 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECXQTmBzFDgjiUakh8NRBVFwA2IrMTf5bmMTCdebOkA=;
        b=pYquTQUf0hoen+Q+syQ9tYb/Nqk55KHsS+K/6/xUCLtIRU5xEDUsVWkXmvPIGD+vo1
         jo/uzUwRevjSATlkfGHnF/WsVraK95EV5yzhhElAl7vYt4A0HqxmY3/ySVfeQPyKE/xu
         u1k5TsAJ39npA7kLrnZWgHnsEToca2ZDNjk+owKZr1B1luza/4y+fUj/30BJlJjzNmX5
         Ylm63AHuUyiXq3JDb5wClEABk9YeSmyrcJpUMlVyvDpEtCe92I/3OUI8wZa06wJNVVWY
         66hYQei608Lat5zBjVQ9RRVhkgov0r99JSedFa7NmYY1nW2hNM81jp+EP4GN2XNFJTSk
         vPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECXQTmBzFDgjiUakh8NRBVFwA2IrMTf5bmMTCdebOkA=;
        b=Kno24DWowOS5upIuP9H2J/VYNUJRJa/carhlP5LBUct1Cqn7XFRWxpH2SI2Tl8rjKa
         uLaiH/CiOzXx+WXrpyw1Vkgy8Y33kA14JmbMCnRcl7erobVYXrCWKImlfmxVilAwxOHU
         /Z2YgR4IV1Le5/73njorVD5/kQhdT0BDDzlK1fWgFrSe95an0Mo7FgfiHfYPGrUqVXi+
         CXp33+Zgp4aCn9yy1dOccTDmOUJyw1Dr39s0qANI0udsk3IHQgjNmuI9mhgLTpCFxQ1M
         YzeSPClypqIrktduVe7lblF0zWIQx/gzspY7zZ/v6wWtC2Gpi5R7k5OzxxmpGgl8iCqi
         oqUw==
X-Gm-Message-State: AOAM532v/EsgVb9xr1KLLPE4pdkBHuC87NOnUGJ22EHi6zmRPimVSJmB
        tUH9w/Nvt0gr7NDZXfa14jE=
X-Google-Smtp-Source: ABdhPJyMi++6vT6HjTE+jQBsVzMNGEiSwpBUH6vNB53jLlJyDnGZzGPmDzJl2JS4YZ7Ntaz1ocg9pQ==
X-Received: by 2002:a05:6512:ea4:: with SMTP id bi36mr5481005lfb.486.1633208992771;
        Sat, 02 Oct 2021 14:09:52 -0700 (PDT)
Received: from localhost.localdomain (105-28-94-178.pool.ukrtel.net. [178.94.28.105])
        by smtp.gmail.com with ESMTPSA id l9sm279511lje.32.2021.10.02.14.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:09:52 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Kamil Pietrzak <kpietrzak@disroot.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (nct6775) Use custom scale for ASUS motherboards.
Date:   Sun,  3 Oct 2021 00:08:55 +0300
Message-Id: <20211002210857.709956-3-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211002210857.709956-1-pauk.denis@gmail.com>
References: <20211002210857.709956-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use custom scaling factor for:
* TUF GAMING Z490-PLUS
* TUF GAMING Z490-PLUS (WI-FI)

Voltage scaling factors are based on Asus software on Windows.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 8eaf86ea2433..ba18c1cbf572 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -140,6 +140,7 @@ struct nct6775_sio_data {
 	int ld;
 	enum kinds kind;
 	enum sensor_access access;
+	bool custom_scale;
 
 	/* superio_() callbacks  */
 	void (*sio_outb)(struct nct6775_sio_data *sio_data, int reg, int val);
@@ -1159,14 +1160,19 @@ static const u16 scale_in[15] = {
 	800, 800
 };
 
-static inline long in_from_reg(u8 reg, u8 nr)
+static const u16 scale_in_z490[15] = {
+	888, 4000, 1600, 1600, 9600, 800, 800, 1600, 1600, 1600, 1600, 1600, 800,
+	800, 800
+};
+
+static inline long in_from_reg(u8 reg, u8 nr, const u16 *scale)
 {
-	return DIV_ROUND_CLOSEST(reg * scale_in[nr], 100);
+	return DIV_ROUND_CLOSEST(reg * scale[nr], 100);
 }
 
-static inline u8 in_to_reg(u32 val, u8 nr)
+static inline u8 in_to_reg(u32 val, u8 nr, const u16 *scale)
 {
-	return clamp_val(DIV_ROUND_CLOSEST(val * 100, scale_in[nr]), 0, 255);
+	return clamp_val(DIV_ROUND_CLOSEST(val * 100, scale[nr]), 0, 255);
 }
 
 /*
@@ -1323,6 +1329,9 @@ struct nct6775_data {
 	u8 fandiv2;
 	u8 sio_reg_enable;
 
+	/* voltage scaling factors */
+	const u16 *scale;
+
 	/* nct6775_*() callbacks  */
 	u16 (*read_value)(struct nct6775_data *data, u16 reg);
 	int (*write_value)(struct nct6775_data *data, u16 reg, u16 value);
@@ -2026,7 +2035,7 @@ show_in_reg(struct device *dev, struct device_attribute *attr, char *buf)
 	int index = sattr->index;
 	int nr = sattr->nr;
 
-	return sprintf(buf, "%ld\n", in_from_reg(data->in[nr][index], nr));
+	return sprintf(buf, "%ld\n", in_from_reg(data->in[nr][index], nr, data->scale));
 }
 
 static ssize_t
@@ -2044,7 +2053,7 @@ store_in_reg(struct device *dev, struct device_attribute *attr, const char *buf,
 	if (err < 0)
 		return err;
 	mutex_lock(&data->update_lock);
-	data->in[nr][index] = in_to_reg(val, nr);
+	data->in[nr][index] = in_to_reg(val, nr, data->scale);
 	data->write_value(data, data->REG_IN_MINMAX[index - 1][nr],
 			  data->in[nr][index]);
 	mutex_unlock(&data->update_lock);
@@ -3980,6 +3989,11 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->write_value = nct6775_wmi_write_value;
 	}
 
+	if (sio_data->custom_scale)
+		data->scale = scale_in_z490;
+	else
+		data->scale = scale_in;
+
 	mutex_init(&data->update_lock);
 	data->name = nct6775_device_names[data->kind];
 	data->bank = 0xff;		/* Force initial bank selection */
@@ -5020,6 +5034,7 @@ static int __init sensors_nct6775_init(void)
 	struct nct6775_sio_data sio_data;
 	int sioaddr[2] = { 0x2e, 0x4e };
 	enum sensor_access access = access_direct;
+	bool custom_scale = false;
 	const char *board_vendor, *board_name;
 	u8 tmp;
 
@@ -5043,6 +5058,10 @@ static int __init sensors_nct6775_init(void)
 				pr_err("Can't read ChipID by Asus WMI.\n");
 			}
 		}
+
+		if (strcmp(board_name, "TUF GAMING Z490-PLUS") == 0 ||
+		    strcmp(board_name, "TUF GAMING Z490-PLUS (WI-FI)") == 0)
+			custom_scale = true;
 	}
 
 	/*
@@ -5066,6 +5085,7 @@ static int __init sensors_nct6775_init(void)
 		found = true;
 
 		sio_data.access = access;
+		sio_data.custom_scale = custom_scale;
 
 		if (access == access_asuswmi) {
 			sio_data.sio_outb = superio_wmi_outb;
-- 
2.33.0

