Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8521630634A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhA0S2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:28:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236211AbhA0S14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:27:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10RIHDCI036792;
        Wed, 27 Jan 2021 13:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Cs7vVcVEinjdu3nzZ3wIpq6Kuaavfjxy7BT5QDRN1K4=;
 b=J0MhQnoZR5MlkQZVKI8K7JsaVnUdbxSuzYIHqt0BXQPgZfMiC3iLal+me9qFC2gddfb4
 fTwJjqBqhO9MWVy/fAR7h+8BfzhFlM/g5rClB1Yr/cizmXzNC2aeWU90DUd7Z5fLxTj7
 QFcx0bGMmHQe+CE3Rq2PuQQ3fU1zCEcTtYBbZb8jWlK23wNn0pH67TEQGWnR5ws1qWYa
 yUlFv/QXR7yqHGRaWj63/6/oiughR4w3ocRxvcjqMGOiWxkCMO3CAwBk6HFROZmwtLW5
 k7NtIlhEkXjktJaG3h95WazALLoRWpwabLeTlN9rEyM/4vt6fw4Uuir9tWdAijtNuwO3 sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36b5awe549-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 13:27:02 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10RIHJV3037717;
        Wed, 27 Jan 2021 13:27:01 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36b5awe53s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 13:27:01 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10RII4qs001584;
        Wed, 27 Jan 2021 18:26:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 368be7v309-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 18:26:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10RIQvmM39584002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 18:26:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 707EDA4060;
        Wed, 27 Jan 2021 18:26:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C16DEA405B;
        Wed, 27 Jan 2021 18:26:54 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.191.214])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Jan 2021 18:26:54 +0000 (GMT)
Date:   Wed, 27 Jan 2021 20:26:51 +0200
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
Message-ID: <20210127182651.GA281042@linux.ibm.com>
References: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
 <20210127100454.GK196782@linux.ibm.com>
 <CAFJ_xboaFNQ9NuZ1rhH8WdejoFRzvez9cp2AQ59rKY6T_xZ-_w@mail.gmail.com>
 <20210127111858.GA273567@linux.ibm.com>
 <CAFJ_xbo8Zv9VdJibC106sFOqoYsVhifm0eh=VWtMzeoUE4KVWA@mail.gmail.com>
 <CAFJ_xbrwLwgDfCyHA=PmJ8j_3dJXqVNxmv7e+ATQAAa9n3de2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJ_xbrwLwgDfCyHA=PmJ8j_3dJXqVNxmv7e+ATQAAa9n3de2w@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_06:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wed, Jan 27, 2021 at 02:15:53PM +0100, Łukasz Majczak wrote:
> Hi Mike,
> 
> I have started bisecting your patch and I have figured out that there
> might be something wrong with clamping - with comments out these lines
> it started to work.
> The full log (with logs from below patch) can be found here:
> https://gist.github.com/semihalf-majczak-lukasz/3cecbab0ddc59a6c3ce11ddc29645725
> it's fresh - I haven't analyze it yet, just sharing with hope it will help.

Thanks, that helps!

The first page is never considered by the kernel as memory and so
arch_zone_lowest_possible_pfn[ZONE_DMA] is set to 0x1000. As the result,
init_unavailable_mem() skips pfn 0 and then __SetPageReserved(page) in
reserve_bootmem_region() panics because the struct page for pfn 0 remains
poisoned.

