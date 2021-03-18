Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D26340154
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhCRIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCRIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:52:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE414C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 12so3008958wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LSRu3B7vTOehIF+pPi+UNH/SrfnJ26bQ8jJ9MYE7/g=;
        b=PNjjaiEovLZUonRxnIGR3ImVloNSF8ldt8dyaCxBC28aqjKAs/a5DKAZ+N59fzdauZ
         y6m3IBNONcOWwWtX8Fby+/P2l/Pzh0OFUZeiiW9CQH1yr4WlbgVD2vCa+Dja8GFVkU5p
         i6TPratcgwrM0szQJuHbqAxm/n6prU8nimMjbSp9CZGAmS01oZIGuqpqtIdZWAlKPRy6
         9Q9zfsRROdM6T+jFl/dKas9kSn8n9Ugn2zLgJixA80jYp8fQ6Cwl4fwSyfuY13hn7KxS
         4U37PDUXSpSvP28vQm+1lAUpqPoi4abMoRdlD5DfjR2SgkNTDxq49dyIulJT2pzIsi95
         l23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LSRu3B7vTOehIF+pPi+UNH/SrfnJ26bQ8jJ9MYE7/g=;
        b=HksJw4haA7UE8gXAP/v1igm/CzZLJtoar+HNzKl/srdWi8Td2WD9HoPC1vEHrjUqKQ
         /FO3ZN57EGJJLRPRTRDYidHcpLf5Xijupo3mFHxlGIcLnXUUX4LrrIdhHUkmorE1hJy1
         1oG/fRnnWmpDNGW9CbgO1Xbuw7gq39iw9fq1LoT+Ip72A5zrsxxm3noRVHFx1EFQLrtD
         N4Hu8e5/VJMwEDXwoNNMBzX6lpXEXxTtCfQVM+ebvgpXENWWzaLKWe7YLRNAq0X1Tzms
         0nah6yVkHsJFiCtlQjOp0Ze545tjQAic19RuOIqVkgithwuDc1jwSfGHFhI//1QVy0mG
         gwVg==
X-Gm-Message-State: AOAM5322oWBVoRiZbt5OxEaN6xSH7LFRWliP7SiBDeNlons77NFsDyu1
        jIHfv/jq3wdgvLrgUhhlPnGoQA==
X-Google-Smtp-Source: ABdhPJwxfsmQo8LTvurXnGpxqnAHfbVwXbRto0zZJmZy7QI/jBR+MV+eJWV7QIMprPIybvud/h50pQ==
X-Received: by 2002:a05:600c:4ca9:: with SMTP id g41mr2556836wmp.150.1616057520550;
        Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jaromir Koutek <miri@punknet.cz>, Jan Harkes <jaharkes@cwi.nl>,
        Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org
Subject: [PATCH 09/15] ata: pata_opti: Fix spelling issue of 'val' in 'opti_write_reg()'
Date:   Thu, 18 Mar 2021 08:51:44 +0000
Message-Id: <20210318085150.3131936-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_opti.c:82: warning: Function parameter or member 'val' not described in 'opti_write_reg'
 drivers/ata/pata_opti.c:82: warning: Excess function parameter 'value' description in 'opti_write_reg'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jaromir Koutek <miri@punknet.cz>
Cc: Jan Harkes <jaharkes@cwi.nl>
Cc: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_opti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 06a800a3b0706..01976c4e40330 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -69,7 +69,7 @@ static int opti_pre_reset(struct ata_link *link, unsigned long deadline)
 /**
  *	opti_write_reg		-	control register setup
  *	@ap: ATA port
- *	@value: value
+ *	@val: value
  *	@reg: control register number
  *
  *	The Opti uses magic 'trapdoor' register accesses to do configuration
-- 
2.27.0

