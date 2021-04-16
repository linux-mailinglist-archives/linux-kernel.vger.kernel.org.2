Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C730E361A89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhDPH1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhDPH0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:26:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FF2C60238;
        Fri, 16 Apr 2021 07:26:29 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] Fix binfmt_flat loader for RISC-V
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "uclinux-dev@uclinux.org" <uclinux-dev@uclinux.org>
References: <BL0PR04MB65148D80C819A7E3B8365242E74D9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <mhng-61cff5f4-32a0-417d-9a2f-eb6d052cf802@palmerdabbelt-glaptop>
 <20210415055605.GB8947@lst.de> <YHjYoDA2JPxSYVu0@zeniv-ca.linux.org.uk>
 <BL0PR04MB65143E710571C8CE7E7F0FB0E74C9@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <f407de5f-7799-3e47-c68c-38a2428533aa@linux-m68k.org>
Date:   Fri, 16 Apr 2021 17:26:27 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB65143E710571C8CE7E7F0FB0E74C9@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/4/21 10:26 am, Damien Le Moal wrote:
> On 2021/04/16 9:22, Al Viro wrote:
>> On Thu, Apr 15, 2021 at 07:56:05AM +0200, Christoph Hellwig wrote:
>>> binfmt_flat tends to go through Greg's uclinux tree, adding him and
>>> the list.
>>
>> 	FWIW, my involvement with binfmt_flat had been pretty much nil -
>> the least trivial had been "binfmt_flat: flat_{get,put}_addr_from_rp()
>> should be able to fail" about 4 years ago and that fell out of hunting
>> for places where __get_user() had been used without checking error values.
>>
>> 	It's in fs/*, but I've no way to test it and I have pretty much
>> zero familiarity with the guts of that one, so I can't give any useful
>> feedback on that series.  So consider the Christoph's comment seconded -
>> you want it reviewed by gerg et.al., and it probably ought to go via
>> gerg/uclinux.git tree.
>>
>> 	I'm reasonably familiar with binfmt_{elf,misc,script}; anything
>> else gets touched as part of larger series and only with sanity checks
>> from other folks, if the changes are not entirely trivial.
> 
> Al,
> 
> Thanks for the clarification. Would it make sense to have an entry in
> MAINTAINERS file pointing to Greg and the uclinux tree for binfmt_flat.c ?
> Greg ?

Yep, looks like it does need that.

Regards
Greg

