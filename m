Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5240D339E58
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 14:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhCMNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 08:49:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232999AbhCMNsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 08:48:25 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12DDXxmI190261;
        Sat, 13 Mar 2021 08:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Aezt22k7nI1/dEk1EZX87rLj6hGzbx2k2MzYvcp7d6E=;
 b=U6NR5DsIOySWOYxJ5kWVnhMpLY6JDrqTH78/y5DEo3KDFtLiIA9wlbaCJekJsqRfFhLy
 c+IZSahFN1vniZpFss9oKcoANj+YZuI96A1WikVa91sDhQQzUH5z6khOHkz3aPKWXRz7
 /vvUAu3qKXhdb1nWdAuvtlmEFyPzTVjS1riK1H3VDeW2X6cHoBE0kTmJ/6s+HZSRN9pk
 4SlVzZy/38/Po1tRiyiuC7nKEY3fxSZAYa9MV4PQJAMOnMHAl7BuXSPm76AinoIVvUX7
 6Zx1GJ9HYifxTz8Q2mz2cgrXjMExI7HeKZEa7wSsipCs7bVE1+/bvSBARXn/a28TVGM4 pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 378te0byyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Mar 2021 08:48:18 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12DDmINx032872;
        Sat, 13 Mar 2021 08:48:18 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 378te0byyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Mar 2021 08:48:18 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12DDlnqa013157;
        Sat, 13 Mar 2021 13:48:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 378n18gacm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Mar 2021 13:48:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12DDmEro22086114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 13:48:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 294B152054;
        Sat, 13 Mar 2021 13:48:14 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.23.212])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 12E6C5204E;
        Sat, 13 Mar 2021 13:48:12 +0000 (GMT)
Date:   Sat, 13 Mar 2021 15:48:11 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Liang, Liang (Leo)" <Liang.Liang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        linux-kernel@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <YEzCm/Uwvw7kKpd7@linux.ibm.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-13_05:2021-03-12,2021-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103130104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 13, 2021 at 10:05:23AM +0100, David Hildenbrand wrote:
> > Am 13.03.2021 um 05:04 schrieb Liang, Liang (Leo) <Liang.Liang@amd.com>:
> > 
> > Hi David,
> > 
> > Which benchmark tool you prefer? Memtest86+ or else?
> 
> Hi Leo,
> 
> I think you want something that runs under Linux natively.
> 
> I‘m planning on coding up a kernel module to walk all 4MB pages in the
> freelists and perform a stream benchmark individually. Then we might be
> able to identify the problematic range - if there is a problematic range :)

My wild guess would be that the pages that are now at the head of free
lists have wrong caching enabled. Might be worth checking in your test
module.

> Guess I‘ll have it running by Monday and let you know.
> 
> Cheers!

-- 
Sincerely yours,
Mike.
