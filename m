Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6094739D184
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFFVAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 17:00:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45658 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhFFVA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 17:00:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 156KYAOP041978;
        Sun, 6 Jun 2021 16:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=v/Pgm97Z11drNf8nXECRFFf+FeEuyFn2DEcRD37eW0E=;
 b=ccd0R54ELuOhjRkf12xPKuPCHgugZUwz+RXK2R6qka2+e6sU4VKUI6pqyLxjZujF0IA+
 VFr77MX5tKHajhI4Dd6jYAaP6gPKcO5/xgoQ2WW28okqIu/axjFbRzwTGMP3SwRHgchG
 FHXA0SBlTJjqoB6jD+QWkAK7ajPZA9v8ev1ZX/dF8+Y8oKGD87Qg1yn2szRxdoSUZNtN
 YpNljT5W6kEpbeqzzjUcueP5gNkvkey5fQZmYLmWcY9LyUD+TKM1Ii1Nqck73sDkFbN6
 yvK8PsExoMU/oCNjvVByrjnFpvb7tPAIQ3wjFmASGnk9AwqSHWzPgkc0ORKhP6RyTVXr ng== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3914ungtua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Jun 2021 16:58:36 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 156KvOcp021586;
        Sun, 6 Jun 2021 20:58:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3900w8ghae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Jun 2021 20:58:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 156KwWx619530130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Jun 2021 20:58:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F3BA52052;
        Sun,  6 Jun 2021 20:58:32 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.59.223])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 74E285204E;
        Sun,  6 Jun 2021 20:58:31 +0000 (GMT)
Date:   Sun, 6 Jun 2021 23:58:29 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
Message-ID: <YL029aQZb09G3ShY@linux.ibm.com>
References: <YLx/iA8xeRzwhXJn@zn.tnic>
 <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UbvyWy-13jw-GKdD79R5dtEWHE5uIa7m
X-Proofpoint-ORIG-GUID: UbvyWy-13jw-GKdD79R5dtEWHE5uIa7m
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-06_15:2021-06-04,2021-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 phishscore=0 mlxlogscore=961 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106060166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 12:38:32PM -0700, Linus Torvalds wrote:
> On Sun, Jun 6, 2021 at 12:55 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > - Do away with all the wankery of reserving X amount of memory in
> > the first megabyte to prevent BIOS corrupting it and simply and
> > unconditionally reserve the whole first megabyte.
> 
> This seems a bit draconic.
> 
> How does this work at all under Windows? There must be some windows
> knowledge about what the BIOS updates that we're not aware of.

A while ago hpa said:

	As far as I know, Windows 7 actually reserves all memory below
	1 MiB to avoid BIOS bugs.

(https://bugzilla.kernel.org/show_bug.cgi?id=16661#c2)
 
> I've pulled it, but it does seem like something odd is going on.
> 
> And that
> 
>     Fixes: a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
> 
> makes me go "Umm.." too. What did a799c2bd29d1 actually break? It
> looks like it was meant to be a no-op consolidation - if somebody
> bisected to it, I think that is a sign that there's something odd
> there.
 
I also hoped that a799c2bd29d1 would be a no-op consolidation, but I
overlooked that if a user sets CONFIG_X86_RESERVE_LOW or reservelow to 640K
instead of the default 64K, we end up reserving all the memory below 1M
before we allocate the real mode trampoline. This gets even more hairy
because of other things that may also need to reserve the entire first
megabyte, like crash kernel or workaround for Sandy Bridge integrated
graphics bugs.

I believe that reserving everything below 1M after the real mode trampoline
is allocated reduces amount of hidden dependencies and makes things simpler
overall.

-- 
Sincerely yours,
Mike.
