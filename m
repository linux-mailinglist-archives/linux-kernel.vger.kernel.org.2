Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D62392A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhE0JTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbhE0JSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:18:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33049C061760;
        Thu, 27 May 2021 02:17:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z4so2028745plg.8;
        Thu, 27 May 2021 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cg0JBj0t9k90YMmoJUaJeIXOCJH7nE+15iPIyxQMRnY=;
        b=NJmTeb5dJgpbisAd6L5or3jNf1J4aEV1LsrVDPx0W+7B3vbx7eCpoFcSj+8NS7myRL
         FKS72Q3MgZdLCWB0AF51YBUp543C+RZsnOIUB1bYrUSapdhmfirDQ7Xj2G+11Fh32VjF
         2EGCOJQJUy6xBottPleBwan3XK4XqKQikDzwXYfCvNIqri3Bd0kNVcVtAHAYbPEzFGqn
         J7RQwZxAN/bMcvZd0LxyjLMqZxiUGbSHpNFFApt38eZSbrFDPU4YkPaDntbQ2u2NGmZX
         zlnBJPURJ//n2s6f5/OUGDJCg+XK1SEJi76T0NFKB6b0hocTpxA6l3sTvVRhivsSv7bO
         wOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cg0JBj0t9k90YMmoJUaJeIXOCJH7nE+15iPIyxQMRnY=;
        b=BZdPIioa5V0ssBdxagd3v6swN7az92e4xpQqUOR201O1kxosCLFKnvcM3ad8aAYier
         i/pd0roCnP6fIlR4efe1kWZcytczY9PfTDcWM11vo8U0pjv5cUCGwXvD7JfU1oCELBb3
         HNiAWJJD7ihyY7tSiVGW5T2gcwzaZiP3RWOVbIHMXb3H1LC+7EKD/8o2Pbn5TCYdKuEi
         WUX6ztW4JbF76dvyYJtH89a2BOsc98q5dQ2LBn/ujoPqEpKenrWUNemiBiXXeLA4EHTO
         ivA3pnKv9x/Bo5W6W/7HBtBTniIU4SJn06dnDRBbfSWFCdMdSdAongHylKfwyQcJa1mm
         1TJA==
X-Gm-Message-State: AOAM533OkNPR2DZbGBRbpBdntb+CmCaR7ogjhcPzbb76dkMPO5vY6rzt
        TgH7Wk6YKb0m/SJ71QRELZdDwd02yWIEfImvMJc=
X-Google-Smtp-Source: ABdhPJw97eLPEbCRQd9h7hIKqsKJzO+DuNSdZsMbLKVDrdfpsLBFwXhem2ia5T9KQI5K90aDlK1yRg==
X-Received: by 2002:a17:90a:6285:: with SMTP id d5mr2766488pjj.3.1622107026057;
        Thu, 27 May 2021 02:17:06 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id 126sm1473079pfv.82.2021.05.27.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:17:05 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v3 09/13] docs: path-lookup: no get_link()
Date:   Thu, 27 May 2021 17:16:14 +0800
Message-Id: <20210527091618.287093-10-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527091618.287093-1-foxhlchen@gmail.com>
References: <20210527091618.287093-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no get_link() anymore. we have step_into() and pick_link().

walk_component() will call step_into(), in turn call pick_link,
and return symlink name.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 3855809784cf..0a125673a8fe 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1103,12 +1103,10 @@ doesn't need to notice.  Getting this ``name`` variable on and off the
 stack is very straightforward; pushing and popping the references is
 a little more complex.
 
-When a symlink is found, ``walk_component()`` returns the value ``1``
-(``0`` is returned for any other sort of success, and a negative number
-is, as usual, an error indicator).  This causes ``get_link()`` to be
-called; it then gets the link from the filesystem.  Providing that
-operation is successful, the old path ``name`` is placed on the stack,
-and the new value is used as the ``name`` for a while.  When the end of
+When a symlink is found, ``walk_component()`` calls ``pick_link()`` via ``step_into()``
+which returns the link from the filesystem.
+Providing that operation is successful, the old path ``name`` is placed on the
+stack, and the new value is used as the ``name`` for a while.  When the end of
 the path is found (i.e. ``*name`` is ``'\0'``) the old ``name`` is restored
 off the stack and path walking continues.
 
-- 
2.31.1

