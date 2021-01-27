Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1B3057DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhA0KIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:08:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235572AbhA0KFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:05:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10RA2uWt064715;
        Wed, 27 Jan 2021 05:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=ZbyhUIIa6b/q5x+lD1FboRzmgCjgx7QUQ+N1eISoezM=;
 b=Tew4nsOLTlLR9zsPScAKuBOGOw1RUuk6OgdnZsQJmkA2H0FxLuBjG6gDz9QGDsXuP5Xg
 +sVouO1lk6ZP84Xx840zWK16ZHzVvNcGnV8Ya97Lrnz7eS8U9RqeSoI7LS9sf09wvIh0
 xmuRiFeDGpXiBMrD2dpDPzZt8m4T1S14rmKyYEKZi5ZZcHct9p6eMeY7wea44uvLTS29
 jsgB/ZI4ZMwTHEUbd1Zn2NdRRu5vOh9QlssMs/zW7Ky9xUVarH2DamoNdaGsNM9kHQcJ
 Y9xDY/5ZNQGxyVdWYgpMjzzS6w4+lWyEU8BfgY3d/7g6uUO/SrQJPV0W6j8HQ7ikepEd IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36b410umtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 05:05:03 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10RA36eh065860;
        Wed, 27 Jan 2021 05:05:03 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36b410umsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 05:05:03 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10RA31Td003257;
        Wed, 27 Jan 2021 10:05:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 368be7up8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 10:05:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10RA4x1c42205520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 10:04:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66B8652051;
        Wed, 27 Jan 2021 10:04:59 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.68.25])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C4F1552050;
        Wed, 27 Jan 2021 10:04:57 +0000 (GMT)
Date:   Wed, 27 Jan 2021 12:04:54 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     =?utf-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>,
        Guenter Roeck <groeck@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>
Subject: Re: PROBLEM: Crash after mm: fix initialization of struct page for
 holes in memory layout
Message-ID: <20210127100454.GK196782@linux.ibm.com>
References: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_04:2021-01-26,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wed, Jan 27, 2021 at 10:22:29AM +0100, Łukasz Majczak wrote:
> Crash after mm: fix initialization of struct page for holes in memory layout
> 
> Hi,
> I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (Caroline),
> but I've noticed it has crashed - unfortunately it seems to happen at
> a very early stage - No output to the console nor to the screen, so I
> have started a bisect (between 5.11-rc4 - which works just find - and
> 5.11-rc5),
> bisect results points to:
> 
> d3921cb8be29 mm: fix initialization of struct page for holes in memory layout
> 
> Reproduction is just to build and load the kernel.
> 
> If it will help any how I am attaching:
> - /proc/cpuinfo (from healthy system):
> https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f07377c1a785b64a97066
> - my .config file (for a broken system):
> https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e43b53efe8e18b5da33c
> 
> If there is anything I could add/do/test to help fix this please let me know.

Chris Wilson also reported boot failures on several Chromebooks:

https://lore.kernel.org/lkml/161160687463.28991.354987542182281928@build.alporthouse.com

I presume serial console is not an option, so if you could boot with
earlyprintk=vga and see if there is anything useful printed on the screen
it would be really helpful.

> Best regards
> Lukasz

-- 
Sincerely yours,
Mike.
