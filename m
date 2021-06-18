Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B801A3AD0D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhFRRD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhFRRDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:03:53 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:43 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z1so9039860ils.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HeAW5ZZBsaS19LdP3gb8OCWm8CcTsSDDoRHVly6f8Ow=;
        b=PZwziGAOPyMlKkMW16e1cC/3EiMvOXM5/jhb0yWEuzlyD8da0IQubaaqCOzV67OHr9
         XwLKyWetwozziQM1kCh1vAG7R2KcTYl/wUcyM1bYrtz8tMAu6lrLXr9Qdmhi1nmeoU1K
         BpnOqCiALE4knnPhj251ZU+EBS9gwil2q/6bDw6Pf+Jj9q+x+oTEpN/VKZ+puFz7GnTi
         AjN4uPrNojYvY1lFKfttFja9yxAk/4RWyJf8JS6J7O99D0xKtDlHsXMvUVU+mdolrjL/
         94bZZ6XsmfxWA1/QaaYpAq5xKDe5pPL2WPC1fy702WKGtixPNGpEWufFI/AhiineXNII
         Hfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HeAW5ZZBsaS19LdP3gb8OCWm8CcTsSDDoRHVly6f8Ow=;
        b=l7rYh5anmGhZTAQD4YFKfyi/9296Q5UGoWGMsVlZi54biwA+08tHTpDrcBh+5ir+2Y
         ibjA0pS83wVt6ui6P6daVvn0tmetjE98xjwXUNdzfhlYKMK6lsRg2ZqmPTEtEd2WYWMJ
         w9iCSmV70ENw/zfsHx3sm0JmtkPcG7s7bvJ/Zm1TSNL5vajnjDjwr12QwriuW220p1zu
         +HIUZVcvtiyPqC/vqSQ4HtuKxs/udPzjnBQweUmb/kdsrSoxoEe5WkHG2Md3up0AXKOI
         KYJHXsfxwDy1UT1EGKWz6Z2XkPRBh5DHfdQVuD6zHr8PdvihdCvY0CJdmevdzyr7AxgV
         5Q6Q==
X-Gm-Message-State: AOAM533k+vh0nD0uVfq5hb2QFNPZNQpcSBlKD8TEvHDOdrEWlqcR7fjJ
        utYxxt6+A/VzrYFedhM40B0=
X-Google-Smtp-Source: ABdhPJx5cgCeukAUP7nU6QLxVVBReLGMGECDiIU39vZ7C9sFra9TBePLGSMvX8RnNqd3oywpJ9Mjtw==
X-Received: by 2002:a92:c952:: with SMTP id i18mr7981855ilq.292.1624035703105;
        Fri, 18 Jun 2021 10:01:43 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x11sm1434887ilg.59.2021.06.18.10.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:01:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id E113327C005A;
        Fri, 18 Jun 2021 13:01:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 18 Jun 2021 13:01:40 -0400
X-ME-Sender: <xms:dNHMYI5lH8j-cabqrYjOyi7gMPy9UnpPOyKWxsixBry8zO9JbKmu0A>
    <xme:dNHMYJ7teXWFl-Jxky-rStrXYtzNI3bTit9mZeWtHP8SBxHvsJfIFql5Z3T9PQX_0
    _F5lCXyyf4PObpqgA>
X-ME-Received: <xmr:dNHMYHd4bpl4RmicpRQAgw0CqXS5l4CrxCmN62pZGVe0XWyEX9cIdk9YlG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeffedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeijefhledvtdegudfhffeugeetveeluefgkeevhfeuudeuudfgveevhfetvdeu
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:dNHMYNKg2xhM5zZ7Aots6WKfFRqt042soZcleoGlLeVaYBOOCvgTmA>
    <xmx:dNHMYMLp24GsgeTZUgdYIJuVVIOyI3j-ktA_L0nN4KHDudmsGKWhqQ>
    <xmx:dNHMYOxvZRr63oXP9oeuiP_BS9pYYNuE8q3yYwyshTA3aPC64XUIYw>
    <xmx:dNHMYGjZO0zctMPcijmNXgquliriQWOGZK6xhKTd2EB4apk0Aq3EAQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 13:01:39 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 0/4] Fix issues in check_irq_usage()
Date:   Sat, 19 Jun 2021 01:01:06 +0800
Message-Id: <20210618170110.3699115-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

As we talked in IRC, Johannes Berg reported a problem and I could
reproduce by the selftest case in patch #4, there are three issues:

1)	printing of backwards dependency path doesn't work as expected,

2)	we have unnecessary and incorrect save_trace() call

3)	check_irq_usage() may result in a wrong depedency path (when a
	real one really exits).

Fix them separately in patch 1~3.

Regards,
Boqun

Boqun Feng (4):
  locking/lockdep: Fix the dep path printing for backwards BFS
  locking/lockdep: Remove the unnecessary trace saving
  lockding/lockdep: Avoid to find wrong lock dep path in
    check_irq_usage()
  locking/selftests: Add a selftest for check_irq_usage()

 kernel/locking/lockdep.c | 123 +++++++++++++++++++++++++++++++++++++--
 lib/locking-selftest.c   |  65 +++++++++++++++++++++
 2 files changed, 182 insertions(+), 6 deletions(-)

-- 
2.30.2

