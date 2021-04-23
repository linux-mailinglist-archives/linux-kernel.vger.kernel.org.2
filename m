Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EEE369571
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbhDWPBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243326AbhDWPAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD6C061348
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h4so39665922wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwuVZ4DerzLqtKGB6gfK45URd5Glj/AwHPmshqzuvhg=;
        b=FuP3OWHVV1DneN7hb4YOknJaPgA9ztx3r+mAPwQCIxaRdzx3BEaS23NZIQj6Ux49Fx
         3gF6luN1Wm0GuNCdhnc/SQL0Kk8mJ3d3PCn3IDQnwKUvEbBQA0gVRenuPn1A5EVUSjN/
         ITy0JrDme6fE25DGW2QFNzhkSglFiWGcqEQV9gQzQrNqB+eoiUPWTu25G2r5gh7A8W/N
         3xWdeA199K2CJbBTG+4M6xreJfnHdZb7kiCQFJFA5sBWDqYfY4aAf+Dn+tN9kjoav6DM
         uKr6tbN1GgKOxEVzAYkaSA7Zt2bBHaxbkpEL6xohsyes0jRy3GpJr9mRMVLmD8sZ9yg4
         762Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwuVZ4DerzLqtKGB6gfK45URd5Glj/AwHPmshqzuvhg=;
        b=cJ+ccS87m9lKhyVKovHow1dahDOX+Ykn5G8tIK+GhB1o3AqCJwmoy9Bo9OXa6aoNB2
         +B3Sx2LgFeBsFXwb9uI097fl58WPtypFHAhoWEGnuRhX2fQlgd7ilvZdnosIimb97yV1
         t84XajxRZDToK5BSPGRS/F61C560ZRRqMI6ansEhERd2JfZNTCbhwRWZoagSmfyKpomO
         Q5717YU1Btln2R52eKPw2Io8LHexQaDiZhJqxuhD4YtluD8oHJVCCCNSdWGkh7F7hpNP
         P8sN2+98EP4oJpi7aQV30Aor5CxFHNRzu9VmPG506c16oSOyGPAZew2j/Oxjr3VcBYDq
         BM2g==
X-Gm-Message-State: AOAM531J4kVha8sdDCRfCjgLF45YQe5yyEhzebx1cvUbfuJWv9dn4/70
        o2zsJ6w2yrgGHSEy9cOKVsLA5nk2feA=
X-Google-Smtp-Source: ABdhPJw7m5Uk7QuZr6gJaIZZxkfeuoWmffpzdFt4MaAEMS0Q89CxWh//Jx3jXgUU/VP/GSYbK6Qd0w==
X-Received: by 2002:adf:f0cc:: with SMTP id x12mr5403580wro.16.1619189988138;
        Fri, 23 Apr 2021 07:59:48 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id l5sm8062466wmh.0.2021.04.23.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 40/49] staging: rtl8723bs: remove unused _module_mp_ def
Date:   Fri, 23 Apr 2021 16:58:31 +0200
Message-Id: <c090a96bade97cde0dbcae6aadfa46b21acecf36.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused _module_mp_ def.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 3e391a23ac8f..261317b07635 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_mp_			BIT(23)
 #define _module_hci_ops_os_c_			BIT(24)
 #define _module_rtl871x_ioctl_os_c		BIT(25)
 #define _module_rtl8712_cmd_c_		BIT(26)
-- 
2.20.1

