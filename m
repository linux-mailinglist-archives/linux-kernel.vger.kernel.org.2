Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0D376D9A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 02:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhEHAAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 20:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhEHAAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 20:00:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2FC061574;
        Fri,  7 May 2021 16:59:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v191so8982877pfc.8;
        Fri, 07 May 2021 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZryPiI1aj5OPp2LLfkdKXs07LsCC3xu5eq2Sse1t2n0=;
        b=NLI91gYxPSA2lEPlvOyZhr/jBcXxIjCAelKLly7HIjFm8/oSyrE+Gswedzvi7AREdz
         KAZciMOQcP3fvwqk0OaVpSbokdURQvfFR4jvOU/AL9EV56oQSRR3pGumnubhuib3yAqZ
         84bronBzNWDIDeNVA/cIcHbCReUB8rkoSDrcI/5HE/R8d55IibI2T1XxyxKKbrBKlrON
         7+7ZxgZXDNVL3zV4DR+055lkuOWI08IZT86cPZczvfH3OGiTg0NRAlyjDcZKNhj6NYoO
         PvhVuNIuQkwoLdob3LnbtbCGBbTdTzD/82bYPgNHUID5om2CvVAty8RoqRVbuPFeBR5z
         cMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZryPiI1aj5OPp2LLfkdKXs07LsCC3xu5eq2Sse1t2n0=;
        b=bI5voQ1xrw8R3lybq28actQSpbiS4ngnmS/ZWtjcWo4kLBB74lglzQ3EnVWy/UGBeo
         zoICtYAwhRB5Vr8V8KFF80W2Mp8XfPWZMYeU3gSxk3xnUQOgRTwQj+t+/hCjHTb28vmn
         zCfpHy9f+Ux7QITC1JIP9MxrNIG53vC9oip+TgBlZ5XX+JGrgdHNNZ4zHtdqBZFOjBDw
         aJiLxjx/e+nSR2odIpVgE8yz94g3wylViGmlIXO3jwToFLkK9zdB7iFC33r/izhqKxK6
         WdyO8o0csp+PDY+x/fVsThY28MWIsIPSHFxzRmQf10i7r8pa/2JKI62zMBKL01hSdCZ9
         sTFA==
X-Gm-Message-State: AOAM533/l1dcgtFZ6uTqZozqV7yMlfMzvYYiOjhTQbRUKU5uFXcE7lpw
        JuLIcjmECZ+Sdbu4o9UNmMU=
X-Google-Smtp-Source: ABdhPJydRJNOEFJNhhy2ZrYutQBrKpcybP3bX1zUkOWnLJNk9+S4uIf2+jkMDNlMaXwiKyx8hNBuoQ==
X-Received: by 2002:a62:5f87:0:b029:263:d07d:e88e with SMTP id t129-20020a625f870000b0290263d07de88emr13082747pfb.39.1620431988981;
        Fri, 07 May 2021 16:59:48 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id g18sm5700449pfb.178.2021.05.07.16.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 16:59:48 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 2/3] 9p: doc: move to a new dedicated folder
Date:   Sat,  8 May 2021 07:58:41 +0800
Message-Id: <20210507235842.16796-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210507235842.16796-1-changbin.du@gmail.com>
References: <20210507235842.16796-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later we will add another documentation for v9fs.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/filesystems/index.rst         |  2 +-
 Documentation/filesystems/{ => v9fs}/9p.rst |  0
 Documentation/filesystems/v9fs/index.rst    | 11 +++++++++++
 MAINTAINERS                                 |  2 +-
 4 files changed, 13 insertions(+), 2 deletions(-)
 rename Documentation/filesystems/{ => v9fs}/9p.rst (100%)
 create mode 100644 Documentation/filesystems/v9fs/index.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index d4853cb919d2..e53992636a49 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -63,7 +63,7 @@ Documentation for filesystem implementations.
 .. toctree::
    :maxdepth: 2
 
-   9p
+   v9fs/index
    adfs
    affs
    afs
diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/v9fs/9p.rst
similarity index 100%
rename from Documentation/filesystems/9p.rst
rename to Documentation/filesystems/v9fs/9p.rst
diff --git a/Documentation/filesystems/v9fs/index.rst b/Documentation/filesystems/v9fs/index.rst
new file mode 100644
index 000000000000..a1e45b89e2a2
--- /dev/null
+++ b/Documentation/filesystems/v9fs/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====
+v9fs
+====
+
+.. toctree::
+   :maxdepth: 6
+   :numbered:
+
+   9p
diff --git a/MAINTAINERS b/MAINTAINERS
index c9f9c89bad13..2d22e2af4d10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -232,7 +232,7 @@ W:	http://swik.net/v9fs
 Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
 T:	git git://github.com/martinetd/linux.git
-F:	Documentation/filesystems/9p.rst
+F:	Documentation/filesystems/v9fs/
 F:	fs/9p/
 F:	include/net/9p/
 F:	include/trace/events/9p.h
-- 
2.30.2

