Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7338332BE9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385984AbhCCRdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbhCCNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:50:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199AAC0698CA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u14so23750862wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3xPEHi6egTkwvWXcCWYIyS0K3zaWAAbSzwMQ/qKgYI=;
        b=JBhtQCRKcqLPe0dwAMaSPsbnFi0wbQuCUn4xQf9Xb3MLfWa9Gekp03nTcRSi+Ab/+4
         umFVmud0hLFrAqQlcj4BHxjvAb3WDfGHHr1ph2IViuFyrvlOe+0HHy5cZwlNjNsj2JWe
         CumSKeKBGrNyEpwGgKRtM7bifqHTKUspukU9gInkM1LspVA3xD+Lx2uGtaxgDfWc4vpP
         EkU9TQh2OqP0bvOkrAHO7jZhcjYEjJSyAGjKdhoX6ntx7DEdSqBMxl+/gBGPpXmJpyTD
         iXAR5/KdBwxlVrToW2OsLt2/arAH1yDev4SJGJd+7v0Zp8zIvVvzKlMpsKI0knh7wvK5
         ww1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3xPEHi6egTkwvWXcCWYIyS0K3zaWAAbSzwMQ/qKgYI=;
        b=c62bpi5Pgtp/8KC+K1Mjy7BSTA61uuU7gLudbQNQFcLuZyP1f5HXDCiNBGc9hU+QNy
         7i9jhIUIfTc7FSQjn3UJnw5azNUnKbdRnEMmFmiu7s3NGkN47NN1cEXifjrIW8HiwqM9
         waQ4GmCmq74tI+PmnHfIWkhj4wx6Ruh/1KWoYt+uO9xP5MSerEe/fVnQ99F0EfpeYGIO
         J3Ic+EdZ8rcGdcO/+tq2ibYZTjG+5muJpCty27yaCzMCzZQV0+YHsWbcsPhq8p7/RpaJ
         TaWOjvx6tX6L3krsnicsyc6nctfBa6K0dg68ln9HxrjPU0Fax/8y/UiJYSZ0v9n1fPMI
         Qx8w==
X-Gm-Message-State: AOAM532man2LvlsqOQRZL7NWoPmhDojK8btCTYrdbQ8d/XjjiMSXgjOs
        zUA4zoYmdIlIjjjJI/mZb9dnww==
X-Google-Smtp-Source: ABdhPJxDyaHvKTYB+FuVTEoLeXNmHOSn2maq6TRxgw6HeBYfJpgKfvcihdXAfSMYdVDQlfT/xV4TLA==
X-Received: by 2002:a5d:528f:: with SMTP id c15mr27394416wrv.142.1614779064899;
        Wed, 03 Mar 2021 05:44:24 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 48/53] drm/vmwgfx/vmwgfx_msg: Fix misspelling of 'msg'
Date:   Wed,  3 Mar 2021 13:43:14 +0000
Message-Id: <20210303134319.3160762-49-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:261: warning: Function parameter or member 'msg' not described in 'vmw_send_msg'
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:261: warning: Excess function parameter 'logmsg' description in 'vmw_send_msg'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181601.3432599-6-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 15b5bde693242..609269625468d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -253,7 +253,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
  * vmw_send_msg: Sends a message to the host
  *
  * @channel: RPC channel
- * @logmsg: NULL terminated string
+ * @msg: NULL terminated string
  *
  * Returns: 0 on success
  */
-- 
2.27.0

