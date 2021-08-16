Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9765F3EDC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhHPRgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbhHPRgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:36:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B50BC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:35:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a5so21515609plh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TChWHj0hKTEFv1sp24LirftPFIQvL4OhiwdiV2nww84=;
        b=Ox891SvXPSjB6iyl3u/eb2rxw/mfCiksEDBVmY2HJs0vUen49+0J2WZHcDQmqSW8/7
         aQwYI2Z3QNk5CfNKdFJjxE2X/yCQlx8EvI6AvMvoThxaCvjzxxTOrMorWUFnrf5yQyca
         b8zSAL/C108L+OOyU2xDHYAEBKfNwB9BgZlGPZY0QtX+YuU86UQME7cpc8ID4q819qNl
         dWotEpaznnJMcrChvJwlobCFXIpegVedMfFHAImeWYeCEFahRLz8APkhtpHDS3CE98Zv
         UBW9Ov0yfDgTUZgpuZ2Flxs77L5rID8+Np7PwLOKWgWBy3l8YZvfO3CMFbzp8NMK3RJo
         t4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TChWHj0hKTEFv1sp24LirftPFIQvL4OhiwdiV2nww84=;
        b=f4yjfDfolFvNMoOV8nWX3vQ9eUt6EPD2RiVuezyS3xvosYb9VTAKcr3kxz35yEFPrY
         rtOZ8kBWZyJqNQW+OMml/HCsqxbKJqWXcmAOkiTJzq+K25NPdUGDpTLGvapHaN5S2KoL
         C90+lI5B7uHwAHzviOV0m5QPMNPGECt+PVugTAa13mTjCPpxtGun0/BSR1WHTE+U6ra1
         e9AWIZqeOnGBMeThByTHncEt8dVnX47ah7KuO1FDnUcPRyfJZJUoZD6CNsrW5L/04BgH
         yx7/KahL2SkxKGx7D3fIFJPZLfF9LJETVkSTZIPC2BR2sj4A90cAddpHs6jeX2d6VObZ
         dr5w==
X-Gm-Message-State: AOAM531hnxJNSS6y0XhSwvfLuVlcLiwEByNWxxhmcKFwPnbmeDrRXl6d
        yOuqOsFV1bbeOk5rxrOSkAU=
X-Google-Smtp-Source: ABdhPJze7pyGEk4RS1YqLThrWdNpEGkVdlIyleFItKyHjC+DXRCmlMF+t5J8Aeaj/VavbxcG+BMiww==
X-Received: by 2002:a62:ea06:0:b0:3e1:62a6:95b8 with SMTP id t6-20020a62ea06000000b003e162a695b8mr11625262pfh.70.1629135330994;
        Mon, 16 Aug 2021 10:35:30 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id u10sm14030pgj.48.2021.08.16.10.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:35:30 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8732bs: Fix sparse warnings
Date:   Mon, 16 Aug 2021 23:05:05 +0530
Message-Id: <cover.1629135143.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the below sparse warnings

rtw_security.c:72:50: warning: incorrect type in assignment (different base types)
rtw_security.c:72:50:    expected restricted __le32 [usertype]
rtw_security.c:72:50:    got unsigned int
rtw_security.c:80:50: warning: incorrect type in assignment (different base types)
rtw_security.c:80:50:    expected restricted __le32 [usertype]
rtw_security.c:80:50:    got unsigned int
rtw_security.c:124:33: warning: cast to restricted __le32
rtw_security.c:509:58: warning: incorrect type in assignment (different base types)
rtw_security.c:509:58:    expected restricted __le32 [usertype]
rtw_security.c:509:58:    got unsigned int
rtw_security.c:517:58: warning: incorrect type in assignment (different base types)
rtw_security.c:517:58:    expected restricted __le32 [usertype]
rtw_security.c:517:58:    got unsigned int
rtw_security.c:621:41: warning: cast to restricted __le32

This can be applied cleanly on next-20210816, and is compile tested.

Please ignore the duplicate of this patchset, I did not CC staging.
Message ID: <cover.1629134725.git.aakashhemadri123@gmail.com>

Aakash Hemadri (2):
  staging: rtl8732bs: incorrect type in assignment
  staging: rtl8723bs: cast to restricted __le32

 drivers/staging/rtl8723bs/core/rtw_security.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.32.0

