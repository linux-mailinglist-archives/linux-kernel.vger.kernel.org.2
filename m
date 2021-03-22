Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083C934475E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhCVOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:33:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43038 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCVOc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F3xmf1Jcpz9tyhT;
        Mon, 22 Mar 2021 15:32:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ddg49OyYyGfy; Mon, 22 Mar 2021 15:32:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F3xmd5qZNz9tyhR;
        Mon, 22 Mar 2021 15:32:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1785C8B79F;
        Mon, 22 Mar 2021 15:32:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6Tx7BT7WTY9N; Mon, 22 Mar 2021 15:32:54 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E4318B79C;
        Mon, 22 Mar 2021 15:32:54 +0100 (CET)
Subject: Re: [PATCH v11 0/6] KASAN for powerpc64 radix
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
References: <20210319144058.772525-1-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5a3b5952-b31f-42bf-eaf4-ea24444f8df6@csgroup.eu>
Date:   Mon, 22 Mar 2021 15:32:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319144058.772525-1-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/03/2021 à 15:40, Daniel Axtens a écrit :
> Building on the work of Christophe, Aneesh and Balbir, I've ported
> KASAN to 64-bit Book3S kernels running on the Radix MMU.
> 
> v11 applies to next-20210317. I had hoped to have it apply to
> powerpc/next but once again there are changes in the kasan core that
> clash. Also, thanks to mpe for fixing a build break with KASAN off.
> 
> I'm not sure how best to progress this towards actually being merged
> when it has impacts across subsystems. I'd appreciate any input. Maybe
> the first four patches could go in via the kasan tree, that should
> make things easier for powerpc in a future cycle?
> 
> v10 rebases on top of next-20210125, fixing things up to work on top
> of the latest changes, and fixing some review comments from
> Christophe. I have tested host and guest with 64k pages for this spin.
> 
> There is now only 1 failing KUnit test: kasan_global_oob - gcc puts
> the ASAN init code in a section called '.init_array'. Powerpc64 module
> loading code goes through and _renames_ any section beginning with
> '.init' to begin with '_init' in order to avoid some complexities
> around our 24-bit indirect jumps. This means it renames '.init_array'
> to '_init_array', and the generic module loading code then fails to
> recognise the section as a constructor and thus doesn't run it. This
> hack dates back to 2003 and so I'm not going to try to unpick it in
> this series. (I suspect this may have previously worked if the code
> ended up in .ctors rather than .init_array but I don't keep my old
> binaries around so I have no real way of checking.)
> 
> (The previously failing stack tests are now skipped due to more
> accurate configuration settings.)
> 
> Details from v9: This is a significant reworking of the previous
> versions. Instead of the previous approach which supported inline
> instrumentation, this series provides only outline instrumentation.
> 
> To get around the problem of accessing the shadow region inside code we run
> with translations off (in 'real mode'), we we restrict checking to when
> translations are enabled. This is done via a new hook in the kasan core and
> by excluding larger quantites of arch code from instrumentation. The upside
> is that we no longer require that you be able to specify the amount of
> physically contiguous memory on the system at compile time. Hopefully this
> is a better trade-off. More details in patch 6.
> 
> kexec works. Both 64k and 4k pages work. Running as a KVM host works, but
> nothing in arch/powerpc/kvm is instrumented. It's also potentially a bit
> fragile - if any real mode code paths call out to instrumented code, things
> will go boom.
> 

In the discussion we had long time ago, 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20190806233827.16454-5-dja@axtens.net/#2321067 
, I challenged you on why it was not possible to implement things the same way as other 
architectures, in extenso with an early mapping.

Your first answer was that too many things were done in real mode at startup. After some discussion 
you said that finally there was not that much things at startup but the issue was KVM.

Now you say that instrumentation on KVM is fully disabled.

So my question is, if KVM is not a problem anymore, why not go the standard way with an early shadow 
? Then you could also support inline instrumentation.

Christophe
