Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A698C3910CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhEZGl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:41:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230007AbhEZGlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:41:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q6Xb3T080790;
        Wed, 26 May 2021 02:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=qkTltOOEw1YGnc1KY8pva2+CHx60RP31oqQO/YyPM98=;
 b=MobCuICAMBF9EsESTHRsJiMSe2VGJpES9NG0FDU+LTMwxNOxgyPGvvgyTg/i0Jqy0VJ4
 l9fClRZ7byrvzzjJZF0PRL9qb4F/OslTYBDhYi3OWjDgF+S4/3ujRnd7+Ngeis3d8AZz
 jaaLY7OJ4YTTla8MnnHdQs0rnmtkz9uhXbo6k7nI43GSVm+SVlxvpNG3D/oE+l3nPwI2
 c73oyS3nMZoutEmWctIZmC3i94gOtm5VuBOm7pXiz6P7xtGPtiQSqQgSdqf0S22Ecu4E
 ey0XTwsXwodVt325vwbkzRlHWM6RfDpG5ss7ZoQdweecOMfX0nah6xRCRoTy2zHBxoPb 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sgr2gtg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 02:40:12 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14Q6XvQK082174;
        Wed, 26 May 2021 02:40:12 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sgr2gtes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 02:40:12 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14Q6XV42019134;
        Wed, 26 May 2021 06:40:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 38s1ht06m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 06:40:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14Q6e7c523527868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 06:40:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19FC842045;
        Wed, 26 May 2021 06:40:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D586342041;
        Wed, 26 May 2021 06:40:05 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.39.77])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 26 May 2021 06:40:05 +0000 (GMT)
Date:   Wed, 26 May 2021 09:40:03 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <YK3tQ0a0S/CLxyyb@linux.ibm.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WkcJw4Bam72ZJKEFAxvMPt_MCNaj4EUy
X-Proofpoint-GUID: hLAI5wI0U758LBzexuSnJIMmNFa4grFt
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_04:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=593 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 25, 2021 at 03:25:59PM +0000, Qian Cai (QUIC) wrote:
> Reverting the patchset "arm64: drop pfn_valid_within() and simplify pfn_valid()" [1] from today's linux-next fixed a crash while reading files under /sys/devices/system/memory.

Can you please send the beginning of the boot log, up to the
	 "Memory: xK/yK available ..."
line?
 
> [1] https://lore.kernel.org/kvmarm/20210511100550.28178-1-rppt@kernel.org/
> 
> [  247.669668][ T1443] kernel BUG at include/linux/mm.h:1383!
> [  247.675987][ T1443] Internal error: Oops - BUG: 0 [#1] SMP
> [  247.681472][ T1443] Modules linked in: loop processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit nvme mlx5_core i2c_core nvme_core firmware_class
> [  247.696894][ T1443] CPU: 15 PID: 1443 Comm: ranbug Not tainted 5.13.0-rc3-next-20210524+ #11
> [  247.705326][ T1443] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
> [  247.713842][ T1443] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [  247.720536][ T1443] pc : test_pages_in_a_zone+0x23c/0x300
> [  247.725935][ T1443] lr : test_pages_in_a_zone+0x23c/0x300
> [  247.731327][ T1443] sp : ffff800023f8f670
> [  247.735327][ T1443] x29: ffff800023f8f670 x28: 000000000000a000 x27: 000000000000a000
> [  247.743156][ T1443] x26: ffffffbfffe00000 x25: ffff800011c6f738 x24: dfff800000000000
> [  247.750984][ T1443] x23: 0000000000002000 x22: ffff009f7efa29c0 x21: 0000000000000000
> [  247.758812][ T1443] x20: ffffffffffffffff x19: 0000000000008000 x18: ffff00084f9d3370
> [  247.766640][ T1443] x17: 0000000000000000 x16: 0000000000000007 x15: 0000000000000078
> [  247.774467][ T1443] x14: 0000000000000000 x13: ffff800011c6eea4 x12: ffff60136cee0574
> [  247.782295][ T1443] x11: 1fffe0136cee0573 x10: ffff60136cee0573 x9 : dfff800000000000
> [  247.790123][ T1443] x8 : ffff009b67702b9b x7 : 0000000000000001 x6 : ffff009b67702b98
> [  247.797951][ T1443] x5 : 00009fec9311fa8d x4 : ffff009b67702b98 x3 : 1fffe00109f3a529
> [  247.805778][ T1443] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000034
> [  247.813606][ T1443] Call trace:
> [  247.816738][ T1443]  test_pages_in_a_zone+0x23c/0x300
> [  247.821784][ T1443]  valid_zones_show+0x1e0/0x298
> [  247.826483][ T1443]  dev_attr_show+0x50/0xc8
> [  247.830747][ T1443]  sysfs_kf_seq_show+0x164/0x368
> [  247.835533][ T1443]  kernfs_seq_show+0x130/0x198
> [  247.840143][ T1443]  seq_read_iter+0x344/0xd50
> [  247.844581][ T1443]  kernfs_fop_read_iter+0x32c/0x4a8
> [  247.849625][ T1443]  new_sync_read+0x2bc/0x4e8
> [  247.854063][ T1443]  vfs_read+0x18c/0x340
> [  247.858066][ T1443]  ksys_read+0xf8/0x1e0
> [  247.862068][ T1443]  __arm64_sys_read+0x74/0xa8
> [  247.866591][ T1443]  invoke_syscall.constprop.0+0xdc/0x1d8
> [  247.872072][ T1443]  do_el0_svc+0xe4/0x298
> [  247.876162][ T1443]  el0_svc+0x20/0x30
> [  247.879906][ T1443]  el0_sync_handler+0xb0/0xb8
> [  247.884429][ T1443]  el0_sync+0x178/0x180
> [  247.888435][ T1443] Code: b0005ee1 912b8021 910b0021 97fc57ac (d4210000)
> [  247.895217][ T1443] ---[ end trace 4ff9f5cbe7443f54 ]---
> [  247.900522][ T1443] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [  247.907501][ T1443] SMP: stopping secondary CPUs
> [  247.912122][ T1443] Kernel Offset: disabled
> [  247.916296][ T1443] CPU features: 0x00000251,20000846
> [  247.921340][ T1443] Memory Limit: none
> [  247.925100][ T1443] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
> 

-- 
Sincerely yours,
Mike.
