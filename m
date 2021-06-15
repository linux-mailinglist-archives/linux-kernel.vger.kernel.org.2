Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8213A77EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFOH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:26:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22840 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhFOH0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:26:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G40FF50W0zBB5S;
        Tue, 15 Jun 2021 09:24:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5ovWE20aMevL; Tue, 15 Jun 2021 09:24:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G40FF45n3zBB1b;
        Tue, 15 Jun 2021 09:24:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 78ED48B7A5;
        Tue, 15 Jun 2021 09:24:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id U9H5EriO6hYV; Tue, 15 Jun 2021 09:24:33 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DDFE68B7A4;
        Tue, 15 Jun 2021 09:24:32 +0200 (CEST)
Subject: Re: [PATCH v2 00/12] powerpc: Cleanup use of 'struct ppc_inst'
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
 <87r1h3tx3a.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <0c2b2eb4-f58d-9ec3-4b98-af22cef188e2@csgroup.eu>
Date:   Tue, 15 Jun 2021 09:24:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87r1h3tx3a.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/06/2021 à 09:18, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> This series is a cleanup of the use of 'struct ppc_inst'.
>>
>> A confusion is made between internal representation of powerpc
>> instructions with 'struct ppc_inst' and in-memory code which is
>> and will always be an array of 'unsigned int'.
> 
> Why don't we use u32 *, to make it even more explicit what the expected
> size is?
> 

I guess that's historical, we could use u32 *

We can convert it incrementaly maybe ?
