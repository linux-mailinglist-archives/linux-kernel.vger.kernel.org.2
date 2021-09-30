Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AD241D6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbhI3Jqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349510AbhI3Jqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:46:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A194A61875;
        Thu, 30 Sep 2021 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995101;
        bh=fdTI9W97nWGgWipBrkiQEXu+hBS4pKQhl3Kr1mmrqRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgrTFF1hB1TCj74BXfJcoTxmzp86NO1f4SYC3GijIz7g/NEV7sQ717/XUVTcw6I6h
         LSUpoLGoq/QwSPv7BJDrEaD3+tLzJfZYJNc1Vkqmau7iz6Lo50cZEI1DxgIwc0OQsT
         XMVJcFgx/YVgB69Vr1QeqKkizZayv5F/jhDDWCoVuaq8yo7PAxl/MQRTiYTwm5Y++3
         Jm9Taw0wQAm3YWijyr1QPIIUogcs54+YAhuuFDUPDFOuiyD1vby8CpNXoaSZQ5XEBy
         t0a5puGjC/djtVdTl8zu1HJ81V2z/guTUz0fK516DyuL9uQipEdqyl3gepnFD7KjVC
         cyKDRmnTbS8dQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVscd-002ATC-NA; Thu, 30 Sep 2021 11:44:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] ABI: sysfs-class-hwmon: add a description for tempY_crit_alarm
Date:   Thu, 30 Sep 2021 11:44:50 +0200
Message-Id: <a14f98e1b23ea14cf14da3c3169955343ec28bbe.1632994837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632994837.git.mchehab+huawei@kernel.org>
References: <cover.1632994837.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such ABI symbol is currently not described. Document it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1632994837.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-class-hwmon | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index ea5a129ae082..1f20687def44 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -410,6 +410,20 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/tempY_crit_alarm
+Description:
+		Critical high temperature alarm flag.
+
+		- 0: OK
+		- 1: temperature has reached tempY_crit
+
+		RW
+
+		Contrary to regular alarm flags which clear themselves
+		automatically when read, this one sticks until cleared by
+		the user. This is done by writing 0 to the file. Writing
+		other values is unsupported.
+
 What:		/sys/class/hwmon/hwmonX/tempY_crit_hyst
 Description:
 		Temperature hysteresis value for critical limit.
-- 
2.31.1

