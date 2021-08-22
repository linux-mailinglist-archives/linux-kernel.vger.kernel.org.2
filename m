Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6583F3E18
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 08:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhHVGIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 02:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhHVGIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 02:08:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF7C061757
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 23:07:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c17so13521434pgc.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 23:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8xtan08Su1aPHkuXwbXQb4qxZDxvf0Qz0X3flwzJxU=;
        b=glTLbJ2Sj4cEiSfUev0riRc/uov5ePb3Ps1DkQXEkdZ7BFC2eaoMXOIqCSaMvc4D5m
         aeGo9Z8QFVBz1v/4W89yuiVMMqc+rrAZnwspKsiwxrjgDSDK2lAe7k3Sss+pMBftKYIa
         pz+Ev49XPauOM4Yo7gZkZeRYpXvVdkZSJIfqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8xtan08Su1aPHkuXwbXQb4qxZDxvf0Qz0X3flwzJxU=;
        b=euybo4Mdo0sbP+DHqCqW0vz0ZPNtc26fz+z7Dr8uhDQDy86fVO49WcQtTs69lQmn6Q
         s1NmhvLPFsZ3o76UoEOaZ4f5Pc6zXKVTfx32RNPVTX16HvvXYQO93qfL0zyMl9SWpFrT
         0z6fWoomJ3PRz/BufR/2+umyPa8/UB9iC+bSUspbWNSkq65kcxvgUx6HLICWz61PEEIQ
         mYPl8Dy5Lm9qGWrYW6QntscOJx3zA1v+/GCmKdswkN13BjEjEgk+MKLTP2f1l5nzH14Q
         ple1wXiv3neXw0x3yjxPuwVpU068BbKTcHw5CcwnI+Nrh2Vybw7eKvtnTXIhipuYIbtT
         sPGg==
X-Gm-Message-State: AOAM532Vz4eB0WaolUaafAETw5crlwhPss0gFrpSCCuAoDX2bp5BvPUB
        eKOMyLPAn822/o1BMxD3CluypA==
X-Google-Smtp-Source: ABdhPJwl0IV4B5B/h0qlM8PDt7ajy2UF47YRyW5udsODdhJEXLGCjKRdBd3cBwW8MKRIaxdrHD0vVw==
X-Received: by 2002:a62:1d0a:0:b0:3e2:7dd6:e4b0 with SMTP id d10-20020a621d0a000000b003e27dd6e4b0mr27511966pfd.27.1629612455373;
        Sat, 21 Aug 2021 23:07:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9sm11953817pfn.97.2021.08.21.23.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 23:07:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] stddef: Fix kerndoc for sizeof_field() and offsetofend()
Date:   Sat, 21 Aug 2021 23:07:30 -0700
Message-Id: <20210822060730.4092722-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; h=from:subject; bh=LSI9Ve3iPXm24/e6+dJ/Whm/+Dq6iMvpCYAHC2kT7As=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIemiw21LSBQACqZKJobE9QLuzQzYC1C0zIz8fHlJ j7xmpjuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSHpogAKCRCJcvTf3G3AJsEuD/ 9nAv6y7l5rXl2sYk4uF4Ov/U/QKP+wOj3BHK+n7i02qn0JCUqxf80SNlWsMsdTxWDSUe+ytP7lM0q/ 0hJLWDeWevdw1lbp6ueVf8RBUEcJJKfpsNKjFM9i0hlFo/dRh0of5t3v2IkLycPWs1kl/Hc4svUR6v 6A7DrQVT19u8LHWGE9Dm+a7ck+Jq8DfLeBD1M3ZELoUi7Azp7uVC4zekS4si3qPdkYerxG0rX+QcUn UR67m6+Jj/cxOZ+mOAd7g3lLvFj5iPiMMAgUyj37/y10k+tNfBeKdrrMgl6C/7NEoRJh/qbyxhF2/e ezLN9dwUz9umJx3rcAL3XFkQkk/PSjDEMVWM/AdBN52hdhiLAqBQUKwlM39R0NElwfYEdADSnz6Jim RU/ggWjdxKvOkoyIUjDVemFzlAURDbwWYqCew1sG6LcGfpMbauVwgwU1RMzA2vTHnt2V+biG+Cqo9O ZscMMfu4twsHuy9HIKxAiHP9tu7I8GJn5q0vldy1PR6TFfxxJaIgok4+oJ50Bw080XxBS+pZU5gz9v Y77l22xvuqCCtsnEHDm5eWYb1IhRR/tNdA1JtatDwjlS2Ew/++vug2RoLovBHALGpv4jvJ/MILU0+1 YZnInWkA+okHJAckUn5arm7SVVosyKlbKgUSQ1ncyIOtjjA7lymUUJWSlnXQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the comment styles so these are correctly identified as valid
kern-doc.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/stddef.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 998a4ba28eba..8553b33143d1 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -20,7 +20,7 @@ enum {
 #endif
 
 /**
- * sizeof_field(TYPE, MEMBER)
+ * sizeof_field() - Report the size of a struct field in bytes
  *
  * @TYPE: The structure containing the field of interest
  * @MEMBER: The field to return the size of
@@ -28,7 +28,7 @@ enum {
 #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 
 /**
- * offsetofend(TYPE, MEMBER)
+ * offsetofend() - Report the offset of a struct field within the struct
  *
  * @TYPE: The type of the structure
  * @MEMBER: The member within the structure to get the end offset of
-- 
2.30.2

