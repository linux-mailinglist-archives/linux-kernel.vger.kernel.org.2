Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B593FA200
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 02:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhH1ADZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 20:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhH1ADY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 20:03:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71A7C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 17:02:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h13so12846634wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/F6truudQkrd6D0yWmDRMgUxpMmDNonPusTihynd4Jg=;
        b=aP4rAV3OQGFz4akh4Cx+FUeaDVTA6Pns1s522jZk/bz5hdm73Br6VyaS9f/wTuYAUC
         uIvQCBBzEDF+1Wx2JeXDEYtQkumJZpAIGQlCMEdYh0263cAbtNbgTRQMjCzlTzcIXxx/
         O16zxfebDfux9dok3F7tcv1o1SbxiUHeETJPp6hV0ijdwXSz8Bw+/zq4VboWtOyd7k5c
         tYM9hzeSsTW7nXY29VTituBUgwv2F+2sRiiYha/otCg6U0914Ou1poNyD4NCZVioBQSe
         vxsC7Nje26KSvHrDW9Hf/Nu5qg+9wJOhUIONbte4MUa/gcYvIMOon8uX7BIaxc01EXq0
         cJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/F6truudQkrd6D0yWmDRMgUxpMmDNonPusTihynd4Jg=;
        b=U97H9dBdxbvniIzZlBOyBd3TKVBiTjs9fAZ+fyx8Xk9w6D2gBeeyQewCp/MeUNPMlt
         iln47DzTDivztyxo4XfSBYpU2EY+FnAlqku9VUG3DuPLMDcI2XEmCHfXjWuezgdi96xh
         vf5geVBoIkRWVAquQle5/v30F/2kSe06XD6R8TlBiDBmGedyl6G1XICsvB2EwCCrMxzR
         b9QT/+BjXpAGTtIjH6WC7u5l6ZH5zgCf7kpZn7qJuvGG54KqVr7Er2Phw8TCtPvUKC4s
         mEvjlwhAk394XbLjHlE5vCw3QRyvtuL+IVQoq6XUduM56+7eBrPhc2brFggiKVci1vbv
         iRUQ==
X-Gm-Message-State: AOAM531tfz278/WewRKDEhkj7F9uVZMW375hKJ18vfHaA85T1LfC+s2B
        QH2jtA0MZAt77l2KBWq6o/luFw==
X-Google-Smtp-Source: ABdhPJxRQlGRFsLYO4cEKlBl+QZhbr6u/rPLki7bE+YygdzqH7FnIVWKqgWdlRq6ntkiZzJE5HjFWQ==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr12964869wrp.381.1630108953617;
        Fri, 27 Aug 2021 17:02:33 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id h6sm7059657wmq.5.2021.08.27.17.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 17:02:32 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        fabioaiuto83@gmail.com, fmdefrancesco@gmail.com
Subject: [PATCH] staging: r8188eu: add extra TODO entries
Date:   Sat, 28 Aug 2021 01:02:31 +0100
Message-Id: <20210828000231.1458-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for CFG80211 to reflect that it is currently being worked on
and is a desirable feature to have for this driver. Leave entries for
LIB80211 and MAC80211 in case anyone else wishes to work on them - they
can always be removed later, but MAC80211 in particular would certainly
be good to aim for. Also, include an entry for improving error handling,
as this is another goal of the cleanup effort.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/TODO | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/r8188eu/TODO b/drivers/staging/r8188eu/TODO
index 98f918480990..ab9d5d145b3b 100644
--- a/drivers/staging/r8188eu/TODO
+++ b/drivers/staging/r8188eu/TODO
@@ -11,3 +11,6 @@ To-do list:
   the driver.
 * Switch to use LIB80211.
 * Switch to use MAC80211.
+* Switch to use CFG80211.
+* Improve the error handling of various functions, particularly those that use
+  existing kernel APIs.
-- 
2.31.1

