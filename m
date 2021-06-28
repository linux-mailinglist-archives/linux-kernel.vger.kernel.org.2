Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DFE3B59B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhF1H1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1H1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:27:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC96C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:24:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i24so24314432edx.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jVNTSHzyPdwPKJpT8dlRef55eBUHyowQ9V2IpIhGGgY=;
        b=g+iVFERxlAsLxxqdruLIIhyxZMVntswNHCeDhafy2aDICYspsBfw/1V3sGm+n/GSR3
         FXh9lB41R0FdPVcj6bikEgTDast/N/IdTMJjdWLIrdKeWgJKpAtXGyTJZX6bnbVTUzJo
         v8xFySlvgaz+MULxEQeHyugMQ8DWh29ggvckG/2reeT0v8gkgreHcwAjsbnRv0zlrTEY
         OK3WDWVAbL8y+sOV4LvaLDWnV5Jtc9MdNQqzg4RNiLuHlZqV78hvLfoXA7CtVLXcyB+9
         A5o2W9fYyz5gzfE1cmpDKtW+RxbYycbJUmrh9fS3/6D1/Bv1rQZ7k83dZMwU8VebkzWU
         Q32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=jVNTSHzyPdwPKJpT8dlRef55eBUHyowQ9V2IpIhGGgY=;
        b=h9NutKXnFEVj3I1+yOCLKOAwoYWtW1bfUvInsnI/GQitnjW6mTm9x0ubzuM0adkc+7
         bIK4HaTOuEzXyqHrsZ3ZWCSwtrieGvXX+B1Mah1zYmpP1zXrsOoqH783OSXqGR5fX5cg
         Al2DqhvbCrGIFHXhV145WM5bg6UHjXzbIq7qfLhHAeSSwHMqkVQqMJQV09JH7wtyZV2A
         vyotgR/UI8ViszdAJIa7GYvPfxfGWD1+gj5QKR/IDiayvS7XNvonEVVVqpsMC6KjYNBQ
         0FMLyZloweaLKUmxUKd4uoZEzEhNeuJkH9H5VyqPWi7PbWezRG4AkW1PbI6cfR7Y1vlX
         AA1g==
X-Gm-Message-State: AOAM532F+bOyk1TsXX4AfPGtRhJ+lCAEfg69Dcdfnq50kKThGec+MRsK
        gp14gEOn1sLK1Wx3iDCLhw0E0DwrNnc=
X-Google-Smtp-Source: ABdhPJyCGY/SjEEbkRgy2XgcV4ckxoNVUq7fhc/DzkxzyFcnTmDS5yL/zTq/Ut8G7Fa0RyhxPCvIpw==
X-Received: by 2002:a05:6402:501:: with SMTP id m1mr31259514edv.163.1624865095433;
        Mon, 28 Jun 2021 00:24:55 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id ec24sm9217724edb.74.2021.06.28.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:24:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 09:24:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot change for v5.14
Message-ID: <YNl5RRO5PSlokM+G@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/boot git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2021-06-28

   # HEAD: f279b49f13bd2151bbe402a1d812c1e3646c4bbb x86/boot: Modernize genimage script; hdimage+EFI support

Modernize the genimage.sh script, add a 'hdimage' target and EFI support.

 Thanks,

	Ingo

------------------>
H. Peter Anvin (Intel) (1):
      x86/boot: Modernize genimage script; hdimage+EFI support


 arch/x86/Makefile            |   5 +-
 arch/x86/boot/.gitignore     |   1 +
 arch/x86/boot/Makefile       |  44 ++++---
 arch/x86/boot/genimage.sh    | 303 +++++++++++++++++++++++++++++++------------
 arch/x86/boot/mtools.conf.in |   3 +
 5 files changed, 252 insertions(+), 104 deletions(-)
