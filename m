Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E73924CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhE0C2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhE0C2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:28:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E775C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:26:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so1593019plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hvd4+Xb+GzIKrsCZxZPtXp6GkRNOcFPQJULvXYt9j6g=;
        b=TbVD5UqtAvekmmrAhf6UB48FbjnD1dXYsbIuxV/jSLAk6R5ZRCm8Peku/zaFzB9FxY
         IX9IGSz2bJmTeWAT2xoHsvz2JLkdZEbDXg5NuBAgtGLg4xBT084OFpggt4xxORgx4eeY
         +cr2sYttkWUfDbhOyPzvTIpNW8VTglO1L8Mj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hvd4+Xb+GzIKrsCZxZPtXp6GkRNOcFPQJULvXYt9j6g=;
        b=JE1eUpxK2vtOCEs6cZqWxN4JSvsNEDEMX1RmMex2oK+pEBEK4/nBH+c2+TOgyZbYBN
         Sm9oscW8234MgfLGAfgsnNA2oZAyjohY/yPpPJo0AeVCsR9VuFEPFXaBz5BLlIYSY4o6
         FcQgb3bkxEYwAE47U/n/3JqvbTer+qMyJLPrnlVPz8rVVWZdeA4CNxs+mjdUBIkotyg+
         0yt3GCMHcwVDgIjJFh+XPe08d4R/nr93YuFFDoIQK4j2R/efyVsBREVWjuNCColON3ep
         dC9wW+WMELAsBuYZ2MRsYA0jPMvDPj+TLywJ+i2IDHDKtB8wfXrmDKLoCaZYBxzbA6jS
         hpJg==
X-Gm-Message-State: AOAM531LnZi9P4ml76QWkdkb+tCOm0dJLwprty/wG+gS8edrCCuOwkXE
        +bhJqgXBKclhSwYMLBve3m1s9w==
X-Google-Smtp-Source: ABdhPJzm6pXr5bHzhGKTFnOJSBjP+UO1CQY7QcAUwfUCis10QyU0M0hjv1hQfBO+cnvITDs+ch7JIQ==
X-Received: by 2002:a17:90a:880c:: with SMTP id s12mr1299279pjn.66.1622082393809;
        Wed, 26 May 2021 19:26:33 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:9021:eef6:e19b:9dd])
        by smtp.gmail.com with ESMTPSA id gj21sm470703pjb.49.2021.05.26.19.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 19:26:33 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH v2 0/3] Detect suspicious indentation after conditional
Date:   Wed, 26 May 2021 19:26:21 -0700
Message-Id: <20210527022624.1034423-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is adding functionality to checkpatch.pl to test for
incorrect code indentation after a conditional statement, like this:

 if (a)
   b;
   c;

(Indentation implies that `c;` was guarded by the conditional, but it
isn't.) The main part is re-sending a patch from Ivo Sieben that was
already proposed in 2014 [1]. I don't know why it was never merged --
it seems that there was no discussion on it. I hope that it was only
overlooked, because it works great, and I think this is a very important
class of common error to catch.

I have tested it extensively on the kernel tree and in the course of
that found a few more edge cases that get fixed by the other two
patches. With all these applied, the vast majority of hits I get from
this check on the kernel tree are actual indentation errors or other
code style violations (e.g. case label and statement on the same line).
The only significant remaining group of false positives I found are
cases of macros being defined within a function, which are overall very
rare. I think the benefit of adding this check would far outweigh the
remaining amount of noise.

[1]: https://lore.kernel.org/patchwork/patch/465116

Ivo Sieben (1):
  Suspicious indentation detection after conditional statement

Julius Werner (2):
  checkpatch: ctx_statement_block: Fix preprocessor guard tracking
  checkpatch: Ignore labels when checking indentation

Changelog:
  v2: Expanded fix to ctx_block_get, some minor simplifications

 scripts/checkpatch.pl | 56 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

-- 
2.29.2

