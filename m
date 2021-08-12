Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604C43EA27E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhHLJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbhHLJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:51:27 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A38C061765;
        Thu, 12 Aug 2021 02:51:02 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id n11so998736qkk.1;
        Thu, 12 Aug 2021 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5+Ex4M/WVmsJrPcs5phjc6Esb1xB2cb0aVJHoij0E+Y=;
        b=VoLz81yapzJNBaZBJDTBZQoiAweeL7Hcya0fYeAtf7nnnLV3YcPJxsL3xYiN1zQs/q
         qjaMwAN7ACQx3e9NsVIyjEhd2sEvr+FrA9Mji4L+qufNW41wLZbsQQVvXyK+YcjYBn90
         PTonhsQiOGjqOFeNy2gIxrB2X+WQ9YGXtF3Jpsz3u4lOMHr1PzpAPbFAqVQgno2OXQY3
         5Hou7HuIg1E8STcD2s1lZj6BzWS7pb7/zSwK9q8/beIrRpnqFLrKAtHWOE+5PJXBUycv
         s48uj0JC9lkmO9Su9P+7rBru1XWlc2fKELSB8iBKM59TrBI//wGmEwWRqdiJFhLU6ZFJ
         GgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5+Ex4M/WVmsJrPcs5phjc6Esb1xB2cb0aVJHoij0E+Y=;
        b=JfDghUp8b1lG6jUu8ROm1BrIuMAGpQKi4otYfgeT8CkHx/0FYxc1wbckqtDdfvCQ7Z
         dScHnF35lZf9KeS4nYVNc4+Xu9tfWEiwtMBNJ8bbPB0ay2wBhOBF6I5w+a1VTixk14uJ
         7mrbuk6x9HIMc/n0wyjDMbwBL3HU2uvaVnRYHvdBARIFOYTp87O+AlVQN8/pz9fX+YQz
         wCQL9u17IST2WR3OOb/EvaoT2Cgh2oggg/na3bSdIeNhGZPJmr6fTuU0exQ8msMGDVuQ
         WHEmnYqn3ljb3+8xKLssIYAd4hlY/diHIwyhcW5UNdxyw5Y8OTMbPWYxs+XlsA82t0OM
         RHVg==
X-Gm-Message-State: AOAM53210O8lPTGGjIZgFGEzNl1b8XZsmy+FdBo3DCvElhA2cBRxoFxV
        wI73lr53AeOaaZdrcNN/6rg=
X-Google-Smtp-Source: ABdhPJy86Kc7Esb+9oNstDewCabJ1WtL/GR2y10YUv3X1zy3P5Gn1F4aWXOrEazOSromiiucPXsREw==
X-Received: by 2002:a37:a482:: with SMTP id n124mr3530903qke.175.1628761861332;
        Thu, 12 Aug 2021 02:51:01 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id n10sm817684qtk.89.2021.08.12.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:51:00 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 1/2] Documentation/process/applying-patches: Activate linux-next man hyperlink
Date:   Thu, 12 Aug 2021 09:50:29 +0000
Message-Id: <20210812095030.4704-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

There is a url for linux-next in the 'applying-patches.rst', but it's
surrounded by backquotes.  So the url doesn't have a hyperlink in the
built document.  To let readers easily move to the page, this commit
puts the url outside of the backquotes so that a hyperlink to the url
can be automatically made.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/process/applying-patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
index 2e7017bef4b8..c2121c1e55d7 100644
--- a/Documentation/process/applying-patches.rst
+++ b/Documentation/process/applying-patches.rst
@@ -389,7 +389,7 @@ The -mm patches are experimental patches released by Andrew Morton.
 
 In the past, -mm tree were used to also test subsystem patches, but this
 function is now done via the
-`linux-next <https://www.kernel.org/doc/man-pages/linux-next.html>`
+`linux-next` (https://www.kernel.org/doc/man-pages/linux-next.html)
 tree. The Subsystem maintainers push their patches first to linux-next,
 and, during the merge window, sends them directly to Linus.
 
-- 
2.17.1

