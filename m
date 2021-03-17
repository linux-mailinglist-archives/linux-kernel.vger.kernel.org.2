Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485DD33EBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhCQI5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhCQI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D574C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j18so960193wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KspmBqbjk4SwVrkpMki278CpteugIPA4FRqHSDe0Ld8=;
        b=f0wMl7PPI9GyJQ54AsUw33UqcpCkutaW99aa+jPQ9689zDYUS3KVhJe4WI5qMqNIMx
         T0XQXz/xhmwwte8hcpnLMQZ+oKFfRkIzVEL8FEwBnOEdKMnGJfJvnBWyH0gg+QjzGKkP
         ouulMB01hntTnTyV5ZPGOSVNs5eq3hLvrbWC0pIbQi1k8XrTnDPLHxWf5T910lB7U7+J
         KDirvMUvLbDFUbILI65/V2KTy4LFIZRwRoJ7tDVGrrcL/py9f30rUdnozR3ZWli9q2QY
         ECsn1RWJYUel/qmol5Q8F6YE9PAMhJib289eXCSDAUuSngGXnCzyFVB7uRcmtsNVfe2I
         i23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KspmBqbjk4SwVrkpMki278CpteugIPA4FRqHSDe0Ld8=;
        b=ER2zKgBogWYOMRFS4QzeImCTahRbQ0kdvWkaUI44GXHHXh9I3O14B0qhe7mhyHNM//
         6HgfzDPi12QUcAurPyRVORYYzybMoYKWPFxNOBAo7RhEFitlWY/sxWnTIueqKkiBAsdi
         pvV1t8in+PdwyoLZfutOPIOgQHZQAuEw1uGr6kkK1RmYRz9bZgc211sxcMmQd87HU+Up
         VO4nhekGh6HoqavFjS2qmI7q1GAOlldTHHJPyKUhzI8rLZLbWSNZnbPMONNWXOg5ue/l
         Up59tJMGK89Jb5Sw1QS+WYHDoEqWNxLciF2hEUrmmWB+x5flhpWmJFMN/71+hhnl+Z08
         Hwig==
X-Gm-Message-State: AOAM530bW4X7uE2EvEmc3ToR5NIaIwnKIQctPLoV4EOLC2nGd6na8nQK
        BPsVtYQCHG3SF9mvv1lpWVQv1g==
X-Google-Smtp-Source: ABdhPJxiWEKbcNLmng1Gyv4HVIliU9TYFHWiylRwsZe31cecjp+u+ZiyKznNHkHuce3wCKPgTS/0Iw==
X-Received: by 2002:a5d:528f:: with SMTP id c15mr3252496wrv.142.1615971429964;
        Wed, 17 Mar 2021 01:57:09 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j123sm1807243wmb.1.2021.03.17.01.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:57:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 04/18] scsi: esas2r: esas2r_log: Supply __printf(x, y) formatting for esas2r_log_master()
Date:   Wed, 17 Mar 2021 08:56:47 +0000
Message-Id: <20210317085701.2891231-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317085701.2891231-1-lee.jones@linaro.org>
References: <20210317085701.2891231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/esas2r/esas2r_log.c: In function ‘esas2r_log_master’:
 drivers/scsi/esas2r/esas2r_log.c:155:3: warning: function ‘esas2r_log_master’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Cc: Bradley Grove <linuxdrivers@attotech.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/esas2r/esas2r_log.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/esas2r/esas2r_log.c b/drivers/scsi/esas2r/esas2r_log.c
index b545798e400c4..d6c87a0bae098 100644
--- a/drivers/scsi/esas2r/esas2r_log.c
+++ b/drivers/scsi/esas2r/esas2r_log.c
@@ -101,6 +101,11 @@ static const char *translate_esas2r_event_level_to_kernel(const long level)
 	}
 }
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
 /*
  * the master logging function.  this function will format the message as
  * outlined by the formatting string, the input device information and the
@@ -170,6 +175,8 @@ static int esas2r_log_master(const long level,
 	return 0;
 }
 
+#pragma GCC diagnostic pop
+
 /*
  * formats and logs a message to the system log.
  *
-- 
2.27.0

