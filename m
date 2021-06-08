Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC139F710
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhFHMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:48:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2227 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232351AbhFHMsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:48:36 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FzqkB2cr1zBDc0;
        Tue,  8 Jun 2021 14:46:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5jIKldteYWR6; Tue,  8 Jun 2021 14:46:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FzqkB1jkszBDbW;
        Tue,  8 Jun 2021 14:46:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BA768B7BB;
        Tue,  8 Jun 2021 14:46:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 71_pEKagHxiX; Tue,  8 Jun 2021 14:46:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F21F8B7A8;
        Tue,  8 Jun 2021 14:46:41 +0200 (CEST)
Subject: Re: [PATCH v2 00/12] powerpc: Cleanup use of 'struct ppc_inst'
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
Message-ID: <e28c4639-00b3-6bf9-6c5e-72e251372cb4@csgroup.eu>
Date:   Tue, 8 Jun 2021 14:46:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Le 20/05/2021 à 15:50, Christophe Leroy a écrit :
> This series is a cleanup of the use of 'struct ppc_inst'.
> 
> A confusion is made between internal representation of powerpc
> instructions with 'struct ppc_inst' and in-memory code which is
> and will always be an array of 'unsigned int'.
> 
> This series cleans it up.
> 
> First patch is fixing detection of missing '__user' flag by sparse
> when using get_user_instr().
> 
> Last part of the series does some source code cleanup in
> optprobes, it is put at the ends of this series because of
> clashes with the 'struct ppc_inst' cleanups.

What are your plans about this series ? I fear that the more we wait the more we get additional bad 
uses of 'struct ppc_inst'.
There are several people working around places that play with instructions, so I think the sooner it 
gets cleaned the better it is. Do you agree ?

Thanks
Christophe
