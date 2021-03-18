Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D5E34059B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhCRMgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:36:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCRMfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:35:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D68DAC1E;
        Thu, 18 Mar 2021 12:35:38 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm/slub: Add Support for free path information of an
 object.
To:     Maninder Singh <maninder1.s@samsung.com>, paulmck@kernel.org,
        linux@armlinux.org.uk, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>
References: <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
 <CGME20210316103736epcas5p3758de57b57c732074acc0989e563cc2e@epcas5p3.samsung.com>
 <1615891032-29160-2-git-send-email-maninder1.s@samsung.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <cd57a6e5-ce82-3cc5-4bc8-850ddc0c2b94@suse.cz>
Date:   Thu, 18 Mar 2021 13:35:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615891032-29160-2-git-send-email-maninder1.s@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 11:37 AM, Maninder Singh wrote:
> Adding support for inforamtion of free path along with allocation
> path of an object:
> 
> slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at meminfo_proc_show+0x40/0x4fc
> [   20.192078]     meminfo_proc_show+0x40/0x4fc
> [   20.192263]     seq_read_iter+0x18c/0x4c4
> [   20.192430]     proc_reg_read_iter+0x84/0xac
> [   20.192617]     generic_file_splice_read+0xe8/0x17c
> [   20.192816]     splice_direct_to_actor+0xb8/0x290
> [   20.193008]     do_splice_direct+0xa0/0xe0
> [   20.193185]     do_sendfile+0x2d0/0x438
> [   20.193345]     sys_sendfile64+0x12c/0x140
> [   20.193523]     ret_fast_syscall+0x0/0x58
> [   20.193695]     0xbeeacde4
> [   20.193822]  Free path:
> [   20.193935]     meminfo_proc_show+0x5c/0x4fc
> [   20.194115]     seq_read_iter+0x18c/0x4c4
> [   20.194285]     proc_reg_read_iter+0x84/0xac
> [   20.194475]     generic_file_splice_read+0xe8/0x17c
> [   20.194685]     splice_direct_to_actor+0xb8/0x290
> [   20.194870]     do_splice_direct+0xa0/0xe0
> [   20.195014]     do_sendfile+0x2d0/0x438
> [   20.195174]     sys_sendfile64+0x12c/0x140
> [   20.195336]     ret_fast_syscall+0x0/0x58
> [   20.195491]     0xbeeacde4
> 
> Co-developed-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
