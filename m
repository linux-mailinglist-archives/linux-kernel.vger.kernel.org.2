Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B8325A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 00:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBYXQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 18:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBYXQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 18:16:25 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8746C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:15:45 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b16so7457782otq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Smj9hGl2RbGm2CySkaquhF9hKXGORoT8wFtF23aPw80=;
        b=PQGapdtWdHUGvCi4b/U/fKSxKfUa3+e/PkCB9xyTGoprNmMWOt+EFulQdTJXOhC2kE
         tnXT5OjUevpUtXJ61zrNNs57toOIMqekxK2ymiIX1dQZl2xewyyxY0tsbA3lwcbkxVJs
         0T0hPe+/vHoLnwpD4Ogji36u0TEX3qc7+W1CW4M9vqusdlz/AYjR1Hs15qvHJRwi2o5c
         OsOsV1s7uC+H2ribn2aMqGB/liPnNCoYChsODRXycMZAUuFrkgdmOkARiMEKQAkSJhnE
         D9bpWDcMqJFMY7P19IGXgjEwk6pfAoLWFZ++i/VYxfaG/3wfG3HivaMo6D+JNsPngvuK
         cRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Smj9hGl2RbGm2CySkaquhF9hKXGORoT8wFtF23aPw80=;
        b=nOfaJmmy/NOc1hruW1dAX63tykn6miSgOJZw7L5Cryp6F1mH/WTPOUnldCVaZUVtnc
         B9tzGGMB74zMVlP2Iu/LnJOTm9yALrdZwvUzUFz3IoUHaG1EdXyHu1y3/4LAju0aZtQj
         eCpGJ6gMyUyrc7urc6ZJ9TXcm+w/IbUn5hFbeI5eUejpbjTrY18F5lneK/CGQTSw7OiZ
         tp//gMjYlMzPVidSAhnsTHMUwKubrlVrzE1+0wYux+UDmq560yrp3yWAHtZ+x8VtNTys
         qCRnG3R+feS5Zw7eqxUk3W6cIk6RpAncpuCU+OnVjtuschz+wnEW9cplHQVKcj43O0jx
         hjgw==
X-Gm-Message-State: AOAM5316Tj3qIh1uuV96i9UBHoKysqpQ2XVEvmbmiy3mdqVxaZ+HDqEF
        VX8JA+Fd7QZb5UuFH0rl2Lyt2w==
X-Google-Smtp-Source: ABdhPJwbH5jvPK2gCLC3PeoMa4S06XMPNqRsA3R2ADfVT5/7tiGM4VGjxoFR2Y5LuJe996G+Qavpjw==
X-Received: by 2002:a9d:1429:: with SMTP id h38mr59302oth.135.1614294944875;
        Thu, 25 Feb 2021 15:15:44 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j100sm1404302otj.66.2021.02.25.15.15.43
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 25 Feb 2021 15:15:44 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:15:42 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm: /proc//sys/vm/stat_refresh stop checking monotonic
 numa stats
In-Reply-To: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2102251514110.13363@eggly.anvils>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the VM NUMA stats are event counts, incremented never decremented:
it is not very useful for vmstat_refresh() to check them throughout their
first aeon, then warn on them throughout their next.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/vmstat.c |    9 ---------
 1 file changed, 9 deletions(-)

--- vmstat3/mm/vmstat.c	2021-02-25 12:42:15.000000000 -0800
+++ vmstat4/mm/vmstat.c	2021-02-25 12:44:20.000000000 -0800
@@ -1854,15 +1854,6 @@ int vmstat_refresh(struct ctl_table *tab
 				__func__, zone_stat_name(i), val);
 		}
 	}
-#ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
-		val = atomic_long_read(&vm_numa_stat[i]);
-		if (val < 0) {
-			pr_warn("%s: %s %ld\n",
-				__func__, numa_stat_name(i), val);
-		}
-	}
-#endif
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
 		/*
 		 * Skip checking stats known to go negative occasionally.
