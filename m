Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28553A2A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFJLUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:20:21 -0400
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:47870 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhFJLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:20:19 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id C8E62BAAA3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:18:22 +0100 (IST)
Received: (qmail 10021 invoked from network); 10 Jun 2021 11:18:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Jun 2021 11:18:22 -0000
Date:   Thu, 10 Jun 2021 12:18:21 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored
 on the per-cpu lists
Message-ID: <20210610111821.GY30378@techsingularity.net>
References: <20210603142220.10851-1-mgorman@techsingularity.net>
 <20210603142220.10851-3-mgorman@techsingularity.net>
 <88FCC7AA-FAAA-4B87-B382-50BD54B2886B@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <88FCC7AA-FAAA-4B87-B382-50BD54B2886B@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 02:30:18PM -0400, Zi Yan wrote:
> On 3 Jun 2021, at 10:22, Mel Gorman wrote:
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  include/linux/mmzone.h |  20 +++++-
> >  mm/internal.h          |   2 +-
> >  mm/page_alloc.c        | 159 +++++++++++++++++++++++++++++------------
> >  mm/swap.c              |   2 +-
> >  4 files changed, 135 insertions(+), 48 deletions(-)
> >
> 
> Hi Mel,
> 
> I am not able to boot my QEMU VM with v5.13-rc5-mmotm-2021-06-07-18-33.
> git bisect points to this patch. The VM got stuck at ???Booting from ROM??????.
> 
> My kernel config is attached and my qemu command is:
> 
> qemu-system-x86_64 -kernel ~/repos/linux-1gb-thp/arch/x86/boot/bzImage \
>     -drive file=~/qemu-image/vm.qcow2,if=virtio \
>     -append "nokaslr root=/dev/vda1 rw console=ttyS0 " \
>     -pidfile vm.pid \
>     -netdev user,id=mynet0,hostfwd=tcp::11022-:22 \
>     -device virtio-net-pci,netdev=mynet0 \
>     -m 16g -smp 6 -cpu host -enable-kvm -nographic \
>     -machine hmat=on -object memory-backend-ram,size=8g,id=m0 \
>     -object memory-backend-ram,size=8g,id=m1 \
>     -numa node,memdev=m0,nodeid=0 -numa node,memdev=m1,nodeid=1
> 
> The attached config has THP disabled. The VM cannot boot with THP enabled,
> either.
> 

There is not a lot of information to go on here. Can you confirm that a
revert of that specific patch from mmotm-2021-06-07-18-33 also boots? It
sounds like your console log is empty, does anything useful appear if
you add "earlyprintk=serial,ttyS0,115200" to the kernel command line?

-- 
Mel Gorman
SUSE Labs
