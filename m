Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8247D34C2D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhC2FQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2FPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:15:38 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0952AC061574;
        Sun, 28 Mar 2021 22:15:38 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id j7so8547198qtx.5;
        Sun, 28 Mar 2021 22:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qum4IYVDaQdVr2baOxkdvQBmfIMWs71T6sBotGIbjc=;
        b=Catg9+A/pcRgXs2HE5U3odCZqK3rzXpfJcNw9ElomcPL1HOMJOYbp9YKBfMizQBdiR
         YgpusfRu6xIOhftIELcdPPMhdyxRgPuZ/L3Izc0WC1pJimk4YTRt4uCSauL1KCx32ijk
         Pn7PdxOaiYTHnJKdFI391e9JSPB5UDu5BQbObykB7L88KG9C+rCsOPWVSutxalCyaOFu
         0QSKx6K+WbTCyKs0PlR2135luENmsdWokmI798UVvnD/dPPqUsl5/lCFq5FiDZV7NDdi
         gCpNL6v9+2gMFXl+SnVqo8X9jPCdmUBRsXnkw8jAn7hajkuYcO9O7CmM/IX0YwpvGIll
         aN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qum4IYVDaQdVr2baOxkdvQBmfIMWs71T6sBotGIbjc=;
        b=QHFlT9lK5mR1C6OldQjVWns73SZAVasjFYi05fP1Imt8PDIgP+323PbR/90lqLbSxX
         MxLckoD/LL7FjpBrjef9wwyyvsd0GrbdQQ4ajSgrIHhHLq2dGCVrNhIrU1H6w6TeLTid
         L6aEHkgpf4sK9ggJ1xGrfTs9xVdsLweCpLeRg9WAWNkre0muEaxjSyiSDRAL+2ht8QHc
         sgKxbSCqYYgLm3ZLg5nqu1tErUmXIOdIurDL6fZe8WPL4NuxEaZWl9oWnPAq44AfIJ+P
         X9nRp0lY35scjODsoZVvpcfmqmMpz0waDuDKo8u4qLafQJBp1Jyl4QnXgjRY0ghgx7DX
         QJZA==
X-Gm-Message-State: AOAM532jZjhd8dzPyNIChD6pDpAqGzqzh99USPDVwS+xIVGe/xb+hczq
        tSJrtBLn9XbHxGL+pY5kSyk=
X-Google-Smtp-Source: ABdhPJwFXG4T0LhRsQ3ki+1RrhIZ0Pjcgjy/URgl2OC0HZC3Ns8rTnMVLLMWJWb3rjJbBH8gwFykUg==
X-Received: by 2002:ac8:6a04:: with SMTP id t4mr21775660qtr.258.1616994937354;
        Sun, 28 Mar 2021 22:15:37 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:15:36 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/23] w1-generic.rst: A typo fix
Date:   Mon, 29 Mar 2021 10:42:40 +0530
Message-Id: <fe13b9b018501549e5b457ab936255291e0530f2.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/beetwen/between/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/w1/w1-generic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/w1/w1-generic.rst b/Documentation/w1/w1-generic.rst
index da4e8b4e9b01..229b16b6399b 100644
--- a/Documentation/w1/w1-generic.rst
+++ b/Documentation/w1/w1-generic.rst
@@ -101,7 +101,7 @@ w1_master_search          (rw) the number of searches left to do,
 w1_master_slave_count     (ro) the number of slaves found
 w1_master_slaves          (ro) the names of the slaves, one per line
 w1_master_timeout         (ro) the delay in seconds between searches
-w1_master_timeout_us      (ro) the delay in microseconds beetwen searches
+w1_master_timeout_us      (ro) the delay in microseconds between searches
 ========================= =====================================================

 If you have a w1 bus that never changes (you don't add or remove devices),
--
2.26.3

