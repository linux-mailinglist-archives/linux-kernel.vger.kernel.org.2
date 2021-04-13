Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6035E3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbhDMQYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:24:12 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:44705 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245161AbhDMQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:24:04 -0400
Received: by mail-pj1-f48.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso9255093pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sC0eEHlwjpguCW0VkhIBoQ5JVcn0IeS6daplONajYsw=;
        b=lWLDKrvcTySp+B9xOCOTJY8/F/ueStTgGmz0rZpR3GgotNwFO8dLii60XUkSCz2PLj
         WCffFYiJlmuNyoV/PiZg9yDTLkdpYFxgGVW3XaAlCMLCLXDFIypBTE3Y0MIyqxDo6CND
         OLGven+hK83HFz/BBUiVP2lkRRuySFqYbUojdgkX0Vf1ZuKMJatoJzwdYq3+wCo3cnSK
         CfNSOj1+UanPX/8l1BkdnjzU0fv5Mfx9cc2mVme357pClH+z4LLIbsciUQNWsKtczBdv
         5GH6TWcSgpkGVlb4FtvcTffjaz5GNGy2flJLYaY7zoRYfAnHM0/72q9/NRQ8snTQ/ygx
         ddpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sC0eEHlwjpguCW0VkhIBoQ5JVcn0IeS6daplONajYsw=;
        b=l6D9FUvVgRrsEQXn3gYaOyUoitamYE1ilXNTVZJ912cFAVrDSSJHdXoDvYrVD3hUcd
         UhUmynN2OtjZGppn6XHzz3hV2pOfvIFfFGWKwWpcq8k7LHK06pPOO0X0N6FhwNNUVWqt
         y0rquBfAg/O5pogR5hMlHfeGdz7FKBCFRSCmC4PZNOfDI5UKnEERGvgFDm9nffyhUe/+
         7nmvzIX1YZ5UHdNwTNSH8+zBB+uFg/Kew1BCAgnKKLkkDVixQbVz/wWgQWIo28TkF5kx
         FPKTjfaBbcQ7E2JjijoQN/w6VmdHZGbRFa6vHHj41hJiXDO861yp0PiCLbZLbCM9ZLEH
         GqIg==
X-Gm-Message-State: AOAM531gOCJFdDUQ0KL+dZdZ3IhdqHDcB2mEet03h8f0FPU5a8TCMxBZ
        fPJIWpI4WFRN3l6oig9uiXI=
X-Google-Smtp-Source: ABdhPJyoYKOkuZ4Cc2jFQhiUKPpI7Rzk0NrHM9XpyXP719zFWWBECUzMeiKK7rrcOk11Q0F9oirwvw==
X-Received: by 2002:a17:90a:5b0b:: with SMTP id o11mr885506pji.18.1618330963863;
        Tue, 13 Apr 2021 09:22:43 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:485b:46b2:8be1:2cdd])
        by smtp.gmail.com with ESMTPSA id l25sm15897591pgu.72.2021.04.13.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:22:43 -0700 (PDT)
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
Subject: [PATCH v2 0/3] rseq: minor optimizations
Date:   Tue, 13 Apr 2021 09:22:36 -0700
Message-Id: <20210413162240.3131033-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

rseq is a heavy user of copy to/from user data in fast paths.
This series tries to reduce the cost.

v2: Addressed Peter and Mathieu feedbacks, thanks !

Eric Dumazet (3):
  rseq: optimize rseq_update_cpu_id()
  rseq: remove redundant access_ok()
  rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()

 kernel/rseq.c | 61 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 16 deletions(-)

-- 
2.31.1.295.g9ea45b61b8-goog

