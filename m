Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63C932A8E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580375AbhCBSCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:02:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:58389 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1575656AbhCBPYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:24:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dqghb2Clsz9v0tm;
        Tue,  2 Mar 2021 16:16:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id o6ue3sntJFXZ; Tue,  2 Mar 2021 16:16:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dqghb193vz9v0td;
        Tue,  2 Mar 2021 16:16:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 75B788B7B5;
        Tue,  2 Mar 2021 16:16:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NJiP_PO3SpRK; Tue,  2 Mar 2021 16:16:48 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B32E8B75F;
        Tue,  2 Mar 2021 16:16:47 +0100 (CET)
Subject: Re: [PATCH 0/2] Fix CMDLINE_EXTEND handling for FDT "bootargs"
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Daniel Walker <danielwa@cisco.com>, devicetree@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Doug Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Max Uvarov <muvarov@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20210225125921.13147-1-will@kernel.org>
 <CAL_JsqJX=TCCs7=gg486r9TN4NYscMTCLNfqJF9crskKPq-bTg@mail.gmail.com>
 <20210301144153.GA16716@willie-the-truck>
 <CAL_JsqJ11D-7a3pwLTVd+rHjqDGBb=b8OU_a6h3Co-at+2qMtQ@mail.gmail.com>
 <bbbf5def-a168-9a4c-1106-b80883dfd389@csgroup.eu>
 <CAL_Jsq+Te5+kQzbAMCzuRCkmoZWBDKGhynUC8BfvOm=R5jT4Jg@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <fe4de021-6bc6-577c-858e-8c79a5ec2340@csgroup.eu>
Date:   Tue, 2 Mar 2021 16:16:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+Te5+kQzbAMCzuRCkmoZWBDKGhynUC8BfvOm=R5jT4Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/03/2021 à 15:56, Rob Herring a écrit :
> On Mon, Mar 1, 2021 at 11:45 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>>
>> Le 01/03/2021 à 18:26, Rob Herring a écrit :
>>> +PPC folks and Daniel W
>>>
>>> On Mon, Mar 1, 2021 at 8:42 AM Will Deacon <will@kernel.org> wrote:
>>>>
>>>> On Mon, Mar 01, 2021 at 08:19:32AM -0600, Rob Herring wrote:
>>>>> On Thu, Feb 25, 2021 at 6:59 AM Will Deacon <will@kernel.org> wrote:
>>>>>> We recently [1] enabled support for CMDLINE_EXTEND on arm64, however
>>>>>> when I started looking at replacing Android's out-of-tree implementation [2]
>>>>>
>>>>> Did anyone go read the common, reworked version of all this I
>>>>> referenced that supports prepend and append. Here it is again[1].
>>>>> Maybe I should have been more assertive there and said 'extend' is
>>>>> ambiguous.
>>>>
>>>> I tried reading that, but (a) most of the series is not in the mailing list
>>>> archives and (b) the patch that _is_ doesn't touch CMDLINE_EXTEND at all.
>>>> Right now the code in mainline does the opposite of what it's documented to
>>>> do.
>>>
>>> Actually, there is a newer version I found:
>>>
>>> https://lore.kernel.org/linuxppc-dev/1551469472-53043-1-git-send-email-danielwa@cisco.com/
>>> https://lore.kernel.org/linuxppc-dev/1551469472-53043-2-git-send-email-danielwa@cisco.com/
>>> https://lore.kernel.org/linuxppc-dev/1551469472-53043-3-git-send-email-danielwa@cisco.com/
>>
>> This was seen as too much intrusive into powerpc.
> 
> It looked like the main issue was string functions for KASAN?

This is one issue yes,

> 
> As far as being too complex, I think that will be needed if you look
> at all architectures and non-DT cases.

As far as I remember, I could't understand why we absolutely need to define the command line string 
in the common part of the code, leading to being obliged to use macros in order to allow the 
architecture to specify in which section it wants the string.

Why not leave the definition of the string to the architecture and just declare it in the common 
code, allowing the architecture to put it where it suits it and reducing opacity and allowing use of 
standard static inline functions instead of uggly macros.


> 
>> I proposed an alternative at
>> https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1554195798.git.christophe.leroy@c-s.fr/ but
>> never got any feedback.
> 
> Didn't go to a list I subscribe to. In particular, if it had gone to
> DT list and into PW you would have gotten a reply from me.
> 

Sorry for that. Original series from Daniel 
(https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20190319232448.45964-2-danielwa@cisco.com/) 
was sent only to linuxppc-dev list, and Michael suggested to also send it to linux-arch list, and I 
also always copy linux-kernel.

If there is new interest for that functionnality, I can try and rebase my series.

Christophe
