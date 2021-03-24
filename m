Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92A347F51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhCXR0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbhCXR0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:26:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55F6C061763;
        Wed, 24 Mar 2021 10:26:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bx7so28535748edb.12;
        Wed, 24 Mar 2021 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KizuK1VUhVYZ48HlzjbMOXlUT2sfsfq66m33DGRHaDI=;
        b=pTh311UJjSMALDPHdTIuQ2TAW4axDn3TxMJaqRD0M1BwPSq8SPmnuncRIrqbsboujF
         JMpXF6lNo0Md2Mh/RvlfJ14OuRjR/IIsOXFD5G560slXerkaDQf7ULOdTl3S7WYM19XN
         2PKbgBfDq/2voTg61Tivx9eTYi/U4pcreDTccTBCqqolQPigwPa+VdQmGXO05Ns/yveY
         xD+u5e1pveYeIp1Pi+McEa3H/jgvSdWTjRS+fSgnCH07QkYYmNBI6xV1ECbn9+j13T3Q
         CXKWBKfIQ1jSErkJYAWVioHIDHVlYGG3HkScsj901niA+MzKWk+1mqrEU7vICryk6sYV
         szlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KizuK1VUhVYZ48HlzjbMOXlUT2sfsfq66m33DGRHaDI=;
        b=klIcFTqhNyofxRWT7JeinRL+8wm8xBluwhZurpfNQ2KY2AEhaRza9n29ADysPZY34Z
         hSwycMHzQXksY8z0+NR1GArg4pif1c7oiKV4/xYTratkyidP3YSLfwuWYCi5DRlUMShC
         x6SA3ihiSXkuuo+cvVTK6P1srGu386j/47T0GJ69iW2ZekokOXKPdiSXzc1Y3PDQDnG4
         PZNGt+uZ5ceD7IMCHHAvryIUwwPQSwJ+TwTpIHtv5YGkslG/6VrCIK3z/lK3gyFg5tvL
         HsmwI8VjIDY+ejUVhAGTSpFLbDMaui+Y2sQwOEsDGhjSmN9nHFHC0XlVptdbAjHWk6GE
         AwMg==
X-Gm-Message-State: AOAM531T+5s/HTP8s6KEozdsdpffyvGDTfsaHsr2ollel/IiFEb6pRif
        CdB9+kDgh5x7DI9LWfWM9fE=
X-Google-Smtp-Source: ABdhPJyuDpGmKn92QSjwWRLF+NDomum8mFJQOg1ryM/gi1/hMZKWQodOsaoxb7kNh64BWOjunHwNgQ==
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr4589027edb.329.1616606769634;
        Wed, 24 Mar 2021 10:26:09 -0700 (PDT)
Received: from LEGION ([111.119.187.57])
        by smtp.gmail.com with ESMTPSA id x1sm1233872eji.8.2021.03.24.10.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:26:09 -0700 (PDT)
Date:   Wed, 24 Mar 2021 22:26:04 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com,
        dan.carpenter@oracle.com
Cc:     musamaanjum@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix missing return assignment
Message-ID: <20210324172604.GA380592@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value of usb_driver_claim_interface should not be ignored.
Instead it should be stored in err variable and returned from
this function.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 sound/usb/quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9e5e37eff10e..dd32ceaef18a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -427,10 +427,10 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,
 
 		err = create_autodetect_quirk(chip, iface, driver);
 		if (err >= 0)
-			usb_driver_claim_interface(driver, iface, (void *)-1L);
+			err = usb_driver_claim_interface(driver, iface, (void *)-1L);
 	}
 
-	return 0;
+	return err;
 }
 
 /*
-- 
2.25.1

