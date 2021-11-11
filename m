Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFBE44D36D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhKKIyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhKKIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:54:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058D5C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso8233659ybj.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=necuowKpR6SCl8hMjN3TBt7K4UmzbXxYcnFh1WBbDXM=;
        b=Z3UqPfpdUV7ySbrkJWlPg+0GfmrZc21JrwO9p9tBTqoclTVN3YTAQKnT15yZE2URs0
         L8Ml42CU9E4l1JQjD6XQ4GhL9C4s/Wv3OZtV0J5Pk/SKpuzJPkTefxUfxZruZRz9W0tX
         cGUjFSeT91eNdwqACYprAcjkkQ3tXNZofDhb45KxlV2GwepWqkVAY0QWT2ONh/NlszXE
         fc7Qy7yRp4ANX1+oVp4TE5BpEn6i+lL/R9IPHidcZ6UfqrTFWY0ZUxrjI8qr/n5/RbVI
         r/f8eab0lXq85oFVF/7NHui2Hl8YW3tEU72b5gzZ/iDiptG904TS/qTA+Xg3ZgZ3imrh
         CvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=necuowKpR6SCl8hMjN3TBt7K4UmzbXxYcnFh1WBbDXM=;
        b=zpgYIspZKlZExVNhnkj/YhcbqzmQd+o9f5FWE24O1vhJHld99oKo+eEkFZhVxIOmg8
         7bBs3EzSbL8KcyFVPjRfMafIepm0RGd9Yl0BdW6xgHvdMyMWRpgu4PuNcFKjIZrdaboZ
         JYOw9fMPqPwS9jsmmdu+qj9X9Q8OPvPo8eW7uJYT8rh58kUvcWD/idBJcPwPYRsSHY/R
         uJyeNBLzW3/ogshHKySlZGbfTYXXhIp0dFloGyVs5L0++tVqKAzc8kD7xGAAhHF2OwBM
         xC7QKp4LQw+M5YljTorE/NXLCvb2juhD2aZaF6TBZxL0eMwSG/qy4/4N9V+KvxRDA/lk
         qyoQ==
X-Gm-Message-State: AOAM532M1hehcXSxAAW/ouWtPIhGTLXiFYgkAPwljE68bvqalwpsZWV8
        AwwBINLsYDRXmIxORwlLD/DlbTSq5EesA08XwzJuH3rGehsVDB3xwyxN3pxrBwVRQ1J+hpIJO9p
        SZdzT0G3ibstonkraZIIp/hir6vkZk4PASUbP19iDnifc1r8UmqancYOs805gRb+2aWx30pZX
X-Google-Smtp-Source: ABdhPJyMvS+fuhvDmEoTko780bkM/cEy7k6YXsGKSxLgWkbEVNJWZcapnwBM689Q1FX9t2YIU/6hi2P9Nz5h
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:cdfe:134b:9d27:6cbf])
 (user=eranian job=sendgmr) by 2002:a25:2d66:: with SMTP id
 s38mr6106562ybe.527.1636620683176; Thu, 11 Nov 2021 00:51:23 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:44:06 -0800
In-Reply-To: <20211111084415.663951-1-eranian@google.com>
Message-Id: <20211111084415.663951-5-eranian@google.com>
Mime-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 04/13] perf/x86/amd: add branch-brs helper event for Fam19h BRS
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a pseudo event called branch-brs to help use the FAM Fam19h
Branch Sampling feature (BRS). BRS samples taken branches, so it is best used
when sampling on a retired taken branch event (0xc4) which is what BRS
captures.  Instead of trying to remember the event code or actual event name,
users can simply do:

$ perf record -b -e cpu/branch-brs/ -c 1000037 .....

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8031b9400aaa..d47cc2c6d85c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1109,8 +1109,24 @@ static struct attribute_group group_caps_amd_brs = {
 	.is_visible = amd_brs_is_visible,
 };
 
+#define AMD_FAM19H_BRS_EVENT 0xc4 /* Fam19h RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
+EVENT_ATTR_STR(branch-brs, amd_branch_brs,
+	       "event=" __stringify(AMD_FAM19H_BRS_EVENT)"\n");
+
+static struct attribute *amd_brs_events_attrs[] = {
+	EVENT_PTR(amd_branch_brs),
+	NULL,
+};
+
+static struct attribute_group group_events_amd_brs = {
+	.name       = "events",
+	.attrs      = amd_brs_events_attrs,
+	.is_visible = amd_brs_is_visible,
+};
+
 static const struct attribute_group *amd_attr_update[] = {
 	&group_caps_amd_brs,
+	&group_events_amd_brs,
 	NULL,
 };
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

