Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBC3F42DB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhHWBNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:13:31 -0400
Received: from ozlabs.org ([203.11.71.1]:42813 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231452AbhHWBNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:13:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GtDkP4KgRz9sVw;
        Mon, 23 Aug 2021 11:12:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1629681167;
        bh=3617d1wzXnjSlPLePamFOKaTTSsHAU2Hht3MegCG/fY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=s2kUtebBLqozNQypZrHVlFYCIKF+v3fOv1IWEJ7sKUi6zPxdPd4xsAojiuo/RS7Fq
         heRwCeZlJGpGtAQ/qfPzw2vBOJLBkIeLyZjL6dJUtzYuqvbb8id6qtwlc80Od6euKo
         O51B86WDGQKDjbHFxc4iYSInjLUfQwINJvB7VeXpJgHDs/gz96lX6h2nPNCdO42sYV
         ptUuLWjotXQhv82OGNqFPPDBHQwo6wZy+lveICPSDNKBK4YkeA3J74/uN3bWtSbM8N
         +DJzjUfoVz06JWnG0HJEgZD/r1bMyQWckEnT5wlw2PJbCwL9y8LZgk+DFVq+mTzKFO
         3wUA52+1jYmLA==
Message-ID: <b43d2cf8dd0e2721a5b834a660bd35633bc82436.camel@ozlabs.org>
Subject: Re: [PATCH linux-next] fsi:(fsi-master-gpio)Convert sysfs
 sprintf/snprintf family to sysfs_emit
From:   Jeremy Kerr <jk@ozlabs.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Mon, 23 Aug 2021 09:12:44 +0800
In-Reply-To: <20210821034250.27914-1-jing.yangyang@zte.com.cn>
References: <20210821034250.27914-1-jing.yangyang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Fix the following coccicheck warning:
> ./drivers/fsi/fsi-master-gpio.c:721:8-16:WARNING:use scnprintf or
> sprintf

Looks good, but we may as well do the other cases (in fsi-core) at the
same time.

There's a cocci script in the initial sysfs_emit series:

  https://lore.kernel.org/lkml/c22b7006813b1776467a72e716a5970e9277b4b7.camel@perches.com/

Which gives me these additional changes:

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 59ddc9fd5bca..159db87a043d 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -818,7 +818,7 @@ static ssize_t slave_send_echo_show(struct device *dev,
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
 
-	return sprintf(buf, "%u\n", slave->t_send_delay);
+	return sysfs_emit(buf, "%u\n", slave->t_send_delay);
 }
 
 static ssize_t slave_send_echo_store(struct device *dev,
@@ -862,7 +862,7 @@ static ssize_t chip_id_show(struct device *dev,
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
 
-	return sprintf(buf, "%d\n", slave->chip_id);
+	return sysfs_emit(buf, "%d\n", slave->chip_id);
 }
 
 static DEVICE_ATTR_RO(chip_id);
@@ -873,7 +873,7 @@ static ssize_t cfam_id_show(struct device *dev,
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
 
-	return sprintf(buf, "0x%x\n", slave->cfam_id);
+	return sysfs_emit(buf, "0x%x\n", slave->cfam_id);
 }
 
 static DEVICE_ATTR_RO(cfam_id);

Do you want to include these in your patch too?

Cheers,


Jeremy

