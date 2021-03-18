Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82E534014E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCRIwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCRIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:51:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76573C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so2687129wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aoLGrjaA86gEYNhPzBdhJFKTeunMjqb/nCBdLbMyrRo=;
        b=P7fYXWggStTWJ87VH6ccWK9NEZNIsOaKORnKXyLJTqXez6COXfwcLnSnSE+ursORem
         W2K+IED0ZIE7OoVpSVjUgHyif+UXHFSe/vVCviNpSRD5VdN4nxhNlXQchP5VBu8WOmqx
         ViY3LKbNm3J3iDcxt1KfmQ/K9pirPDC93Ml1ualQCpOsII0L/dZ6cCXdpRy17M1DDDc8
         ZIz1EhyDpnx4aD+irzAB3Lh9Yhwgt4WfWxnovtsk/Yjubor6xTWmTW5hlvgMk32Z1a5y
         JywumIFxihRXZPJ3fpW5wWSLMncKmHSn+qsTcastNFZmgW62JUeaKxRhTxqCPGWi1EtX
         LUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aoLGrjaA86gEYNhPzBdhJFKTeunMjqb/nCBdLbMyrRo=;
        b=hWxc7qDFi1vNrLNk1ab7owIMvG/XEkUPWKAM9cu11OkODQQrDQuz9cZnszdknjTZmP
         VqI9e1TZ87fb/Hcma9XxCBRnlLmVNNZjCJs+nfaxXS8icmZa2xjPe4GoBaoliN0i/Uxt
         Zu5OQVsYmculjigwOWWEOz00t4ShEx/RaTSpZKEgq53hCkjIPBk+Z4uK6YPOAJp8TwvI
         YWJ2ZpkgCbLw4qkapbyKW+lFEchQwXBvTaG2bztRiCD4WbHdUEhfu1DK//pfQO+Sw60g
         lekg/BSV13au6dqp/5lQf3w4EFXD8POfCY5FhA7TvkiLlFT5R8FQRxVnwxTJgWnrNSl0
         PGfw==
X-Gm-Message-State: AOAM531zhTOU14EiFJ2cBj+lF9XEPnB6cdm3NUaK7uv64Ud0DSpgSdwg
        a2f+5EJw2j682Ss/QTY94kzSng==
X-Google-Smtp-Source: ABdhPJwSvksHLUPPKG5u0cLbB8259uYmWTJcgL4zfB+XBygfRMGsA3fYXZfFeHbUs+uqn4X5byrctw==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr2547884wmb.62.1616057516258;
        Thu, 18 Mar 2021 01:51:56 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Torben Mathiasen <torben.mathiasen@hp.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 04/15] ata: pata_triflex: Repair some misnamed functions and fix some param descriptions
Date:   Thu, 18 Mar 2021 08:51:39 +0000
Message-Id: <20210318085150.3131936-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_triflex.c:143: warning: expecting prototype for triflex_dma_start(). Prototype was for triflex_bmdma_start() instead
 drivers/ata/pata_triflex.c:159: warning: Function parameter or member 'qc' not described in 'triflex_bmdma_stop'
 drivers/ata/pata_triflex.c:159: warning: expecting prototype for triflex_dma_stop(). Prototype was for triflex_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_triflex.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 2a4d38b980261..8a033598e7e17 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -129,7 +129,7 @@ static void triflex_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	triflex_dma_start	-	DMA start callback
+ *	triflex_bmdma_start	-	DMA start callback
  *	@qc: Command in progress
  *
  *	Usually drivers set the DMA timing at the point the set_dmamode call
@@ -146,9 +146,8 @@ static void triflex_bmdma_start(struct ata_queued_cmd *qc)
 }
 
 /**
- *	triflex_dma_stop	-	DMA stop callback
- *	@ap: ATA interface
- *	@adev: ATA device
+ *	triflex_bmdma_stop	-	DMA stop callback
+ *	@qc: ATA command
  *
  *	We loaded new timings in dma_start, as a result we need to restore
  *	the PIO timings in dma_stop so that the next command issue gets the
-- 
2.27.0

