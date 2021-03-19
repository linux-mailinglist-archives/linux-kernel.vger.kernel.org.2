Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E30342920
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 00:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCSXXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 19:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCSXXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 19:23:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C1726198A;
        Fri, 19 Mar 2021 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616196222;
        bh=No8jxwVXbt0baLG77yLL4xAfkyo5ppTWSVF534G6q1k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eIyGGnJc4XJKPHeFjat/7fj7brhRbrtq0gpJ1TfDglry0iHT+Bbd7kmQorMQvS4Hi
         KXMP1149WBbMiDs1dAlPNEKui7W7zKuZtRl7uWDZaKl296kMbSUC512xSLVfNVkhWQ
         yPufj9DSM3REcfQ5vJ6CXI45YQD5F1miYjd3ir2ggDT0wrrC8EaF9j0u4RkippFvw6
         pUPXgBOZPCqMk+zfvWhOfpiH+axE1r1OJWVLcpsdu7nYz3kECazvJhfcLChMcNogwa
         85WSvmUR2cdhy2eN2pW8CnvXKBSwFesd7XRilGMGe0YGchDX10PpTgHgMfI2msOWGy
         rU4y9s8MOHIKA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D56DB35239E5; Fri, 19 Mar 2021 16:23:41 -0700 (PDT)
Date:   Fri, 19 Mar 2021 16:23:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Maninder Singh <maninder1.s@samsung.com>, linux@armlinux.org.uk,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        0x7f454c46@gmail.com, viro@zeniv.linux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>
Subject: Re: [PATCH 2/3] mm/slub: Add Support for free path information of an
 object.
Message-ID: <20210319232341.GS2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
 <CGME20210316103736epcas5p3758de57b57c732074acc0989e563cc2e@epcas5p3.samsung.com>
 <1615891032-29160-2-git-send-email-maninder1.s@samsung.com>
 <cd57a6e5-ce82-3cc5-4bc8-850ddc0c2b94@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd57a6e5-ce82-3cc5-4bc8-850ddc0c2b94@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 01:35:37PM +0100, Vlastimil Babka wrote:
> On 3/16/21 11:37 AM, Maninder Singh wrote:
> > Adding support for inforamtion of free path along with allocation
> > path of an object:
> > 
> > slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at meminfo_proc_show+0x40/0x4fc
> > [   20.192078]     meminfo_proc_show+0x40/0x4fc
> > [   20.192263]     seq_read_iter+0x18c/0x4c4
> > [   20.192430]     proc_reg_read_iter+0x84/0xac
> > [   20.192617]     generic_file_splice_read+0xe8/0x17c
> > [   20.192816]     splice_direct_to_actor+0xb8/0x290
> > [   20.193008]     do_splice_direct+0xa0/0xe0
> > [   20.193185]     do_sendfile+0x2d0/0x438
> > [   20.193345]     sys_sendfile64+0x12c/0x140
> > [   20.193523]     ret_fast_syscall+0x0/0x58
> > [   20.193695]     0xbeeacde4
> > [   20.193822]  Free path:
> > [   20.193935]     meminfo_proc_show+0x5c/0x4fc
> > [   20.194115]     seq_read_iter+0x18c/0x4c4
> > [   20.194285]     proc_reg_read_iter+0x84/0xac
> > [   20.194475]     generic_file_splice_read+0xe8/0x17c
> > [   20.194685]     splice_direct_to_actor+0xb8/0x290
> > [   20.194870]     do_splice_direct+0xa0/0xe0
> > [   20.195014]     do_sendfile+0x2d0/0x438
> > [   20.195174]     sys_sendfile64+0x12c/0x140
> > [   20.195336]     ret_fast_syscall+0x0/0x58
> > [   20.195491]     0xbeeacde4
> > 
> > Co-developed-by: Vaneet Narang <v.narang@samsung.com>
> > Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

I have queued 1/3 and 2/3, thank you both!

Would any of the ARM folks be willing to ack 3/3?

							Thanx, Paul
