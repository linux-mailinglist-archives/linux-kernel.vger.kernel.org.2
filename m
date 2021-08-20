Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87053F2B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbhHTLSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbhHTLSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:18:38 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C76FC061230
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 04:17:47 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id k65so18112588yba.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/5YusWKi4mMtAdaU6d/BBWgplNbGITEAezWLtaFz7rU=;
        b=WY8G1goCQxK+CDam4CXathjUIAYVS3CfJ95oXavKFhMVQSPIA4tCtcLelytlo+41fz
         H8JyIzANIqEYimrF9QFfCQFWdFGLFvJRfn6d3ilOHICAgdpdRLERHduk8z6QGhQqA50C
         UDuCiy24nKCuLi9MfT1agQoCXL0wlIIAbUTJAW8zXLM7J7Sl6ntbWshtwTvMMSdVeK6j
         6f/jxtZUICWP9d83um/XKnYVZYlPT12eQEKMRd3XtUywx+XJE+yQvzrQlPAV5M7zBeQm
         rGr5iZrYFHw53bTTFSWm5adIAA0HGO/igYCfxKs7msZxil2f8w6t8KSL0dhGQrqN1Z75
         r++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/5YusWKi4mMtAdaU6d/BBWgplNbGITEAezWLtaFz7rU=;
        b=sM8ukEhS8v7BeCEgd3Dh8arYFekIyqI5eZY/FGZA9wjngjNyBWlgozIEfm7cFQ7fdM
         V36GRBB1AaCXdAh+ISe46NzQNO/PT9Dmv7EhoLPosmUo0K4myoOuLbadv+3wVPjiIHte
         2Dzyw4850Qh+6MuejFItnzWlAIuZEPUagujGla1gQM1Wv5C3fmC8JH2EmuLfGgThPEUn
         WWxM7XWMYD/GMRHUqIFLfpaTxioRmw9pFRCck1v/+B2tIP11xzaA8LieHdP56vh0gogx
         PcRAe3m8TTgq9SOY2g3NL5XYpqMU8NtRO3os3c+aHqatEgw/DjhOWydOp/twqLWyxw6A
         tPmQ==
X-Gm-Message-State: AOAM533vbdH7sCueUeuSkY3dHL8o3drnblH5bBcfNyg5jZlOBGUM47j8
        oB/kgXk0YDg3VBZYGLOZbNLVmo91Z1v1LQ5ST8I=
X-Google-Smtp-Source: ABdhPJw0S96eBoW7rmRSkGQ3C0Rx9Rti/xgmk5Y1F2EQjhyKaeELqSCM7qbX+TRdQDmjkzuCBgZfjGSoC8LUu4UuRVA=
X-Received: by 2002:a25:f310:: with SMTP id c16mr22964783ybs.464.1629458266629;
 Fri, 20 Aug 2021 04:17:46 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 20 Aug 2021 13:17:42 +0200
Message-ID: <CAKXUXMzqmN1dYpbYSCXWN9VwHn8+MXj3P=G09qD6=atwrcJ8WA@mail.gmail.com>
Subject: Question on commit dc7109aaa233 ("futex: Validate waiter correctly in futex_proxy_trylock_atomic()")
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thomas,

in commit dc7109aaa233 ("futex: Validate waiter correctly in
futex_proxy_trylock_atomic()") visible on next-20210819, you add:

+    /*
+     * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
+     * and waiting on the 'waitqueue' futex which is always !PI.
+     */
+    if (!top_waiter->rt_waiter || top_waiter->pi_state)
+        ret = -EINVAL;

However, ret is unconditionally reassigned later and erases any
intended effect of this assignment. This is making that assignment
above a Dead Store, which clang-analyzer correctly warns about and
which motivates me to write you an email.

Did you intend to return -EINVAL here? So:

+       if (!top_waiter->rt_waiter || top_waiter->pi_state)
+               return -EINVAL;



Best regards,

Lukas

Static analysis tools are as foolish as they are... but every dog has its day...
