Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E033D354607
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhDER3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhDER3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:29:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5510C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 10:29:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j18so11529963wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=islgxB5cX7ryyAEWQujyZ6yBo7lGXTDZIsEo+AqSaLI=;
        b=o32v2vqh2JB2QYn2BWTwMD4LCIFxgyvadEJXKeNx02aw3z9umZ+J0PvTgWXVCnevv1
         wVg5BT6WxgPwfuZdlwkwD/5vUrCpfKz2stpoKVd7Y6LdUdAV9rjZuFSYRynZqQekY2QR
         +DB9+P8k8fappSrY4B2GwUzEKWkE4hDUwCLg9hk0mzsDo/90i7RcknEbzggN3ltgm1vQ
         iDZtN2mGoP0NE99xwCiSX1ygPfdGrf6EDDEU8l9/H4u6bUC2u4kiBWctJNJK9L70W7hF
         9m7guE2sI9tRZIDvzovoouvvjBfGlFR8//NdroUCBZjA5iVGEMdNsl0hw+F+tIYt83db
         7FGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=islgxB5cX7ryyAEWQujyZ6yBo7lGXTDZIsEo+AqSaLI=;
        b=p99EAvaH1hmwFIkerdBovxU4mqXOVV4clFab+fqfAO4XeXZ1mRhNNA9AraN/g7R7VK
         ea3a2LkLlRHTFy3coF0fGXksqm+DSHcLI8unATVfDOsdkT7BjxOJbtkb9CIM0ADMkymf
         vQb+lS3Ggn9LMrLtclibfNOyuKfMD4uzvvZqasvP7toH9C40K81T42JYovJm3zgl3og+
         u0ynWuZNaQROLJL2BxZlyXyAccaYQOAbwutTlmzQD8Qxi2OWgXSAm6muPchAjH3/LV+n
         dEStqSXuKPEvoTtwNWXvgVQchTIwjQrc/iPrg8jyIG16kYQ2lSYq9w0cL6GcarRWfU2S
         LCXw==
X-Gm-Message-State: AOAM530GrLDjgaRrOJkJbojPSzH7n2FM6u+niKcwH9Vi336BYD9UpE2K
        MnkU+RnvTZhJlxCecgQjc8A=
X-Google-Smtp-Source: ABdhPJwD+5GvCazXiiLVZAuxEDFL944bL9uiCr9Tf1G/ObZVWPn7R3Ei475DOTRKP1pyFjp0gFqH0Q==
X-Received: by 2002:a5d:5256:: with SMTP id k22mr30836945wrc.162.1617643762740;
        Mon, 05 Apr 2021 10:29:22 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:9a5b:98e6:2174:bf29])
        by smtp.gmail.com with ESMTPSA id x1sm17858699wro.66.2021.04.05.10.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:29:22 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 0/4] staging: rtl8723bs: core: Patchsets cleans up in rtw_ap.c
Date:   Mon,  5 Apr 2021 18:29:16 +0100
Message-Id: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset of cleans up checks of "Blank lines aren't necessary before a close
brace '}'", "Lines should not end with a '('", "line over 100 characters", 
and "Alignment should match open parenthesis" in file rtw_ap.c.

Beatriz Martins de Carvalho (4):
  staging: rtl8723bs: core: Removed extra blank line
  staging: rtl8723bs: core: Ending line with argument
  staging: rtl8723bs: core: reorganize characters so the lines are under
    100 ch
  staging: rtl8723bs: core: align arguments with open parenthesis

 drivers/staging/rtl8723bs/core/rtw_ap.c | 137 +++++++++++-------------
 1 file changed, 62 insertions(+), 75 deletions(-)

-- 
2.25.1

