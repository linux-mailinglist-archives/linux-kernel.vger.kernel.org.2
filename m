Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0B53A77B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFOHNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:13:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45422 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhFOHNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:13:04 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G3zxZ6l8PzB9cj;
        Tue, 15 Jun 2021 09:10:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xd2TKTQK8ov2; Tue, 15 Jun 2021 09:10:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G3zxZ5qcLzB9VY;
        Tue, 15 Jun 2021 09:10:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B8BD8B7A5;
        Tue, 15 Jun 2021 09:10:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Tr_kw5KW1-Uj; Tue, 15 Jun 2021 09:10:58 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C5F38B7A3;
        Tue, 15 Jun 2021 09:10:58 +0200 (CEST)
Subject: Re: [PATCH 6/7] powerpc/uaccess: Add unsafe_clear_user()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
 <67eedb69ca81e5a4b16459a4c61f99e64cb42675.1623739212.git.christophe.leroy@csgroup.eu>
 <YMhOYKM5+s0wUoeP@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1940d0cc-1aea-07d0-95e6-8d63047e4d9e@csgroup.eu>
Date:   Tue, 15 Jun 2021 09:10:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMhOYKM5+s0wUoeP@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/06/2021 à 08:53, Christoph Hellwig a écrit :
> On Tue, Jun 15, 2021 at 06:41:02AM +0000, Christophe Leroy wrote:
>> Implement unsafe_clear_user() for powerpc.
>> It's a copy/paste of unsafe_copy_to_user() with value 0 as source.
>>
>> It may be improved in a later patch by using 'dcbz' instruction
>> to zeroize full cache lines at once.
> 
> Please add this to common code insted of making it powerpc specific.
> 

A common version is added in previous patch.

Just like unsafe_copy_to_user(), unsafe_clear_user() needs to be arch defined.

unsafe_copy_to_user() has both an x86 implementation and a powerpc implementation, why do different ?

I can't see how it could be not powerpc specific. At the end we want to use 'dcbz' to zeroize full 
cachelines at once, even if at the time being that's a simple write of 0.
