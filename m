Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B6353A18
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 00:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhDDWt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 18:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhDDWt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 18:49:57 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901FFC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 15:49:51 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so943062otq.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=nOcn0vPLVXxEmV92y9dqyHeBVs9VlV3r+13+jQMCYTI=;
        b=nvvSZz75tIKCp29BJjqqS0GAGb9LZ/ElLCex9zGhJwb5c6BZl56Yt58akOSRSh4uFy
         bcbX7EuZpKWklE8y0NFfuXw5CNuUk+HTr0E8IJjY3milB6peJeh3ys70IVYbGcBmgVSu
         Wp6wjk0DollRYQUjotAUh7LWz5/kWyvJouiEqeCK7kUHxJqolCpWmn2IDsaLBJbEdZc6
         iILGI8i/O6KYSNZXErfzNF3gQKAgY3VP2013eSEYUs0QKl1Q2UqXXttDZb+ziAR6iHo+
         Dt/wVZDPohOiOIUhbY2+dAlivaGiRY6U4+hvREHMp3/9PHWPNiUiQkGE09ZuqOe/kZjJ
         K8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=nOcn0vPLVXxEmV92y9dqyHeBVs9VlV3r+13+jQMCYTI=;
        b=id0Zmh/SY6p6KPpjiYRE24InNXwIvtXm1Ox8Sinu8KikyawRSZqolHk9Dj1i7NaPg9
         wr9cEyHnQRc0zB0nvddWyk51yR09ftxBZkmoUwGUFDqSjeRAJQMQ3rpyxRTpsDZg54Hk
         tvIZ/0YdieGbjkMwBI6nloHc+rh1EOxTkk0qGBLv06AVXX+bIpGlNAOXc9isTYfqKv/P
         PbbeB2O8QuR+djVn2HVj/FTnt7HGm6wZVvbeDoO/n+4wq9XY+YpZoOkNDZZhThq7s4YO
         VVv8Ya9VIRiQWXmOfzvmsdf9uZiT6V4Uj6/110rdjnN+ixsl5Lfmw7UDgFtDHvduErQN
         1wcA==
X-Gm-Message-State: AOAM531jsEkhslEMVSmtO+xCt3o5Bvex7ln79YhAu/yH1o9lNJB9yb6y
        2DHTpTJszQNY0weNrnGmS0Y=
X-Google-Smtp-Source: ABdhPJxTVePmUwcUaTU+jNkASTqfbyIavcc2QMhaILzTNPmc9hzMLtTIdKY6+A5OoZRiBf7lFa8lFg==
X-Received: by 2002:a9d:5a5:: with SMTP id 34mr20853977otd.353.1617576590968;
        Sun, 04 Apr 2021 15:49:50 -0700 (PDT)
Received: from fedora ([2806:2f0:7000:86b1:c1bc:6875:f962:d652])
        by smtp.gmail.com with ESMTPSA id d1sm3466977oth.13.2021.04.04.15.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 15:49:50 -0700 (PDT)
Date:   Sun, 4 Apr 2021 17:49:46 -0500
From:   David Villasana =?iso-8859-1?Q?Jim=E9nez?= 
        <davidvillasana14@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] kpc2000: kpc2000: Removed extra blank line
Message-ID: <YGpCij8SVkJwO9AN@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning:
CHECK: Please don't use multiple blank lines

Signed-off-by: David Villasana Jiménez <davidvillasana14@gmail.com>
---
 drivers/staging/kpc2000/kpc2000/pcie.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/pcie.h b/drivers/staging/kpc2000/kpc2000/pcie.h
index cb815c30faa4..f1fc91b4c704 100644
--- a/drivers/staging/kpc2000/kpc2000/pcie.h
+++ b/drivers/staging/kpc2000/kpc2000/pcie.h
@@ -6,7 +6,6 @@
 #include "../kpc.h"
 #include "dma_common_defs.h"
 
-
 /*      System Register Map (BAR 1, Start Addr 0)
  *
  *  BAR Size:
-- 
2.30.2

