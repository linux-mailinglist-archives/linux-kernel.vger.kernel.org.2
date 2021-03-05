Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E6132E71E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCELRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:17:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:21668 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhCELQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:16:57 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DsQDP6krLz9txfD;
        Fri,  5 Mar 2021 12:16:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IaumhEy4LJKR; Fri,  5 Mar 2021 12:16:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DsQDP5NzTz9txf7;
        Fri,  5 Mar 2021 12:16:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0909B8B81F;
        Fri,  5 Mar 2021 12:16:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ahQmwKGZx4cI; Fri,  5 Mar 2021 12:16:54 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A0DF8B78B;
        Fri,  5 Mar 2021 12:16:54 +0100 (CET)
Subject: Re: Build regressions/improvements in v5.12-rc1
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20210301104316.2766484-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2103011342520.710098@ramsan.of.borg>
 <CADnq5_O-j8EWL+Eb8zK-7WqUuWKWETVWYRQNFdS_ymUSgo1jrg@mail.gmail.com>
 <CAMuHMdVFstnce-WKmj=4h3ZdtSThJNOLz_f1ervcZxE6hg=KsA@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <09155bb0-4403-bcde-239f-eae4067953ca@csgroup.eu>
Date:   Fri, 5 Mar 2021 12:16:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVFstnce-WKmj=4h3ZdtSThJNOLz_f1ervcZxE6hg=KsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/03/2021 à 21:01, Geert Uytterhoeven a écrit :
> Hi Alex,
> 
> On Tue, Mar 2, 2021 at 8:30 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Mon, Mar 1, 2021 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Mon, 1 Mar 2021, Geert Uytterhoeven wrote:
>>>> Below is the list of build error/warning regressions/improvements in
>>>> v5.12-rc1[1] compared to v5.11[2].
>>>>
>>>> Summarized:
>>>>   - build errors: +2/-0
>>>
>>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8/ (all 192 configs)
>>>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f40ddce88593482919761f74910f42f4b84c004b/ (all 192 configs)
>>>>
>>>>
>>>> *** ERRORS ***
>>>>
>>>> 2 error regressions:
>>>>   + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 674:2
>>>>   + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 638:2
>>>
>>> powerpc-gcc4.9/ppc64_book3e_allmodconfig
>>>
>>> This was fixed in v5.11-rc1, but reappeared in v5.12-rc1?
>>
>> Do you know what fixed in for 5.11?  I guess for PPC64 we depend on CONFIG_VSX?
> 
> Looking at the kisskb build logs for v5.11*, it seems compilation never
> got to drivers/gpu/drm/ due to internal compiler errors that weren't caught
> by my scripts.  So the errors listed above were not really fixed.
> 

As far as I can see, the problem has been there for any config without CONFIG_VSX from the beginning 
ie since https://github.com/linuxppc/linux/commit/16a9dea110a6

The following should fix it up:

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index fdab93428372..9d1fbd8be1c7 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -71,6 +71,16 @@ static inline void disable_kernel_vsx(void)
  {
  	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
  }
+#else
+static inline void enable_kernel_vsx(void)
+{
+	BUILD_BUG();
+}
+
+static inline void disable_kernel_vsx(void)
+{
+	BUILD_BUG();
+}
  #endif

  #ifdef CONFIG_SPE
---
Christophe
Christophe
