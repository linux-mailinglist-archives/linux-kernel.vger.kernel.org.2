Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B000031ED48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhBRR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhBROn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:43:57 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C1C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 06:32:14 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u143so1406754pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 06:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z8JGVPoDk6C0GygHaIvieM1VYWj30R2VXfC11nFdH/c=;
        b=X0aOFqFvmjFpY9xgl3yKZmEpRqki1EKkRuRoylf+XjMDp6WaVdWU4ZAm3eaB3NxiiB
         cMu5KvTILY25mR7aeswieXmhOApOV/jrd/lxQ/p8OmKnTyG9RYAL2e0sOMd/28XxTeWb
         AeGj49ylCG0JYoRrq6OgGkEuLK4C8uSCRhTtgqHMEcDZi4oxslKUc470XIgXkZS4JGQA
         US2uCo7ZsWt4epXDLPY24YQNrHJG7/JrZcrEciWpz8q1S7np7V/fdseFHOiNk9vWnWmI
         I7wvxpEc7XpJamkVQiV7wdTWWFspu30oQZMKLmN2UFou6qRSm+YuASHO7wYUfs9Nw205
         Cnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z8JGVPoDk6C0GygHaIvieM1VYWj30R2VXfC11nFdH/c=;
        b=Igb3faWPbf1m9lqM7RYKh3V3e3wTHhOTyg3BfehcDW3cAKdzxVIFG21TURfov9nTNR
         5o3pAnBiHvI95AgN99ILR/h8Ru0utmqAiFHA1bcCdJYirLkEymXR0gtHNIwlZ1I/jD8j
         6jzxDB4ARNiuwKuw8UgrliMaId8EZEWzbz6fwGAE+0A0Mdb9l+unC5K4bHl+OM9iUxjy
         /KKjhDjoPCnPqfgS4WFW05nUPX7I7EAsM+t+UZa4ZyTA/M6c9PPJyfS4RXelwvdmvKI/
         i++R14R8fvE2C+MTSScz0MLiEZUA5csNcOzDUwrXOxZ1C8fp4v2JrTnqpdv6VmyXC8th
         ph0A==
X-Gm-Message-State: AOAM531jHaS4rB4SdHls/YdNN11rzIH3uTh31hLaKW4XFCMqTq2Cvb4C
        sZKNoRsvhjiFeUeCZ847iV4=
X-Google-Smtp-Source: ABdhPJx6YgqCo+rd/vRYhoFamNZsdAUgT1FFDjdBhOrdqiCf7wB8XwEpPQLZ4P2cN29po6xzSh11LA==
X-Received: by 2002:a63:907:: with SMTP id 7mr4195885pgj.96.1613658732794;
        Thu, 18 Feb 2021 06:32:12 -0800 (PST)
Received: from rayare.domain.name ([106.51.141.71])
        by smtp.googlemail.com with ESMTPSA id a5sm5985919pgh.15.2021.02.18.06.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:32:12 -0800 (PST)
From:   chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     chakravarthikulkarni2021@gmail.com, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Michel Lespinasse <walken@google.com>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: comedi: Replaced strlcpy to strscpy
Date:   Thu, 18 Feb 2021 20:01:49 +0530
Message-Id: <20210218143152.3957-1-chakravarthikulkarni2021@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpath.pl script.

Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 80d74cce2a01..df77b6bf5c64 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -939,8 +939,8 @@ static int do_devinfo_ioctl(struct comedi_device *dev,
 	/* fill devinfo structure */
 	devinfo.version_code = COMEDI_VERSION_CODE;
 	devinfo.n_subdevs = dev->n_subdevices;
-	strlcpy(devinfo.driver_name, dev->driver->driver_name, COMEDI_NAMELEN);
-	strlcpy(devinfo.board_name, dev->board_name, COMEDI_NAMELEN);
+	strscpy(devinfo.driver_name, dev->driver->driver_name, COMEDI_NAMELEN);
+	strscpy(devinfo.board_name, dev->board_name, COMEDI_NAMELEN);
 
 	s = comedi_file_read_subdevice(file);
 	if (s)
-- 
2.17.1

