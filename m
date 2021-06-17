Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1E3ABDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhFQVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhFQVHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:07:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470D7C061574;
        Thu, 17 Jun 2021 14:04:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o10-20020a17090aac0ab029016e92770073so4604643pjq.5;
        Thu, 17 Jun 2021 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4hzfs4C5s5996Anf36saILan2RNfe6VDAOXYGhmerw=;
        b=sW5El4rAB4VJt4+UpL7pZ4nHnCEuLy/0zKmqefTmqCQE/QMuGoMGAn/NJLcKNdvwad
         3Lpg/QV2UUqHDauDPZP4YiaEondU2tcgo5tPbJnkMy8QfunRxeQfedtRNqZG/8eet63v
         TpgkdcKp1v03LQMWtLLI9xz/Grq3fJVham7uVzcKmcIf2oso9oi5pwXQQ6ECjxYyYVdR
         8KzGNx3ixWX91fbuT53UModfPZngvVbaAxD4hqxPjz+Xg896PtY53nGkdPd5n5PAHT+V
         A/Mzv8/TdDznzz38lnS+C2Jw2DybJnjOHEpF3PWcvPFP+v1+0pZS68Smcf8yEHNA2DIS
         e/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4hzfs4C5s5996Anf36saILan2RNfe6VDAOXYGhmerw=;
        b=OKyIAtf3zQg992CPWU08hey/d65xy4++bqgT5cPsRUsTU5n2tm4Yq/1MfRvqXNTwqR
         vMvwoThUPSunoswSeWCneqy6kj/j8NchC1yLGeQJwQ2Kx4JbauvrKkTmXJ70yxX0G8Ue
         nRKzrXX1sC+vSAexVBo25hMC5+BcIITUQM/u6T3Cob/pSyBGGBmzG2lrJfCuxqrA+Fe2
         baweFladKfGZlPD59XH6StTMg8Xw0orB7+wBbCAUvFwKI4tR6DQg5/jNGVATQH385uJ3
         d414hESnWyeLwxLnyifsnxmPOWiu275I+7FfvV8SDUTKiYUc64LBj8TXwjYM/eUNCLXZ
         qVLQ==
X-Gm-Message-State: AOAM530JNSsgjCGmr8rsUFL4ve4L/eg4lpMC8G/1K/6tvOB1vrgibEfs
        nGPh+fkMDcq24lgq9Ef3MRa0D+HU0DCN+c6K
X-Google-Smtp-Source: ABdhPJxK51L5zpDihvV4/6rXrVf/hsizo4aS+Ld5qPcZyCDYTfHHN0BzzXZc/p12U3ueGKhp12CuQQ==
X-Received: by 2002:a17:90a:b64:: with SMTP id 91mr7117223pjq.24.1623963895701;
        Thu, 17 Jun 2021 14:04:55 -0700 (PDT)
Received: from nuc10.amust.local (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id r24sm8829324pjz.11.2021.06.17.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:04:55 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     catalin.marinas@arm.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] docs: kmemleak: add more details about kmemleak usage
Date:   Thu, 17 Jun 2021 14:04:20 -0700
Message-Id: <20210617210420.392412-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a user may need to initiate a manual scan twice via debugfs before
kmemleak reports an orphan object.
this is mentioned in Testing section, let's mention this again in the
Usage section for better visibility.

Link: https://lore.kernel.org/lkml/YMpEtyUP0vuWo9HV@nuc10/
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 Documentation/dev-tools/kmemleak.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index 1c935f41cd3a..512f78e6e4fb 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -38,6 +38,9 @@ Note that the orphan objects are listed in the order they were allocated
 and one object at the beginning of the list may cause other subsequent
 objects to be reported as orphan.
 
+If you are triggering a manual memory scan, you might need to do it at least
+twice before kmemleak reports an orphan object.
+
 Memory scanning parameters can be modified at run-time by writing to the
 ``/sys/kernel/debug/kmemleak`` file. The following parameters are supported:
 
@@ -235,7 +238,7 @@ enabled. Load the module and perform a scan with::
         # modprobe kmemleak-test
         # echo scan > /sys/kernel/debug/kmemleak
 
-Note that the you may not get results instantly or on the first scanning. When
+Note that you may not get the results instantly or on the first scanning. When
 kmemleak gets results, it'll log ``kmemleak: <count of leaks> new suspected
 memory leaks``. Then read the file to see then::
 
-- 
2.30.2

