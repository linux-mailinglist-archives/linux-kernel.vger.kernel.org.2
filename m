Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE33335F464
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351008AbhDNM6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:58:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34313 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347646AbhDNM6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:58:20 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FL2ZX4sPrz9txMS;
        Wed, 14 Apr 2021 14:57:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2SNyNYClAnNU; Wed, 14 Apr 2021 14:57:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FL2ZX3NNKz9txMR;
        Wed, 14 Apr 2021 14:57:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C95C28B7C8;
        Wed, 14 Apr 2021 14:57:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 53S2lL7lZviC; Wed, 14 Apr 2021 14:57:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 147B68B7C4;
        Wed, 14 Apr 2021 14:57:57 +0200 (CEST)
Subject: Re: [PATCH v2 3/4] powerpc: Rename probe_kernel_read_inst()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, jniethe5@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <857ceb23b6a614aea2522e770b067593d5f9e906.1618331980.git.christophe.leroy@csgroup.eu>
 <e2fbccd1a0b4e8ed7e12936e03be76588202c7a0.1618331980.git.christophe.leroy@csgroup.eu>
 <874kg930di.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9cedd64c-5585-353b-4f8b-eab245950d0f@csgroup.eu>
Date:   Wed, 14 Apr 2021 14:57:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <874kg930di.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/04/2021 à 07:23, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> When probe_kernel_read_inst() was created, it was to mimic
>> probe_kernel_read() function.
>>
>> Since then, probe_kernel_read() has been renamed
>> copy_from_kernel_nofault().
>>
>> Rename probe_kernel_read_inst() into copy_from_kernel_nofault_inst().
> 
> At first glance I read it as copy from kernel nofault instruction.
> How about copy_inst_from_kernel_nofault()?

Yes good idea.

Christophe
