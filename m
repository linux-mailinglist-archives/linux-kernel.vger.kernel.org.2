Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062EE3FF08D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbhIBP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:56:08 -0400
Received: from home.keithp.com ([63.227.221.253]:52816 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345955AbhIBP4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:56:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 6A8823F30801;
        Thu,  2 Sep 2021 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630598084; bh=dTnEhfSTBX1r8HQRdASbu+0ew3HA1uG32vI5yfvrYOU=;
        h=From:To:Cc:Subject:Date:From;
        b=Fshb7aOUXYGYWtoWGvIzDahlAk+/ivJr5kBq4gPx5mekIKJ8dgcKaB3lIfOWnH3wf
         48gDxehdjOZ4r+2jEC7mDZ+ge4YzqwjINJHraD1snnzXQ/WMR6eOyXPXdbyyKz9vD7
         KLyOi78NjORQN0Nzi4llTYlU4M7UV0GNzGOsHR9w4tD4VuYXB8WqVgYIrYZ3G4z9w9
         qTK+p1wPpZX6juAUpqxuJpAVmnz7Ad7q0x51PEGdZcLIUYwnKwSMBp1nwdyuAEzUv1
         eauwn/KOspdGs1A//x4v+tXiqocWMPGozmeZ2u1yHch39JiQjx7JqELILCRakR69UU
         zzqh3BzjhHGBg==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dAK48ukwV8WB; Thu,  2 Sep 2021 08:54:39 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 7E8B63F30802;
        Thu,  2 Sep 2021 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630598079; bh=dTnEhfSTBX1r8HQRdASbu+0ew3HA1uG32vI5yfvrYOU=;
        h=From:To:Cc:Subject:Date:From;
        b=YDuLIzr5QMdZkKv1Oyn80Ntd52B+R9e0Z/GbRtJtDR6TF+DNHYMaAMcDUhTeQfuis
         t/pUkToDhV4+gzmXHPdpmAVrmd4I+htPHC8S373H2FAEeuyykVVXvRiCtqCo7TRn4b
         nrcqy0HpQ4b0qMVjhj/zJ3ZpQWTTQcynESuU84dIat29BB7450Z/TckCtdRULBVl/i
         QxX5ZqVCWwSZmaeEIPcq3UtG3ERBGchsyXiaI3rNMs2Wmiy00Q9tuCWobyEvW71Pe+
         8tS9/bV9rb9xBwP9AR655SbW7KHcILklRXWQMiGkE4oiiWprk44FuCUbZf1n81e7YJ
         FS5M7iegcpODg==
Received: by keithp.com (Postfix, from userid 1000)
        id A92811E60119; Thu,  2 Sep 2021 08:55:01 -0700 (PDT)
From:   Keith Packard <keithp@keithp.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Keith Packard <keithp@keithp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>
Subject: [PATCH 0/2]: ARM: Enable THREAD_INFO_IN_TASK
Date:   Thu,  2 Sep 2021 08:54:26 -0700
Message-Id: <20210902155429.3987201-1-keithp@keithp.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Placing thread_info in the kernel stack leaves it vulnerable to stack
overflow attacks. This short series addresses that by using the
existing THREAD_INFO_IN_TASK infrastructure.

As this is my first patch in this part of the kernel, I'm looking for
feedback about the general approach as well as specific comments on
places where I've missed something.

I've only run this on armhf running under qemu, so while I've tried to
make patches for other code paths, I haven't been able to test those.

(yes, I know checkpatch.pl complains about whitespace in asm-offsets.c, I
decided to leave the existing whitespace alone)

Signed-off-by: Keith Packard <keithpac@amazon.com>

