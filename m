Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FCC369B52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbhDWUbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhDWUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:31:35 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0920C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:30:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c17so163145pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fAnBXmbI8k7isUTh/URInLKNzVSBWp0SOquPgfUFDB4=;
        b=MwKIvA28TgK6WGm7yDG83kdPdu+iJx45hsYRagGRtaTFc+j6k1V6cMeEkbrW8820zO
         TiEFzVWI2Yn3fdBWafk7FT+jy0hxahoX5Kctb9OL/6pPGvBVEcOupd6x18PD91aRGgTo
         2miM6OtfTWEqR/mQ8jjzeMCDvksvCIztaZG9WvgpzlfyzxQdtq6e+9vDHUUrhY4++q9e
         SlBj8DEeroJ50+Rg1gClbSY0VRHabG+DS3hIkneFO/WQltxHfH4yAGgqKbX6F+bhOMTw
         UwzhaR8+HQqubb2qTYESY9PbjwwjWmTUplnQJDFZo0s0iK3+G8DpK1peg3HuXzgFAynk
         cY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fAnBXmbI8k7isUTh/URInLKNzVSBWp0SOquPgfUFDB4=;
        b=OJS1WPuINXfOq4PZOKJitQJG3TRQF/annXlVSfRGtCK5LrNEtmrdCsZvAW0RcaFzpz
         7XEyBWPA1jdiGGJ6koTs8jeyXhcuUrxANQ2sCCRlMDphGavTmqzsZM0ZFTR79iGmchNP
         DfAy7MFosqI1cpyh+3tFiaDJKqybXBd/zOwz5PnxU+HVpXQ2p3/EhxCybAK7BrNE7ySi
         /D7l2l+C/VGoPqwpVTFWRGrkJtDpRmIqBq+cwRRWgSEWkD46PW2YrdI2Hm4SkOgUySZA
         EQMi6IR4zmCKXOTPGshftgIpKqdtm1jk8g8MPaN5YjEtqNdC9ZqLdVenO2/0ishiw8+q
         TMcQ==
X-Gm-Message-State: AOAM531yh/z4zB/0nzEk9Li4PTYGwqpcVFN+R/hbnnuwODRbMofQ4S6K
        r6barYAZkyPu/WulN2HFeGVcuP8wo4BbuZfc
X-Google-Smtp-Source: ABdhPJwDmbvWSN3Q7z5mpgQIFfMiRL97nbEnqZxq4/dkPXNsTr5MhMR0vMofqtSs+QzDl7QBIKqfVw==
X-Received: by 2002:a63:3812:: with SMTP id f18mr5553847pga.380.1619209858468;
        Fri, 23 Apr 2021 13:30:58 -0700 (PDT)
Received: from localhost.localdomain ([49.37.83.174])
        by smtp.gmail.com with ESMTPSA id z26sm5409348pfr.106.2021.04.23.13.30.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Apr 2021 13:30:58 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] firewire: net: Removed unused variable dev
Date:   Sat, 24 Apr 2021 02:00:51 +0530
Message-Id: <1619209851-4739-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot throws below warning ->
All warnings (new ones prefixed by >>):

   drivers/firewire/net.c: In function 'fwnet_finish_incoming_packet':
>> drivers/firewire/net.c:491:23: warning: variable 'dev' set but not
>> used [-Wunused-but-set-variable]
     491 |  struct fwnet_device *dev;
         |                       ^~~

Removed unused variable *dev.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/firewire/net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 2878564..4c3fd2e 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -488,7 +488,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 					struct sk_buff *skb, u16 source_node_id,
 					bool is_broadcast, u16 ether_type)
 {
-	struct fwnet_device *dev;
 	int status;
 
 	switch (ether_type) {
@@ -502,7 +501,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 		goto err;
 	}
 
-	dev = netdev_priv(net);
 	/* Write metadata, and then pass to the receive level */
 	skb->dev = net;
 	skb->ip_summed = CHECKSUM_NONE;
-- 
1.9.1

