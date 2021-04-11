Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD02035B2EB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhDKJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:55:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B5CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:55:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d124so7192375pfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7F1O+bCAJeRId7kUZbXaUrQs1QzWOIovw5IMYAIBgIw=;
        b=UZ+wMFzbIft4Q+ZPHh+UzuG7t5OLjaylBYvANNTU7gwLwVLA3oRYBuV0tOKBGacoxs
         6r4W+CUcReefrZ/pkkNuabslafThVW7DWR+g3XE4NSM/K8B0YOgSFqnSvWtPCSHlwKM/
         2q7AUthsPhAZOwp6jWHIGQ+wR+pjFWh3ebafGPcExTU8RzYn0PDkSZTCfvWvD/ZUZeo5
         gd+wGHtVpKsM3g0I6Yr+Krt13ZAT/j6FJYg0yq85qRx3SL4aU4Ydd1DhfzKm++CO1dFZ
         wpHE911647Q5rIdYYR9Oel3rpdqsMHaPwkI5i/sLl7bOZT2cqkacAshmG8Td+MczeMKn
         OotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7F1O+bCAJeRId7kUZbXaUrQs1QzWOIovw5IMYAIBgIw=;
        b=kjDxOvo6uapyK7VoS9nt6JGn0Nyuk3sOJIHc3uNJO/V8rq3n2Tn50cSYh/8b7IZqHY
         kvmq7Bwb7Y0MbKrG1P22MSx0/EVeVLXuA4BIRPGxAm03KSjy+hrlgOSesnKev2uScZec
         x2OPZ1WPscZ4uRIKApb5OoXv9+1ddq2l3n6nJ1Ga+Zk3MGL6V7KWd6DlBrPSEXqHVhf3
         gZsDI61j0QGEC1ZXXojFLaA1GRGQa/PqnukdXnmBUe2em8k7QYxvLQgK9sTDlCU7mUXd
         QtzR1nWKzrk1HGktxBb6PvJv5vSlb/HiB9U3VJPnLYcYG0zOo0mzUr+XP+ecTCykteGf
         lKgA==
X-Gm-Message-State: AOAM5312QZ8DvAU1HhWb8iPLBPnF6IzbUXmoEDqILAB6jGodBdaE1UZF
        yEhcoUxbazUCReuAUoIOT7U=
X-Google-Smtp-Source: ABdhPJxXYmVx3abCfCXWnRfEd+xPH5PnTb5oIDEBoIwm29FEfbm5LXTD20t/2ogISJrjCoUiLKN7CQ==
X-Received: by 2002:a63:7e51:: with SMTP id o17mr21501048pgn.281.1618134912802;
        Sun, 11 Apr 2021 02:55:12 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id g3sm6734435pfi.31.2021.04.11.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 02:55:12 -0700 (PDT)
Date:   Sun, 11 Apr 2021 15:25:05 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v3 0/3] Modify subject description and rectify spelling
 mistake.
Message-ID: <cover.1618133351.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes style issues
Changes from v2:-
[PATCH v2 1/3]:- Modified subject description.
[PATCH V2 2/3]:- No changes.
[PATCH v2 3/3]:- Rectified spelling mistake in subject description.

Changes from v1:- 
[PATCH 1/3]:- Removed unnecessary parentheses around boolean expression.
Changes has been made in v2.
[PATCH 2/3]:- No changes.
[PATCH 3/3]:- No changes.

Mitali Borkar (3):
  staging: rtl8192e: remove parentheses around boolean expression
  staging: rtl8192e: remove unnecessary ftrace-like logging
  staging: rtl8192e: remove unnecessary parentheses

 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  18 ++-
 1 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.30.2

