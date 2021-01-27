Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761EB305980
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbhA0LVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:21:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236458AbhA0LUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:20:00 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10RB4xC6098979;
        Wed, 27 Jan 2021 06:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=HvXyQ1nsl8T650lX2tqx/YmDVaCV1S3RYHWwvIx4vag=;
 b=mTt0TxC0Qx2+EFAp6SCPItWFzs3w2/llK8mQtjIKztXfrsz0HVWFutL0UOBehWoPwRHW
 VxozA+yYDN+w5GwaHnzRqBU5hi+mGsdRIcKGrRPBXqGzCEt+0FgiCNok4zbm61E2GJrD
 lQZJL9om9sekxCleyz3VcqjQXQ0YaQl1odm32J2Mi+8F+oTLdaUXh3sXu9hgvoZqSXdE
 Y4+iIfbLOfi9IslEEB+TGc7pARN7Ho7gu/D5VE6mniVrEOdKRIu2JCmOglvxfl0pnNr7
 ZOEovWqbW3lD13INdt7qHZ7l7l/fh64sWR/1n7f7PwasI1xN5gbqAuSZmvxLnM3RP4ZX zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36aweepa23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 06:19:07 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10RB5Tdd102304;
        Wed, 27 Jan 2021 06:19:07 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36aweepa1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 06:19:07 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10RBJ5pw032546;
        Wed, 27 Jan 2021 11:19:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 368be7ur4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 11:19:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10RBJ30h31392088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 11:19:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ED5811C04C;
        Wed, 27 Jan 2021 11:19:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D837A11C04A;
        Wed, 27 Jan 2021 11:19:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.191.214])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Jan 2021 11:19:00 +0000 (GMT)
Date:   Wed, 27 Jan 2021 13:18:58 +0200
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
Message-ID: <20210127111858.GA273567@linux.ibm.com>
References: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
 <20210127100454.GK196782@linux.ibm.com>
 <CAFJ_xboaFNQ9NuZ1rhH8WdejoFRzvez9cp2AQ59rKY6T_xZ-_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJ_xboaFNQ9NuZ1rhH8WdejoFRzvez9cp2AQ59rKY6T_xZ-_w@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_04:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:08:17AM +0100, Łukasz Majczak wrote:
> Hi Mike,
> 
> Actually I have a serial console attached (via servo device), but
> there is no output :( and also the reboot/crash is very fast/immediate
> after power on.
 
If you boot with earlyprintk=serial are there any messages?

> Best regards
> Lukasz
> 
> śr., 27 sty 2021 o 11:05 Mike Rapoport <rppt@linux.ibm.com> napisał(a):
> >
> > Hi Lukasz,
> >
> > On Wed, Jan 27, 2021 at 10:22:29AM +0100, Łukasz Majczak wrote:
> > > Crash after mm: fix initialization of struct page for holes in memory layout
> > >
> > > Hi,
> > > I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (Caroline),
> > > but I've noticed it has crashed - unfortunately it seems to happen at
> > > a very early stage - No output to the console nor to the screen, so I
> > > have started a bisect (between 5.11-rc4 - which works just find - and
> > > 5.11-rc5),
> > > bisect results points to:
> > >
> > > d3921cb8be29 mm: fix initialization of struct page for holes in memory layout
> > >
> > > Reproduction is just to build and load the kernel.
> > >
> > > If it will help any how I am attaching:
> > > - /proc/cpuinfo (from healthy system):
> > > https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f07377c1a785b64a97066
> > > - my .config file (for a broken system):
> > > https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e43b53efe8e18b5da33c
> > >
> > > If there is anything I could add/do/test to help fix this please let me know.
> >
> > Chris Wilson also reported boot failures on several Chromebooks:
> >
> > https://lore.kernel.org/lkml/161160687463.28991.354987542182281928@build.alporthouse.com
> >
> > I presume serial console is not an option, so if you could boot with
> > earlyprintk=vga and see if there is anything useful printed on the screen
> > it would be really helpful.
> >
> > > Best regards
> > > Lukasz
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
