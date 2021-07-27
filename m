Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95CA3D7F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhG0UlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:41:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231424AbhG0UlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:41:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RKXTPA171906;
        Tue, 27 Jul 2021 16:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GXrqMLJnfay41Qa+AEwE55svFy1XguVHqDhNlpP+SmY=;
 b=hB+/zUXeprcYwbn6nKjhIwwbuz3kv4QY69lNUMnB2OPWbtKODl6V2tW7u12lcV56s0/9
 Bj+qYrmvrNlPc2puSZqY340ul56S8x4iBctf9wylkYs29a/WOIcFWAUpGMOkGbf8/SfN
 5GXh96CCilH9y5AtjGjtiIzoQhd/eCtnqoInsP2tiTR3ir+yz+1EZA+bvHxgMV07aE3S
 +6PBjnR1jRxZ5Kc0WuzXj03Hcskwi8GQnJr7HMagPA/J71VF9RjtPEf+oUzhSURVsBA4
 6pJffJVZgggdz4XnhRV3iszXx2F80nXiu1PePvJgG3VVEgWsA5eIAKeWbqkPztMazBCk +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2rjahm0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 16:41:13 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RKXXnQ172213;
        Tue, 27 Jul 2021 16:41:13 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2rjahkyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 16:41:13 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RKeZ62006116;
        Tue, 27 Jul 2021 20:41:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3a235kge2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 20:41:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RKf8tS14025072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 20:41:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 664DF4C05A;
        Tue, 27 Jul 2021 20:41:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7F104C040;
        Tue, 27 Jul 2021 20:41:07 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.86.232])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Jul 2021 20:41:07 +0000 (GMT)
Date:   Tue, 27 Jul 2021 23:41:05 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Michael Cree <mcree@orcon.net.nz>, linux-mm@kvack.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regression bisected to fa3354e4ea39 (mm: free_area_init: use
 maximal zone PFNs rather than zone sizes)
Message-ID: <YQBvYUupT/jgDMqI@linux.ibm.com>
References: <20210726192311.uffqnanxw3ac5wwi@ivybridge>
 <YP8Vxt0xuV1m5EPS@linux.ibm.com>
 <CAEdQ38F2ddbM0WBjut6MH-0TpencKmx9Wu4++gLtfQ5HGRwxFQ@mail.gmail.com>
 <YP+rI9Fh4wl/O6/8@linux.ibm.com>
 <CAEdQ38G+ZfXmc01iZTc+q4dYpRqQJUz0KNFCPwTQ25AYqJVbMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEdQ38G+ZfXmc01iZTc+q4dYpRqQJUz0KNFCPwTQ25AYqJVbMA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S8r08Wo9u9aCfzX1EHvYSMLnmWVwisHg
