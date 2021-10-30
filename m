Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4AC44077D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 06:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhJ3EtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 00:49:03 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:38859 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhJ3EtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 00:49:01 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Hh6Fc6J51z9sST;
        Sat, 30 Oct 2021 06:46:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n86lCrBIDXgC; Sat, 30 Oct 2021 06:46:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Hh6Fc5JQhz9sSM;
        Sat, 30 Oct 2021 06:46:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D2628B768;
        Sat, 30 Oct 2021 06:46:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id S1NDqDmCduDo; Sat, 30 Oct 2021 06:46:28 +0200 (CEST)
Received: from [192.168.233.13] (unknown [192.168.233.13])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 427A28B763;
        Sat, 30 Oct 2021 06:46:28 +0200 (CEST)
Message-ID: <064efc28-eb86-b729-0bb0-b1f5ed5bbf60@csgroup.eu>
Date:   Sat, 30 Oct 2021 06:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 1/1] soc: fsl: Replace kernel.h with the necessary
 inclusions
Content-Language: fr-FR
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
References: <20211027153354.81129-1-andriy.shevchenko@linux.intel.com>
 <YXwZihLk1njsBNT4@smile.fi.intel.com>
 <c0524c86-fc7e-632a-8b2a-862695529115@csgroup.eu>
 <CAHp75VeB8Dmr6Hrupb1Hj=D=oG1zPyJrhCXu37QtXHNNKdNvZg@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <CAHp75VeB8Dmr6Hrupb1Hj=D=oG1zPyJrhCXu37QtXHNNKdNvZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 29/10/2021 à 22:31, Andy Shevchenko a écrit :
> On Fri, Oct 29, 2021 at 10:04 PM LEROY Christophe
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>>
>> Le 29/10/2021 à 17:55, Andy Shevchenko a écrit :
>>> On Wed, Oct 27, 2021 at 06:33:54PM +0300, Andy Shevchenko wrote:
>>>> When kernel.h is used in the headers it adds a lot into dependency hell,
>>>> especially when there are circular dependencies are involved.
>>>>
>>>> Replace kernel.h inclusion with the list of what is really being used.
>>>
>>> Seems nobody from PPC took this patch.
>>> Any idea who can take it?
>>>
>>
>> You have to check in MAINTAINERS file in the root directory of kernel
>> sources: https://github.com/linuxppc/linux/blob/master/MAINTAINERS
> 
> Actually for these files get_maintainer.pl showed nothing.
> I have chosen PPC maintainers manually.
> 
>> That's Michael who takes them. But you have to allow him enough time for it.
> 
> Thanks!
> 
> I wrote that message because I have got a notification from checkpatch
> that it should go somewhere else.
> 

That means that Michael considered it is not for him.

And I think the reason is that in MAINTAINERS you have:

FREESCALE QUICC ENGINE LIBRARY
M:	Qiang Zhao <qiang.zhao@nxp.com>
L:	linuxppc-dev@lists.ozlabs.org
S:	Maintained
F:	drivers/soc/fsl/qe/
F:	include/soc/fsl/*qe*.h
F:	include/soc/fsl/*ucc*.h


FREESCALE SOC DRIVERS
M:	Li Yang <leoyang.li@nxp.com>
L:	linuxppc-dev@lists.ozlabs.org
L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:	Maintained
F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
F:	Documentation/devicetree/bindings/soc/fsl/
F:	drivers/soc/fsl/
F:	include/linux/fsl/

Sorry I overlooked your patch.

Christophe
