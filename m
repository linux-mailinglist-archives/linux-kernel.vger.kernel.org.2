Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A72309AFF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 08:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhAaHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 02:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhAaHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 02:36:54 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D1C061573;
        Sat, 30 Jan 2021 23:36:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so13140792wrx.1;
        Sat, 30 Jan 2021 23:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+eDAtUV67eYS9CRNl6IR3Sz9HfgX28vWrmN15pZ52p8=;
        b=g9BbxxLj8xpJGGA29mLW72H72WfU2vhvXSGtaUEtsG9E8AhJ1TBeHp3R6vT18Jz9Hq
         Nr2zfEKKzK7IjO5WnNBzO18uC7Pu7BQeqAC4fx9Wzlt25nIC+PIDP/GKx19CmH3X5fwp
         BDTjKVEF4dzz6flUwe45xxQNOesbvniKneTwFEFAFG8NQbWgVh3GUnS35TIYZRkx/Nlp
         hSxAKs0RW5Mgbf4kiF619C/L7m5IDUb12d0xguIjsewdiBDEwFJeNEql5tvwUPRWsKNV
         pOA6LHsnW3/idez8wDmXIxzQay+f5TXIE1sSW8GRAsb/brYfD3N7nFVhrEEYvT71y9Mi
         Uyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+eDAtUV67eYS9CRNl6IR3Sz9HfgX28vWrmN15pZ52p8=;
        b=QuXyMEuoSR91zx0016Rd4jf3R8s6mcg+4A85FlSKwqbYKX5tXpZOEDJAhtbIs179m9
         WRlUE20AWZnBzBv4kYph8yRiUtxV0LMokTmmv/DdtnjlXXfZFUzbJShBxlnhDfd5kbuY
         InyGoNymaEld/lAeemNPzgcU6EDz2cqIwBEZ6QsRcZmoTX6YEdlsnFt+VcH3n1dAodO4
         pN/NqP3ihBcpRhFsw1p+BZTJtlByA9KLBjM8Gpo3noeqJYNu+aVndR/4tyCiI+yJxrXU
         ZWJ9ClHjLNkm+qEJDpeyxLytRPvHLAS+1/r7BOz29gv7JbzWejGYpXPW0Guo7jSJGwm4
         cdVA==
X-Gm-Message-State: AOAM531FTCq0axrgofk4eYqBgYRd44xh+XJ80QuXgud1J9Fue0FB6MYI
        1c+BwPAHyIiQzo/sbqJcqCo=
X-Google-Smtp-Source: ABdhPJwehVRNuFP8iTmNJUAlD88gCjHpt0drUPfNTdkT+URywXh43xurLl4dWG8cZS6sGbzhbsbtyw==
X-Received: by 2002:a05:6000:8c:: with SMTP id m12mr12579019wrx.101.1612078572447;
        Sat, 30 Jan 2021 23:36:12 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d29:6400:618b:2d13:c477:783d])
        by smtp.gmail.com with ESMTPSA id l1sm4577170wmq.17.2021.01.30.23.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 23:36:11 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH for -next] docs: drop removed pti_intel_mid from driver-api index
Date:   Sun, 31 Jan 2021 08:36:04 +0100
Message-Id: <20210131073604.7643-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8ba59e9dee31 ("misc: pti: Remove driver for deprecated platform")
removed ./Documentation/driver-api/pti_intel_mid.rst, but missed to remove
it from the index at ./Documentation/driver-api/index.rst.

Hence, make htmldocs warns:

  WARNING: toctree contains reference to nonexisting document
    'driver-api/pti_intel_mid'

Remove pti_intel_mid from driver-api index.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210129

Greg, please pick this minor fixup on top of the commit above.

 Documentation/driver-api/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 9d9af54d68c5..66c4c01eeec6 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -93,7 +93,6 @@ available subsections can be seen below.
    pps
    ptp
    phy/index
-   pti_intel_mid
    pwm
    pldmfw/index
    rfkill
-- 
2.17.1

