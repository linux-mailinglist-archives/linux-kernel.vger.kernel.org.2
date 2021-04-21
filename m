Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A033673B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbhDUTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbhDUTrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:47:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4EC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e7so33537410wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbsSVt7sDZG21p+Jtcnqvu0ncqhD0atmQImaH5s0bwk=;
        b=hXaSUZBKWs848qfeVqeV28s7ipAbNsGnYXpFqoWKSh0AnfRNyYL30Deb2TIxaQ8+Nw
         tzEq1y6VELyipK+ZTpYupeR2+lrbf5ECMqXiYmMTM2xkzXWunYg6QtMOsoI1RuM1INE0
         UAhmv+cWERrrCpP8mf6xAJVFjPIW6D1bUPMROipmAPIGQUc91IJbCxBjwdtvVDxXGZy1
         0iwxfI5yh2SDdpC852X1JzgmRqa9+sjhne1b9i4R+hsR6Sy07EN+opOjoQiNjuQaLxku
         zshAtna2LUOwHcf0Xwg4CoJJU5ZpIANS2v+idVRH3Ni6UlucvoMhP/Yq5K3boJOCb8q/
         QgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbsSVt7sDZG21p+Jtcnqvu0ncqhD0atmQImaH5s0bwk=;
        b=OFEmgo2QJIvgBWN2SRWpNj7PuHD3An66fGpJLDaasUFWQJGlXreBJKOXHVrfBLzDrn
         dBRypXLiAXQejhgTwP7gOSwLC1zmjPYDnMuU53emeBS6Au3r2CpTBOkwOy9zrT0mByyc
         OW7mX8IzScpkVy+bgAQqN9t3THk/QBGtvN/6+fGXbzPqsqLDmKvPpHvM64/2CW5Mcul/
         Pes7lP8E5/g3gPxMt3ySTEVZheffdfgxOWksv63xEgZaFrw42XzK+D4W8VpnxXK/5bB5
         7vrBO+KT6itubG5caUQ2algv+La5cmebeoqrM/XhpjEjorWxAwm3Jz++NSFGzSRFSdDh
         okxA==
X-Gm-Message-State: AOAM531FJW46m0pIs3QbTpk2S0NMXr619H51+XOHH1FYfTO+TQZHr4/r
        3pLxrbeWoHotS7VpWbiaMHMFL+FaJOSh1A==
X-Google-Smtp-Source: ABdhPJxP1aXh5dtJXaC5CzIhfHBRCWzADTDBq/drjfza2c9pNgFdMscavfFKqAewtHOEZ2qU6u0Kyg==
X-Received: by 2002:a5d:6d0a:: with SMTP id e10mr27714506wrq.161.1619034425291;
        Wed, 21 Apr 2021 12:47:05 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:6d3d:2d8b:5417:831c])
        by smtp.gmail.com with ESMTPSA id c6sm13004217wmr.0.2021.04.21.12.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:47:04 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 2/5] drm: drm_auth.c: Adjust end of block comment
Date:   Wed, 21 Apr 2021 20:46:55 +0100
Message-Id: <cd1e8f6637b914825ee4b9643a4e9d9eba49f276.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new line with */ on the last line of a block comment to follow the
Linux kernel coding conventions.
Problem found by checkpatch.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/gpu/drm/drm_auth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index f2d46b7ac6f9..f00e5abdbbf4 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -300,7 +300,8 @@ int drm_master_open(struct drm_file *file_priv)
 	int ret = 0;
 
 	/* if there is no current master make this fd it, but do not create
-	 * any master object for render clients */
+	 * any master object for render clients
+	 */
 	mutex_lock(&dev->master_mutex);
 	if (!dev->master)
 		ret = drm_new_set_master(dev, file_priv);
-- 
2.25.1

