Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41C35CE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbhDLQpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343811AbhDLQgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:36:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C19C06135D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:29:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso7260292wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5yY5T3qXbRwDZwbWFp204Mh6qLEwM+ac+6A7HNtQQE=;
        b=nda4l2RVT64ALFuoKZJlYYidK5Nu9fX9bhaY2jQrnycCcOituFOY+qkIXOXgujWgUV
         Ac+WazIcisX71wBu+bcgbYE545Z6dGP7VDto9Wa4d/VRt18Y4J6HkVZqjX/FNtR2G5IE
         G4pVUwXredBR2co8Mjigy2n+biy7SLYFqdGqxmqt6U/w35F+EwLwV+44L/Gsoq0s2Eot
         vabj4ZzD4pdaati330+S7cLfCl+8vsjDkeBZa3rf4zdqJV4hSdfZKV9bkkV/fhOAum+p
         3dzjTtkA43IEO+LPoxG5gtEmpSLBP9zJguuZy9LlZK9pVglNiZRmVt0xDn9jcGSwDoLG
         mEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5yY5T3qXbRwDZwbWFp204Mh6qLEwM+ac+6A7HNtQQE=;
        b=PkDuambD+zzi0GvLYMOILIwjChhzBu3QisyTJmGKQVc1+R1Tt8jCy9CCrIeGuAyZZ+
         Fwryg03DtfoKiLVA8NKevQpo4nfyueZjp4JYS7DW376n3+0onHN+QVmqnEz3V1l5o0QZ
         AzERwBhI30WgmPsmPb/POlJAG+mjh4xg9FFpxMEE6h0zd6fC9uXKK5imS+EmUq+87VP1
         IBs4lOUwzPXOvvgj1Ls/+DglbaTRqim9hgJXytbAEYPF8GcUYA1omsmckZgCMbwZpL6j
         rtCkwfH55aNy9+oxOtnRzgMVg+xtz4U/smg68uyqL8d/G19FmRqcOOJSv0AV/fDRZoD1
         dCbA==
X-Gm-Message-State: AOAM530X0/Xx1ztHmAThNcZyLeWtnAss39tFSOmyosKKiPN4upFnBhi3
        ZlVkMqx/vsnQ51251rEocCXYnMFxTDQiWA==
X-Google-Smtp-Source: ABdhPJwrgJ2ya6wkGwUWoDKmqX0jvdukHMLXBIfo/kyrZ3qMewjnV8atKqKAIo7JUaxCt83P7TtRew==
X-Received: by 2002:a1c:4d19:: with SMTP id o25mr27580464wmh.137.1618244988757;
        Mon, 12 Apr 2021 09:29:48 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:813f:b20e:675a:834d])
        by smtp.gmail.com with ESMTPSA id b5sm16786524wri.57.2021.04.12.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 09:29:48 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Cc:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Subject: [PATCH 0/3] staging: rtl8723bs: hal: Rectify with Linux kernel coding style
Date:   Mon, 12 Apr 2021 17:29:35 +0100
Message-Id: <cover.1618243073.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset rectifies the file Hal8723BReg.h with Linux kernel coding style.
The issues were:
	- Space before tabs;
	- Extra blank line;
	- Indentation problem.
 

Beatriz Martins de Carvalho (3):
  staging: rtl8723bs: hal: remove space before tabs
  staging: rtl8723bs: hal: Remove extra blank line
  staging: rtl8723bs: hal: Correct indentation

 drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 421 ++++++++++----------
 1 file changed, 208 insertions(+), 213 deletions(-)

-- 
2.25.1

