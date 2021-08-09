Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7CA3E4590
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhHIMZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbhHIMZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:25:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFCDC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 05:25:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so34252639pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sbO0qwPyU+28PdAHmm3zrOPb8UejH35IoqepPQCPWxg=;
        b=IiG358cfqfYm4QdhgJL+2Ne4W+KOkekGcJBUuw4d1GwdIkplViQKkn0ekqlJDVUS/r
         ua2/UT6eJwGvpIAyl8Rn51HB8SWKKOeR73wHSfo32waNPS4tdU+PFdcXcSU4yuqNvOJA
         w+TpLSCHZGNuVigQYaBsiK92YzMx+Usy4cI5lbcveFCllc/kH2NIqSKvShk1bJlX/P1c
         4N/Qgz9r/1zmnWGy2qXEsYIqJhiPNszBOVmO86JpNjD+hvvxRwdbnIBM1N+/W60afrNi
         9+vwUM2EybEqYnSWjxYhrjIT9xmlMFlVI0IQi3vhVrvDOPxJRQrIpZLpw9X6Qgqm2VPE
         8buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sbO0qwPyU+28PdAHmm3zrOPb8UejH35IoqepPQCPWxg=;
        b=ffghLTogWf4dDpF/MCI3/X2Glmrpwu+JE3aTbdBxzCqsxgO4P7c+K6aR3N/YZCqTSL
         dEOUorDlar1tTCwdadgPzKv4AorKPFkqaNA8xekwzDxiwq1UdjV8b75hFrWtknje98c0
         STkKGmlwHzzMj4k1Q0DF9PeaQLKQPAX0ERSzsMgqxC2gVg8cFm4wefqPOlyPLl6eEZQ4
         17h+PGDxEYxY0Oi13K4VSa0CKyMRLOCCFtV7ByJHyADqyIY/S8QJ5xeRoxp3AFmGLbD/
         /udpgu87/0DUid5zvk0m/w5wfGn2inRbutR5sb4Ge/yO4MtBJC1j9mZzZqI3tJMeBgZT
         FMAA==
X-Gm-Message-State: AOAM533K7den44sCVsHb6AEwcQWJLwnmM7JC8C4utDvRh1JXKyFoGudf
        s9MfxN0ovZqaBb3x0QX3pN8=
X-Google-Smtp-Source: ABdhPJwwRrlx2A5cZyR5h0hVWcbAokcihg9eyBTO/pNaRJPZbHbOLb9wHuWn8Na+7lxKL+CjEcJKBg==
X-Received: by 2002:a17:90a:c286:: with SMTP id f6mr36275115pjt.121.1628511907184;
        Mon, 09 Aug 2021 05:25:07 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id x14sm19790780pfa.127.2021.08.09.05.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:25:06 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     mhocko@suse.com
Cc:     akpm@linux-foundation.org, chenguanyou9338@gmail.com,
        chenguanyou@xiaomi.com, gpiccoli@canonical.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, vbabka@suse.cz
Subject: Re:[PATCH v2] hungtask: add filter kthread
Date:   Mon,  9 Aug 2021 20:24:59 +0800
Message-Id: <20210809122459.7368-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YREYEewURDEFf/7y@dhcp22.suse.cz>
References: <YREYEewURDEFf/7y@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Then I am afraid you have to keep this a local non-upstream feature in
> your kernel. This doesn't look like an upstream material to me.

Thank you for your reply.

Guanyou.Chen
