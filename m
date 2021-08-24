Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B263F55AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhHXCKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhHXCKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:10:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:09:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y190so17022826pfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZlG/ChLDc3AYgjy5sVCdo5NPSHi2j9z4lW6SbGIsUs=;
        b=ELOiKeJOKunMM67OBX89RJhJxeeZ6S6vvhu4v807klx48Hz/GxxMNa4wfwsPKDGeaV
         jjw5nn8TFbYMqf5gaN3OIV52OJv5vguS8je1TJVSbFmnHKn1PWlBxvvxvYkDMn1ag3nr
         4eUr5bFmjThrfRhFbPhwL2ddgTxxHiFw0lTuqc4YcoPXhuC8HpEO9F9Wy006i+WMeX5J
         yqUfzSX5GDYEb+9jNRybHZcUjAxA8Phmf1JPeabaej6U9g24XZKafP1SgHLB8sK122rv
         /wCTTcpYqh7jUV9XM/rZmRBZFJwM7X1VgDvEsRaQKd/3z5lo0JbvdFLeBDMKUXhHzO3g
         j8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZlG/ChLDc3AYgjy5sVCdo5NPSHi2j9z4lW6SbGIsUs=;
        b=Dds/FYUZwdM7qX8QoX4nSwBl65vAHkpCAO4ssmpCdAzg6hdGo/tPzAFd9L/UCSxAId
         uckQXAyD4itJcmWfmUMAob3E42TS3zuDmhiPj5AJ2vdfhlBtv9xqFweHrrtQ3dg58Gz3
         CiLJ47u5NV16J2SUGDtNEHC8zrGhuEjPZ4XQVLFqptA+eFG1AWhjt97XiKUuGY61UHkg
         NhEwhilAblVBTbu5fmeIbQ+Zwp2ouCLUj+PjDwlN1zY5Faoj5Prs1GcpLj/1Z81MnjbF
         s5FgnhTd5BBMhUJkgD/qnUM2gsZGBFNXAFqBfovu3tPlRGirLi/9VW158t6MfWpkTGRX
         iWnQ==
X-Gm-Message-State: AOAM530auDTRfO2miY4c7IixHOeJethlAl0V6tbjvQIfa6Temn7S1Q7s
        stmYW4iFe+rW/87x3mq1YYU=
X-Google-Smtp-Source: ABdhPJw/3t/sfo5GyAyM3hy9TRZA3TfWfwDJ+bxIbX/6ERhjW0bVLDtb+dgMJpe5jmZDauTBG569nA==
X-Received: by 2002:a63:408:: with SMTP id 8mr34060362pge.78.1629770992309;
        Mon, 23 Aug 2021 19:09:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id h16sm16830958pfn.215.2021.08.23.19.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 19:09:51 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, osalvador@suse.de, tdmackey@twitter.com,
        david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/3] doc: hwpoison: correct the support for hugepage
Date:   Mon, 23 Aug 2021 19:09:45 -0700
Message-Id: <20210824020946.195257-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210824020946.195257-1-shy828301@gmail.com>
References: <20210824020946.195257-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwpoison support for huge page, both hugetlb and THP, has been in
kernel for a while, the statement in document is obsolete, correct it.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v3: * collected reviewed tag from David Hildenbrand
v2: * Collected ack from Naoya Horiguchi

 Documentation/vm/hwpoison.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index a5c884293dac..89b5f7a52077 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -180,7 +180,6 @@ Limitations
 ===========
 - Not all page types are supported and never will. Most kernel internal
   objects cannot be recovered, only LRU pages for now.
-- Right now hugepage support is missing.
 
 ---
 Andi Kleen, Oct 2009
-- 
2.26.2

