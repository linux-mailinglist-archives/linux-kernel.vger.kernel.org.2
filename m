Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97903072DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhA1Jft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:35:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232605AbhA1Jcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:32:48 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10S9Vuj4091082;
        Thu, 28 Jan 2021 04:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=3Q2qmiEifmRSPBb1Bip1Gm9i9vcD47f/XUqE1pAP5QA=;
 b=mBwEYkbLLBX6CkFNL3AOe7+yTQgPflpMqs9mH77s9zNyk121NSGoaOb7B5IZUTakj+RP
 HBvZX7oCT2quPLp+7K0hYCoFVuwaFtFILv1HCYVto/bH/lU0XDa8eJFRSWFmIVsN3HH2
 kY+c6NprCmqqPQ0VjBF6mCgSyeY0yfsRT1/j2iVEiGIqhY//AwgFCaAI5jGG3wrd2cOk
 2yPEYeK5pf7WO8bhHxyTolNcuIJKa7duu7QjaOkbRzZm0uOVPpnvBLkNcpvS+Vd7/AFr
 EdNcVOoS48TpQgwljkLTsHs1X2NtKAJpvW3NBadZbMl0COhKAY5nZAwRv72bBMb+KSyi XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36brxgu4qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 04:31:57 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10S91vVK166493;
        Thu, 28 Jan 2021 04:31:40 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36brxgu4ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 04:31:40 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10S9HNv3024670;
        Thu, 28 Jan 2021 09:31:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 368b2h4np4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 09:31:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10S9VW4f44433778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 09:31:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A796A4053;
        Thu, 28 Jan 2021 09:31:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BADA0A4051;
        Thu, 28 Jan 2021 09:31:29 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.187.107])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Jan 2021 09:31:29 +0000 (GMT)
Date:   Thu, 28 Jan 2021 11:31:27 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     =?utf-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
Message-ID: <20210128093127.GB299309@linux.ibm.com>
References: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
 <20210127100454.GK196782@linux.ibm.com>
 <CAFJ_xboaFNQ9NuZ1rhH8WdejoFRzvez9cp2AQ59rKY6T_xZ-_w@mail.gmail.com>
 <20210127111858.GA273567@linux.ibm.com>
 <CAFJ_xbo8Zv9VdJibC106sFOqoYsVhifm0eh=VWtMzeoUE4KVWA@mail.gmail.com>
 <CAFJ_xbrwLwgDfCyHA=PmJ8j_3dJXqVNxmv7e+ATQAAa9n3de2w@mail.gmail.com>
 <20210127182651.GA281042@linux.ibm.com>
 <20210128024549.GA3693@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210128024549.GA3693@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_05:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:45:49AM +0800, Baoquan He wrote:
> On 01/27/21 at 08:26pm, Mike Rapoport wrote:
> > Hi Lukasz,
> > 
> > On Wed, Jan 27, 2021 at 02:15:53PM +0100, Łukasz Majczak wrote:
> > > Hi Mike,
> > > 
> > > I have started bisecting your patch and I have figured out that there
> > > might be something wrong with clamping - with comments out these lines
> > > it started to work.
> > > The full log (with logs from below patch) can be found here:
> > > https://gist.github.com/semihalf-majczak-lukasz/3cecbab0ddc59a6c3ce11ddc29645725
> > > it's fresh - I haven't analyze it yet, just sharing with hope it will help.
> > 
> > Thanks, that helps!
> > 
> > The first page is never considered by the kernel as memory and so
> > arch_zone_lowest_possible_pfn[ZONE_DMA] is set to 0x1000. As the result,
> > init_unavailable_mem() skips pfn 0 and then __SetPageReserved(page) in
> > reserve_bootmem_region() panics because the struct page for pfn 0 remains
> > poisoned.
> 
> It's a great finding and quick fix.

Unfortunately it's only a partial fix as it does not address the problem of
having pfn 0 outside any zone. It gets ZONE_DMA link at
init_unavailable_mem(), but zones[ZONE_DMA]->zone_start_pfn is 1.

I'm looking now how to fix this as well, hopefully I'll have a patch Real
Soon (tm) :)

