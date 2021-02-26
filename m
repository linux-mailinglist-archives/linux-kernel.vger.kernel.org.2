Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57661326222
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBZLsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBZLsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:48:46 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCFFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:48:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c6so10645794ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p4qJGLkjE+ZTf4s2f/49t4kWBaGGOzuYYXQVPUg3WZI=;
        b=FlzAqwfzLgX8RhWInKuCrnVfD5WpWalYUibUel9W/M5vZ2DqQIy4OnCnl1dOLZoicD
         bSC+3Ku4ST/FPX4m4xELECRfA+GCzTkbdDmO/Q/ladLDX6D67VBhqtqeDEYx0OSnSHZs
         wKB3sYGwJ1O02aX1tp15QuI3ChyjfA04FxIfQa36ItsRPjU5+rKPDNE+PhmT2KgcCcdx
         0TSTw4fHiDnCH5SUrR2vRq7auZ5VgF3RNtgne2fqcgvr/l1+KssYUaAHiyM/u5pKD4Ew
         6P9Tpxc1SuhaEapi4HpqDpSJYZZ70ztf4zz4o0PAAk2tM3nZqfGLkmlopOqzKZLPjDcH
         8iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p4qJGLkjE+ZTf4s2f/49t4kWBaGGOzuYYXQVPUg3WZI=;
        b=gS7xFylqU3zBE7NQWqV3ezXstAq0X8H+h+R4F6aNMovmxPVEincxjo1mpnmZIz+AZn
         Y4Ump0dvnpp1G00i7+W0lGNpodoRETsZWtjb2tI46VSEL8yrIcGEixFVw0Ztlgok+Hzk
         zAEWmxXfH3w3nyfs91LhBdvOCJWcfzcSXY3a+/+Aza+qudPbPqF/kAB0iQly9wzvsH4b
         aUOWAKBPyCMS9B9IozFs9NOutldpxFI5AOyqxd0QOW9E22519NgdKBhomg7ZaHUgcQ3b
         eeoMTZyQp47/5cipdENc9hJwQZdpOsklTJQS9q8YpqEuurEQvf61gAc5DHQFAt6OKZ/p
         GStQ==
X-Gm-Message-State: AOAM533/IXBy38dB8RPI4+u+Bxzzf/CxziK9SkdxlqhiAcEEmXF3EWIx
        RXrT6cCcrgdRL/KxmInYAUc=
X-Google-Smtp-Source: ABdhPJzy2OC3XcGlKwr3feiGZ9P7GSKAcF8kyhJY8jSMNYfwjJzBJAHAE2kXrc/p2McMKovuTsJlzw==
X-Received: by 2002:aa7:d5c4:: with SMTP id d4mr2764010eds.49.1614340084754;
        Fri, 26 Feb 2021 03:48:04 -0800 (PST)
Received: from ubuntudesktop.lan (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id t16sm5622442edi.60.2021.02.26.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:48:04 -0800 (PST)
From:   Lee Gibson <leegib@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Lee Gibson <leegib@gmail.com>
Subject: [PATCH] staging: fwserial: minor coding style fix
Date:   Fri, 26 Feb 2021 11:48:00 +0000
Message-Id: <20210226114800.316897-1-leegib@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes this checkpatch warning
WARNING: Integer promotion: Using 'h' in '%04hx' is unnecessary

Signed-off-by: Lee Gibson <leegib@gmail.com>
---
 drivers/staging/fwserial/fwserial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index c368082aae1a..a020f533c982 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -2632,7 +2632,7 @@ static int fwserial_parse_mgmt_write(struct fwtty_peer *peer,
 
 	rcode = RCODE_COMPLETE;
 
-	fwtty_dbg(&peer->unit, "mgmt: hdr.code: %04hx\n", pkt->hdr.code);
+	fwtty_dbg(&peer->unit, "mgmt: hdr.code: %04x\n", pkt->hdr.code);
 
 	switch (be16_to_cpu(pkt->hdr.code) & FWSC_CODE_MASK) {
 	case FWSC_VIRT_CABLE_PLUG:
-- 
2.25.1

