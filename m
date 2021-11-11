Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB21844D373
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhKKIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhKKIy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B1C06120A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d9-20020a251d09000000b005c208092922so8329891ybd.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vO55Ki1YTxX9p529FHMA4/9V0/syHawoHFbG6ofXD+g=;
        b=FM4dD3fZEJovC/OoXctHnYniLOT5N6pfNbwlu46sSbLVU6/OqMYO8fSY+fKKzdFuTC
         pTK/9URZ2u9n2o0E+/PCMPxSZgKfWs6M3I8YxxllzRgLksS1O1KLOdeF3RrnZ7UyrZ4o
         14nGv2jUB01ZdAnZeeGvfm04rduWAjWUMJLncQvrSqD1CWEssZ7ASg6bwZBOZShadcWZ
         OFycnBEE9n85FP7nY2CdFXBD/DD+3i/25sC6+NZV31iDycWJs1KJ3HzpCVa8v+dcAebh
         Ef9jLOFC5hswrqODNes9AqOpnqRfSjztVxSQUlZ6N1onmqXjmgSV3B2Y6H6swp5a1mSl
         xCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vO55Ki1YTxX9p529FHMA4/9V0/syHawoHFbG6ofXD+g=;
        b=w+aOwlHBIZ/W/1ygtpwyDLgbcEjdj3C47BjttCSl29lamuWSAElOilnZD/FJbSQW+t
         N5kQUmIjCa7X7+S4Vqn94QiGFHh5s6OLebajQFUBjtA3H8AC6/YodFlaIhWNE14SIRs4
         apAjmDYb6x2gCDZqY/TrAkjK8AVfNiDPa95e8d6+wzCV2PtIcp+5BLfd9xMkwZoj6lpl
         NLxrgUe2ez6EEmxTgSCLWPQvgtkbeJqgYVtddQW0nsoMPI/d1DEnWVlqO7WiJ++wiQ2+
         zaoGB48biryrs0V7AZ4yb1JtVJSgWnKJ7lWgQhsrxWOB45uL4Zw4uQBnHSKcs4UtUW59
         zkFQ==
X-Gm-Message-State: AOAM533gcBgsqvyWancCTKydQo/RsheaRybpKX+cmESvUh7CSxWPQ58j
        qlIPyayUa7UufgafBgwptPkvuxlf3O9bKEhFtNlg5RQeNC/St2AdFR5dYs8QkVJq+rHaen6tVU2
        /1oUxE61erPIcvfICgBNdln5xe/1N1bwY0UTOSpWzsD8/6KLCae7Jn09dvt9XaO+HIjbYMVqb
X-Google-Smtp-Source: ABdhPJyuh6WrZjtGcgjS+X5r931DkKDTprAOr5NYX3HXJmDAA09ZnPxlHFXVOm0UQr0j7r2G/0mlJOl5iOaN
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:ef0b:: with SMTP id
 g11mr6514267ybd.404.1636620697347; Thu, 11 Nov 2021 00:51:37 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:12 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-11-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 10/13] perf tools: add branch-brs as a new event
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although branch-brs is specific to AMD Zen3, we provide it in the list of
events recognized by perf as a convenience. It allows: $ perf stat -e
branch-brs $ perf list

and enable some test suite to pass.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/parse-events.l | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 923849024b15..ae229f5c4758 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -361,6 +361,7 @@ mem-loads-aux				|
 mem-stores				|
 topdown-[a-z-]+				|
 tx-capacity-[a-z-]+			|
+branch-brs				|
 el-capacity-[a-z-]+			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
 
 L1-dcache|l1-d|l1d|L1-data		|
-- 
2.34.0.rc0.344.g81b53c2807-goog

