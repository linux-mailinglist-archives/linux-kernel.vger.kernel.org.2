Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26CF31749B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhBJXp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhBJXpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:45:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BFCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:44:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t2so2158954pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9VbMJ5pZE69aew0qRg2m2VXJUkAgCJIdRjfuswu8AU=;
        b=jvE8b7n+7Zrm/g+WDhwwZJEzGoXp2sL6K+LYtbaxWVKSWLwKWiQN9795CW1pEFzF0/
         j7qTh28edcwQqc18r7Pivk5hrNlwo1jGq9NSn4h3Rt6YQfbDEDhQEEJj7R7uEUcLV1M0
         dnBjZyAxZSQ0QMw3/9NNiJN333LihrGz2hy7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9VbMJ5pZE69aew0qRg2m2VXJUkAgCJIdRjfuswu8AU=;
        b=AiKYvpW3YDahmo6goczsJJGIldKizfAM7aJ1GFdicyfyrRGA7Rc1qjJrKanWztgOve
         HwiZtFZOkkHyx1ke0Pj+IpsCxlVOKIyjaTBwlN9omfffb6exwWRZ3PbpLpdOrarWX2Sw
         yfOHoprJtiD7cBufTAjllSEwCulaLKkThn5eIR7gt/Ol0+RM2NhKkYbUZjLQgLA/T3E+
         gSfNomV2+TK1079Ixx+Lo8cF7bk4pF5/XXGmiubo1ELVaBmfgLGoGhzvhH5UBv0cxK6u
         afigLdr43Hp/yVdT9n3FpxIZIUk6fwsU1+sqRGi3bGGTrEvkjwAWxOqYXg1W4YVqL/im
         DXhQ==
X-Gm-Message-State: AOAM5312dHGM9e1iPs0BzMhjMk/Yf67ux8Ax+li8E0MceDO5n7Ikpu7s
        yTlVL+g965REWZewL2QNqe4eHg==
X-Google-Smtp-Source: ABdhPJz0TmM99AzdcFlGqNiYmPIhVlu9D8xo9ddlxEm7dh+DvhqU977+iAryQSNZ9uKPmnGP2BsS5g==
X-Received: by 2002:a17:902:b616:b029:e1:805d:b4a7 with SMTP id b22-20020a170902b616b02900e1805db4a7mr5173966pls.34.1613000684410;
        Wed, 10 Feb 2021 15:44:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t25sm3219103pgv.30.2021.02.10.15.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:44:43 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Joe Perches <joe@perches.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: Replace lkml.org links with lore
Date:   Wed, 10 Feb 2021 15:44:38 -0800
Message-Id: <20210210234438.2554926-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=62a459b27fa9437687c60a908cf70c0948d2c0f8; i=UtvdoOe5luAfyO5+h4uTFemSL9e8jtPes6FkheTXQNw=; m=kc8NgBcNkR1FdAUFoBcecPqIFWVDlhJwDI99K+gzg58=; p=Kyyyyq+YL+t4ghn0bnwCdWD/CgSNAbtHvSGmjuq/RxA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmAkb+YACgkQiXL039xtwCYoew//W24 /EbW4Tb6lo3NdGW0m4R52Zl6i2Vk021pY2Dm5CmgWGsFkHm5qRXuM3aFiWZJwvG2WjL5vBjr7EoZG 9y4HTmvLtkIwEcwQtEsUtBDBPxnzRBvd+qZ7INq+tmg/7Q0UXNxaGzbmlRTUzqur7kbTm82NsPrYz iNk4f5fGmPlMos5vzscFe/01TlIMjtF1YGmClb+BLwvzeQInBvEIKF9xnWJh4tFu7S3BN3DDVJNlV tLoLnJJ34CeEHFYwV1sthOJLXJFp0IUQFt7W1wXP/e0D7z+vNjZfbvRDmcCBBcorZYy5SfyJqK5Oz GHeSakd4UwTMzcb+GzfWIPA4W6dik5PB+bjVUbQkhT7RoJpcVQoxBnAtbFYp4DvqJqibN+6ZxH0vT IAtOJv/9O7dew8PER5egmNUZToOB5u0bLcujeZVgxaluWyXds5oQNPzrADwYyD3fIMK2O8F5e60bX QaXdTjeT0OVlAEdODnkbqZrZA7ROaWlhY70rCWtuqpOIXc1E0wmLUIeClq1Ji9UGEcKidbKIudKAa j8AO1Jf+58ntz2jguVv+Ut5K73B0M5eZRtFglVu0d0HFjy1zMREZjffp24R+FBfO+mkf0yV9b9Bdh 8uOQPc1AWmOOVXtbUdHCZ2mY24hltosEA7GstLfYUeW/AdpeOowvFD6a0oUrnt8U=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
links with lore"), replace lkml.org links with lore to better use a
single source that's more likely to stay available long-term.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/hibernate.c   | 2 +-
 arch/arm64/kernel/hibernate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
index 2373020af965..574fba125018 100644
--- a/arch/arm/kernel/hibernate.c
+++ b/arch/arm/kernel/hibernate.c
@@ -7,7 +7,7 @@
  * Ubuntu project, hibernation support for mach-dove
  * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
  * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
- *  https://lkml.org/lkml/2010/6/18/4
+ *  https://lore.kernel.org/lkml/AANLkTimmvPMG0GFEXfgFlXgC7V4dIWmW8vEC5gegsKSE@mail.gmail.com
  *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
  *  https://patchwork.kernel.org/patch/96442/
  *
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index b1cef371df2b..d0d75f9c00f6 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -7,7 +7,7 @@
  * Ubuntu project, hibernation support for mach-dove
  * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
  * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
- *  https://lkml.org/lkml/2010/6/18/4
+ *  https://lore.kernel.org/lkml/AANLkTimmvPMG0GFEXfgFlXgC7V4dIWmW8vEC5gegsKSE@mail.gmail.com
  *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
  *  https://patchwork.kernel.org/patch/96442/
  *
-- 
2.25.1