>  Previously I tested my cleanup patches based on Mike's commit
>  9ebeee59af4cdd4d ("mm: fix initialization of struct page for holes in
>  memory layout") on a hardware system, didn't meet this crash. But this
>  crash seems to be a always reproduced issue, wondering why I didn't
>  reproduce it.

This crash is reproducible on systems that do not report pfn 0 as usable,
e.g for Chromebook Lukasz is using it is 'type 16':

[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] type 16
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable

And on my laptop and on a bunch of other systems I have it is usable:

[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x000000000009ffff] reserved

 
> > 
> > Can you please try the below patch on top of v5.11-rc5?
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 783913e41f65..3ce9ef238dfc 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7083,10 +7083,11 @@ void __init free_area_init_memoryless_node(int nid)
> >  static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn,
> >  					 int zone, int nid)
> >  {
> > -	unsigned long pfn, zone_spfn, zone_epfn;
> > +	unsigned long pfn, zone_spfn = 0, zone_epfn;
> >  	u64 pgcnt = 0;
> >  
> > -	zone_spfn = arch_zone_lowest_possible_pfn[zone];
> > +	if (zone > 0)
> > +		zone_spfn = arch_zone_highest_possible_pfn[zone - 1];
> >  	zone_epfn = arch_zone_highest_possible_pfn[zone];
> >  
> >  	spfn = clamp(spfn, zone_spfn, zone_epfn);
> > 
> >  
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index eed54ce26ad1..9f4468c413a1 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -7093,9 +7093,11 @@ static u64 __init
> > > init_unavailable_range(unsigned long spfn, unsigned long epfn,
> > >         zone_spfn = arch_zone_lowest_possible_pfn[zone];
> > >         zone_epfn = arch_zone_highest_possible_pfn[zone];
> > > 
> > > -       spfn = clamp(spfn, zone_spfn, zone_epfn);
> > > -       epfn = clamp(epfn, zone_spfn, zone_epfn);
> > > -
> > > +       //spfn = clamp(spfn, zone_spfn, zone_epfn);
> > > +       //epfn = clamp(epfn, zone_spfn, zone_epfn);
> > > +       pr_info("LMA DBG: zone_spfn: %llx, zone_epfn %llx\n",
> > > zone_spfn, zone_epfn);
> > > +       pr_info("LMA DBG: spfn: %llx, epfn %llx\n", spfn, epfn);
> > > +       pr_info("LMA DBG: clamp_spfn: %llx, clamp_epfn %llx\n",
> > > clamp(spfn, zone_spfn, zone_epfn), clamp(epfn, zone_spfn, zone_epfn));
> > >         for (pfn = spfn; pfn < epfn; pfn++) {
> > >                 if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> > >                         pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> > > 
> > > Best regards,
> > > Lukasz
> > > 
> > > 
> > > śr., 27 sty 2021 o 13:15 Łukasz Majczak <lma@semihalf.com> napisał(a):
> > > >
> > > > Unfortunately nothing :( my current kernel command line contains:
> > > > console=ttyS0,115200n8 debug earlyprintk=serial loglevel=7
> > > >
> > > > I was thinking about using earlycon, but it seems to be blocked.
> > > > (I think the lack of earlycon might be related to Chromebook HW
> > > > security design. There is an EC controller which is a part of AP ->
> > > > serial chain as kernel messages are considered sensitive from a
> > > > security standpoint.)
> > > >
> > > > Best regards,
> > > > Lukasz
> > > >
> > > > śr., 27 sty 2021 o 12:19 Mike Rapoport <rppt@linux.ibm.com> napisał(a):
> > > > >
> > > > > On Wed, Jan 27, 2021 at 11:08:17AM +0100, Łukasz Majczak wrote:
> > > > > > Hi Mike,
> > > > > >
> > > > > > Actually I have a serial console attached (via servo device), but
> > > > > > there is no output :( and also the reboot/crash is very fast/immediate
> > > > > > after power on.
> > > > >
> > > > > If you boot with earlyprintk=serial are there any messages?
> > > > >
> > > > > > Best regards
> > > > > > Lukasz
> > > > > >
> > > > > > śr., 27 sty 2021 o 11:05 Mike Rapoport <rppt@linux.ibm.com> napisał(a):
> > > > > > >
> > > > > > > Hi Lukasz,
> > > > > > >
> > > > > > > On Wed, Jan 27, 2021 at 10:22:29AM +0100, Łukasz Majczak wrote:
> > > > > > > > Crash after mm: fix initialization of struct page for holes in memory layout
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > > I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (Caroline),
> > > > > > > > but I've noticed it has crashed - unfortunately it seems to happen at
> > > > > > > > a very early stage - No output to the console nor to the screen, so I
> > > > > > > > have started a bisect (between 5.11-rc4 - which works just find - and
> > > > > > > > 5.11-rc5),
> > > > > > > > bisect results points to:
> > > > > > > >
> > > > > > > > d3921cb8be29 mm: fix initialization of struct page for holes in memory layout
> > > > > > > >
> > > > > > > > Reproduction is just to build and load the kernel.
> > > > > > > >
> > > > > > > > If it will help any how I am attaching:
> > > > > > > > - /proc/cpuinfo (from healthy system):
> > > > > > > > https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f07377c1a785b64a97066
> > > > > > > > - my .config file (for a broken system):
> > > > > > > > https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e43b53efe8e18b5da33c
> > > > > > > >
> > > > > > > > If there is anything I could add/do/test to help fix this please let me know.
> > > > > > >
> > > > > > > Chris Wilson also reported boot failures on several Chromebooks:
> > > > > > >
> > > > > > > https://lore.kernel.org/lkml/161160687463.28991.354987542182281928@build.alporthouse.com
> > > > > > >
> > > > > > > I presume serial console is not an option, so if you could boot with
> > > > > > > earlyprintk=vga and see if there is anything useful printed on the screen
> > > > > > > it would be really helpful.
> > > > > > >
> > > > > > > > Best regards
> > > > > > > > Lukasz
> > > > > > >
> > > > > > > --
> > > > > > > Sincerely yours,
> > > > > > > Mike.
> > > > >
> > > > > --
> > > > > Sincerely yours,
> > > > > Mike.
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> > 
> 

-- 
Sincerely yours,
Mike.