Can you please try the below patch on top of v5.11-rc5?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 783913e41f65..3ce9ef238dfc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7083,10 +7083,11 @@ void __init free_area_init_memoryless_node(int nid)
 static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn,
 					 int zone, int nid)
 {
-	unsigned long pfn, zone_spfn, zone_epfn;
+	unsigned long pfn, zone_spfn = 0, zone_epfn;
 	u64 pgcnt = 0;
 
-	zone_spfn = arch_zone_lowest_possible_pfn[zone];
+	if (zone > 0)
+		zone_spfn = arch_zone_highest_possible_pfn[zone - 1];
 	zone_epfn = arch_zone_highest_possible_pfn[zone];
 
 	spfn = clamp(spfn, zone_spfn, zone_epfn);

 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eed54ce26ad1..9f4468c413a1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7093,9 +7093,11 @@ static u64 __init
> init_unavailable_range(unsigned long spfn, unsigned long epfn,
>         zone_spfn = arch_zone_lowest_possible_pfn[zone];
>         zone_epfn = arch_zone_highest_possible_pfn[zone];
> 
> -       spfn = clamp(spfn, zone_spfn, zone_epfn);
> -       epfn = clamp(epfn, zone_spfn, zone_epfn);
> -
> +       //spfn = clamp(spfn, zone_spfn, zone_epfn);
> +       //epfn = clamp(epfn, zone_spfn, zone_epfn);
> +       pr_info("LMA DBG: zone_spfn: %llx, zone_epfn %llx\n",
> zone_spfn, zone_epfn);
> +       pr_info("LMA DBG: spfn: %llx, epfn %llx\n", spfn, epfn);
> +       pr_info("LMA DBG: clamp_spfn: %llx, clamp_epfn %llx\n",
> clamp(spfn, zone_spfn, zone_epfn), clamp(epfn, zone_spfn, zone_epfn));
>         for (pfn = spfn; pfn < epfn; pfn++) {
>                 if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
>                         pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> 
> Best regards,
> Lukasz
> 
> 
> śr., 27 sty 2021 o 13:15 Łukasz Majczak <lma@semihalf.com> napisał(a):
> >
> > Unfortunately nothing :( my current kernel command line contains:
> > console=ttyS0,115200n8 debug earlyprintk=serial loglevel=7
> >
> > I was thinking about using earlycon, but it seems to be blocked.
> > (I think the lack of earlycon might be related to Chromebook HW
> > security design. There is an EC controller which is a part of AP ->
> > serial chain as kernel messages are considered sensitive from a
> > security standpoint.)
> >
> > Best regards,
> > Lukasz
> >
> > śr., 27 sty 2021 o 12:19 Mike Rapoport <rppt@linux.ibm.com> napisał(a):
> > >
> > > On Wed, Jan 27, 2021 at 11:08:17AM +0100, Łukasz Majczak wrote:
> > > > Hi Mike,
> > > >
> > > > Actually I have a serial console attached (via servo device), but
> > > > there is no output :( and also the reboot/crash is very fast/immediate
> > > > after power on.
> > >
> > > If you boot with earlyprintk=serial are there any messages?
> > >
> > > > Best regards
> > > > Lukasz
> > > >
> > > > śr., 27 sty 2021 o 11:05 Mike Rapoport <rppt@linux.ibm.com> napisał(a):
> > > > >
> > > > > Hi Lukasz,
> > > > >
> > > > > On Wed, Jan 27, 2021 at 10:22:29AM +0100, Łukasz Majczak wrote:
> > > > > > Crash after mm: fix initialization of struct page for holes in memory layout
> > > > > >
> > > > > > Hi,
> > > > > > I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (Caroline),
> > > > > > but I've noticed it has crashed - unfortunately it seems to happen at
> > > > > > a very early stage - No output to the console nor to the screen, so I
> > > > > > have started a bisect (between 5.11-rc4 - which works just find - and
> > > > > > 5.11-rc5),
> > > > > > bisect results points to:
> > > > > >
> > > > > > d3921cb8be29 mm: fix initialization of struct page for holes in memory layout
> > > > > >
> > > > > > Reproduction is just to build and load the kernel.
> > > > > >
> > > > > > If it will help any how I am attaching:
> > > > > > - /proc/cpuinfo (from healthy system):
> > > > > > https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f07377c1a785b64a97066
> > > > > > - my .config file (for a broken system):
> > > > > > https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e43b53efe8e18b5da33c
> > > > > >
> > > > > > If there is anything I could add/do/test to help fix this please let me know.
> > > > >
> > > > > Chris Wilson also reported boot failures on several Chromebooks:
> > > > >
> > > > > https://lore.kernel.org/lkml/161160687463.28991.354987542182281928@build.alporthouse.com
> > > > >
> > > > > I presume serial console is not an option, so if you could boot with
> > > > > earlyprintk=vga and see if there is anything useful printed on the screen
> > > > > it would be really helpful.
> > > > >
> > > > > > Best regards
> > > > > > Lukasz
> > > > >
> > > > > --
> > > > > Sincerely yours,
> > > > > Mike.
> > >
> > > --
> > > Sincerely yours,
> > > Mike.

-- 
Sincerely yours,
Mike.
