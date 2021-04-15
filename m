Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6421E360211
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhDOF4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:56:34 -0400
Received: from verein.lst.de ([213.95.11.211]:33313 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhDOF4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:56:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F1E3A68BEB; Thu, 15 Apr 2021 07:56:05 +0200 (CEST)
Date:   Thu, 15 Apr 2021 07:56:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>, viro@zeniv.linux.org.uk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jcmvbkbc@gmail.com, gerg@linux-m68k.org,
        Anup Patel <Anup.Patel@wdc.com>,
        Christoph Hellwig <hch@lst.de>, uclinux-dev@uclinux.org
Subject: Re: [PATCH v2 0/2] Fix binfmt_flat loader for RISC-V
Message-ID: <20210415055605.GB8947@lst.de>
References: <BL0PR04MB65148D80C819A7E3B8365242E74D9@BL0PR04MB6514.namprd04.prod.outlook.com> <mhng-61cff5f4-32a0-417d-9a2f-eb6d052cf802@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-61cff5f4-32a0-417d-9a2f-eb6d052cf802@palmerdabbelt-glaptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binfmt_flat tends to go through Greg's uclinux tree, adding him and
the list.

On Wed, Apr 14, 2021 at 10:46:36PM -0700, Palmer Dabbelt wrote:
> On Wed, 14 Apr 2021 17:32:10 PDT (-0700), Damien Le Moal wrote:
>>> On 2021/04/08 0:49, Damien Le Moal wrote:
>>> RISC-V NOMMU flat binaries cannot tolerate a gap between the text and
>>> data section as the toolchain fully resolves at compile time the PC
>>> relative global pointer (__global_pointer$ value loaded in gp register).
>>> Without a relocation entry provided, the flat bin loader cannot fix the
>>> value if a gap is introduced and executables fail to run.
>>>
>>> This series fixes this problem by allowing an architecture to request
>>> the flat loader to suppress the gap between the text and data sections.
>>> The first patch fixes binfmt_flat flat_load_file() using the new
>>> configuration option CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP. The second
>>> patch enables this option for RISCV NOMMU builds.
>>>
>>> These patches do not change the binfmt_flat loader behavior for other
>>> architectures.
>>>
>>> Changes from v1:
>>> * Replace FLAT_TEXT_DATA_NO_GAP macro with
>>>   CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP config option (patch 1).
>>> * Remove the addition of riscv/include/asm/flat.h and set
>>>   CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP for RISCV and !MMU
>>>
>>> Damien Le Moal (2):
>>>   binfmt_flat: allow not offsetting data start
>>>   riscv: Disable text-data gap in flat binaries
>>>
>>>  arch/riscv/Kconfig |  1 +
>>>  fs/Kconfig.binfmt  |  3 +++
>>>  fs/binfmt_flat.c   | 21 +++++++++++++++------
>>>  3 files changed, 19 insertions(+), 6 deletions(-)
>>>
>>
>> Ping ?
>>
>> Any comment on these patches ?
>>
>> Without them, RISC-V NOMMU user space does not run... I would really like to get
>> these in this cycle if possible.
>
> This LGTM, but it's pretty far out of my area of expertise.  I'm happy to 
> take them via my tree, but I'd prefer to get an Ack from someone.
>
> Al, get_maintainer suggests you?
>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---end quoted text---
