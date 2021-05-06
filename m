Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38FD37567D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhEFPXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhEFPX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:23:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B35C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 08:22:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l2so6039569wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LjkmNLfvqPyiL6614IK57vCZCshkuyxTiVxlK7RyKtA=;
        b=CMqxdjlogQnANY0VSTrBV6eFGXtkS+zAJKD1u/fKWxqZrqdn7N0d56jErtHZas5P9R
         Pf4HteJ2Y4/c/cpzK7Ok/LwxGOseGrIwf8jDphlXe9jLm6cfKTNvzB+d/G5PTeTmf2MU
         F+o89XkALsUT2fplqCk8O0VB+p4mkiCzrO4ijm0SY6OoWwLESwlJ07CnnY2LZ6hZIIby
         omLlZqUsb0DAMRaSNHzpXsXbUG3E8HZm/6wK5XjkRSlb691jm79660CBIgmTmzNDyorI
         t8Cb7TQE6kI+gP03d3eJHloqRVgna2nuFOviCLb8bSIoDfKTnnSLx0Jyjp6UFYellv2w
         sifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LjkmNLfvqPyiL6614IK57vCZCshkuyxTiVxlK7RyKtA=;
        b=Ts6w7SCW4VjWbwXjeBOwwwyZHqsljFGz+0Owm9UWL1QxK+T/oegbeeoSQRsTfcYN6s
         7/L/sMfQdroaeqIqhA2G0zFEVctvx6NGdzQwxIl324yuJuM2/BR8WEfaDPSJbKGFz3H+
         HaIctguLwQbRADXVGEsbu6CQDaKMhq2TDDL0klh9J2y9gNVRjleHGBTCnZYBd/vi7SWh
         qG7pEIRFOn133WshQVoHIdIxxgU2dPAL2IJFoBv3ElAZbkxt8b/ux78DaEuDyjHYhtGw
         gLIxpk6wKZqkD3cgXh1MUFd9wzfi4DpjkPCcHMsUHkIS62+BAW6gPT5T+gTZtjt7NA5A
         Xsgw==
X-Gm-Message-State: AOAM531qA55lC4sXxD4x6xjm3kO5IWBXfo8+5Ekvh3n9S4FDK6bqB7tC
        drOYlKpp3F2EirW7dM/KtaAB9A==
X-Google-Smtp-Source: ABdhPJxdb+luU7TjtYehHC6AgShtkBAy0A4Wk/HkhJo47Oe0t/FbqPNTthbkMXDy91vXqJYGSnQRag==
X-Received: by 2002:a5d:5603:: with SMTP id l3mr5836134wrv.79.1620314537204;
        Thu, 06 May 2021 08:22:17 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:56c7:a45c:aa57:32c4])
        by smtp.gmail.com with ESMTPSA id t10sm10687781wmf.16.2021.05.06.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:22:16 -0700 (PDT)
Date:   Thu, 6 May 2021 17:22:10 +0200
From:   Marco Elver <elver@google.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] checkpatch: warn about direct use of send_sig_info and
 force_sig_info
Message-ID: <YJQJoq+7MAJosrHg@elver.google.com>
References: <20210506132827.3198497-1-elver@google.com>
 <CABJPP5D_azxBiKq08_m_WVmcEy8qbMCa0EsAgu57t2T+eDJA0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJPP5D_azxBiKq08_m_WVmcEy8qbMCa0EsAgu57t2T+eDJA0A@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting up siginfo and using send_sig_info() or force_sig_info()
directly is discouraged. Instead, new code wanting to generate signals
should use the appropriate helper specific to the signal.

Eric mentioned that he'd like to make these static at some point, but
until that can happen, let's try to avoid introducing new users of them.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Tested-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Use ?: because we don't need $2 (suggested by Dwaipayan Ray).

v1: https://lkml.kernel.org/r/20210506132827.3198497-1-elver@google.com
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ccb412a74725..59f6eb3a2026 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7153,6 +7153,12 @@ sub process {
 			     "Where possible, use lockdep_assert_held instead of assertions based on spin_is_locked\n" . $herecurr);
 		}
 
+# check for direct use of send_sig_info(), force_sig_info()
+		if ($line =~ /\b((?:force|send)_sig_info)\(/) {
+			WARN("USE_SIGINFO_HELPER",
+			     "Where possible, avoid using '$1' directly and use a signal-specific helper setting required siginfo fields (see include/linux/sched/signal.h).\n" . $herecurr);
+		}
+
 # check for deprecated apis
 		if ($line =~ /\b($deprecated_apis_search)\b\s*\(/) {
 			my $deprecated_api = $1;
-- 
2.31.1.607.g51e8a6a459-goog

