Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A27F305798
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhA0J7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhA0IuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:50:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815AC061573;
        Wed, 27 Jan 2021 00:49:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id kx7so848813pjb.2;
        Wed, 27 Jan 2021 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogvLlSlY+9vRowRJOJWWs9+NcXhZK6hGZGMuwRJokxQ=;
        b=NsKGxARarBhzADz1AXaEpB6slfr4w/lYrQbedp5OKcg6TDsNJtoN1efF/FDqvyeboB
         lrbVeN025zLsi4/WTlStjpjs+ab/SIZlLwU9U/17CDllC3F1CvZVwq9645ieNfdW+4J8
         x4YdW91FD8eiER+enxxJ1A17uLvgFYX5iDyV5OZRComPBqGnJjgi82Y5rfAFDtCBq+xd
         9u5lZSzOPDK0jXOt9OwKdVK9oypaV4x3Gpw5esLU9myl74DrHE0IpmCRIsMfDOZNX+Yd
         rDxLUMbAgwv97dmRtUbPe6jiisY2GVLI6Jfb39EjowrWtdPm71IMY29qG+gTo1Qaf6GS
         9Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogvLlSlY+9vRowRJOJWWs9+NcXhZK6hGZGMuwRJokxQ=;
        b=Bxm9L3YaQWoljhlyKdsYfA2pUR3ur0N6RT3YcCD+iIXn1LCjuxZJVOOyCCTSasXFFC
         gYi7O3a0Xg4YAEjac/X6xDFsDdL32+WXxI3bAlOgPs2+BNIEbgEiNnzcXErzfWnj2pJ+
         TYB9Q/nfuRzBG/X2qkbLxlAULdvDsJfByPsipRAQ4RkbVjBhZ4IQ25mmpOGBU14tuVSi
         6zFgirU7B6k488RkPJsoDwpK/6yE623fAWZjuQ2yVfx2lSjoRC4mAzxlwa+IuS7xs3LP
         zD+u7hptLyOxQRvlSotjVi7aSwzCdJr3BOop+pZZEl6h+YvjsbkGt3pqDAm2cImMZ7bo
         ZrMg==
X-Gm-Message-State: AOAM5305D3Y/raeEL1aOAQL8nqJto/7p2S1NfZFJWDkK6MXtpo3SJocA
        9mM+nuaZt4pCrq8XMf2umF0=
X-Google-Smtp-Source: ABdhPJyqCxsziH3LzAab1WyOuAouEDFcW0a8bqa+3VmqnE5dq8bp5Ma7UvYMz1A82CcO97ZWrehpkw==
X-Received: by 2002:a17:90a:7d08:: with SMTP id g8mr4634598pjl.180.1611737355109;
        Wed, 27 Jan 2021 00:49:15 -0800 (PST)
Received: from localhost ([98.126.155.250])
        by smtp.gmail.com with ESMTPSA id l190sm1548393pfl.205.2021.01.27.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 00:49:14 -0800 (PST)
From:   Cao jin <jojing64@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        corbet@lwn.net, daniel.kiper@oracle.com,
        Cao jin <jojing64@gmail.com>
Subject: [PATCH] Documentation/x86/boot.rst: Correct the example of SETUP_INDIRECT
Date:   Wed, 27 Jan 2021 16:49:11 +0800
Message-Id: <20210127084911.63438-1-jojing64@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct setup_data.len is the length of data field. In case of
SETUP_INDIRECT, it should be sizeof(setup_indirect).

Signed-off-by: Cao jin <jojing64@gmail.com>
---
 Documentation/x86/boot.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index abb9fc164657..fc844913dece 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -851,7 +851,7 @@ Protocol:	2.09+
     struct setup_data {
       __u64 next = 0 or <addr_of_next_setup_data_struct>;
       __u32 type = SETUP_INDIRECT;
-      __u32 len = sizeof(setup_data);
+      __u32 len = sizeof(setup_indirect);
       __u8 data[sizeof(setup_indirect)] = struct setup_indirect {
         __u32 type = SETUP_INDIRECT | SETUP_E820_EXT;
         __u32 reserved = 0;
-- 
2.29.2

