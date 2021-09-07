Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182DE4030A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347456AbhIGWBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:01:54 -0400
Received: from home.keithp.com ([63.227.221.253]:56072 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344772AbhIGWBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:01:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 8839D3F30869;
        Tue,  7 Sep 2021 15:00:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id D1flVso7MpDe; Tue,  7 Sep 2021 15:00:19 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id D3EF03F30864;
        Tue,  7 Sep 2021 15:00:18 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
        id CACEA1E6011A; Tue,  7 Sep 2021 15:00:40 -0700 (PDT)
From:   Keith Packard <keithpac@amazon.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <linux@armlinux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: [PATCH 0/7] ARM: support THREAD_INFO_IN_TASK (v3)
Date:   Tue,  7 Sep 2021 15:00:31 -0700
Message-Id: <20210907220038.91021-1-keithpac@amazon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904060908.1310204-1-keithp@keithp.com>
References: <20210904060908.1310204-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Placing thread_info in the kernel stack leaves it vulnerable to stack
overflow attacks. This short series addresses that by using the
existing THREAD_INFO_IN_TASK infrastructure.

This is the third version of this series, in this version the changes
are restricted to hardware which provides the TPIDRPRW register. This
register is repurposed from holding the per_cpu_offset value to
holding the 'current' value as that allows fetching this value
atomically so that it can be used in a preemptable context.

The series is broken into seven pieces:

 1) Change the secondary_start_kernel API to receive the cpu
    number. This avoids needing to be able to find this value independently in
    future patches.

 2) Change the secondary_start_kernel API to also receive the 'task'
    value. Passing the value to this function also avoids needing to
    be able to discover it independently.

 3) A cleanup which avoids assuming that THREAD_INFO_IN_TASK is not set.

 4) A hack, borrowed from the powerpc arch, which allows locating the 'cpu'
    field in either thread_info or task_struct, without requiring linux/sched.h
    to be included in asm/smp.h

 5) Disable the optimization storing per_cpu_offset in TPIDRPRW. This leaves
    the register free to hold 'current' instead.

 6) Use TPIDRPRW for 'current'. This is enabled for either CPU_V6K or CPU_V7,
    but not if CPU_V6 is also enabled.

 7) Enable THREAD_INFO_IN_TASK whenever TPIDRPRW is used to hold 'current'.

Signed-off-by: Keith Packard <keithpac@amazon.com>


