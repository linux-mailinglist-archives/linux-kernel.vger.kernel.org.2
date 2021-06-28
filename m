Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5AF3B59BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhF1H3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhF1H3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:29:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:27:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gn32so28295178ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=a+4k979hwEQ5keQJzjtrHb7TuJ3bMTFj9cOz5LXkkRE=;
        b=PsG5jVygJM7DY8o5iCbty5Yo8PLTA8IDbnCkxRNV9h+C/4yAvsa5tBHuRRPOFhzTgg
         xVI53sUJQ77ijSrwKFz/wPSkmtvMY+BO8gDn5QpqVePdOltsQgsXRphTnP73Hx+ZzeaW
         yYJAVZz+Xhxhljl9Qq4icqzRALkT7IH29BBJWVLyd0rdY7ALaXOC8SllQVRvC0hGhQ+W
         5VNgp4W6DPpws2OZD3xQHPjSPRtd6jwW0KjkzFsa29IXbqkqjIiAczBMDTliVmoZx0Ix
         9eS94YrzjPMgE3pVAdN+4BUUD06NKNh2ShtsRiKbBcLFVkK/IseUO63SACtmdD/ERSqT
         jaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=a+4k979hwEQ5keQJzjtrHb7TuJ3bMTFj9cOz5LXkkRE=;
        b=PRGAUunWyRy1Cb9aiqquAdQjxMDLpDs9iTjMBuvggHKnU4fmsnSjz/QCeyBO0nu5mW
         JRDrmRBPkehQyNxw2sYRYjYU0wWQ28M3orjnCcrrVVh0hAmBHHkjo1Y0aywnPgYvrdHH
         kJ7Nw3feUaR3dZyIYm9Leen7kIMZcBgD3H2lxFJ7fXsXl/6uqrSBEks9Q/GKDfPaZiK2
         FXDexfuWTIuEnhw/Mu6RqEByLgKYGZ3ArIv3EKEM/HDZjIhNTFlfLOIlhCslWDmlWTGR
         eUEbLODo2PRBO7HbY24NbjqQKDzq0Xx4s7Ng5PhbhOMFduR61AA6Ulw63J5UltrjM5Jj
         C/Vg==
X-Gm-Message-State: AOAM532WIBz9yZFfEOuesN77dimgHUL+aivOyY22n4488nDJ9Mhp1FvD
        +QB3W+YbigpDEEnvnuq4Ogg=
X-Google-Smtp-Source: ABdhPJzrdvHKUZPJdBtrEGHRL3rw1U3H0TKkIWhCW7ZnSD+xzVHh4Q6d3YjA4tW1KPxA5JWtON144w==
X-Received: by 2002:a17:906:d83:: with SMTP id m3mr22998158eji.63.1624865225228;
        Mon, 28 Jun 2021 00:27:05 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id h20sm6232930ejl.7.2021.06.28.00.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:27:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 09:27:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cache changes for v5.14
Message-ID: <YNl5x+NnCqi5DyG6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/cache git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-2021-06-28

   # HEAD: fd2afa70eff057fab57c9e06708b68677b261a0c x86/resctrl: Fix kernel-doc in internal.h

Fix Docbook comments in the x86/resctrl code.

 Thanks,

	Ingo

------------------>
Fabio M. De Francesco (2):
      x86/resctrl: Fix kernel-doc in pseudo_lock.c
      x86/resctrl: Fix kernel-doc in internal.h


 arch/x86/kernel/cpu/resctrl/internal.h    | 21 ++++++++++++++-------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 10 ++++++++--
 2 files changed, 22 insertions(+), 9 deletions(-)
