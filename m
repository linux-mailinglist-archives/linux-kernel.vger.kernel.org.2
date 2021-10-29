Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8575E4402C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhJ2TF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:05:29 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:53451 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhJ2TF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:05:28 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HgsJL195Cz9sSd;
        Fri, 29 Oct 2021 21:02:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lmmftEZponZG; Fri, 29 Oct 2021 21:02:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HgsJL0PdJz9sSb;
        Fri, 29 Oct 2021 21:02:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EEF368B78C;
        Fri, 29 Oct 2021 21:02:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RTaeov4xe8Tj; Fri, 29 Oct 2021 21:02:57 +0200 (CEST)
Received: from [192.168.233.12] (unknown [192.168.233.12])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A19E18B763;
        Fri, 29 Oct 2021 21:02:57 +0200 (CEST)
Message-ID: <233e9abd-0b50-9a55-c10d-d0b536ac2dde@csgroup.eu>
Date:   Fri, 29 Oct 2021 21:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/1] soc: fsl: Replace kernel.h with the necessary
 inclusions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>
References: <20211027153354.81129-1-andriy.shevchenko@linux.intel.com>
 <YXwZihLk1njsBNT4@smile.fi.intel.com>
Content-Language: fr-FR
In-Reply-To: <YXwZihLk1njsBNT4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/10/2021 à 17:55, Andy Shevchenko a écrit :
> On Wed, Oct 27, 2021 at 06:33:54PM +0300, Andy Shevchenko wrote:
>> When kernel.h is used in the headers it adds a lot into dependency hell,
>> especially when there are circular dependencies are involved.
>>
>> Replace kernel.h inclusion with the list of what is really being used.
>
> Seems nobody from PPC took this patch.
> Any idea who can take it?
>

You have to check in MAINTAINERS file in the root directory of kernel 
sources: https://github.com/linuxppc/linux/blob/master/MAINTAINERS

That's Michael who takes them. But you have to allow him enough time for it.

Christophe

