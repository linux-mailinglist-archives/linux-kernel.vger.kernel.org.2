Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF6340156
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhCRIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCRIwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:52:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E40C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so2834231wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwGRt156EdlfIcuKCMjM9ajk7y2qH3FZ5j2kkdApNlI=;
        b=ZNLc1rmscy9Ufcs8ax9kjjJYActKRhTxjQl+CJeo5Z+wXmHIWr58HGrFeIxK17WLNJ
         ZZeK53R+VbzfyDMJroa4R25E4EsQ0NM3ceZsYj9Uul2llUlIGdqxNXtVJB1EWhOKRiyX
         k8qcxjdbyr5LrkIVK6p6HYGTDydAtDRS4WfYTWX4d4qw4bNn9WYXvx6S0Bnurw3OhgHt
         vhNWDgyWjTGMXTVl4EZKOe3yhXtKspvt1mxQvcicD0f3XINahUn+xk5OTZRifJX6Z0SW
         MgKXZAERdMrA8OeQ4FwLFeOZ5RjOYiw34gObUDKFthl24OsaLgffdrVbOMtVm1E96KQk
         c8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwGRt156EdlfIcuKCMjM9ajk7y2qH3FZ5j2kkdApNlI=;
        b=JAQ+dEElZhsfLYy6bOxGyG0WQa90/vSJihbmMP7Fw9RsWEXxJ7KRggnkN4jci7xSjP
         zC1EaXO7QA3yf8kZD1TmhtW3PskDgBnC33GRXuSrM6C3fnmOTpMxhrJv+osY2+A4GgU2
         1/f77t1TGJGvIgHScv3KeLiU/4GEgZwjE+Teo3HoTIHHMyU3DQnzyJD9paUAqbMaOIYv
         RnZhv+4Kvc7jwcAhUiNZ7NKo8/J7Omy+rAtFqNGzdn7nsR5D7E8BPgFuhwz/0baIRI3Y
         INB4ONHM5TIGJ9NzKxpJA0G1fk5+6fXFw4vPv4ybVmH0V44o5qT2anDrt8Z5WcBSnvOq
         fTCg==
X-Gm-Message-State: AOAM530g4WV8CzvWPCBnexLj9kKorznbDGgj3e0ndWFsVngrIVTh5+7C
        M4tFYMSqPH2iC6p8I3O6novUjg==
X-Google-Smtp-Source: ABdhPJxZI+GUVBWWZ9xe0iTVmppX9sAmLpMzxVjISl/r1/8XtXHftByBvBuu6UbNTJ2x/RvJ+HvC8g==
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr2467016wmq.25.1616057524149;
        Thu, 18 Mar 2021 01:52:04 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        ALWAYS copy <linux-ide@vger.kernel.org>
Subject: [PATCH 13/15] ata: sata_mv: Fix misnaming of 'mv_bmdma_stop()'
Date:   Thu, 18 Mar 2021 08:51:48 +0000
Message-Id: <20210318085150.3131936-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/sata_mv.c:1929: warning: expecting prototype for mv_bmdma_stop(). Prototype was for mv_bmdma_stop_ap() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mark Lord <mlord@pobox.com>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/sata_mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index eafca46d8feb4..bd23d63435cb4 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1917,7 +1917,7 @@ static void mv_bmdma_start(struct ata_queued_cmd *qc)
 }
 
 /**
- *	mv_bmdma_stop - Stop BMDMA transfer
+ *	mv_bmdma_stop_ap - Stop BMDMA transfer
  *	@ap: port to stop
  *
  *	Clears the ATA_DMA_START flag in the bmdma control register
-- 
2.27.0