X-Proofpoint-ORIG-GUID: lNX4TlWTPq5LmsgcIPyx2wZqsYcT-S58
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_13:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:24:26PM -0700, Matt Turner wrote:
> On Mon, Jul 26, 2021 at 11:43 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Mon, Jul 26, 2021 at 02:23:20PM -0700, Matt Turner wrote:
> > > On Mon, Jul 26, 2021 at 1:06 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > >
> > > > Hi Matt,
> > > >
> > > > On Mon, Jul 26, 2021 at 12:27:50PM -0700, Matt Turner wrote:
> > > > > Reply-To:
> > > > >
> > > > > Hi Mike!
> > > > >
> > > > > Since commit fa3354e4ea39 (mm: free_area_init: use maximal zone PFNs rather
> > > > > than zone sizes), I get the following BUG on Alpha (an AlphaServer ES47 Marvel)
> > > > > and loading userspace leads to a segfault:
> > > > >
> > > > > (I didn't notice this for a long time because of other unrelated regressions,
> > > > > the pandemic, changing jobs, ...)
> > > >
> > > > I suspect there will be more surprises down the road :)
> > > >
> > > > > BUG: Bad page state in process swapper  pfn:2ffc53
> > > > > page:fffffc000ecf14c0 refcount:0 mapcount:1 mapping:0000000000000000 index:0x0
> > > > > flags: 0x0()
> > > > > raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > page dumped because: nonzero mapcount  Modules linked in:
> > > > > CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-03841-gfa3354e4ea39-dirty #26
> > > > >        fffffc0001b5bd68 fffffc0001b5be80 fffffc00011cd148 fffffc000ecf14c0
> > > > >        fffffc00019803df fffffc0001b5be80 fffffc00011ce340 fffffc000ecf14c0
> > > > >        0000000000000000 fffffc0001b5be80 fffffc0001b482c0 fffffc00027d6618
> > > > >        fffffc00027da7d0 00000000002ff97a 0000000000000000 fffffc0001b5be80
> > > > >        fffffc00011d1abc fffffc000ecf14c0 fffffc0002d00000 fffffc0001b5be80
> > > > >        fffffc0001b2350c 0000000000300000 fffffc0001b48298 fffffc0001b482c0
> > > > > Trace:
> > > > > [<fffffc00011cd148>] bad_page+0x168/0x1b0
> > > > > [<fffffc00011ce340>] free_pcp_prepare+0x1e0/0x290
> > > > > [<fffffc00011d1abc>] free_unref_page+0x2c/0xa0
> > > > > [<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
> > > > > [<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
> > > > > [<fffffc000101001c>] _stext+0x1c/0x20
> > > > >
> > > > > I haven't tried reproducing this on other machines or QEMU, but I'd be glad to
> > > > > if that helps.
> > > >
> > > > If it's reproducible on QEMU I can debug it locally.
> > > >
> > > > > Any ideas?
> > > >
> > > > It seems like memory map is not properly initialized. Can you enable
> > > > CONFIG_DEBUG_MEMORY_INIT and add mminit_debug=4 to the command line. The
> > > > interesting part of the log would be before "Memory: xK/yK available ..."
> > > > line.
> > > >
> > > > Hopefully it'll give some clues.
> > >
> > > Sure thing. Please find attached.
> >
> > > aboot: loading uncompressed vmlinuz-5.7.0-03841-gfa3354e4ea39-dirty...
> > > aboot: loading compressed vmlinuz-5.7.0-03841-gfa3354e4ea39-dirty...
> > > aboot: PHDR 0 vaddr 0xfffffc0001010000 offset 0xc0 size 0x17c5ae0
> > > aboot: bss at 0xfffffc00027d5ae0, size 0xe4ea0
> > > aboot: zero-filling 937632 bytes at 0xfffffc00027d5ae0
> > > aboot: loading initrd (5965252 bytes/5825 blocks) at 0xfffffc05ff2cc000
> > > aboot: starting kernel vmlinuz-5.7.0-03841-gfa3354e4ea39-dirty with arguments ro panic=5 domdadm root=/dev/md1 console=srm  mminit_debug=4
> > > Linux version 5.7.0-03841-gfa3354e4ea39-dirty (mattst88@ivybridge) (gcc version 11.1.0 (Gentoo 11.1.0-r2 p3), GNU ld (Gentoo 2.36.1 p3) 2.36.1) #26 SMP Sun Jul 25 18:20:06 PDT 2021
> > > printk: bootconsole [srm0] enabled
> > > Booting on Marvel variation Marvel/EV7 using machine vector MARVEL/EV7 from SRM
> > > Major Options: SMP EV67 VERBOSE_MCHECK DEBUG_SPINLOCK MAGIC_SYSRQ
> > > Command line: ro panic=5 domdadm root=/dev/md1 console=srm  mminit_debug=4
> > > memcluster 0, usage 1, start        0, end     1984
> > > memcluster 1, usage 0, start     1984, end  1048576
> > > memcluster 2, usage 1, start  2097152, end  2097224
> > > memcluster 3, usage 0, start  2097224, end  3145728
> > > Initial ramdisk at: 0x(____ptrval____) (5965252 bytes)
> > > Found an IO7 at PID 0
> > > Initializing IO7 at PID 0
> > > FIXME: disabling master aborts
> > > FIXME: disabling master aborts
> > > FIXME: disabling master aborts
> > > FIXME: disabling master aborts
> > > SMP: 2 CPUs probed -- cpu_present_mask = 3
> > > Zone ranges:
> > >   DMA      [mem 0x0000000000f80000-0x00000fffffffdfff]
> > >   Normal   empty
> > > Movable zone start for each node
> > > Early memory node ranges
> > >   node   0: [mem 0x0000000000f80000-0x00000001ffffffff]
> > >   node   0: [mem 0x0000000400090000-0x00000005ffffffff]
> >
> > I think that the issue is that memory marked as used in memcluster is never
> > added to memblock and it skews node/zone sizing calculations.
> 
> Thanks, this patch fixes it. With the patch applied, I see
> 
> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x00000fffffffdfff]
>   Normal   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x00000001ffffffff]
>   node   0: [mem 0x0000000400000000-0x00000005ffffffff]
> Initmem setup node 0 [mem 0x0000000000000000-0x00000005ffffffff]
> 
> If you want to send me this patch with your S-o-b I'll take it through
> my alpha git tree.

The patch is on its way :)

Now I'm really curios how commit e7793e53901b ("arc: update comment about
HIGHMEM implementation") will work out.

 
> Thanks Mike!
> Matt

-- 
Sincerely yours,
Mike.
