Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296E244A471
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbhKICLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:11:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238023AbhKICLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:11:07 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8MNUwb013719;
        Tue, 9 Nov 2021 02:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=xfrQmRyHkeOj6Fea4V2SKM536tS86ylqfHe3yf+yiVs=;
 b=NwNvsoJnB5TOs/VLfXEmEydURUt6qvzbXpQDvTyRm8Io0pypjsAAxLwmdE57fzBb1FWb
 lqPFoxXm/eikm/7Dz0GpXRkNTK+ur2hUTqSij8fVoFaM2SvpV/SjgbhqenczqalD8P7s
 WGaloZvuF5rZL4781uP/XyWQwRB+R/yN8f3cbHBlbN0eWXdYAKoqFmu2+k9lykqk8mpL
 m4i7nsvEdPWVObLYGuu6v+DNB8cGM7k3Fk4SX5uDBGlaQbn6EYkhwlxjJbbxIdNl2AJH
 zZOFdowMFuZnEldn2g4s/N4bYRJzuejfho7UWkObH4g72dvRp/eNCOVSPknCxrtUwQJb SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c7cn6v0yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 02:08:01 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A9281XU025940;
        Tue, 9 Nov 2021 02:08:01 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c7cn6v0yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 02:08:01 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A91uvgR021709;
        Tue, 9 Nov 2021 02:07:59 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 3c5hbajtym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 02:07:59 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A927xpM46072296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Nov 2021 02:07:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E64DCAC067;
        Tue,  9 Nov 2021 02:07:58 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0323AC05F;
        Tue,  9 Nov 2021 02:07:58 +0000 (GMT)
Received: from localhost (unknown [9.211.44.202])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Nov 2021 02:07:58 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Waiman Long <longman@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/cpuhp: Use alloc_cpumask_var() in
 pseries_cpu_hotplug_init()
In-Reply-To: <a90f0361-329b-1e21-90c1-601d6f7c2f24@redhat.com>
References: <20211108164751.65565-1-longman@redhat.com>
 <87y25ym96i.fsf@mpe.ellerman.id.au>
 <1636421918.tc1hk6vx8h.astroid@bobo.none>
 <a90f0361-329b-1e21-90c1-601d6f7c2f24@redhat.com>
Date:   Mon, 08 Nov 2021 20:07:58 -0600
Message-ID: <871r3qjd35.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8xMAC84lTy769LAByALRxfY-bdnp-5Be
X-Proofpoint-GUID: -jvDEFVFVi4zRUqIKBvQLWvh3S2DWwcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:
> On 11/8/21 20:46, Nicholas Piggin wrote:
>> Differences between the two patches are error checking - no big deal but
>> we should just do it. And GFP_NOWAIT - is this required here?
>
> As I have replied in another thread, I added it because it was used in 
> memblock_alloc_internal().

From the pseries code's point of view, that's an incidental property of
the misuse detection branch in memblock_alloc_internal() -- I'd
speculate to make it robust for calls from atomic context. GFP_NOWAIT is
not needed here.
