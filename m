Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4542388A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhJFHLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhJFHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:11:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B17C06174E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:09:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so6308126lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvXatvGat/zwzJqSmrQCEyhrxQWhLfa0q1L0IoYWuTg=;
        b=OUMXFkVRlHjmPfLG01X7bZWCgFjToKccbZtsyf9eZ8/OEK+CvHpiA5aPvlz2z9mRSD
         +ZKfg2U/a2An2ygd2VpvvsmPX7uCKkAC+Hxc41yuQTj+uePVLiOU+haODZ/ApYHH/8f2
         3NtIrioLve9QELz1V3TrL3NotEHS9iQA8y4r+cJqKg9I7OGLndz+S6fBgkpjg+gxWis/
         iblOzSOrQ8Yhakjl26lrMc4NPO5mWRL6Lu+Ut/JZLmsyhsPdF2RGgMFETpmAdABz0j4D
         Hk3mvPCK7lhVyyi3R3FFdaF92xiAeEqYtq86fH+kS+L6FtG3jJD0zGAJattBFE05YAj5
         RNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvXatvGat/zwzJqSmrQCEyhrxQWhLfa0q1L0IoYWuTg=;
        b=vHmeaEehSiHGUJEPwo4dPp11g/AzpM9Q2WRixCSbDaN/Ynbxc/DbFYOqZbSCNsEnQI
         a1Wk3wi0abdeD8aLgAZCvIqeN1aaIPPgD6Bc7Qf0e9Lc5AoxaConPYkQ91tgoeK1xJye
         kT2ppckF5zDgAIN08QFNOlXr2gO9VCFNZy79pp+gg9YKOWzbXCFMjmxh0k8W95N24/S6
         QAvapK9KTQgQ66eNFEU9XIHFvptrGwoYAnltBbzabMwFJ47yV30iT88H+W66PCpFNtXU
         Atq3UqLDsSTnjlbV/+p48KubSF6DMxmDjZ2VBk9xLQLX7V/O4Xn/QHjsAEdS1waOYGS1
         Kmrg==
X-Gm-Message-State: AOAM530UJE9rQXJbUhsiox1c/A1oDtvNY/dn80v0KHzfhT6bVA4Ifq+d
        w5deqjLSH6G8VjOxdiwK2tXa8Jy5HHa9XA==
X-Google-Smtp-Source: ABdhPJwiWckAjDP0oEVOp7O6I+2xdWl6g3KHBDRUZLJcWAjzuNr4/EViv0KcghFJmprudeewbUSrZg==
X-Received: by 2002:a05:6512:108f:: with SMTP id j15mr7531991lfg.337.1633504149074;
        Wed, 06 Oct 2021 00:09:09 -0700 (PDT)
Received: from jade.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u15sm2381032lfl.20.2021.10.06.00.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 00:09:08 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v6 1/5] tee: add sec_world_id to struct tee_shm
Date:   Wed,  6 Oct 2021 09:08:58 +0200
Message-Id: <20211006070902.2531311-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006070902.2531311-1-jens.wiklander@linaro.org>
References: <20211006070902.2531311-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds sec_world_id to struct tee_shm which describes a shared memory
object. sec_world_id can be used by a driver to store an id assigned by
secure world.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/linux/tee_drv.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 3ebfea0781f1..a1f03461369b 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -197,7 +197,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
  * @num_pages:	number of locked pages
  * @dmabuf:	dmabuf used to for exporting to user space
  * @flags:	defined by TEE_SHM_* in tee_drv.h
- * @id:		unique id of a shared memory object on this device
+ * @id:		unique id of a shared memory object on this device, shared
+ *		with user space
+ * @sec_world_id:
+ *		secure world assigned id of this shared memory object, not
+ *		used by all drivers
  *
  * This pool is only supposed to be accessed directly from the TEE
  * subsystem and from drivers that implements their own shm pool manager.
@@ -213,6 +217,7 @@ struct tee_shm {
 	struct dma_buf *dmabuf;
 	u32 flags;
 	int id;
+	u64 sec_world_id;
 };
 
 /**
-- 
2.31.1

