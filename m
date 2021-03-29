Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE56734C2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC2FQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhC2FPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:15:33 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ADBC061756;
        Sun, 28 Mar 2021 22:15:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id j17so5883158qvo.13;
        Sun, 28 Mar 2021 22:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LEajfzfDvno2WVWCLLSqPqu5g6n7EFFfEdOdIi3ufs=;
        b=LnnZnWLsqP+NMAm/odrDaTRW1ARytn5i5Emr0I72hOvYUVrlr6iEW/Z0oecl+nKwtq
         8oh3rVfAuaxAUEM1ws7zYGdYX1EJSPcud1+YEuURv7MKDcqSvL9fcGb3j5HHLnBwH1Tz
         wcR+Gi12TmdEDjlwCjb9GnbpU8e/vMTHZKx4sAxgUmyAs4LeCRllaU4aepzv/x70DW6V
         kGEQLp3/ufoetAq5LmA5Ntn4hAvunRz1qeHFi4dTPiygtuUYJdvvCMyppGQh3NyTFCLS
         7csp7MrCZZwnLoDs44vD5HRNHjWlkB9+mPa4fK7x6vOUO07UNG/RS69FChm8j8XO6ftj
         wZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LEajfzfDvno2WVWCLLSqPqu5g6n7EFFfEdOdIi3ufs=;
        b=WV8Hi3tr4fPEx5YsNskxXoYNNNJZSuEp8ChoUw5yLJFtgqA3M1KSrOA3cbUYmdJQHU
         3PIhG842UwKBzeuWxwK567T0XiCNuWHbVrePKq8zpEk+S5vE7t+fRmLEN9qFtNj6oKB4
         1tX+nOLxcDhgiwwoeO02dMGV3T1Y4Lzs1SoFyL87JIG74RceZnPqGq74tvX3IhdQ/HlE
         glMtMNPQ/JSvyGLkocL3aUki0vL3jer4x4byJ73h+Y1AAy7/q+gT23bfHlb0NTN26w2b
         OxuNNGsNjmgFHkeTUWurBfEX/GmL+u6bDemlIEAnBJ5uRChmMy98wOjfBDUbjuSbCCdh
         2w0g==
X-Gm-Message-State: AOAM533nijyfiWaTMwMOoPh28Qq93qxLzcKmY1XCWUpGPjGGkAyuHNng
        Ngfl0dFb7CwKJJXVIzTx9A0=
X-Google-Smtp-Source: ABdhPJwQPYgj+hAUA/YpYZq81t8h7qHPp9wSW45CrbesrRnKYyw+OV0+VH6deJVgFDetXaBUI3gWYw==
X-Received: by 2002:a0c:b294:: with SMTP id r20mr23259370qve.16.1616994927052;
        Sun, 28 Mar 2021 22:15:27 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:15:26 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/23] atomctl.rst: A typo fix
Date:   Mon, 29 Mar 2021 10:42:37 +0530
Message-Id: <b103bd6a8bcdad7f90806dbe7680017235cf1d9c.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/controlers/controllers/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/xtensa/atomctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/xtensa/atomctl.rst b/Documentation/xtensa/atomctl.rst
index 1ecbd0ba9a2e..a0efab2abe8f 100644
--- a/Documentation/xtensa/atomctl.rst
+++ b/Documentation/xtensa/atomctl.rst
@@ -23,7 +23,7 @@ doing a Cached (WB) transaction and use the Memory RCW for un-cached
 operations.

 For systems without an coherent cache controller, non-MX, we always
-use the memory controllers RCW, thought non-MX controlers likely
+use the memory controllers RCW, thought non-MX controllers likely
 support the Internal Operation.

 CUSTOMER-WARNING:
--
2.26.3

