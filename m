Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425C541E775
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 08:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352147AbhJAG0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 02:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhJAG0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 02:26:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2109CC061773
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 23:25:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u18so13720142wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ox0kcF+wR7alSGypm9vvkslmozP56AiJpgAmEJ1vubM=;
        b=lpLDwU+vDA4Z8xsLLM2rXgfAgHfC58jR5b/nUATZYSond+Y/X4WIvAEPoR+SuekoGo
         iRs7/fODp89EdFjECkmzQOu9Dy8gpLH432ocd4fzPWRvbqNI+qVmkchRJICFf+zj/XNs
         JyoJEklHai4Tjt2S5X5pGVpPpcd6bpvVrUazN0tF4j7Laoz0HeIGfG4yoPlewqWHJaeI
         jeFurF/Mub29N5+u7Ch47O1Sh/U5YDWQAyHOXGgqhHHrHe3sagsORQyUB3bALMm9aI8c
         BNuBc+S3oSmm1iLQx4dvGFNHvudbIbi7wrFobmHfTW3nKcCZN2dLG4Bj62NY8QRKH8z4
         OaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ox0kcF+wR7alSGypm9vvkslmozP56AiJpgAmEJ1vubM=;
        b=zC3U3Gj/X6OC4ZqGR1dQFlmcxymtEkLkcl4VdAKzm19In5wIDz2N4sAcXF7evTPgwp
         RPcAsU+UGyR8aItLoQxkgpjMz+2c1zfij0wB4Y1KKn5ishXhe16tODYRROsQF2vHBdwN
         LxCffGF8KcyrfFGgdn6BgPd38epSRJDguNAplUJXGwEyk0+v+4ZkB8c2xZTERmgBma+N
         LiC0tevgo2syOjCYr3xX7BlLGLNc0EI3Lx8VRZ3B9MkEYqzucIhxL/QfiqxibI1f6JR5
         PIKP/uTW8tb9T30bMIMeKvemoF+vAgSGPgrYpT28T2UOfewlA9J0H9Ei5pyWjlPVYYmt
         872g==
X-Gm-Message-State: AOAM532lcNyV5rhlw+02bjMDeGwIQVYL2jpass6Ag9WRzTknRpzzKrqS
        7jjbxl5oZN7+mkfdz4SUHa4=
X-Google-Smtp-Source: ABdhPJyTgIKUdfjL8rfoWlpW1rP4l+OxKv4EVTvDQ2svg6XO09fT+f80UBF5qiDAr2lkZnm+5BRFFw==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr10260591wrr.0.1633069498632;
        Thu, 30 Sep 2021 23:24:58 -0700 (PDT)
Received: from localhost.localdomain ([197.49.49.194])
        by smtp.googlemail.com with ESMTPSA id 15sm6714135wmk.48.2021.09.30.23.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 23:24:58 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/9p: cleanup: opening brace at the beginning of the next line
Date:   Fri,  1 Oct 2021 08:24:54 +0200
Message-Id: <20211001062454.99205-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error found by checkpatch.pl

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 fs/9p/v9fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index cdb99507ef33..694687effdfe 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -519,7 +519,8 @@ void v9fs_session_close(struct v9fs_session_info *v9ses)
  * mark transport as disconnected and cancel all pending requests.
  */
 
-void v9fs_session_cancel(struct v9fs_session_info *v9ses) {
+void v9fs_session_cancel(struct v9fs_session_info *v9ses)
+{
 	p9_debug(P9_DEBUG_ERROR, "cancel session %p\n", v9ses);
 	p9_client_disconnect(v9ses->clnt);
 }
-- 
2.25.1

