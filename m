Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF545B266
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 04:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhKXDHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 22:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhKXDHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:07:48 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:04:39 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id d2so1294297qki.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3UKjW7fmUe9JRzmjdiiBs6fkzP9ZvlZsvWeHL4ExR0=;
        b=BBddd5ZUGiBGsnJmx7bTL7Ov17NuqWLJ7XumhtNZtHWj90Eo9myNX757frsBUn49pi
         CG1hcOFC2xKZ9U1FSPDhqUajYJezCfSi7Zkbb7xEJStZYAD3J+QISUHdYkeP4G3z3Lh0
         imEtCAnQGzNbxrA1iy5netuKQ4/F47gwGLjI+uggEsMUR0IQ8EwSZQH9PGfPmdq0N/CU
         eYOihzo7MyaFhCtDCHw5dcBBBcUc3uI2A27iNFvyrBE34aV4v4HAIm1YBOPxcS/Pq6ge
         L1ncErC64CNx+oSGSuc/2RnvdWj06cCVMRvjvnq60LRWOKygWaxk4B/Fet4bLzdbtioI
         oqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3UKjW7fmUe9JRzmjdiiBs6fkzP9ZvlZsvWeHL4ExR0=;
        b=uEL5sR3tYuln7+OmZ3DDsJvyk95kUSHVJonwBJzImIlnZU0BCyVcJIBnZXyksKmjzM
         AJcP0m3fJdJssf1A+vvmMMl+5bcx3tSkLdWL6wMMxuqR99vyl6YWao3NvC2I2rp94Mix
         wIVNHxxw7frCGdT3PND4fOl0/3pbqsQLtblAJ2yv6VlUQ4HNTLlogczn0grlj5fuIqL8
         mYtQK3KNze64/KFOFsE3LoRPBSsIxewyX1/Zyh2dmAODPrq9mfAUfLWT9FO9bRi5NVKW
         cQH/XnaI6FyCJLNL7Rw9PEzHBLNbX/FZd7rXHCK0gnAGvfEqE0NeYxjU5wds/XbIJf2p
         IbuA==
X-Gm-Message-State: AOAM533Db56yxCrJF2jr9gFGNUpKcjD8w7JjeC8qXtNk+hBkbG1HoKyu
        p+UwBwQAnw/nJfBKDj0sR3YdXv3PSDc=
X-Google-Smtp-Source: ABdhPJzMa9PpQpZk9WGjY47S9dF0nk8A++HjGijauQYx1EqOq/o2FrQ5Ema1QEDpfwkZ7iqimV/fcw==
X-Received: by 2002:a05:620a:288b:: with SMTP id j11mr2315125qkp.257.1637723077907;
        Tue, 23 Nov 2021 19:04:37 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i23sm6973927qkl.101.2021.11.23.19.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 19:04:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     sunpeng.li@amd.com
Cc:     harry.wentland@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        jun.lei@amd.com, wayne.lin@amd.com, lv.ruyi@zte.com.cn,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amd/display: fix application of sizeof to pointer
Date:   Wed, 24 Nov 2021 03:04:26 +0000
Message-Id: <20211124030426.34830-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Both of split and merge are pointers, not arrays.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
index ece34b0b8a46..91810aaee5a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
@@ -1223,8 +1223,8 @@ static void dml_full_validate_bw_helper(struct dc *dc,
 		*pipe_cnt = dml_populate_dml_pipes_from_context(dc, context, pipes, false);
 		*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
 		if (*vlevel < context->bw_ctx.dml.soc.num_states) {
-			memset(split, 0, sizeof(split));
-			memset(merge, 0, sizeof(merge));
+			memset(split, 0, MAX_PIPES * sizeof(*split));
+			memset(merge, 0, MAX_PIPES * sizeof(*merge));
 			*vlevel = dml_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
 		}
 
-- 
2.25.1

