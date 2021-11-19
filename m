Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1410456EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhKSM3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhKSM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:29:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E48AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:26:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so41966850edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWz0xXDI9+fzW5uta6xg7ju3GS8ia27/5sZwutU+H4U=;
        b=fFKrISg2tuaV5kmhhUJO/se/2mKUB5qioOVAJrNNrgbT4jJHQTWk/uTxpglJfPHZtN
         c47H45Zu1dPX1/vjDfiL9CJ3/Gu6aeRJAlwC8W/bAEQmE5OIOXOaBx92s+Kd/3C7weVS
         AanwHaZ9UiQ65bqE2asexRU2IEVPjUDvmOaEoZ4DzkCl8hBym3Y4FU5EJfXb73y+O22A
         m3Hynq2MMCu8KPqdqbhFYcNO3HxaRPzZMhSedVwzuXGXvOvcHKUwVs1Vs88Yo1OCyXX+
         IFLpLLhl72pQaO1KKt6htSIeq0sGWk8wscqmKmY0zB59vpMQblN3Udn+UF5G2DIhbJVb
         C2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWz0xXDI9+fzW5uta6xg7ju3GS8ia27/5sZwutU+H4U=;
        b=wpdVqBDBKw+f3W8ibHp4cpgo8DJu9DbAjlB0gNGBp6Zjp20Xdnk+JLe2pYA+0F59QI
         2+zBFAxj5BUSjyxkIHzMFTIU+FX05XBz5Usk5KCJ0tiZZJQheRax+3QeeI0aKo8zS71O
         LTjfbvgnVWF1mG4CIextrD0pbJ5tiVq57yEeEbzxrEgb05gcqY5pIgSJhg5vFPm8F0Nk
         1B2Yzk5ENbjhqqNGtHjXhbLUgJ8wtM1u4C6l6LMuUmpl2a1hFlsoMqMGBM0UfZ/B3YXE
         16Z+AJ29AebCkh5WqAtZvYok20UZvL5nf62kVLKFQ1TDmU2RHtKmPVE/goqild+zY9VO
         CP9w==
X-Gm-Message-State: AOAM530jhP+9twyqPBw6e75AyYnNwAIkq4gH7/V3LwtuGd0Ljz1tiVpY
        d5Q/ZEoSPgit/KMnXrG13Sw=
X-Google-Smtp-Source: ABdhPJwRG2DdRACvkK/1eHc9+WGbXJK6dG2M1L2GX5KpL7eEUoF+UrCSXrXaU7gc+XJq2aLEWzVupQ==
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr7453696ejc.75.1637324802611;
        Fri, 19 Nov 2021 04:26:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::79b5])
        by smtp.gmail.com with ESMTPSA id v10sm1374994edt.24.2021.11.19.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:26:42 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: remove more rf_type related dead code
Date:   Fri, 19 Nov 2021 13:26:33 +0100
Message-Id: <20211119122635.28435-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series removes some more rf_type related dead code.

Michael Straube (2):
  staging: r8188eu: remove rf_type from add_RATid()
  staging: r8188eu: remove rf_type from HT_caps_handler()

 drivers/staging/r8188eu/core/rtw_ap.c        |  7 +------
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 11 ++---------
 2 files changed, 3 insertions(+), 15 deletions(-)

-- 
2.33.1

