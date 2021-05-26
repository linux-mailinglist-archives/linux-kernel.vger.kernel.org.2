Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9555D3922D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhEZWgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhEZWgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:36:38 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:35:05 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so2559811oth.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RiTRNHS1ejuygpTt5xXgXCB+d0rqEUKIB0Nj1i+xQDY=;
        b=IsEjAVpJPCM9sAw6G1yIlOtxfdXTrw3mEXlgtLrpEO16mJ1mnI86/pKL+M2F3nMY3g
         PmbmlE5R7fCMARFpTVFmYXEZISShFHh93XtIlZrKwCAhQfpTbTgKIZdNnfe3fpIxTkIR
         dfQIeLEd6QUpWEd+81Q4N26SOr5GJqxKocK/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RiTRNHS1ejuygpTt5xXgXCB+d0rqEUKIB0Nj1i+xQDY=;
        b=UaRNQl0qZiBKjlcjQN2ZSp3M3N3SyjOJJh3nNwsS9nIdaSmldiAZyMtxMaCF+rYJca
         FELlsb3W/vJkS3OZq1WPzkV5PD8pSj3kw+fWLrtpS98lylML/KqVFZE/smyDo6Sb9VpF
         m0zsEJ2EP0UCkyHnrG97wjXZV0i4tjEScfy/4QkB2PBvpxOK8pQlbV7TUnkrveR4i5SW
         CSIwFmZJkgfHg9VtRPA6sebpvFHSUqe101KBUR9963Rv5nYyb6nc/JfZY69QffiugqGi
         NPg8zPcMYnvHOOmuXeyAOz7zHDFjC7ZLquvniqdlFp/VMFR8DeJpbUOQDhRrOSVvZhyI
         VepQ==
X-Gm-Message-State: AOAM532zvJOwk8U0rh3YCFkzEufLv3QOxF8p0jga4o/5ec5WEkKIVfCz
        nZoBFkflSRPOeqeI01lzZiFZdw==
X-Google-Smtp-Source: ABdhPJwCmyUAdh5K+OT1BNb62Luj9O/u2ZkZDzDbqrX7BpjoaY69yIVhnw4dYOuaGbi7xo/egfSr3w==
X-Received: by 2002:a05:6830:2093:: with SMTP id y19mr442231otq.128.1622068505101;
        Wed, 26 May 2021 15:35:05 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id v22sm116487oic.37.2021.05.26.15.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 15:35:04 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     axboe@kernel.dk, asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: [PATCH] io_uring: Remove CONFIG_EXPERT
Date:   Wed, 26 May 2021 17:34:45 -0500
Message-Id: <20210526223445.317749-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While IO_URING has been in fairly heavy development, it is hidden behind
CONFIG_EXPERT with a default of on.  It has been long enough now that I
think we should remove EXPERT and allow users and distros to decide how
they want this config option set without jumping through hoops.

Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1ea12c64e4c9..0decca696bf7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1621,7 +1621,7 @@ config AIO
 	  this option saves about 7k.

 config IO_URING
-	bool "Enable IO uring support" if EXPERT
+	bool "Enable IO uring support"
 	select IO_WQ
 	default y
 	help
-- 
2.31.1

