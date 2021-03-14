Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AA033A36E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 08:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhCNH3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 03:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 03:28:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605E4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 23:28:40 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n10so18601940pgl.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 23:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2DBxZZzfpEFBGCSvP78Nj8qEZTByky+nxFzM0e7NOU8=;
        b=tVTDfqE0cBMhb8ob+K4J60TmYSzRkEIXIPnQkneHTl+dSSjZlI+oZSkesA28WPTVOV
         rhRD4ohwdPEbVVd/EwakNGExHbs7aAe3zEz7FDP75xhuWAEv4q5PCWKNRbpzjLwjqi69
         xnMiM57qD5oqae2NJRcHMQ3R689JrmPVXmX4nuMPOuwhKfMyUbrIECDGkpBt0jXu4yog
         gk8iQs6jIaYIvntqh8pJjW7tbQiJuymop3sZF4WdKnblyypGCcTrAgVd0eaMj6xU/2Tb
         O4IRYDsw6kh1VRWF7uTfI94JGQ0IDRho61JrRc+ku4t9yAzTD4wYAUfHO1xhmur6o+30
         FdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2DBxZZzfpEFBGCSvP78Nj8qEZTByky+nxFzM0e7NOU8=;
        b=BKD2BG4p5L41z1Wvn/XTV3KTqipHsZTfa/trj7Ux1PmHF+Jp8B5V0LG7RxdGOo/1pV
         pvvpFIe09o/M8GZLI8cxpODnucaVJEATa0mzJErY0HuqAWsZThTNBNq7VSn4iiwXW1uv
         M4Z4dgOs8b9byvW5P4mC0bOQ/ilmSwytTA3oejnRaFO/1k29HzBJDfy3eSRp+x7QHZY1
         1wTojoT/OgwQPnXgJRAmGjXcYjGoDXTm4qp02tjA6LkM86hhyUXPK8WVBTllCypxb3lq
         xpklIjwPG5/zfW+Sbfe3fyzWsPdIJ9WLFPEGZkvvpZq+WEkQpQsewEbIh+OC3G55ELPJ
         Afsg==
X-Gm-Message-State: AOAM531JiUvTYy0v0KMcLc1L1ADCA7CB1d5JocZ9IZDOMfGisi+Uj0kP
        9KNar+Bz7BRbG8RklCZWwiwCn7fnpgyimg==
X-Google-Smtp-Source: ABdhPJxYVgYx5WkBx3nd4L116cSq9pHykQvc+OkFZFrhoXbwJG25Q2EixNaR4oaRP0JNMU3Ce1ssPA==
X-Received: by 2002:a63:905:: with SMTP id 5mr18502662pgj.337.1615706919762;
        Sat, 13 Mar 2021 23:28:39 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:ed50:78e5:473:ed82])
        by smtp.googlemail.com with ESMTPSA id gm9sm6823247pjb.13.2021.03.13.23.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 23:28:39 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     leoyang.li@nxp.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: fsl: guts: fix comment syntax in file
Date:   Sun, 14 Mar 2021 12:58:28 +0530
Message-Id: <20210314072828.9270-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for kernel-doc comments.
There are certain comments in include/linux/fsl/guts.h which follows this
syntax, but the content inside does not comply with kernel-doc.

E.g., opening comment for "Freecale 85xx and 86xx Global Utilties
register set" follows kernel-doc syntax(i.e., '/**'), but the content
inside does not comply with any kernel-doc specification (function,
struct, etc).

This causes unwelcomed warning from kernel-doc:
"warning: expecting prototype for Freecale 85xx and 86xx Global Utilties register set(). Prototype was for __FSL_GUTS_H__() instead"

Replace all such comment occurrences with general comment format,
i.e. '/*' to pervent kernel-doc from parsing these.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210312

 include/linux/fsl/guts.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
index 0ac27b233f12..fdb55ca47a4f 100644
--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * Freecale 85xx and 86xx Global Utilties register set
  *
  * Authors: Jeff Brown
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
-/**
+/*
  * Global Utility Registers.
  *
  * Not all registers defined in this structure are available on all chips, so
-- 
2.17.1

