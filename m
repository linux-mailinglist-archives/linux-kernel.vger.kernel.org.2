Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF2238AEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbhETMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbhETMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB7AC04FF22
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so15294095wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yPp50sRjpSjcHg4CewUW4Ob97fInHe87YC20ZeiqPkU=;
        b=yrqrlWl7Etb/gUz4hfx9PAkGl3jodYC4xbwx907FkULtGVl02kEtYJFxZ5+6jYVb+C
         AMSmO3BeWby4jwnHuesif2+1Fy8eefHhe93oHhrsCnUMV1avjkT+t7CCVw0aPZvBC7fe
         qAp8MyvRjX0CiQ0U7Md4bIMU9NVqG7rGZJnYkqonL8lCAwOSdYeaBZTF0CP3gE0sHWEu
         C3wLDVgq7SB84t86kAY5Z+jTZfBXe0llqxs0Os5z5MLVWU3m/z02Hdvc0GPdgx4TgEON
         2hmwjQHc/TIXa+sRlX8vTpGTSNjkcqGnRRDMLdsTQNTVNcV8uGmccsxGfwP2wFf1wK+5
         Qniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPp50sRjpSjcHg4CewUW4Ob97fInHe87YC20ZeiqPkU=;
        b=tPbIm8X/SPGBlSoNydk9x0G2M+lRKKuATCmt/EL/SaAR83kQstApHvaWEq9OT61ieN
         rxiPXC3nl3UyeWtNSLNzrnrR4miH8h7PF9c72u0tMNWnWD0fYMI9GCX9KZjQpmmTfaZc
         4r5LH8zbmQSNMHDw9EhqbS+3jRVz1T+TSuq9I1cmggC8QH+QHJahOtTH+d3F5VA8SoBh
         Q9uN7L/+lIyEb/vlXMONtRScJFZaOHnnUmUhJx2mddShLwpv/2htL2IECIQaeF8TFaq1
         cHtC502OYJHLEPx3F5j89riCiRAM1a3hnxyxC5huNANzCatR3XdwlN0ZbqzPZGJUY4b9
         YF5A==
X-Gm-Message-State: AOAM530B0deCLJxUQah0A7EDuhH3GSMD06kUNads2nSpIdoIdD5cvQM4
        JksLz9RX7/kXIaYAbOJhIBj7yw==
X-Google-Smtp-Source: ABdhPJzFe+B/HMVmIyYSPjn67BV8Ik2wPqYPAqSevrZzEpjj5bb7Ecj4wzcCrFEzH+iePz55vceCcw==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr3948139wrr.12.1621512057470;
        Thu, 20 May 2021 05:00:57 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 14/15] fs: ntfs: compress: File headers are not good candidates for kernel-doc
Date:   Thu, 20 May 2021 13:00:42 +0100
Message-Id: <20210520120043.3462759-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/compress.c:24: warning: cannot understand function prototype: 'typedef enum '
 fs/ntfs/compress.c:24: warning: cannot understand function prototype: 'typedef enum '
 fs/ntfs/compress.c:24: warning: cannot understand function prototype: 'typedef enum '
 fs/ntfs/compress.c:24: warning: cannot understand function prototype: 'typedef enum '
 fs/ntfs/compress.c:24: warning: cannot understand function prototype: 'typedef enum '

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 12444ac8f8ec5..a0a539b206171 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * compress.c - NTFS kernel compressed attributes handling.
  *		Part of the Linux-NTFS project.
  *
-- 
2.31.1

