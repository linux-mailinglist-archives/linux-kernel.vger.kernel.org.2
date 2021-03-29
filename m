Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392F534C2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhC2FQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhC2FQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90651C061574;
        Sun, 28 Mar 2021 22:16:21 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y5so11371962qkl.9;
        Sun, 28 Mar 2021 22:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Hel1jGrSkQGUgfRuAKVn+5JvgYSjZqV5bCXHPwO9P8=;
        b=HvT300GVsYbW7NqDZHuO2Mc6PBTE6uT1Bawq6w3vPpcoMsormkfAj2kgGssZSd/O57
         vdNZtFslfZtOH7uRa38mWWppmr301pgJ30t2TOb/aEbMsV2QhLOaNS9YgPbOzaBxn7o2
         wX3AbjMBhUE4C6JsSajEqScwjwv3EFmSUk7wY7mqPIHNsJ6kp+jhLKPFTvaJaU4ZtaOf
         Y6fmjebIxZgaOvvoTAMrr0+9wFVrfvchtlhRKwWHHdf2zHUCOBE7sTtovUwGmb1bzdI9
         QPKxpYQfufeTu3s8lRyOVPohwz8Uu0a98qKUhM0t+hNe2wF7gwsdV+Dxn4f7qti+z8Aq
         RBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Hel1jGrSkQGUgfRuAKVn+5JvgYSjZqV5bCXHPwO9P8=;
        b=fZ+VEDjaV0/Sd9pTfa5Bkrdy9tjILcUB1+cymzT7KhcDLMeO5JwOJ71vIcou1+zADJ
         t9obFV3x/6dUaG21OocaXt9HFU06N01Kr3wRpVZRVOjP8hJP3ijWZz/l3+eq3jYAwmnA
         PI874zi4V26vl8X0U0FpvJMdrr9PE18/ibdVArSUzG8O/JJj8mIt4Y0K9wVJDSK2nOnc
         29OXZdGy0dUnkkGghgVuCXA3k1ptRqdBqqdpYWgwyoSh3juETKA42qZ6rJmpCjF6wlSV
         1jLwaniU77RCcjcQ5LSIQmEX7KQbGWZ0bWTceFM1bZ0BmTEv3Lg8I16BgpbJIV3er302
         odMA==
X-Gm-Message-State: AOAM5338CMsRVoMgTl3dBvF1CUuq3KUZvdW0QVsLx7t5j9Zyjexh8uDu
        QkerJAIL3+651KViEI/lv8Nt14zBR3dYGQ==
X-Google-Smtp-Source: ABdhPJxVK/LG1OTSETGwbYbKT19ijKVvmMDhpndmb1iAziu6Lkqeh7TMQhRtD4cgpFX3S0APLCn2Rg==
X-Received: by 2002:a37:6108:: with SMTP id v8mr24188067qkb.448.1616994980870;
        Sun, 28 Mar 2021 22:16:20 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:20 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/23] sparc: oradax/oracle-dax.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:52 +0530
Message-Id: <b1a511d3f7cceefb5063d22d16cb898e9fcbcbde.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/discontiguities/discontinuities/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/sparc/oradax/oracle-dax.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sparc/oradax/oracle-dax.rst b/Documentation/sparc/oradax/oracle-dax.rst
index d1e14d572918..54ccb35ed51d 100644
--- a/Documentation/sparc/oradax/oracle-dax.rst
+++ b/Documentation/sparc/oradax/oracle-dax.rst
@@ -197,7 +197,7 @@ Memory Constraints
 ==================

 The DAX hardware operates only on physical addresses. Therefore, it is
-not aware of virtual memory mappings and the discontiguities that may
+not aware of virtual memory mappings and the discontinuities that may
 exist in the physical memory that a virtual buffer maps to. There is
 no I/O TLB or any scatter/gather mechanism. All buffers, whether input
 or output, must reside in a physically contiguous region of memory.
--
2.26.3

