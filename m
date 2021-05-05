Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D046373618
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhEEINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhEEINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 04:13:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82302C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 01:12:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h11so1641332pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AyB4ne21YGsZ3nlNdX7yoz8z8BjHhbU7WYp7er/uBs=;
        b=DIJMfknYggj3QnjgzYWbEmdmY+cwX56YS3oNiQrq6xCe3PZGCx4tdxthKmRY0TKp0v
         M4zOpUnwVM32L80sEuKHO8FBuBlu3czswoBKOj2QPm9zKk4U5Se6F18q0BueoXnEx01P
         GXEu1odFc4GSUQw6vtK0Ojcl0O9QHPtnoK9ilQNbeQ/p1HM7Sf8IpdBSW96KtuZO9uo1
         X9QzOjPBzF7ELQQ804+awSSv5h5q3qgnFJkRWf0G8Tx0l97h9j52MbIpMCYCXeUNXiXy
         z8lmyQjMDLqAiBAXGxKSZCTZHQHMsspB1QGVUO7aY4qIQeRtevBTaimlq+F2tKL/4Y9w
         ie9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AyB4ne21YGsZ3nlNdX7yoz8z8BjHhbU7WYp7er/uBs=;
        b=RtOPqHhp8GXLEsgkZEoN6Tq7GuJVBtcHs95Q2h3vG4Eb5i3jR7exAFYdC7cAfF/EUK
         sxyy1iMiLTkZTIPHb2VNdqLwM3z7Ya/m3wj8kKrmT+NenHtr/XHus/vjI5RGKs1aypuj
         JgJtJqUoNaFImTMNDoX/A1aAayPbxNa+XTfON/Cv2dd76cREpg09KAbs6htKTK7s19RB
         m4tsS9NfCLl54TzbX84DYPsVTqxsRXalZ+1IeX0fsoJv2dmVXlYSknXm893nU3gqtDAN
         3lZtwUw4ixu1SE22hfmFh4t7rpSr56hAOsWrBIQmHw7mGJbrDTIudMUmbg+NU507hZlS
         yQNA==
X-Gm-Message-State: AOAM5300EfPDMgKgUh2LvMUI0I4H6u3t9bdlMvzw086Ma4FiDSiiG2qW
        XROjmMwVq8Pysrua8KD7Qb39
X-Google-Smtp-Source: ABdhPJy4X3QEQX48IbepN7hH8bSFzMYeH3oW8zOJ9qPgPGqBgv9OqcTXHbaRU0NPS6Dz8CNLbicn/g==
X-Received: by 2002:a05:6a00:ccd:b029:28e:d682:cc66 with SMTP id b13-20020a056a000ccdb029028ed682cc66mr6734376pfv.53.1620202372989;
        Wed, 05 May 2021 01:12:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6d18:2fef:221f:3158:8c4c:ea90])
        by smtp.gmail.com with ESMTPSA id l67sm6091691pgl.18.2021.05.05.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 01:12:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     akpm@linux-foundation.org, joe@perches.com, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] checkpatch: do not check for "/dev/null" while parsing addition of files
Date:   Wed,  5 May 2021 13:42:30 +0530
Message-Id: <20210505081230.29190-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"/dev/null" is used to signal created or deleted files in the diff header.
While parsing the addition of files, checkpatch should look for
"+++ b/file" and ignore "+++ /dev/null".

Without this change, checkpatch falsely reports below warning for the
patch that does devicetree YAML conversion:

```
WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
```

There was no includes in the patch but the warning was thrown as the logic
was messed up due to the incorrect entry to "elsif" block.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index df8b23dc1eb0..0c201d387ca9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2694,7 +2694,7 @@ sub process {
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
 			$in_commit_log = 0;
 			$found_file = 1;
-		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
+		} elsif ($line =~ /^\+\+\+\s+b(\S+)/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
 			$in_commit_log = 0;
-- 
2.25.1

