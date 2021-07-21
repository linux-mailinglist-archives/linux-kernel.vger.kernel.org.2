Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB8B3D0FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbhGUNAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhGUM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC3C0613DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bu12so3376459ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AQiL5ZkIL62kHnV4W3WVuoAjYbuzEncbnDSFsmO0kE=;
        b=Qq96oe50Klfxs2PwMji8or0xoeD3j3nEBXvlcrkiHBIJlyo0aiwnVa8JyEdkc/ddRH
         QuKkpYNXE+q8wpfAn65stNV9qTFubo/nz6sP8llH26quObI2QeCiW1bVIalgPunkuC8e
         fRm2JeofSnHCuLHjcM/2PHjTQo+Lq9kCT83uzX4Zqf9cTpbvVTATqfpchPbb2aOXbgK4
         7uZ3v42hlZ0AYgGqZxaIeRhXx27yQv6ET4Zu1AxlJ3ewebKaHRr8tjwGdPbukRZuVmet
         i5IO2ytV58VJGfq8WR/3CLJgM3UCMWJNl91soqDCKpm+HQbUga7w8RFx9DfALO6TCEi7
         z9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AQiL5ZkIL62kHnV4W3WVuoAjYbuzEncbnDSFsmO0kE=;
        b=XO1mbtnoImh6aBMET8Nc4xCKrovHCqxjUkBJtauhT3r6NzfWI+BjJ8dME35pca8XaQ
         a5pNnGU78VlhT648gdQNrA75AEbYHPj0Ix66XAb6oN5DVXygppucMZQU9ieWEY7CB0r5
         80pjCv1skvnQfM0zh/QhgxIwHbJ0a39lvVd1lT0dEbzre7EXShPsE6mNo6rut3dRjqpj
         tcnJ4NJSy/sgthyFsGXmQPs+iQFrGUK2qMSw/wJwWubH9uTKdaSvWqnnFlX4vR3en0qe
         u2FHl9KRwZTCXOFUlHRIB00y2QrOa6HgRX5rWL7RRBJn2Ef6jhYhKHyCakHlliTugc0n
         RTLw==
X-Gm-Message-State: AOAM532cPQgc2YGpewcK5USbr9rnbWlQuSPeri/qKiDowvqpJwoOmxt4
        o7Hu4wrOL4h43om4AGVvBXeJjBQIKM8=
X-Google-Smtp-Source: ABdhPJyRW7rpjdTPux/kZe5WHfclLwc3wEiSET/6hna+eVumWUg7NFkcjRyqEUhW0F8f/aQCasYqew==
X-Received: by 2002:a17:906:4b43:: with SMTP id j3mr25016430ejv.524.1626874654266;
        Wed, 21 Jul 2021 06:37:34 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id c17sm10676975edv.6.2021.07.21.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:34 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/16] staging: rtl8723bs: remove commented out condition
Date:   Wed, 21 Jul 2021 15:37:13 +0200
Message-Id: <83762719c0c13ac8b78612a32db26e691eef17d1.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out condition checking channel > 14.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 8af81c4ff8db..060cdd7b2925 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -159,7 +159,7 @@ static char *translate_scan(struct adapter *padapter,
 		start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN);
 	}
 
-	if (pnetwork->network.Configuration.DSConfig < 1 /*|| pnetwork->network.Configuration.DSConfig > 14*/)
+	if (pnetwork->network.Configuration.DSConfig < 1)
 		pnetwork->network.Configuration.DSConfig = 1;
 
 	 /* Add frequency/channel */
-- 
2.20.1

