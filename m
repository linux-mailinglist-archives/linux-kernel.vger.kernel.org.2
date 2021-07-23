Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9FE3D3595
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhGWHDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:03:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55458 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhGWHCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:02:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B232E22618;
        Fri, 23 Jul 2021 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627026201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGv3LznFQj68M3237sMqjjgkGl6aRsKe6S2Fhiqr9Cc=;
        b=KXq+ckZwyzg6JxoBwZkhZeWN4+N5CE4kZ48rC/vTEZZOirYZ+oYTDwX3grViOOYdseBF2k
        4QflnPkAI24e+ogbkiq8qNHivUGojTVhk+Eb3f+ahq7nB+iBtsv4ZNedRA4q2OzJgZ4kIr
        wYAAUv2j9xoS0m9tiUuz3BcL8TW2LLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627026201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGv3LznFQj68M3237sMqjjgkGl6aRsKe6S2Fhiqr9Cc=;
        b=kp8W8zQKNV81u1ForDI3lERrulZrbrxDzAik6MeoD29ITI4X0aSSqJ0Ooy7KKqtRQkSSh/
        PZbi/pT5jyacXcCQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8A951A3B95;
        Fri, 23 Jul 2021 07:43:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH 8/8] tty: pdc_cons, free tty_driver upon failure
Date:   Fri, 23 Jul 2021 09:43:17 +0200
Message-Id: <20210723074317.32690-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723074317.32690-1-jslaby@suse.cz>
References: <20210723074317.32690-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pdc_console_tty_driver_init() does not free the allocated tty driver in
case tty_register_driver() fails. Add one tty_driver_kref_put() to the
error path.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/kernel/pdc_cons.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 70c2a1648fc1..2661cdd256ae 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -181,6 +181,7 @@ static int __init pdc_console_tty_driver_init(void)
 	if (err) {
 		printk(KERN_ERR "Unable to register the PDC console TTY driver\n");
 		tty_port_destroy(&tty_port);
+		tty_driver_kref_put(driver);
 		return err;
 	}
 
-- 
2.32.0

