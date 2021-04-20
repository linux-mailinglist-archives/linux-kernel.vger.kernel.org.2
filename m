Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272F9365115
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhDTDsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhDTDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:48:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E227CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:47:31 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f29so25676041pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=t9Bqa7QnBBsLTTfr9GFCCJ3YWr2g54/PFrtJWrMMZww=;
        b=DlQMdS+1+NUPp0Ecm91Av/YqS43HZWzw3ylrVpL3l7oASoYlKNZUJBMCzFsCWlY3lP
         smdwFJYtuVU/Md14PIvW6syoeACxnAaGaPkhqjOXWDKe+2jKVqO6m9K0SihN+72d/5W5
         smzhRF2Is4hSdDVZ9sDtcFYR2LUBoL5fArVVmYPYK+Awg5+z1dEmzEBxKmBJSwoBsI5o
         pFSWSGSZ26p6FCDADZQufKoS7DY3kgA05l5Yt6IKPGQZqtYWPcAse/GiZwJ+TJUViRue
         ewwBLFXp7NkuWcgE2hH5sH/RKCL6XaX/wx2Xa15M4805XJszl+fZmOujXtCrQVSxJzFR
         vuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t9Bqa7QnBBsLTTfr9GFCCJ3YWr2g54/PFrtJWrMMZww=;
        b=LGzQbTO8Qni9qlAp09c8rEYaKvlNjOi7v7hS+ugw81KcKLHwbDl7gO0F63hg9nHIal
         P8u0lCgUJyjfDTXbRc6a3yuY7hE8PNuXgDvqAA4ya9I2kFTEBzHqIKRmTEqW3irklxmn
         zD2BQfscuaNtc47gXrtOoIz3IvOiAJThMHYz23AxADbNNRs89svkXYJmhimbWyCKpEZC
         E8k4K+HAkznML6S419UyZ57Ff1d7bIwYmnpk8LxINDyy6drLJ3shksCeoy+BSyhwVIAG
         SPQmI79DSBlKUB7evcL37OnE10aE7xeSWuHhBNAGHlrc9RhajA+ObxvIDE92aDCe368n
         Gs1A==
X-Gm-Message-State: AOAM532IRP148TXSNcQOYpO6E7rzFQZ37xr5E1ajYB5Wierf6VxbhWB1
        gZWxPinDFMtuhhB0QyPkHls=
X-Google-Smtp-Source: ABdhPJxGX/+KZoXBtGATw0jkZU7hqqv/mP1TO0uvUQxDLkXOcjo6sHsQXvKWk0tZm/C+VCZcf23k4w==
X-Received: by 2002:a05:6a00:51:b029:261:d30b:5217 with SMTP id i17-20020a056a000051b0290261d30b5217mr5243599pfk.31.1618890451390;
        Mon, 19 Apr 2021 20:47:31 -0700 (PDT)
Received: from localhost ([27.59.20.146])
        by smtp.gmail.com with ESMTPSA id q13sm14072708pgp.37.2021.04.19.20.47.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Apr 2021 20:47:30 -0700 (PDT)
Date:   Tue, 20 Apr 2021 09:17:18 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        sanjanasrinidhi1810@gmail.com
Subject: [PATCH] drivers: regulator: core.c: Fix indentation of comment
Message-ID: <20210420034718.t7wudu6xcfpahflv@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifted the closing */ of multiline comment to a new line
This is done to maintain code uniformity

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/regulator/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 16114aea099a..06fbf18b6524 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -538,7 +538,8 @@ static int regulator_mode_constrain(struct regulator_dev *rdev,
 
 	/* The modes are bitmasks, the most power hungry modes having
 	 * the lowest values. If the requested mode isn't supported
-	 * try higher modes. */
+	 * try higher modes.
+	 */
 	while (*mode) {
 		if (rdev->constraints->valid_modes_mask & *mode)
 			return 0;
@@ -931,7 +932,8 @@ static DEVICE_ATTR(bypass, 0444,
 		   regulator_bypass_show, NULL);
 
 /* Calculate the new optimum regulator operating mode based on the new total
- * consumer load. All locks held by caller */
+ * consumer load. All locks held by caller
+ */
 static int drms_uA_update(struct regulator_dev *rdev)
 {
 	struct regulator *sibling;
@@ -1219,7 +1221,8 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 		int	cmax = constraints->max_uV;
 
 		/* it's safe to autoconfigure fixed-voltage supplies
-		   and the constraints are used by list_voltage. */
+		 * and the constraints are used by list_voltage.
+		 */
 		if (count == 1 && !cmin) {
 			cmin = 1;
 			cmax = INT_MAX;
@@ -2525,7 +2528,8 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 
 	/* Allow the regulator to ramp; it would be useful to extend
 	 * this for bulk operations so that the regulators can ramp
-	 * together.  */
+	 * together.
+	 */
 	trace_regulator_enable_delay(rdev_get_name(rdev));
 
 	/* If poll_enabled_time is set, poll upto the delay calculated
@@ -5337,10 +5341,12 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	ret = set_machine_constraints(rdev);
 	if (ret == -EPROBE_DEFER) {
 		/* Regulator might be in bypass mode and so needs its supply
-		 * to set the constraints */
+		 * to set the constraints
+		 */
 		/* FIXME: this currently triggers a chicken-and-egg problem
 		 * when creating -SUPPLY symlink in sysfs to a regulator
-		 * that is just being created */
+		 * that is just being created
+		 */
 		rdev_dbg(rdev, "will resolve supply early: %s\n",
 			 rdev->supply_name);
 		ret = regulator_resolve_supply(rdev);
@@ -5899,7 +5905,8 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 
 	if (have_full_constraints()) {
 		/* We log since this may kill the system if it goes
-		 * wrong. */
+		 * wrong.
+		 */
 		rdev_info(rdev, "disabling\n");
 		ret = _regulator_do_disable(rdev);
 		if (ret != 0)
-- 
2.17.1

