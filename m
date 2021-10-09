Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB464277DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhJIHMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhJIHMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 03:12:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2DEC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 00:10:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a591700b001976d2db364so9453909pji.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 00:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ThrZy9IaVr5ANZT/WhhbRhfVGn6fCPXjnkMFw8jmxTk=;
        b=PGic0pjYZYlreOlkCyYqNQtvqcCseoSzhXZLL1N96oZKSWjBSTxXX3+60aZywGkskz
         7cCqgAGzdAcS9qHU5uj4Onyzm+mbUUqeFs4v3IM2jRKn694sO8YkkxR8jPl5QatrV8TU
         Wgl+pARGXDL0Uuym9jLYsCdctRT8n1E2ACmFriy8F/jvZF0Jg4JNOd7Ovl4VazXF2oQm
         hnjl+FdJq63JSRvT/wydeenpyjqlRh0/IwHe1VNflQ9fafjDVDRB+k4nG6GIa5eWnYjQ
         2HccBimaFtmylhD838wmNabz4KBALsOGAamO/wa1qX/IqAhTVcZzyDFz+fS50yvnizxV
         fPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ThrZy9IaVr5ANZT/WhhbRhfVGn6fCPXjnkMFw8jmxTk=;
        b=GHCr3nOBjP8hNPtIJpjhL+B/v8+6VxyZp4q0TvZKGhVuRsJIP4Rarb01kOQqNSr5NK
         kDpXmQM9K0gnZF4U34kciNGBWTt1GMZru1ailJTiv7jU5woogRgfGvG43YAUXUXfJHNP
         Ws3eDOREz+jzlyaJtQIBI3UEyqbx+dW0TIAsfsePrt31X4cJKy696dyeh21XWSz9DfHv
         DhgGK0r+B6NscgLigJG07NC7IVGsAVCFvKI1L9mroutJq6udW2U7vRAVog6Id83sYOgX
         EuhbJc+6mckBjrQpo4JWV5qKYTK0HEcribH7dAj0jX5WDDA7nCES1EjDPOfOPRElzyrs
         SN1A==
X-Gm-Message-State: AOAM533P5gnMNwqUG/jrFhs0zStCPbLnGhWT5guwgaltnvE3WtvqVD60
        5zZ7/8CoGJVyFweTYfYPJs+jJA==
X-Google-Smtp-Source: ABdhPJxLkbxt+De2YgZDydbqBCOZ96T6YrPrIgAythu/bbCxHdjtXGsUL1pju/1w86eeQZfxHfWSvg==
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr6016175pjr.232.1633763453371;
        Sat, 09 Oct 2021 00:10:53 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e17sm1119416pjh.17.2021.10.09.00.10.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Oct 2021 00:10:52 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v2 0/2] mm: mmap_lock: some improvements
Date:   Sat,  9 Oct 2021 15:10:44 +0800
Message-Id: <20211009071044.69439-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series make some improvements for mmap_lock tracepoints.
Please review!

The patch to add ip field in tracepoints has been removed since there
was some controversy about it. I will do more analysis. Perhaps re-post
it in the near future.

Gang Li (2):
  mm: mmap_lock: remove redundant "\n" in TP_printk
  mm: mmap_lock: use DECLARE_EVENT_CLASS and DEFINE_EVENT_FN

 include/trace/events/mmap_lock.h | 48 ++++++++++----------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

-- 
2.20.1

