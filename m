Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC37331A34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 23:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhCHWbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 17:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhCHWae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:30:34 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC888C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 14:30:33 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 2so18167044ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 14:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoLvoqCPKCkOsmIcg5MKSJ6KfR4gV0s8s1BqSsMK/PE=;
        b=daMTkMxExpOEyDR71hH3bgm71wkysgZF1gUWDs4oS5yLiTZ/SgUH0p9F9VO1etuK+t
         CcT3NH1o6zxHROADi/kPoX80BwyN/cUZf67nV6XlxgbM1uL0rBdhdHHt1wykDGWvBJGi
         GEHJu2CrvF2GcAFPZNsEmxuHoliQ/C+yDF/39SCnb+lt86punjGBxOfiVQdfSVKu/iU1
         atR/FKBDJ42ebSD+DafVi2SrbIfJgD2p2RWDjSjtfoXfjNphnJy3MJcYJdvFYmXA77Oc
         GyuvpLLWEZIrJRuAe3c07Pxzztq0HZghrBvweNaiY3M9K1Bl0dXmxa4RJo1ClL5xsRrJ
         7lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoLvoqCPKCkOsmIcg5MKSJ6KfR4gV0s8s1BqSsMK/PE=;
        b=jSAzEDnwjhBIUCzTby1eFodzRBp2EaK+aasu432Mb+jHPKPZOAzHpU8mTnPz6o/oQA
         CS3B2TGNVU5vB7HdV/jBgFrO9LCwE+3ixa1teQ4p0PjVwiAPYJXsir1ENjrZdbN+tNSP
         RU7zqo9wlWY8DpdR98ZjQ7Ch16035SulL0w+YLPCSQiBf/i4C00A7Ad135jaaZE7/lto
         D46k187T8j6O/umcxNYXRtOdueRv+FB2i4RLzO2Eq4hc8a3iOqucM4upM2bzLepa5mKM
         wMhP1gjASPEBXK8U08XqOKj/Eh/4xO230hCRWIZxf9eEXMSDbXmu8FTZtEoF3ac5dOsb
         dxgw==
X-Gm-Message-State: AOAM5314azgNbsoJAkxFY85eGxH93a0SkP/LWC9ShD2tETFAPSMcp1C3
        nzM66mfXp6jGNszhFWkbS0E=
X-Google-Smtp-Source: ABdhPJwRpxdqXdwbqZtWvsCHEeA5CN5U4vXKh3BSiYs9hryGoNTmpcO9cz0CDXI7OxvZmobC4pCTtg==
X-Received: by 2002:a2e:8895:: with SMTP id k21mr15112594lji.510.1615242632284;
        Mon, 08 Mar 2021 14:30:32 -0800 (PST)
Received: from localhost.localdomain ([94.103.235.167])
        by smtp.gmail.com with ESMTPSA id u10sm1501707lfl.111.2021.03.08.14.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:30:31 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kai.heng.feng@canonical.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH next 0/2] fixes for sound: usb:
Date:   Tue,  9 Mar 2021 01:29:26 +0300
Message-Id: <cover.1615242183.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series fixes 2 errors from commit 9799110825db
("ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()").
One of them was reported by syzbot, but second one appeared while testing fixes for the first one.

Pavel Skripkin (2):
  sound: usb: fix NULL ptr dereference in usb_audio_probe
  sound: usb: fix use after free in usb_audio_disconnect

 sound/usb/card.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1

