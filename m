Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E384416EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbhIXJcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbhIXJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:32:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BEC061574;
        Fri, 24 Sep 2021 02:30:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z24so38439753lfu.13;
        Fri, 24 Sep 2021 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfZBefgZKCVrOuu57+nq1H6u9rzubejLN3FV7rqZ18c=;
        b=GYZaY9Pxa0qLtceGySkS8vUAHEFWvvfWfz7MggaEs0/WtK4dJ6fCUVjqJUf3YS0I8z
         iHE7pSCKYgPNT2gYrfDeRjYdTHjhlnbdXoT7zOAUh4NhI44LxRu0ttQ5Ox7uOmpj7fWR
         4DHfISm4N/vFWAkn6u31Tq/pfdVW/y9KkmHfjVxKYTIPDk8J7FAY8ZijRndtHi1pavbJ
         AtMH73EkUPG1ZcS+DzdUw+ohO9yMaVDbObljD6cyACT/ZZKt05eLWwCu+SFpLqdPaHTo
         0loSOUe8HyaQr9WPUTnYLpqTSK5qgQ8aYQmtU8dcmzf6oZgB3alLsG1Q+bTbMzr5hRNV
         o5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfZBefgZKCVrOuu57+nq1H6u9rzubejLN3FV7rqZ18c=;
        b=xH+ZXl8BII47XrdANHrWTaVO+ZXHeexL3oF3gTn5vXWMXJgdvZ5aTTQWrn4hFiPD4n
         FfBP5Zy+g7B8pkvM6mY+lY+3pixAG7TqmzZxXAb63U0pS3hShSBq0uvI2p33HXk18WMJ
         o3XKRiBW8XSFLJw0qVvm7P9ZShzFTeLnJAp+bNgfZxJOn4u6KXQZxJy3Vs59JfssbzBh
         n33opT/vJKdcsrf3yAvaAo4iCmBCbrBGWXXf4CTF8PIFB8dIoo6hx1pZ0AJIyg4Ccl/o
         0gPFE8Cp4Ll9CfApLw2MRfseZg0n6LssNxh376vtc8ZihRbtfK4YsSYVVSL+9mjNLBaR
         ULdg==
X-Gm-Message-State: AOAM531mXRfdaZjgZswQkEl2lsa8IR7muK+GdlUmGmfnAvHmIE+IxchY
        eLu8WFlWzBag3pmj/Tc1i5wXDdigBJI=
X-Google-Smtp-Source: ABdhPJwgbJ1MuQ3J9Bphe7doW4lyBvTqp1gebweVRBt3tfS/amN1aulEo3j/CXXIPVXNV3KvJI5S8w==
X-Received: by 2002:a05:6512:3094:: with SMTP id z20mr8739288lfd.418.1632475830226;
        Fri, 24 Sep 2021 02:30:30 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id x1sm882530ljh.113.2021.09.24.02.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:30:29 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 18O9URAZ026127;
        Fri, 24 Sep 2021 12:30:28 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 18O9URru026126;
        Fri, 24 Sep 2021 12:30:27 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH v3 2/3] hwmon: tmp421: report /PVLD condition as fault
Date:   Fri, 24 Sep 2021 12:30:10 +0300
Message-Id: <20210924093011.26083-2-fercerpav@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924093011.26083-1-fercerpav@gmail.com>
References: <20210924022020.GA3032273@roeck-us.net>
 <20210924093011.26083-1-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For both local and remote sensors all the supported ICs can report an
"undervoltage lockout" condition which means the conversion wasn't
properly performed due to insufficient power supply voltage and so the
measurement results can't be trusted.

Fixes: 9410700b881f ("hwmon: Add driver for Texas Instruments TMP421/422/423 sensor chips")
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---

Changes from v2:
 - Add Fixes: tag

Changes from v1:
 - Trivial rebase

 drivers/hwmon/tmp421.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index e6b2b31d17c8..3a789f21188c 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -182,10 +182,10 @@ static int tmp421_read(struct device *dev, enum hwmon_sensor_types type,
 		return 0;
 	case hwmon_temp_fault:
 		/*
-		 * The OPEN bit signals a fault. This is bit 0 of the temperature
-		 * register (low byte).
+		 * Any of OPEN or /PVLD bits indicate a hardware mulfunction
+		 * and the conversion result may be incorrect
 		 */
-		*val = tmp421->temp[channel] & 0x01;
+		*val = !!(tmp421->temp[channel] & 0x03);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -198,9 +198,6 @@ static umode_t tmp421_is_visible(const void *data, enum hwmon_sensor_types type,
 {
 	switch (attr) {
 	case hwmon_temp_fault:
-		if (channel == 0)
-			return 0;
-		return 0444;
 	case hwmon_temp_input:
 		return 0444;
 	default:
-- 
2.17.1

