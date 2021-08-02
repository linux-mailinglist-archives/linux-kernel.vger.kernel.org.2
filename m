Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28C73DE26A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhHBWWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhHBWWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:22:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD05BC06175F;
        Mon,  2 Aug 2021 15:22:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p5so23167319wro.7;
        Mon, 02 Aug 2021 15:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LFDQ2N8siz8MNk9BrQIvS1rfuibpMLRZ8cqYFTamWz8=;
        b=E7c1pgBNvnaYLBmbkSVkTbXxrb/kMzbTcelvoP8qAoB0Sv3MbzwQCHmxEnKNBFZQdn
         +ZnmAUF8r6lwTHqzooWmHFeLpCIJPnpGt/D0ZerpA/qOu82TD0DyotVaGAiXYF6b3vry
         8CYfswb+IQ8z37U++pzmuKT5V5t+WGhm7MkRcqfO/N5vBox3ZWBmEQ7H69VjsD0gkCm5
         Derkk0CAL7ASN15GBLaJnb3YQSz3iXRtdS8avCJSFNbM8euBTXeigHIbcaLHhXYsrcGj
         eqrxY8eZcpClmAG7b5TunAfv+wRd36ZvXmr+Whu9A0zWDb66Br+PU9NMn9TFXNw9P9P5
         kxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LFDQ2N8siz8MNk9BrQIvS1rfuibpMLRZ8cqYFTamWz8=;
        b=aNuBDsSvJtTdYG3akOg+tOQWH2SxZZdKaMdWvGNwhAObhFQdUy8fta4FQd0s2Z05la
         XMQWbqbQPlrkwJVxk66t+5nb7AIkz77FQtcXH26yHnxQQAiwo8+CkSjc4oWOIdpzGalg
         VYTPGg5eyGrRJ5sFJgD/0J7xwWU96eYdvypOby+l++fMxyJW1OVl/pAnYtoweh3626OI
         jNgIl89+S07Utu5phTvenBcfibxRJEcPIj9AKzdEenp39/bMo/762ik3dpSHrF0lHEiW
         qdATcLdwdWzZIuPT8SZyYa/ORrLmbM6aYOWQgsdWZTvoipCuu/1nFXsakccfsROrkTd5
         JfMQ==
X-Gm-Message-State: AOAM531G4tF2ZIbz1Lo1ud9V7rRXa65fn4Rkv9qoE1ywe+24XX5WSQNQ
        76IUt5Z7jwHtp9fjmhOi+l8=
X-Google-Smtp-Source: ABdhPJzkhfRbi/ObDq0n/8x/v4sdOFj8l7b6p88n7HKeun2z17R8wyGruk5Tzq1W60hWEnGvP8W0Ag==
X-Received: by 2002:a05:6000:124b:: with SMTP id j11mr19962803wrx.348.1627942928521;
        Mon, 02 Aug 2021 15:22:08 -0700 (PDT)
Received: from pc ([196.235.140.151])
        by smtp.gmail.com with ESMTPSA id j19sm1219979wmi.3.2021.08.02.15.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:22:08 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:22:05 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Keith Packard <keithp@keithp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: misc: chaoskey: get lock before calling
 usb_[disable|enable]_autosuspend()
Message-ID: <20210802222205.GA1389315@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the documentation of usb_[disable|enable]_autosuspend(), the
caller must hold udev's device lock.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/usb/misc/chaoskey.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index 87067c3d6109..8af00be7b9e8 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -206,7 +206,9 @@ static int chaoskey_probe(struct usb_interface *interface,
 	if (!dev->hwrng_registered)
 		usb_err(interface, "Unable to register with hwrng");
 
+	usb_lock_device(udev);
 	usb_enable_autosuspend(udev);
+	usb_unlock_device(udev);
 
 	usb_dbg(interface, "chaoskey probe success, size %d", dev->size);
 	return 0;
-- 
2.25.1

