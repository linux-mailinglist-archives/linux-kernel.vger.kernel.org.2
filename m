Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038A7391E14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhEZR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:26:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhEZR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:26:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QHP2YQ144455;
        Wed, 26 May 2021 13:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BcNi/E4J69pn4dNKoVAv0uJlQzSvrjXxDhv3YnEHa9I=;
 b=kZI3xdr8i7fSCVdXmGIcljHkx1PElvhDd5+Ql0R0mHScYcBuf2L2GEET1+qrOB/kOJAs
 +n/1jaU6vjUBvFxcjpuOUVJDPDvmn0hhTp4mSU1FmKIDDWe4N6KfjwUtDdbWhGgy0rTz
 LmyaWXNGYieJ5oR4vFtWv4cMpDIJqogNQXJW6XQTfUFzgUKypilw1Sk3qp1zncXQ0Yg3
 62YRzIcWyX1IwEIzgy80Ekf4vtpIiF2zA51y2+l7Cp3naXsajis6vCAlK4SFgebABMD/
 hSCcZWS/VUUCZ7XnmuOa1ktRAzG0z9z4t5AEgclPxV2YGQ0rOe8RIcSa4NyCDb4Dn6jz rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38stqb002n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 13:25:13 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14QHPCvJ000906;
        Wed, 26 May 2021 13:25:13 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38stqb0027-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 13:25:12 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14QH7pvQ029803;
        Wed, 26 May 2021 17:25:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38s1r48s3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 17:25:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14QHOclL33554898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 17:24:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A7C0A4069;
        Wed, 26 May 2021 17:25:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FC91A405B;
        Wed, 26 May 2021 17:25:06 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.39.77])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 26 May 2021 17:25:06 +0000 (GMT)
Date:   Wed, 26 May 2021 20:25:04 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <YK6EcMPETjBkVahC@linux.ibm.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <20210526130426.GD19992@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526130426.GD19992@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SvMP2yqVC7yeAmHto_8H_DXErAIaLv8b
X-Proofpoint-ORIG-GUID: JhfW_8a7tKAzwDeqWzdu2l-in_x29H7X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_10:2021-05-26,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=898 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 02:04:26PM +0100, Catalin Marinas wrote:
> On Wed, May 26, 2021 at 12:09:14PM +0000, Qian Cai (QUIC) wrote:
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]
> 
> Maybe de-selecting HOLES_IN_ZONE is not correct for arm64 in all
> circumstances. In a configuration with 64K pages, MAX_ORDER is 14,
> MAX_ORDER_NR_PAGES is 8192, so a 2^29 address range. However, the above
> range starts on 2^28 boundary.
> 
> SECTION_SIZE_BITS is 29 in this configuration but the corresponding
> mem_map[] in the first half of the first section is probably not marked
> as reserved as we'd do for NOMAP.

We do initialize (or at least we should) the first of the first section in
page_alloc::init_unavailable_range() so the range [0x8000000 - 0x9000000]
will have struct pages marked as reserved.

I think it should be fine to de-select HOLES_IN_ZONE as long as MAX_ORDER
chunk does not exceed a section because we do have memory map there in such
case and HOLES_IN_ZONE along with pfn_valid_within() protected against
access to non-existing memory map entries.

We still have an issue with memory map initialization, and probably I've
missed something in decoupling of "do we have memory there" from
pfn_valid().

-- 
Sincerely yours,
Mike.
