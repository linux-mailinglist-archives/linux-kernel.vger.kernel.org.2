Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52FE3220C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 21:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhBVUYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 15:24:55 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:36506 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhBVUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:24:53 -0500
Received: by mail-ot1-f52.google.com with SMTP id 105so6897706otd.3;
        Mon, 22 Feb 2021 12:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crirD83b66PkXx5mCJ2kwq4M6jm/8Yo+G83RPUKR9OY=;
        b=jwIVf3MYc3x9JWMfb3PJloFcidbBHkthfM5b5stkjiqgwtFWeomC4EZDhvAhYWgG6v
         8BgoIZpguTNDUpWVr4q8jvimG2LpJiskwcwFZdHStaBuANbilZjTAiAklugzCplRgPKI
         1LtUnJA8n3K8NVygsbr0luyG0uVs7KWX/NJUKyXuApzP+ySdGlZbdLLwihWVS5EOFEAQ
         Le3FZRaG7IVxIQi9wwREcmEzXiOkJzDMWhTMV3R6eL1fdCdwy8/9a/TJVI/IGwhtVSQS
         VeasTOoNAlxKS4j/d4bV3lMFWE+wwIvyO44c+Dm/FrDHOoaosYSL62JG+sBXRrRVu3ed
         Oj2A==
X-Gm-Message-State: AOAM533lBtxe/uTBTKlmFySAm1A9y4evRXGxMFxFlZF3arlyrL6PflJr
        LNyPJitc2XeNruyN5dR2fA/12N0RdA==
X-Google-Smtp-Source: ABdhPJwn3QDKuLRcYKwqq983ZBvBnnugVxz351FrERjNZfswxUgPchEJH24YojC1uae5dFLxSHDgRA==
X-Received: by 2002:a9d:6317:: with SMTP id q23mr17583828otk.301.1614025452005;
        Mon, 22 Feb 2021 12:24:12 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p67sm3910962oih.21.2021.02.22.12.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:24:11 -0800 (PST)
Received: (nullmailer pid 2004359 invoked by uid 1000);
        Mon, 22 Feb 2021 20:24:10 -0000
Date:   Mon, 22 Feb 2021 14:24:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [GIT PULL] Devicetree updates for v5.12
Message-ID: <20210222202410.GA1934901@robh.at.kernel.org>
References: <20210222173541.GA1677515@robh.at.kernel.org>
 <CAHk-=wi60wC2z0yTo+B81x8HNu2HVJ6mSFHJC3xpKJOW9_EV_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi60wC2z0yTo+B81x8HNu2HVJ6mSFHJC3xpKJOW9_EV_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 10:52:09AM -0800, Linus Torvalds wrote:
> On Mon, Feb 22, 2021 at 9:35 AM Rob Herring <robh@kernel.org> wrote:
> >
> > Please pull DT updates for v5.12.
> 
> Ugh.
> 
> This causes "git status" to be unhappy, because there's a new
> generated file (scripts/dtc/fdtoverlay) without a gitignore entry.

Sorry about that.

> This was added by commit 79edff12060f ("scripts/dtc: Update to
> upstream version v1.6.0-51-g183df9e9c2b9"), and then enabled in commit
> 0da6bcd9fcc0 ("scripts: dtc: Build fdtoverlay tool"). But it was
> already referenced before it was even added (by commit b775f49fbc8b:
> "scripts: dtc: Fetch fdtoverlay.c from external DTC project", which
> didn't actually fetch that thing at all!)

Commit b775f49fbc8b is updating the update script we run that does the 
copy. The script takes just the pieces we need from the dtc upstream. 
Commit 79edff12060f is the result of running the script.

> And that commit 79edff12060f is all kinds of strange anyway, in that
> it *claims* to have taken some (other) gitignore updates from the
> upstream dtc code, but it very clearly does no such thing.

Upstream dtc has its own gitignore which we don't copy over, so the 
gitignore references are for upstream commits. I suppose we could just 
take upstream's gitignore, but it has a lot of crap we don't need.

> So I have to say - that whole thing was done very very badly. Actively
> incorrect commit messages, complete mess about when things were added,
> and the end result isn't great.
> 
> Sadly, I only noticed after I had pulled and pushed out.
> 
> Please fix. Not just the current mess with the incomplete .gitignore
> file, but the whole clearly broken workflow.

A fix is below.

I've added a note so hopefully any future updates won't forget 
gitignore. I am wondering if we could automate this as it seems to be 
somewhat frequent problem. Some sort of check that ensures every 
hostprogs entry has a gitignore entry. 

Rob

8<---------------------------------------------------------------------
From 23e61200cfb1d7e8d7f85012b47955387a17435a Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Mon, 22 Feb 2021 13:52:46 -0600
Subject: [PATCH] scripts/dtc: Add missing fdtoverlay to gitignore

Commit 0da6bcd9fcc0 ("scripts: dtc: Build fdtoverlay tool") enabled
building fdtoverlay, but failed to add it to .gitignore.

Also add a note to keep hostprogs in sync with .gitignore.

Fixes: 0da6bcd9fcc0 ("scripts: dtc: Build fdtoverlay tool")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/.gitignore | 1 +
 scripts/dtc/Makefile   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
index b814e6076bdb..8a8b62bf3d3c 100644
--- a/scripts/dtc/.gitignore
+++ b/scripts/dtc/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dtc
+fdtoverlay
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index c8c21e0f2531..95aaf7431bff 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # scripts/dtc makefile
 
+# *** Also keep .gitignore in sync when changing ***
 hostprogs-always-$(CONFIG_DTC)		+= dtc fdtoverlay
 hostprogs-always-$(CHECK_DT_BINDING)	+= dtc
 
-- 
2.27.0

