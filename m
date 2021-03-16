Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF1E33CE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhCPGuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:50:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231794AbhCPGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:50:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12G6XpJh038572;
        Tue, 16 Mar 2021 02:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=U0D9FMetb/d4p0qzlAnQOYDqTF4rYE7A0MPACixrYJw=;
 b=kbFL+0pnRc3qdo+rd/RBfMx/oT1ykn3bwjOwah6KYEo60PgYrJT2T3LyOQmdBQvZ74Et
 tWXkMSUCi4jNGkUwSkxhsJ7qqAUaTs5GHxgCYuL+xC9CoDuCQeiRkWynhIlfKFJY+odK
 Y6uVr0AOonsvlkG9VaO7Jdg5ZeLD6wC6FSoD5EPUlduS/1sytOfrcCuwyqZnx8Sb8XVi
 H+cYKvUQfwrPP78JoguUn9ndA55TqGcYMbRmD+LD0ifr8FbMUecyHs2dgpgc/NIf3v8X
 IWxG3Am7FZ3efNqYKl9rM/VoqRU0gxsj96XTrbhnWSjeEHTOjTgsoIA2YnzGEw1dkwUq KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37abvarcgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 02:50:37 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12G6XvLf038798;
        Tue, 16 Mar 2021 02:50:36 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37abvarcg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 02:50:36 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12G6g0qP016936;
        Tue, 16 Mar 2021 06:50:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 378n181b7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 06:50:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12G6oVQW17629524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 06:50:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B89DB4C052;
        Tue, 16 Mar 2021 06:50:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD35A4C050;
        Tue, 16 Mar 2021 06:50:30 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.58.148])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Mar 2021 06:50:30 +0000 (GMT)
Date:   Tue, 16 Mar 2021 08:50:28 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Liang, Liang (Leo)" <Liang.Liang@amd.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <YFBVNEC7jMZxwleL@linux.ibm.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
 <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_15:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Tue, Mar 16, 2021 at 12:36:29AM +0000, Liang, Liang (Leo) wrote:
> 
> Hi David,
> 
> Sorry for late. If revert 7fef431be9c9 (without 7fef431be9c9), the dmesg attached. And looks the exception as below:
> [  +0.027833] [0x0000000078000000 - 0x00000000783fffff] 20925 MB/s / 25405 MB/s
> [  +1.363596] [0x0000000100000000 - 0x00000001003fffff] 222 MB/s / 222 MB/s
> [  +1.562192] [0x0000000100400000 - 0x00000001007fffff] 222 MB/s / 222 MB/s
> [  +1.881332] [0x0000000100800000 - 0x0000000100bfffff] 195 MB/s / 159 MB/s
> [  +1.383388] [0x0000000100c00000 - 0x0000000100ffffff] 219 MB/s / 221 MB/s
> [  +0.029342] [0x0000000101000000 - 0x00000001013fffff] 19807 MB/s / 24125 MB/s
> 
> What is the problem here? Do you want to check the acpi tables?

As it seems the first 16M at 0x0000000100000000 are two orders of magnitude
slower than the rest of the memory as if there is a different memory device
there.

This would explain why with 7fef431be9c9 everything gets slower as we
allocate the first (and probably quite critical) data from those 16M.

No idea how this could be related to ACPI and why ACPI initialization
causes the huge slowdown on its own.

Can you please try booting with 7fef431be9c9 still applied and with this
patch (not even compile tested):

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176ef2ce..780f11ca14c9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -778,6 +778,7 @@ void __init setup_arch(char **cmdline_p)
 	 * L1TF its contents can be leaked to user processes.
 	 */
 	memblock_reserve(0, PAGE_SIZE);
+	memblock_reserve(0x0000000100000000, SZ_16M);
 
 	early_reserve_initrd();
 
 
> BRs,
> Leo
> -----Original Message-----
> From: David Hildenbrand <david@redhat.com> 
> Sent: Monday, March 15, 2021 9:04 PM
> To: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Liang, Liang (Leo) <Liang.Liang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; amd-gfx list <amd-gfx@lists.freedesktop.org>; Andrew Morton <akpm@linux-foundation.org>; Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Rafael J. Wysocki <rafael@kernel.org>; George Kennedy <george.kennedy@oracle.com>
> Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail in __free_pages_core()")
> 
> On 13.03.21 14:48, Mike Rapoport wrote:
> > Hi,
> > 
> > On Sat, Mar 13, 2021 at 10:05:23AM +0100, David Hildenbrand wrote:
> >>> Am 13.03.2021 um 05:04 schrieb Liang, Liang (Leo) <Liang.Liang@amd.com>:
> >>>
> >>> Hi David,
> >>>
> >>> Which benchmark tool you prefer? Memtest86+ or else?
> >>
> >> Hi Leo,
> >>
> >> I think you want something that runs under Linux natively.
> >>
> >> I'm planning on coding up a kernel module to walk all 4MB pages in 
> >> the freelists and perform a stream benchmark individually. Then we 
> >> might be able to identify the problematic range - if there is a 
> >> problematic range :)
> > 
> > My wild guess would be that the pages that are now at the head of free 
> > lists have wrong caching enabled. Might be worth checking in your test 
> > module.
> 
> I hacked something up real quick:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fdavidhildenbrand%2Fkstream&amp;data=04%7C01%7Cliang.liang%40amd.com%7C61fb103eeb7647f5228408d8e7b2d7d3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637514102622932303%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ufUYQRtdSHvEkR61LiJZtsVdYZbtdGbKlzZHOQdct78%3D&amp;reserved=0
> 
> Only briefly tested inside a VM. The output looks something like
> 
> [...]
> [ 8396.432225] [0x0000000045800000 - 0x0000000045bfffff] 25322 MB/s /
> 38948 MB/s
> [ 8396.448749] [0x0000000045c00000 - 0x0000000045ffffff] 24481 MB/s /
> 38946 MB/s
> [ 8396.465197] [0x0000000046000000 - 0x00000000463fffff] 24892 MB/s /
> 39170 MB/s
> [ 8396.481552] [0x0000000046400000 - 0x00000000467fffff] 25222 MB/s /
> 39156 MB/s
> [ 8396.498012] [0x0000000046800000 - 0x0000000046bfffff] 24416 MB/s /
> 39159 MB/s
> [ 8396.514397] [0x0000000046c00000 - 0x0000000046ffffff] 25469 MB/s /
> 38940 MB/s
> [ 8396.530849] [0x0000000047000000 - 0x00000000473fffff] 24885 MB/s /
> 38734 MB/s
> [ 8396.547195] [0x0000000047400000 - 0x00000000477fffff] 25458 MB/s /
> 38941 MB/s
> [...]
> 
> The benchmark allocates one 4 MiB chunk at a time and runs a simplified STREAM benchmark a) without flushing caches b) flushing caches before every memory access.
> 
> It would be great if you could run that with the *old behavior* kernel (IOW, without 7fef431be9c9), so we might still be lucky to catch the problematic area in the freelist.
> 
> Let's see if that will indicate anything.
> 
> --
> Thanks,
> 
> David / dhildenb



-- 
Sincerely yours,
Mike.
