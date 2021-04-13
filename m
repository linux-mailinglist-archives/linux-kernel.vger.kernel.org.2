Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78035E79F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbhDMUeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhDMUeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:34:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79525C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:33:56 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k8so12785547pgf.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSdlg5xvaQDZsLoPWHTKgWWHFxjvxtKQ5zr5fbA5PpQ=;
        b=WylbRjVSQ+LLbMeRn6+8/7fHGfn8keiW5mt5TLp74Lby8sHnNOp0MjPpHXGN7AfTtl
         6THUNZtVGZCEU5ppa+c1RGGvtzZUur/eTiVWBisZhz6j6c4f9CTNgrPVvCai3+AsyEPw
         5DTsCcyr1TAXNAUq07v8T0ZgkwKAwDWRwvxfHj1RGsJ4gHmTXFoW6JVGIS1eWaD6w7gF
         DSwJdWhpvy5b/dD93dYlczAqhOYMW38OVt2tx2zJ6R6zVWXW0UbDxgZTMfXLCR8ZEJPg
         Z371oM9MSyesNF/faReHGF+nln/VabFNEdH6AWxk4/Kfdl8h493XPBPl4b8WRowdknT/
         Erew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSdlg5xvaQDZsLoPWHTKgWWHFxjvxtKQ5zr5fbA5PpQ=;
        b=sHSzOBtvUYpSN1hsl4jsKvbiQJD4SlwoIRA1VFst2dnaCfnF28mSR+8WaVmqBHoGkF
         9mO43XtkNHL33G27+YpjCNtD+wuIkrdxv55LFucDex5hvLO2ykPxcLs1Mdm6wzWOQqhK
         n4vijPAbmVdHL6WUZdDvjyS+1W5Mg2HsyFDQHPgiiuCrxLJnOyF3R0c1HL6d6WJKZOvJ
         3BJAh1VpQMKSkwMKX7T9EWL2dp/AGvwB3k6CnZGiTaBy+cr88ef2uS0G0iOf+6jv0wFQ
         L+10iKPvXwZq+1Vm0eHukKkqNImJclgXPuELSwMNN7HbHMRsk6q2annV0T/hbGdV5RM1
         SIMg==
X-Gm-Message-State: AOAM532mUDPbz3H4PfZl/MJw9BhY5FQ1POxJQfRDZVkPuCDY0j1C8OB8
        MTBu0zDzhRwmHpKCz3Rm79+ZPJl7j5E=
X-Google-Smtp-Source: ABdhPJyJxgaU0AtjIKqZmJM1Gsr15nczkOPK+ruhLr1Ccl0dm0d1eLXJ7XJy6jRN456ylKBvD0rlnA==
X-Received: by 2002:aa7:9f45:0:b029:24e:6fe8:5bf0 with SMTP id h5-20020aa79f450000b029024e6fe85bf0mr9158416pfr.79.1618346036114;
        Tue, 13 Apr 2021 13:33:56 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:a476:17ee:13ea:2981])
        by smtp.gmail.com with ESMTPSA id 20sm89970pfw.40.2021.04.13.13.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:33:55 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH v3 0/3] rseq: minor optimizations
Date:   Tue, 13 Apr 2021 13:33:49 -0700
Message-Id: <20210413203352.71350-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

rseq is a heavy user of copy to/from user data in fast paths.
This series tries to reduce the cost.

v3: Third patch going back to v1 (only deal with 64bit arches)
v2: Addressed Peter and Mathieu feedbacks, thanks !

Eric Dumazet (3):
  rseq: optimize rseq_update_cpu_id()
  rseq: remove redundant access_ok()
  rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()

 kernel/rseq.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

-- 
2.31.1.295.g9ea45b61b8-goog

