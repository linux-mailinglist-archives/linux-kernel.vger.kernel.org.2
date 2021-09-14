Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A840A628
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 07:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbhINFtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 01:49:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239689AbhINFtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 01:49:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18E4Z3cw022268;
        Tue, 14 Sep 2021 01:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/VpZtdNzYrqZuVxW4hiLpEQZyzc1BnA7ReJVDhGvUQM=;
 b=fRRa085lMIf10cd1d2LKhroHGVoD82F+WhYU2LacffXPmPzaesAqO6iF8/rhhdeY4lq/
 7nw5RQ2POFuEn/oCHDAF5JGnc8USWKF/+WcFMQl6qi0yea3VBC8otUUeD8R8885tyWeN
 Udqaya71hvz/fAP9WdQMrAhglHO5RDjHtI+XCEdRhpsrNedtYN2nGAkkR19HFUWEcYNx
 CkJntheHv9iZAztWpdSxVYalhP2c4TA3vrVLHCcswfsL7+MPWqXqO82vucM7fPfWk8Xf
 hb/K6QGORJIG25nCoaMOW/ldznO7R8HcPzt96K5ZpAtoTjAQCE8NG9LkiwF0Yzn2/2/j fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b2mub92ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 01:48:14 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18E5ScOh028181;
        Tue, 14 Sep 2021 01:48:14 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b2mub929x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 01:48:14 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18E5m7mT029668;
        Tue, 14 Sep 2021 05:48:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3b0m396afd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 05:48:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18E5mAxD42402234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 05:48:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE347AE045;
        Tue, 14 Sep 2021 05:48:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EBD8AE04D;
        Tue, 14 Sep 2021 05:48:09 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.48.104])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 14 Sep 2021 05:48:09 +0000 (GMT)
Date:   Tue, 14 Sep 2021 08:48:07 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: Linux 5.13+ as Xen dom0 crashes on Ryzen CPU (ucode loading
 related?)
Message-ID: <YUA3l0gnTh0gDJ4d@linux.ibm.com>
References: <YT9I+Xs9wOPVCIVd@mail-itl>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <YT9I+Xs9wOPVCIVd@mail-itl>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -uT1WsMIWRkcvek1E0xEUKDb7S2Mk9gy
X-Proofpoint-GUID: Lm4V19AmkqSPfjviWQ2kZm2WQyq4nFi0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Mon, Sep 13, 2021 at 02:50:00PM +0200, Marek Marczykowski-Górecki wrote:
> Hi,
> 
> Since 5.13, the Xen (PV) dom0 crashes on boot, before even printing the
> kernel version.
> Test environment:
>  - Xen 4.14.2
>  - AMD Ryzen 5 4500U (reported also on AMD Ryzen 7 4750U)
>  - Linux 5.13.13, confirmed also on 5.14
> 
> The crash happens only if the initramfs has earlycpio with microcode.

Does the crash happen if you boot the same kernel and initrd directly
without Xen?

> I don't have a serial console, but I've got a photo with crash message
> (from Xen, Linux doesn't managed to print anything):
> https://user-images.githubusercontent.com/726704/133084966-5038f37e-001b-4688-9f90-83d09be3dc2d.jpg
> 
> Transcription of some of it:
> 
>     mapping kernel into physical memory
>     about to get started
>     (XEN) Pagetable walk from ffffffff82810888:
>     (XEN)  L4[0x1ff] = 0000000332815067 0000000000002815
>     (XEN)  L3[0x1fe] = 0000000332816067 0000000000002816
>     (XEN)  L2[0x014] = 0000000334018067 0000000000004018
>     (XEN)  L1[0x010] = 0000000332810067 0000000000002810
>     (XEN) domain_crash_sync called from entry.S: fault at ffff82d04033e790 x86_64/entry.S#domain_crash_page_fault
>     (XEN) Domain 0 (vcpu#0) crashed on cpu#0:
>     (XEN) ----[ Xen-4.14.2  x86_64  debug=n  Not tainted ]----
>     (XEN) CPU:    0
>     (XEN) RIP:    e033:[<0000000000000000>]

Is it possible to get the actual RIP of the instruction that faulted? 
Feeding that to scripts/faddr2line would be just lovely.
 
> I've bisected it down to the commit a799c2bd29d19c565f37fa038b31a0a1d44d0e4d
> 
>     x86/setup: Consolidate early memory reservations
> 
> Since this seems to affect Xen boot only, I'm copying xen-devel too.
> 
> Any ideas?

The only thing I can suggest for now is to move the reservations from
early_reserve_memory() back to where they were before this commit one by
one to see which move caused the crash.

-- 
Sincerely yours,
Mike.
