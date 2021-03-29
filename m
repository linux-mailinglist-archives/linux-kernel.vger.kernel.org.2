Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503B634D899
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhC2TxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhC2Twt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:52:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25743C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:52:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i26so20181287lfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVaNtyqpmAO63m1s9LIcA3e9oGAv9PR4s9Zo1hpVIaI=;
        b=ouf1eR0EAiuh8+KvnQRm6oQZxsGxrv50BvfH8qQLs/34IWJg7jeBGtlotIQkdQxMTs
         RSMYPEjNJUvlzQT7rVbWnW75BzMKalYUt8Xa3QpNR3f0rPAq3A5uagkEPoD2GBOtsqMm
         89vtZ4mgogkyjXBDd806+m2LERGrv/3fFwFeD5mYchVIr6daX5/6xr8UiIR7BKXUzhg3
         9cjCoZGUWELxMhUymtvjUIajkZlbHjondY0SNU9inIrTciutx8IkBLYtm2aYH3qFCVhv
         K5ZJ/Tnjbb7KjKd4quUDkQ/mcrrTu2VAWMFVgtWVjatBbEwKEx868h+7v41Fh6CUiMg7
         djug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVaNtyqpmAO63m1s9LIcA3e9oGAv9PR4s9Zo1hpVIaI=;
        b=Hj9GODiD04FJ382mtI/BmmtBICXq6edIna23Yjne8vXsbZs3tmCO2iNjcsmblptZf4
         NWrLZiSGK9h93eIFBcDRr6xAHiz3a2d1dhV+x0PTmMXHdzglx546P/QzCkhYaLox7zOd
         iaCqUeIZ2fHz6G15VZqpjxefiLFXHPHTdlGZwNcIpVbUGAovou3ztRK9ia0SglEfgfW+
         xiX9BwNydZumwHO6ZhhnnjoqsfYPkY0OrpRAIPWPHjl5/pjiBEQuCTneoDeZobrEFnNN
         MnO5VsB7uaV8vKi423Y8wMA1melcHAyZWK4m7Ix7Gvk7+Np0QoTWdEy9TIytM6Eh9yTb
         dptA==
X-Gm-Message-State: AOAM532g3eC9ddJQR1kwuDscHdCLuVdZYSy8lrdpUaiBLHebTgOpHiey
        BwLt8jBvadXVGLubvgxOCVp/PA==
X-Google-Smtp-Source: ABdhPJwb1AaRiGLFqYY/0RAUVvJPzCAmHQRleTFa6K8lYjUEYoSKb2qk6H/CSzS01nJPZojNsofXWw==
X-Received: by 2002:a19:740f:: with SMTP id v15mr16749480lfe.247.1617047567470;
        Mon, 29 Mar 2021 12:52:47 -0700 (PDT)
Received: from localhost.localdomain (host-193.106.246.138.static.3s.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id v2sm2535743ljg.89.2021.03.29.12.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 12:52:47 -0700 (PDT)
From:   Angela Czubak <acz@semihalf.com>
To:     rafael.j.wysocki@intel.com
Cc:     akpm@linux-foundation.org, john.garry@huawei.com,
        linux-kernel@vger.kernel.org, upstream@semihalf.com,
        dtor@chromium.org, Angela Czubak <acz@semihalf.com>
Subject: [PATCH] resource: Prevent irqresource_disabled() from erasing flags
Date:   Mon, 29 Mar 2021 21:52:38 +0200
Message-Id: <20210329195238.9455-1-acz@semihalf.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not overwrite flags as it leads to erasing triggering and polarity
information which might be useful in case of hard-coded interrupts.
This way the information can be read later on even though mapping to
APIC domain failed.

Signed-off-by: Angela Czubak <acz@semihalf.com>
---
Some Chromebooks use hard-coded interrupts in their ACPI tables.
This is an excerpt as dumped on Relm:

...
            Name (_HID, "ELAN0001")  // _HID: Hardware ID
            Name (_DDN, "Elan Touchscreen ")  // _DDN: DOS Device Name
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (ISTP, Zero)
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, ResourceTemplate ()
                {
                    I2cSerialBusV2 (0x0010, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C1", 
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    Interrupt (ResourceConsumer, Edge, ActiveLow, Exclusive, ,, )
                    {
                        0x000000B8,
                    }
                })
                Return (BUF0) /* \_SB_.I2C1.ETSA._CRS.BUF0 */ 
            }
...

This interrupt is hard-coded to 0xB8 = 184 which is too high to be mapped
to IO-APIC, so no triggering information is propagated as acpi_register_gsi()
fails and irqresource_disabled() is issued, which leads to erasing triggering
and polarity information.
If that function added its flags instead of overwriting them the correct IRQ
type would be set even for the hard-coded interrupts, which allows device driver
to retrieve it.
Please, let me know if this kind of modification is acceptable.
Best Regards,
Angela

 include/linux/ioport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 55de385c839cf..647744d8514e0 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -331,7 +331,7 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
 {
 	res->start = irq;
 	res->end = irq;
-	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
+	res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
 }
 
 extern struct address_space *iomem_get_mapping(void);
-- 
2.17.1

