Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A40452B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 08:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhKPHMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 02:12:32 -0500
Received: from mx.ucr.edu ([138.23.62.67]:53029 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhKPHL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1637046512; x=1668582512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VO2ps4lqNewVdq22Zvj/a2S0OmORg6rzuJt+A60klUs=;
  b=QjmujV4iYHjgfnqXQvB9Bbn1P4tq8w8guvv4c7Wj4M28U/xu3tcP+M1C
   4QfRhuFQZhYlRJdnM/tqxLRxLnE/Lq9QaeGzuEiPnRk0CxoX9R7jbe75+
   jelyRKqT0ZTlrEEB1aV0B46JRR4ham3GbMhlIOXsg70ViIslsVu01O7bp
   pgL3IdgnD7Kti32LkMQm0qMgUmdgUvBzOLs2+yoOorBAHE0f4zMH8kZ1D
   SlRSrh5yUNCxHnark7qn8QKlO9qsvdu2xdhy3Zqrf26f7Tbtw7J6vNtFL
   48h6OmmOqHZ9NLo9os/JqYqErW9OBDRx/OCDUw2nnaf02LaJkCVTm1rg7
   g==;
IronPort-SDR: Wf0Rg9IJBo32/OnWY7S3QskN7UsoixtfI0Ag4RJ5sDq/ej3Y2iClB3tnytkyDRiQ020OlgGXEl
 yeVUz+AVYEvkJyHMGngmOw8rCJl/T1w8MSgUzfRDP42FC45u6rcAfDknKerCGaSUXg1RI24FUe
 usMOFoxw61zOuvPFcqEfAgDr9ivcdeG7HnMin78ish9g6sggSmhg2E4T+MGmy/e/BvGXxl3Gd6
 D0eJRLRpg3tiDA8kUjpmlTvye7RCy94gG4gqmqrurgnAaPjEbeLaQRt7hSgIHJOijdi37TKzL6
 XDlh9Yw1ngiHRlZGjy/qn6Z8
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="255153820"
Received: from mail-qk1-f200.google.com ([209.85.222.200])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2021 23:08:26 -0800
Received: by mail-qk1-f200.google.com with SMTP id bi22-20020a05620a319600b00468606d7e7fso4488546qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3HI54mJH/tMRV5CdW0GGK2Uj3sS8rXd01TKP0agSfQ=;
        b=GTwP4sC0lF0Nu4knrINh27vw5wfFRisKOITj8cPSjtfYQq9hjSO2crPj3dJH52NAxD
         Xsk5ANQ7ZKFYCveEzMIh7H+vrcaWGRxnLLueKLPqdXLSgAN66gYOwmPW+LSjmlDv5ehZ
         hv3TXuUyxOaqP1EhLfwrnsl6VhgzuNAC73d7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3HI54mJH/tMRV5CdW0GGK2Uj3sS8rXd01TKP0agSfQ=;
        b=E0jxpC1QL22avhwkMIHzaLXxh3wojDhGEstanp6Zd+akXYiqUdcfptDyhHIxrsUUyt
         ZiL2xiGSODhJDrTA/0Wjew84JKeT809jnM32gEWOeqGS9TstVlUJmqjwHbAlecfkcANd
         0EpMN2Uv7KaEsBCI5WsJWsNITgat5DZMRdAOrq8Gnl9egGh1j8MaZyEG/zbVRReIK3PJ
         NHFp05rhdlByuIaojqvZsDaI1aPVfP4ImBXd91oIjFZLYoyHcNu3ai0xvAX2fcdzUT95
         PgFzDh7jRpURBkFJqMSpLMP1NRf2ODz7Do5utV2wRoZK3a2D4Y7zyIZ2oZ+8PmDt2bfY
         Zh6Q==
X-Gm-Message-State: AOAM532GDhEBAh+qCr7Py1Yim2nllBEJ6lLWCUrCe8lNR5Po6DiytKbF
        r39pjSXiBilIV9EK1PaUAEFOq/kD6vOXJJOLHFhXyacLMqxg/YqCLECxtyx3EEMHDcOdBQH/ZP9
        /ebH299ggQwp4DjPYRKNe3Pwtdw==
X-Received: by 2002:a37:b5c4:: with SMTP id e187mr4262983qkf.27.1637046505204;
        Mon, 15 Nov 2021 23:08:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzb3aSuqiN7aOqI9nXkfty0FhMxgFyD4ABCEt+11IBb/1fmKrOrRX6A5Su3hDTXUShP/OaowA==
X-Received: by 2002:a37:b5c4:: with SMTP id e187mr4262967qkf.27.1637046505050;
        Mon, 15 Nov 2021 23:08:25 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id w10sm7205942qtj.37.2021.11.15.23.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 23:08:24 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] In function nvkm_ioctl_map(), the variable "type" could be uninitialized if "nvkm_object_map()" returns error code, however, it does not check the return value and directly use the "type" in the if statement, which is potentially unsafe.
Date:   Mon, 15 Nov 2021 23:07:05 -0800
Message-Id: <20211116070708.429432-2-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116070708.429432-1-yzhai003@ucr.edu>
References: <20211116070708.429432-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:01326050391ce("drm/nouveau/core/object: allow arguments to
be passed to map function")
Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
index 735cb6816f10..4264d9d79783 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
@@ -266,6 +266,8 @@ nvkm_ioctl_map(struct nvkm_client *client,
 		ret = nvkm_object_map(object, data, size, &type,
 				      &args->v0.handle,
 				      &args->v0.length);
+		if (ret)
+			return ret;
 		if (type == NVKM_OBJECT_MAP_IO)
 			args->v0.type = NVIF_IOCTL_MAP_V0_IO;
 		else
-- 
2.25.1

