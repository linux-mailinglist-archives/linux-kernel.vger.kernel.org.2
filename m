Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3699B34014D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCRIwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhCRIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:51:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F309AC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo2828170wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxZxF4hq2WUxPEWONl0C36ILOQnwGtK5Kgu+3CdOvGE=;
        b=jgT7ilJ84tK2lz/jYCrcTsFWXdIQqjFrcSZO+wuwNCAxhhzUVWginn5lDvgg4pwc77
         Rv44k5Pr08EeK23LgoIfQplCHraMOTZq4MGNYwJwEDTpECcqWBMrIXyRj+f6gqjCyyzC
         TeY59hmaF6eLpObK8nZyr6KDNHHTELki6neenOBxx6cJgBqLnQ1Bl1nFsAVx6gQFLp57
         W0kyqEL1cvI7M0lpJoOkLrpkRCClWTmBvCu8wYJTo/wY9hlGkh2MA8kj/CmDn9kP8YX3
         rCPNVUEZTA76WCIoyPgXBnxdushlS2CsOGQtZwLohO4WTDZJ/zrt5HYaDAn3pQ+U0LCt
         AMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxZxF4hq2WUxPEWONl0C36ILOQnwGtK5Kgu+3CdOvGE=;
        b=a3wxTLtN0mWt2PS2AkOssJhCSfaoAp2KFXJi+UnT5JGHOIB47GOwxdox0XBWIdM9D0
         5MTtQBj7xP8TTGFc/oR0U+2IGgb1N0Rt2LML7RPemmdvby5HyLCfbW6a/r0VzKPJa7Ta
         kCpOgBoUdJa3rBiVBAwfdt7Bk1+5rEbacFzR4ZyhJh/9Kbos6lLS8h9HGUzdED8IEdau
         AGTy2ZE7OqcR7rBcLg3o6NFfoIRqzeYeEZYzNVynHk8q0hG/s4Q/Ng9nkkS+LRqbFuPc
         5vreZqrSjamkz5k1v5nFeZCf69RgekXzKTRkabwicpQhF8PFHKVNDQJhPH1WnB2l59V3
         X68A==
X-Gm-Message-State: AOAM531q5LXJTSA/0WB3i54UsF3f1GEyE5gkgAdFXhlCN0+nmgQFkiXk
        MXbEQYQTR5NPhJ5f0jdtQ4/cyQ==
X-Google-Smtp-Source: ABdhPJwgIahBU2bvMS81hRPmVLgu9kQbD/3kXrFawRNphy1r7IwfrJ1vt+mGHm7VMPVbrmjhqKuc9g==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr2554933wmi.27.1616057515445;
        Thu, 18 Mar 2021 01:51:55 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>,
        Lionel Bouton <Lionel.Bouton@inet6.fr>,
        Vojtech Pavlik <vojtech@suse.cz>,
        "L.C. Chang" <lcchang@sis.com.tw>, linux-ide@vger.kernel.org
Subject: [PATCH 03/15] ata: pata_sis: Remove superfluous param description and supply another
Date:   Thu, 18 Mar 2021 08:51:38 +0000
Message-Id: <20210318085150.3131936-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_sis.c:124: warning: Excess function parameter 'deadline' description in 'sis_133_cable_detect'
 drivers/ata/pata_sis.c:529: warning: Function parameter or member 'mask' not described in 'sis_133_mode_filter'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Cc: "L.C. Chang" <lcchang@sis.com.tw>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_sis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index d7cd39a9888a9..b5b764e18adfc 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -114,7 +114,6 @@ static int sis_port_base(struct ata_device *adev)
 /**
  *	sis_133_cable_detect - check for 40/80 pin
  *	@ap: Port
- *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection for the later UDMA133 capable
  *	SiS chipset.
@@ -521,6 +520,7 @@ static void sis_133_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 /**
  *	sis_133_mode_filter - mode selection filter
  *	@adev: ATA device
+ *	@mask: received mask to manipulate and pass back
  *
  *	Block UDMA6 on devices that do not support it.
  */
-- 
2.27.0

