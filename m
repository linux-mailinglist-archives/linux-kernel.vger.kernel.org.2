Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1125639120C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhEZIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhEZIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26559C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x7so47232wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drzl0oh2q6ki2VINKxZA9OQQUfsloavhxF0fLxvYBec=;
        b=b0vVW7KfGyMHC9LTLYSTkrn8AQ3qcLfmf/OQplKmboTOy8i/dzx5MSZjqu9VXU4vv/
         MaOM2NRPf7YQZuC09C0F1eA3v9CNAdDxEBJMOaYvTUwlwgmJoKqp1/QH4h3bY36opOmF
         yEf9buTVp9X+6ms1/JD6RKYeQtk/UgaEcxH6wRnq9WGesj0OYPLwPj23HJl7BKZUZ3T6
         //5wrOFkPwS5J9ICRzB625zOhf2ZeP43Jj9+Gru6QD641wyvWEAcWvzhGnPIvLhhX904
         QjpTzhT5SYu9FDlX4fm4omljOTfy+AdfCcs0hXKujRBDRUtSlavS7ENblMzj8b4DixWD
         fwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drzl0oh2q6ki2VINKxZA9OQQUfsloavhxF0fLxvYBec=;
        b=EDUYxVegKizPOBIpmiWitdVwq+hmsOrZaESxSs0NMjdjwfeKquhBaE+BELzAAbIoTw
         Q7iR80n+azIn4MntYGqJf41N6lJC++An6z1aE+nTm8ZLlb2AtSDRqAze8vnzGC2/lMJM
         UdYooaZ7sBWvq9MKOXbvDQkx43kwKncqD8BHFULpzJwdAWZQJ6OoTatB4RVm2hW+X+wR
         mxCwA0q/j/eXtgPDq7/dwSgkzb7CQGPRQUnV5AHrztAaPkyuy01VX+LjJ2qELNbA2JXr
         G8fLx6nt6WyfZt1dQt2f9NrZ6Dq8XL5BzvTYGEjLJQmsRldWyCIFsmms7GzIlZ3cIK+S
         vx3A==
X-Gm-Message-State: AOAM533JVjaP9UaYEQUbxEYQWTu6d+fwsOOfLexrHZDidbQcsTmwxqnw
        BuhqTM58MUxP+0eAUjWLPfotVJ7X7gtguQ==
X-Google-Smtp-Source: ABdhPJzTuOchPu08lm9/zRc1aul21LQKv0qaM/ScEwNVwAQ33HyHLp0bnMSV8I2IYAC+DgkN1cI9FQ==
X-Received: by 2002:adf:a35a:: with SMTP id d26mr31530615wrb.147.1622016649666;
        Wed, 26 May 2021 01:10:49 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id v11sm22628319wrs.9.2021.05.26.01.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:10:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 04/10] bus: fsl-mc: dprc: Fix a couple of misspelling and formatting issues
Date:   Wed, 26 May 2021 09:10:32 +0100
Message-Id: <20210526081038.544942-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526081038.544942-1-lee.jones@linaro.org>
References: <20210526081038.544942-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/dprc.c:345: warning: Function parameter or member 'attr' not described in 'dprc_get_attributes'
 drivers/bus/fsl-mc/dprc.c:521: warning: Function parameter or member 'obj_type' not described in 'dprc_get_obj_region'

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/bus/fsl-mc/dprc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 27b0a01bad9b0..d129338b8bc08 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -334,7 +334,7 @@ int dprc_clear_irq_status(struct fsl_mc_io *mc_io,
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPRC object
- * @attributes	Returned container attributes
+ * @attr:	Returned container attributes
  *
  * Return:     '0' on Success; Error code otherwise.
  */
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(dprc_set_obj_irq);
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPRC object
- * @obj_type;	Object type as returned in dprc_get_obj()
+ * @obj_type:	Object type as returned in dprc_get_obj()
  * @obj_id:	Unique object instance as returned in dprc_get_obj()
  * @region_index: The specific region to query
  * @region_desc:  Returns the requested region descriptor
-- 
2.31.1

