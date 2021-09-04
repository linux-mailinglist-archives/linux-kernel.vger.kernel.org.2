Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC94009FD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 08:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhIDGKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 02:10:17 -0400
Received: from home.keithp.com ([63.227.221.253]:36028 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhIDGKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 02:10:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 132B93F30826;
        Fri,  3 Sep 2021 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630735729; bh=TiBQjRhgDSbNjx047iON2OqbTV5dVpsECJ5EVpXAQx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdC4AZMs592lphtlw4x0KzeVVCLMQIJ+eBX9QPBdPbCCQii4OWQ7EzMMq4vfrE+TR
         XUzhJ06rr2GW1hTq01825KsIln9+kJnDijL0OGHXXZLdYVa7WXO772uHsmeC5exkHe
         YWVMVHKkvmKGJwaQ8Mhz9UDfzXx0jjMMl8vA7wmO52w7LdsU+y81fRuQfGsnI1pAd2
         1X6SU6Q6gL7C0lIX2RhwR+hJeVqI9UgR698x+fgJoX5Hg63xZrtdTQyKGZiiLZGNZm
         wuVO8Rb8LvkFKQyqhLIgW2ZsUihCclq3ti3oXaOj/g01HzhhWKHQeDjjjjDQHOxa+7
         eOYWCc+n2A5SA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id d4vRelaLlD2U; Fri,  3 Sep 2021 23:08:48 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 670813F30823;
        Fri,  3 Sep 2021 23:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630735728; bh=TiBQjRhgDSbNjx047iON2OqbTV5dVpsECJ5EVpXAQx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dp8zjbvLOiyFLpBahF7z3Sv1YeCcWsU52OuLP1wDBt1ymSAxt6+PvAjRHhXyvV7Xg
         41YStC+dh+p2UE2qdy9s/BbuXYq9pC1Acov8e4yTOEQvcG0kXrMDQ/BFolB7pGv8gQ
         /5HHqkxLDSijeigkem2ISW+jBOYnLfWa2J7DaZYD+kJtihraAsnIKxCJ5AJTYFhQMx
         OtVoQOorkaUWiypXnixuSEG9ZZei9pVO/hw8HW7V92+hjBVhzay8s/SxrlVJ7Fg8BW
         yc7EQ+VZm0fv9sCjGxVVpn7a7C+bxHz1Ar66Mxo6F3MFZLD7me9ODG5CI1iLGvYa5O
         heewzlx9InG5A==
Received: by keithp.com (Postfix, from userid 1000)
        id 765121E6013A; Fri,  3 Sep 2021 23:09:10 -0700 (PDT)
From:   Keith Packard <keithp@keithp.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
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
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithp@keithp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>
Subject: [PATCH 0/2] ARM: support THREAD_INFO_IN_TASK (v7 only) (v2)
Date:   Fri,  3 Sep 2021 23:09:05 -0700
Message-Id: <20210904060908.1310204-1-keithp@keithp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902155429.3987201-1-keithp@keithp.com>
References: <20210902155429.3987201-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Placing thread_info in the kernel stack leaves it vulnerable to stack
overflow attacks. This short series addresses that by using the
existing THREAD_INFO_IN_TASK infrastructure.

This is the second version of this series, in this version the changes
are restricted to v7 hardware which offers a way to identify each cpu
in the system without reference to the stack it is using.

The series is broken into three pieces:

 1) Change the secondary_start_kernel API to pass the cpu number to
    this function. This is required for the following patch because the
    raw_smp_processor_id() macro will use the per_cpu_offset value which
    needs to have the cpu number to get the right value.

 2) Enable THREAD_INFO_IN_TASK by creating a new per-cpu variable,
    current_task, just like the x86 architecture. The largest changes
    are in the assembly code where fetching the current_task value
    requires a temporary register. Fortunately, each location in the
    code performing this had a reasonably obvious register to use.

 3) Optimize access to the cpu number using another new per-cpu
    variable. This is not functionally necessary, but avoids
    de-referencing through two pointers at modest memory cost.

Signed-off-by: Keith Packard <keithpac@amazon.com>


