Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0FA39B1C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 07:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhFDFEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 01:04:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhFDFEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:04:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1544q1Y7189594;
        Fri, 4 Jun 2021 01:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pp1; bh=RY9HHRMtm3r4/6fcd4vCA6IZ3fBnma5IDrwpb+zYcow=;
 b=dHYpVnq/RWkxu4431l7Pp3NhpiFhqkrurUsW09BdZZqaow+3kjzKLIY/7Gni0LwEU8Uq
 ORwr1HMG253R1GfeJY02N8Zr4BjcmB5hIb4fErvTYa78Y2TCYJXg/eCPuMCb0zyc35cm
 dxRs1teyWFo9jRKkAB7b/NIW3Ft826IfCfFf1PdMsH+N8fFd/JEZDi5XnICgnLZi3NT+
 EjMKjCDeMWJvNqWAAMSByMWJEQBD7qV0sd/dE5O2j2kWqxEUOoWNB7upGiGwOEU8ejxR
 lUoZsUzaZ/vDooM5KFItx2SMc2uiZ2DQfizD7GfqL2J2yWb85ZWDWW3lmdr5WsGN53k+ gg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ydhc06sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Jun 2021 01:01:58 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1544rQGn027587;
        Fri, 4 Jun 2021 05:01:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38ud88bavm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Jun 2021 05:01:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15451ETg30540044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jun 2021 05:01:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D15E54C05A;
        Fri,  4 Jun 2021 05:01:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BC8C4C046;
        Fri,  4 Jun 2021 05:01:50 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.35.195])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  4 Jun 2021 05:01:50 +0000 (GMT)
Date:   Fri, 4 Jun 2021 10:31:44 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, amakhalov@vmware.com, guro@fb.com,
        vbabka@suse.cz, srikar@linux.vnet.ibm.com, psampat@linux.ibm.com,
        ego@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v0 0/3] CPU hotplug awareness in percpu allocator
Message-ID: <YLmzuB5N3wFD56zg@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20210601065147.53735-1-bharata@linux.ibm.com>
 <YLedMLpU0W1DjWko@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLedMLpU0W1DjWko@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S-J-8eJpoWauA6Iizu0z2xOZaxtzGWsN
X-Proofpoint-GUID: S-J-8eJpoWauA6Iizu0z2xOZaxtzGWsN
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_01:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 03:01:04PM +0000, Dennis Zhou wrote:
> Hello,
> 
> On Tue, Jun 01, 2021 at 12:21:44PM +0530, Bharata B Rao wrote:
> > Hi,
> > 
> > This is an attempt to make the percpu allocator CPU hotplug aware.
> > Currently the percpu allocator allocates memory for all the possible
> > CPUs. This can lead to wastage of memory when possible number of CPUs
> > is significantly higher than the number of online CPUs. This can be
> > avoided if the percpu allocator were to allocate only for the online
> > CPUs and extend the allocation for other CPUs as and when they become
> > online. 
> > 
> > This early RFC work shows some good memory savings for a powerpc
> > KVM guest that is booted with 16 online and 1024 possible CPUs.
> > Here is the comparision of Percpu memory consumption from
> > /proc/meminfo before and after creating 1000 memcgs.
> > 
> > 			W/o patch		W/ patch
> > Before			1441792 kB		22528 kB
> > After 1000 memcgs	4390912 kB		68608 kB
> > 
> 
> I have thought about this for a day now and to be honest my thoughts
> haven't really changed since the last discussion in [1].
> 
> I struggle here for a few reasons:
> 1. We're intertwining cpu and memory for hotplug.
>   - What does it mean if we don't have enough memory?

That means CPU hotplug will fail, but...

>   - How hard do we try to reclaim memory?
>   - Partially allocated cpus? Do we free it all and try again?


... yes these are some difficult questions. We should check if
roll back can be done cleanly and efficiently. You can see that
I am registering separate hotplug callbacks for the hotplug core
and for init routines of alloc_percpu() callers. Rolling back the
former should be fairly straight forward, but have to see how
desirable and feasible it is to undo the entire CPU hotplug when
one of the alloc_percpu callbacks fails, especially if there are
hundreds of registered alloc_percpu callbacks.

> 2. We're now blocking the whole system on the percpu mutex which can
>    cause terrible side effects. If there is a large amount of percpu
>    memory already in use, this means we've accumulated a substantial
>    number of callbacks.

I am yet to look at each caller in detail and see which of them
really need init/free callbacks and which can do without it. After
this we will have to measure the overhead all this is putting on the
hotplug path. Given that hotplug is a slow path, I wonder if some
overhead is tolerable here.

CPU hotplug already happens with cpu_hotplug_lock held, so when you
mention that this callback holding percpu mutex can have terrible
effects, are you specifically worried about blocking all the
percpu allocation requests during hotplug? Or is it something else?

> 3. While I did mention a callback approach would work. I'm not thrilled
>    by the additional complexity of it as it can be error prone.

Fair enough, the callback for the percpu allocator core seems fine
to me but since I haven't yet looked at all callers in detail, I
don't know if we would run into some issues/dependencies in any
specific callback handlers that increases the overall complexity.

Other than the callbacks, I am also bit worried about the complexity
and the overhead involved in memcg charging and uncharging at CPU
hotplug time. In my environment (powerpc kvm guest), I see that each
chunk can have a maximum of 180224 obj_cgroups. Now checking for the
valid/used one out of that, determining the allocation size and
charging/uncharging to the right memcg could be an expensive task.

> 
> Beyond the above. I still don't believe it's the most well motivated
> problem. I struggle to see a world where it makes sense to let someone
> scale from 16 cpus to 1024. As in my mind you would also need to scale
> memory to some degree too (not necessarily linearly but a 1024 core
> machine with say like 16 gigs of ram would be pretty funny).

Well the platform here provides the capability of scaling and until
that scaling happens, why consume memory for not-present CPUs is
the motivation here. But as you note, it definetely is a question of
whether any real application is making use of this scaling now
and the associated complexity.

Even if we consider the scaling from 16 to 1024 CPUs as unrealistic
for now, the usecase and the numbers from the production scenario that
Alexey mentioned in [1] (2 to 128 CPUs) is certainly a good motivator?

Alexey - You did mention about creating a huge number of memcgs and
observing VMs consuming 16-20 GB percpu memory in production. So
how any memcgs are we talking about here?

> 
> Would it be that bad to use cold migration points and eat a little bit
> of overhead for what I understand to be a relatively uncommon use case?

[1] https://lore.kernel.org/linux-mm/8E7F3D98-CB68-4418-8E0E-7287E8273DA9@vmware.com/

Regards,
Bharata.
