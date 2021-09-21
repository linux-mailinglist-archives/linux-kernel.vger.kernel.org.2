Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183004133FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhIUNZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhIUNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:25:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:24:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k23so14396892pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=wQuO8izXOG9jisgArSNnzAfoi7ywDch/eMphXmwo30s=;
        b=i1jSkmGnMkevvu9xk+mg9I+kzvRGylUKLX72O5ED1bwMYAWFjErFIZ0+RfQ/LGqmRT
         DxnagITP+RUe4/z5sGB9VKt9Vl/r60h++1Rt0fMEeiva62IWkPwVzDT7PmoZkNXVZc8Z
         ednx1gzrikLIyyM0+6pVECLtUsGNp4o6Da71g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=wQuO8izXOG9jisgArSNnzAfoi7ywDch/eMphXmwo30s=;
        b=BjsoHvmnD5bUuK2z+P6Gq2C7rR/jzcufxcjPg+0mRQbnbz5FrlNK5yfYVPzMozOE7i
         J5NzEY6yGpbS23zSQe16D0M8B0r2EapQ15xiuQiEgxkuhj8c1Yf3wVJ9Axq7yMt40uvL
         E7Z7JxD39yKkYYQeptfChD3AHQK5Gy0uvsPnjGSMKtLuDaFt83AReyrGMoqzWuRdvbV6
         7sGteEOlQoulvK/Xf3TNaQ4/xIZeRHdkuGlgP7PCWpNneF4sygg0GKrtdiND49jISVPx
         +n2BL6txjP+PlhxTMxPkz2MfTu53yydO2cAgUNdDBVYrvaYXSFnITCXRS1oPe9dL7uuK
         z8Pg==
X-Gm-Message-State: AOAM532DmtaMgtZiU3ILFRsQj6Tr4VeOSFE9wQYRfXpuiJIu1+eW0fTK
        f0aR4fNM8KJUXOdv8VZk1MsIlw==
X-Google-Smtp-Source: ABdhPJzWlL8NPpTebYeQFS56lBAbian1tn2314S/VwRtwFn3x+s8W1oTPw93XD/74aRaACOe/jDWUg==
X-Received: by 2002:a17:90b:1b0b:: with SMTP id nu11mr5327709pjb.74.1632230650798;
        Tue, 21 Sep 2021 06:24:10 -0700 (PDT)
Received: from [127.0.0.1] (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x13sm17520273pff.70.2021.09.21.06.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 06:24:10 -0700 (PDT)
Date:   Tue, 21 Sep 2021 06:24:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     sxwjean@me.com, x86@kernel.org, linux-mm@kvack.org
CC:     Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Balbir Singh <sblbir@amazon.com>, Jens Axboe <axboe@kernel.dk>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Metzmacher <metze@samba.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Use_generic_code_for_v?= =?US-ASCII?Q?irtual_address_of_randomization_of_x86?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20210921110252.2593542-1-sxwjean@me.com>
References: <20210921110252.2593542-1-sxwjean@me.com>
Message-ID: <4EB3D825-264D-447A-8C55-FA0CE8BC31F6@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 21, 2021 4:02:50 AM PDT, sxwjean@me=2Ecom wrote:
>From: Xiongwei Song <sxwjean@gmail=2Ecom>
>
>Hello,
>
>The two patches are to use generic code for randomization of virtual
>address of x86=2E Since the basic code logic of x86 is same as generic
>code, so no need to implement these functions on x86, please see the
>details in comments of patch 2=2E

Hi!

The other patches do not seem to have arrived; I only see 0/2=2E

-Kees

>
>Please review it=2E
>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@redhat=2Ecom>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>Cc: Andy Lutomirski <luto@kernel=2Eorg>
>Cc: Gabriel Krisman Bertazi <krisman@collabora=2Ecom>
>Cc: "Chang S=2E Bae" <chang=2Eseok=2Ebae@intel=2Ecom>
>Cc: Al Viro <viro@zeniv=2Elinux=2Eorg=2Euk>
>Cc: Arvind Sankar <nivedita@alum=2Emit=2Eedu>
>Cc: Alexey Dobriyan <adobriyan@gmail=2Ecom>
>Cc: Oleg Nesterov <oleg@redhat=2Ecom>
>Cc: Balbir Singh <sblbir@amazon=2Ecom>
>Cc: Jens Axboe <axboe@kernel=2Edk>
>Cc: Lai Jiangshan <laijs@linux=2Ealibaba=2Ecom>
>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Cc: Peter Zijlstra <peterz@infradead=2Eorg>
>Cc: Andrew Morton <akpm@linux-foundation=2Eorg>
>Cc: Arnd Bergmann <arnd@arndb=2Ede>
>Cc: "David S=2E Miller" <davem@davemloft=2Enet>
>Cc: Kees Cook <keescook@chromium=2Eorg>
>Cc: Kim Phillips <kim=2Ephillips@amd=2Ecom>
>Cc: Yazen Ghannam <yazen=2Eghannam@amd=2Ecom>
>Cc: Davidlohr Bueso <dave@stgolabs=2Enet>
>Cc: Stefan Metzmacher <metze@samba=2Eorg>
>Cc: Marco Elver <elver@google=2Ecom>
>Cc: "Eric W=2E Biederman" <ebiederm@xmission=2Ecom>
>Cc: Christophe Leroy <christophe=2Eleroy@csgroup=2Eeu>
>Cc: linux-kernel@vger=2Ekernel=2Eorg
>
>Xiongwei Song (2):
>  x86: Rename TIF_ADDR32 to TIF_32BIT
>  x86/mm: Randomize va with generic arch_pick_mmap_layout()
>
> arch/x86/Kconfig                     |   2 +-
> arch/x86/include/asm/compat=2Eh        |   7 +-
> arch/x86/include/asm/elf=2Eh           |   2 +-
> arch/x86/include/asm/page_64_types=2Eh |   6 +-
> arch/x86/include/asm/processor=2Eh     |   4 +-
> arch/x86/include/asm/thread_info=2Eh   |   4 +-
> arch/x86/kernel/process=2Ec            |   5 --
> arch/x86/kernel/process_64=2Ec         |   4 +-
> arch/x86/mm/mmap=2Ec                   | 112 ---------------------------
> include/linux/compat=2Eh               |   4 +
> mm/util=2Ec                            |  18 ++++-
> 11 files changed, 37 insertions(+), 131 deletions(-)
>
