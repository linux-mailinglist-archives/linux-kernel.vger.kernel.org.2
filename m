Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE13D177A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhGUTZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGUTZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:25:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9195560FF1;
        Wed, 21 Jul 2021 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626897954;
        bh=PH79dhvbA5ifENRBFeVP2SQ13AevDDS80mZd2iiPTEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W3AQFpo3D0BD21GopJUVmtm9u0VFSvoJBl61g98i1Z7FJFfyUuAchEXZ/0lspitFD
         W9LoSeCkQGXNSG9lfavh6YUqI+eVMQmAlygHKCZFO8Dk9ZGK0iAK7h2OEJkeDzCsjg
         5aOsWXQ+LsXFzyaxM4p83oP0z+fe6E+yMny6Lvg0=
Date:   Wed, 21 Jul 2021 13:05:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] mm/mremap: Don't account pages in vma_to_resize()
Message-Id: <20210721130551.bbdeae56ca3ec2d0f28b0bac@linux-foundation.org>
In-Reply-To: <77e28552-7a13-0981-f921-cd027cb73525@gmail.com>
References: <20210721131320.522061-1-dima@arista.com>
        <77e28552-7a13-0981-f921-cd027cb73525@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 14:21:54 +0100 Dmitry Safonov <0x7f454c46@gmail.com> wrote:

> > Let's not do this.
> > Account memory in mremap() fast-path for growing VMAs or in move_vma()
> > for actually moving things. The same simpler way as it's done by
> > vm_stat_account(), but with a difference to call
> > security_vm_enough_memory_mm() before copying/adjusting VMA.
> > 
> > Originally noticed by Chen Wandun:
> > https://lkml.kernel.org/r/20210717101942.120607-1-chenwandun@huawei.com
> 
> The patch by Chen Wandun still makes sense with this v2.
> Heh :-)

Should
https://lkml.kernel.org/r/20210717101942.120607-1-chenwandun@huawei.com
still be applied then?  Did you ack it?
