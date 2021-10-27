Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA65B43BF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhJ0COX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbhJ0COV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:14:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FB7C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:11:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so1419577wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=2siizVT2agi4zg/M4FRs9bweg1OJ5eBCSFTZnCvQhAM=;
        b=f90fPzrclpLZLxZIKZ2AZntVK2gNGXsXORjfq8nSr38QkgbWZ+Ofl7mdmAR7DXuoBy
         n0qHyduCwRiBRFdzCH75rZiErmrFWzq66qUgOr9V2Ht1iHRbfJC9BGnJejSihdpaaUs4
         TcanAzZYqjzyom+ITadJYBy1drTZyRWAoxXYtFibQeuW+Lhx9KZY/Ib/Yklyu+0z0D4Y
         lG8dI4xvksHQkBwyTh6EhlF2lEOalfeOxAsPO62vfUNQ4h9LSkRdGB8sPyIJw/KtliTZ
         WswXeePMGPJJ8PHP3F79+QfN/QxCkK1CcZO5JJffArIOs1Y2LR4VVECkeIlVrRHaWELJ
         JjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=2siizVT2agi4zg/M4FRs9bweg1OJ5eBCSFTZnCvQhAM=;
        b=kQa22ryx2LzdLuNnW7OnufcmvzAbOYEhkSB4JlOxhzG1pgbfDdmaKaWX/jar5PM3ij
         ak4jMkBwFKFAcjqrwhqEhqfb7QJoZKDHrJEsDeBN/Xw1JEHo9C9Po//KYo39JzB8u5Xn
         qFSD1EsHeAbv+nL9OMEU795RvOmgEoA7xWu4y6gOMjtJgNdDJsXOdEJgeeck1Wy4A4xq
         k+dpQGPxlcyEIezKajzh4Ng6u0B364cb327wMiP0qrbHd5WOQoxZKunaY0fp7fDsTKwa
         eJHjXA4nytm5be7fvdjierzUmITGiRWPrEevuz3pVx6dsmWJJnOHuCHxry/DV8+ZsqDz
         BLQw==
X-Gm-Message-State: AOAM532j0UtefbSpU6qtHF6vQmEqzEUO0Vg0ToGla65ojz/UCNphc4Rn
        oCEZPuS/8tZygvHagjqIDpAP97sZn8vgwQ==
X-Google-Smtp-Source: ABdhPJwXjfKUacex/GIOtmWee7N5rwXHnaKKXT8ggly3SJEWyfBF1TSmRf+XgDHkpk09pfCksKbJew==
X-Received: by 2002:adf:a2d4:: with SMTP id t20mr36315415wra.229.1635300715729;
        Tue, 26 Oct 2021 19:11:55 -0700 (PDT)
Received: from ?IPv6:2a00:23c5:d03:9f00:5e95:efc8:9b:9197? ([2a00:23c5:d03:9f00:5e95:efc8:9b:9197])
        by smtp.gmail.com with ESMTPSA id c7sm17254409wrp.51.2021.10.26.19.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 19:11:54 -0700 (PDT)
Message-ID: <67f9a3603a52aeb8fd1463fd5786ed544e79ed05.camel@googlemail.com>
Subject: touchscreen_dmi.c Patch for Viglen Connect 10
From:   Mark Stamp <stamp497@googlemail.com>
To:     hdegoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org
Date:   Wed, 27 Oct 2021 03:11:53 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. 

I previously spoke with you on a touchscreen issue

https://github.com/onitake/gsl-firmware/issues/178

With regard to that, I made a patch for touchscreen_dmi.c. It adds
parameters for the Viglen Connect 10 tablet to get its touchscreen and
home button working.

Signed-off-by: Mark Stamp <stamp497@googlemail.com>

--- touchscreen_dmi.c.orig	2021-10-27 01:26:47.842668712 +0100
+++ touchscreen_dmi.c	2021-10-27 01:27:06.426298127 +0100
@@ -938,6 +938,26 @@ static const struct ts_dmi_data trekstor
 	.properties	= trekstor_surftab_wintron70_props,
 };
 
+static const struct property_entry viglen_connect_10_props[] = {
+	//PROPERTY_ENTRY_U32("touchscreen-min-x", 20),
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 0),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 0),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1890),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
+	PROPERTY_ENTRY_U32("touchscrken-fuzz-x", 8),
+	PROPERTY_ENTRY_U32("touchscreen-fuzz-y", 6),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-viglen-
connect-10.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data viglen_connect_10_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= viglen_connect_10_props,
+};
+
 static const struct property_entry vinga_twizzle_j116_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1920),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
@@ -1522,6 +1542,14 @@ const struct dmi_system_id touchscreen_d
 		},
 	},
 	{
+		/* Viglen Connect 10 */
+		.driver_data = (void *)&viglen_connect_10_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Viglen Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Connect 10''
Tablet PC"),
+		},
+	},
+	{
 		/* Vinga Twizzle J116 */
 		.driver_data = (void *)&vinga_twizzle_j116_data,
 		.matches = {


