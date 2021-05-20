Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFA38AEA4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbhETMnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbhETMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FB7C04FF23
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j14so15639307wrq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYp3jg3sRXQlLbxRQ+kLrMqD1BSTvzaOONIVK3wuGQ4=;
        b=LvW0t1skB6XJu8twERfPKSNy3XvylYIG0stcsLic9SOmmZk4ZzcN7FQwTGNICONhPH
         9sBNtHdVHQ/zpECKLYw8DuYLbqbZlOOGd2svy36oQsF7G9cwFt1ckKpDFBPfAlr/sMw9
         XG4HQWchOkNZfCHoeXXllE06rfc8czeAGL0DDfKgLxptKCMfplZfTssn2qBrwNXHJhlH
         +mbtBYS9SSgMEr1/M6e6DILJ7xdxoI2O2r5OJPOU6B4u1yxlKKXNBFjsbPLcicl7wpoF
         +090p3gM/wprAjuFf6uZorYL+HX/88AEFJBrYPqpaBf4xgEVVS8hJR3vBwMUcp7+hz5H
         4NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYp3jg3sRXQlLbxRQ+kLrMqD1BSTvzaOONIVK3wuGQ4=;
        b=kap8qS9ubsYI/37r6qxS4JCuXI7grHxfHp+cjC0i5rK6hiPTrVyLwI99TSt4gvZWb0
         7hmnZ+t+C+t8Ih6F2HTx6SAZLJJ/Y0vi4ec8SN3MGaa0ZTwY6XqE2brJsl+L+D4GEFo0
         42K+qfDhf13SZshYFz2Vmnz5zkcfLZ031XNGG17kr0kRzyrVMAap+vyLU1ChJCVmZ5oA
         MQRnfZE7BZldk2eWrI1q71juCzQOESGNX5g+akWQm4JH1ZPjlBT+88Phb+V9vLKK/HuL
         FnTkj4IcOturMt4JmniNLF0qbP2u7KG+S8zO1bYKqatzFvlXhdYW0SK1DHcAzuMQIxZP
         3Hdg==
X-Gm-Message-State: AOAM531pOdkYSlv+UvGTtWZM8whH8Fg3fSJFRZaIaxL06lpXhVAarxp6
        FrmngcI5/nCVFf+0f0JaGGYFeA==
X-Google-Smtp-Source: ABdhPJwMLZkhMNYQ7r+3ls/lWFpf6jloKJdYaspRvc9HDwaHg4G4iL1cIJ2pYtC94tQgwudmdRIkbg==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr3871348wrp.293.1621512058279;
        Thu, 20 May 2021 05:00:58 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 15/15] fs: ntfs: runlist: File headers are not good candidates for kernel-doc
Date:   Thu, 20 May 2021 13:00:43 +0100
Message-Id: <20210520120043.3462759-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/runlist.c:22: warning: Function parameter or member 'base' not described in 'ntfs_rl_mm'
 fs/ntfs/runlist.c:22: warning: Function parameter or member 'dst' not described in 'ntfs_rl_mm'
 fs/ntfs/runlist.c:22: warning: Function parameter or member 'src' not described in 'ntfs_rl_mm'
 fs/ntfs/runlist.c:22: warning: Function parameter or member 'size' not described in 'ntfs_rl_mm'

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/runlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index 6c7822cdf3ac1..b92fc781f59d7 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * runlist.c - NTFS runlist handling code.  Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2007 Anton Altaparmakov
-- 
2.31.1

