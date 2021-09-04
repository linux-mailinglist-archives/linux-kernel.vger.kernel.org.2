Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B3400C75
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhIDSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhIDSE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:04:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BE3C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 11:03:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m9so3411832wrb.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAxMZgmAwlcrkzJ0yFQJ06dES1cpUa60P+WyvSfsk/c=;
        b=kTFopCSvo62CFSZgtuIBYwiB1hMwuJhlGQJerrZmviyOr/+SFPcXRigllZElO1G+Cd
         je/o9LPMexDvLMDzrVRc8kxFciQHi64HbnrMJJGOnjDFYXkBzHDIT5/v0eYP00Luv4ux
         xNOU0mX5Nejku81W3QeyNoeEZXUpxfuPxa9FSAq1euuN8X9RVzm/G9Itx+NF5xyKziZD
         CaTX3y2bvqbFgYvgh7HHHbuvYi4zjQJ7gRJo/58QG4V0HB5mYSSTQ6/wn3bTlRClRH7+
         MU2Z9sPxYh+QesRzsBvU5KNiSGCKInQ+4hzFPiFvkJ1GzmlXCyyoeNpry1V+9zIJptFG
         SBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAxMZgmAwlcrkzJ0yFQJ06dES1cpUa60P+WyvSfsk/c=;
        b=VgRhMIs/U09ZJ8GOEiPKo14Ht4TjVjJ87nrDlOyTH+GG3nw7i1xjiV/rDmKzg8oAk0
         On0BBLhfjk8FWaKDJTvRMVMHlLZvu+aMqgmGNlZgz+5XPwCUleDD2OHrjGrLukz33MPs
         zUwj9ZgjXvXBdnd7YzjTlwHY0ldLymslzJcV9ccWL+4GzbXMhoOhtVVEVu6AetBtzuMB
         T98ViMLO3It1INlf1a4EqJ8eJFkFy1G7w1+lSGbancN0Jmc2lVMHNDQqvMfeZt0SvTN8
         2RhVW+qVL3hS1A5tKL1wp2thPDsDsN1WV4K2IlAxiDQxRe0IrSnijnygMH50Ku4Oxajc
         +ung==
X-Gm-Message-State: AOAM533frkFJ1FBqfykfhPn1XT23ENEezjMiU76z9ZfRnIzTLHXy2b/P
        k/o0DHaAerYGMzNJhOnCKMU=
X-Google-Smtp-Source: ABdhPJzZo2qskrHQT1r9hwjM0hr+H17A8JZqNbkQlt0ZkYUAz949rcYpdjiTR+uwGTzKv61ggU0lNg==
X-Received: by 2002:a05:6000:34e:: with SMTP id e14mr4842294wre.401.1630778604605;
        Sat, 04 Sep 2021 11:03:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:8f8:1127:62fc:cf28:f9:da98:9620])
        by smtp.gmail.com with ESMTPSA id r25sm2761370wra.12.2021.09.04.11.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 11:03:23 -0700 (PDT)
From:   Carles Pey <carles.pey@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Carles Pey <carles.pey@gmail.com>
Subject: [PATCH 0/1] ftrace: add unit test for removing trace function
Date:   Sat,  4 Sep 2021 22:02:47 +0400
Message-Id: <20210904180248.1886220-1-carles.pey@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A self test is provided for the trace function removal functionality.

Carles Pey (1):
  ftrace: add unit test for removing trace function

 kernel/trace/trace_selftest.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.26.3

