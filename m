Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2573B59D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhF1HhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhF1HhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:37:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315CEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:34:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id df12so24372403edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4Yfb+J5bQrR9GSx7l0SSWdL8etQfgCV0ZiGN0RqiHTw=;
        b=aLVLDovdmEAryY6Lk/Y3deX+MB7r8uJXV0lrDfOoGeuB2Uwj3t0DvpQTYBrDrsnvDO
         LRZ9VbZeP3INyrpCEQBrXelvqRF2Ae3pTcxXNSAjub/0CZ53mSz0fUfV1BEjdKpURbXa
         40qTkkcDzlhgK021yExL+Wtz8zDLA0khiu9kuzzadD+VJMi2NcN/LcjoG2bFg/Jxb8Wh
         IVLzpKHtPjeZ8o9k78EErou9zZZ0QRW2rKKp0VdhbDf2sgrnG29n5UCz3jnrgIwRCKQF
         SBOeHVHprZM3TwNdLv2geBIeASIVohAQfRZaMJbzKywo53e/jUJ/I8ej9309SgsjYwjU
         3lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=4Yfb+J5bQrR9GSx7l0SSWdL8etQfgCV0ZiGN0RqiHTw=;
        b=CgjDdXpmMsbVhrjsf3GvHM3uXI+2z8nYFRJHE+fP3tHhF4xDlhZAmvzttMaHF5VIxg
         IaAjQUGsc3O8EFiocsv4c/d2GJuNvV8bo1bT2N/em7grVK0hHwLWrWOCYDQSv4Y4Epbf
         b9MQi/U8Ig6MuULOUy40rFb9gYVLqqjnye8M4URB7wHTXddIOfdbgDMnEUJ4vQwkODaq
         hvC8Tb8BSP14eXdKTfFbCJIXduDXD8Zx2zfknT+MMe/U5xNWiDpXsJ2hhgPTnCmvLb0s
         XhkZY+j0tGBFn/VagxsPsKTBKjihiVyWHXPUBkW0HVo3mvm8h9viVxz3VMBXaLveY+vi
         zw2w==
X-Gm-Message-State: AOAM531TX99kiWSb0jVRQnMdOvGc1eBlvV3RMub0h27r81RTb2HNYakj
        KCwXYG3ehZ/ZLs6XfsZ41Lo=
X-Google-Smtp-Source: ABdhPJxZQxxiy5LAXdAV4hS4QpVEOHy5t7E5ywX3rL/+Y+91QczFpfbcHFeLKck7gdk5BsqKrSGhNQ==
X-Received: by 2002:a05:6402:348c:: with SMTP id v12mr31377545edc.86.1624865676883;
        Mon, 28 Jun 2021 00:34:36 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id de33sm6432089ejc.38.2021.06.28.00.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:34:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 09:34:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mm change for v5.14
Message-ID: <YNl7ihyyWXDascmK@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2021-06-28

   # HEAD: 314a1e1eabea5b86532e90e0d4e217fa88471e3b x86/pkeys: Skip 'init_pkru' debugfs file creation when pkeys not supported

Do not create the x86/init_pkru debugfs file if the CPU doesn't support PKRU.

 Thanks,

	Ingo

------------------>
Dave Hansen (1):
      x86/pkeys: Skip 'init_pkru' debugfs file creation when pkeys not supported


 arch/x86/mm/pkeys.c | 4 ++++
 1 file changed, 4 insertions(+)
