Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204773DC549
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 11:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhGaJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 05:19:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232371AbhGaJT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 05:19:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16V94aqB158975;
        Sat, 31 Jul 2021 05:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=lJCFZPh6zYoPmvB6VZge0NUSC8dpQezLavM7E24Rq8U=;
 b=ZuvXTLUBwY87LdzWMX4GmsyPBguaYxG2nMHDIxjYYNjdXROTfIWlReymWQiQzQ4+g9Hl
 N1somz2PKCmCa0Ua4ZeWnF+r3LVegEceNKivyQ9Ci+ZyjqmdPEQzUKQFgsFRKyQvsO8y
 cN4cv5FhnPaxKUM5Hs+RpBWztK8LNWORK3GINIxNXmuAm8W1bAos5wH7dN4IcVN24npC
 sQ5Fv5gXcqXp6k/KSNBp7z6XRuquWX4RRGRnxwDdi1am1lv/aj68xhyjuryfMyjbix3i
 TZlgp+dB+mSLnElAWHQ44i/YG7ZnvZEtDJzU6Mk1rraaJd6cnqNl1KDkvN2lu822oSHg IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a531mgx8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 05:19:21 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16V96Y39170209;
        Sat, 31 Jul 2021 05:19:21 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a531mgx87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 05:19:21 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16V9DPW8001901;
        Sat, 31 Jul 2021 09:19:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3a4x5909y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 09:19:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16V9GU6l27787676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 31 Jul 2021 09:16:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E75942047;
        Sat, 31 Jul 2021 09:19:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E073442041;
        Sat, 31 Jul 2021 09:19:15 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.187.235])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 31 Jul 2021 09:19:15 +0000 (GMT)
Date:   Sat, 31 Jul 2021 12:19:13 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Michael Cree <mcree@orcon.net.nz>, linux-mm@kvack.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regression bisected to fa3354e4ea39 (mm: free_area_init: use
 maximal zone PFNs rather than zone sizes)
Message-ID: <YQUVkbhX0U3te1l6@linux.ibm.com>
References: <20210726192311.uffqnanxw3ac5wwi@ivybridge>
 <YP8Vxt0xuV1m5EPS@linux.ibm.com>
 <CAEdQ38F2ddbM0WBjut6MH-0TpencKmx9Wu4++gLtfQ5HGRwxFQ@mail.gmail.com>
 <YP+rI9Fh4wl/O6/8@linux.ibm.com>
 <CAEdQ38G+ZfXmc01iZTc+q4dYpRqQJUz0KNFCPwTQ25AYqJVbMA@mail.gmail.com>
 <YQBvYUupT/jgDMqI@linux.ibm.com>
 <CAEdQ38HZ4g_E3vtG=f6p_sfuWnk7haK_eJ0MZziLsOq0ZmfBoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEdQ38HZ4g_E3vtG=f6p_sfuWnk7haK_eJ0MZziLsOq0ZmfBoQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AxbwOAlgTTu-wCGYwBmM3qGCe3OD30sN
X-Proofpoint-ORIG-GUID: MJwEW2mI35ujpAAPn6_iP0y15ujHymB5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-31_05:2021-07-30,2021-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=868 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 clxscore=1011 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107310046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:53:58PM -0700, Matt Turner wrote:
> On Tue, Jul 27, 2021 at 1:41 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > On Tue, Jul 27, 2021 at 12:24:26PM -0700, Matt Turner wrote:
> > >
> > > Thanks, this patch fixes it. With the patch applied, I see
> > >
> > > Zone ranges:
> > >   DMA      [mem 0x0000000000000000-0x00000fffffffdfff]
> > >   Normal   empty
> > > Movable zone start for each node
> > > Early memory node ranges
> > >   node   0: [mem 0x0000000000000000-0x00000001ffffffff]
> > >   node   0: [mem 0x0000000400000000-0x00000005ffffffff]
> > > Initmem setup node 0 [mem 0x0000000000000000-0x00000005ffffffff]
> > >
> > > If you want to send me this patch with your S-o-b I'll take it through
> > > my alpha git tree.
> >
> > The patch is on its way :)
> 
> Thanks a bunch, Mike, for the patch and for all you do!
> 
> > Now I'm really curios how commit e7793e53901b ("arc: update comment about
> > HIGHMEM implementation") will work out.

Oh, sure, I've copied the wrong line from the log :)
 
> You probably mean fdb7d9b7acd0 ("alpha: remove DISCONTIGMEM and
> NUMA"). Works well so far!
> 
> Maybe in some alternative universe where I have infinite free time
> (and my own power plant!) I'll get a second AlphaServer ES47 with the
> enormous "hose" [1] to link the two and I'll poke you for guidance on
> restoring NUMA support :)

Heh, I'm not sure that restoring NUMA on alpha is really good use for free
time even if it were infinite :)
 
-- 
Sincerely yours,
Mike.
