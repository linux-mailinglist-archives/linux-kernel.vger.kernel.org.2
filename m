Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A21426B56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbhJHM5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:57:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhJHM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:57:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198BgFeG007846;
        Fri, 8 Oct 2021 08:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=q/nZZRTC6KfPzJdVjJhTzCrqurPKeUam0xxgMNzlhzc=;
 b=W0uVTEEN4VWVVv12sUFJoX657zaVhQVptYgjl+1oALSCAVEebb45/Q1cLClvNxtJQhOB
 vDOfhSmbhXME5NQzChMu+a4Srfnmz99YcCvWOKviZNf9HKTn3cdQs2XATtPDtJB/QE6V
 6/JU2MZx3YseIdWoDWWL+bynX0DELuOsxfZ3PqidsIwmksYMAoUNPrR90sy+XuCjtE/o
 0MDAh1EHmfV10Ngmr+xR4vgiZkJS0Ty2jyZAIE2hJj8e/KGYfQMnmAxbdx6IYAIAkXKW
 +4+eqf2JZl8jKZrPIHbFhzoiyD+a7/9m9X7V3Caz8/YIPh6+hkckWSOk5lGJ3W8b3Rpj BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bjnbaskr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 08:54:21 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 198C66DB017397;
        Fri, 8 Oct 2021 08:54:21 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bjnbaskqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 08:54:21 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 198CqZZ9028289;
        Fri, 8 Oct 2021 12:54:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3bef2b2pmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 12:54:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 198Cmne642270994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 12:48:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13EF7A404D;
        Fri,  8 Oct 2021 12:54:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 497FCA4069;
        Fri,  8 Oct 2021 12:54:15 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.5.116])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Oct 2021 12:54:15 +0000 (GMT)
Date:   Fri, 8 Oct 2021 14:54:12 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, ultrachin@163.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, brookxu.cn@gmail.com,
        chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit
 time
Message-ID: <20211008145412.20cbd312@p-imbrenda>
In-Reply-To: <8f30837b-5186-e836-21bc-9964456400c1@suse.cz>
References: <20211008063933.331989-1-ultrachin@163.com>
        <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
        <8f30837b-5186-e836-21bc-9964456400c1@suse.cz>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RF2SETarFTA36SpBOFVuIas9P7P_wGIR
X-Proofpoint-GUID: 86muJwm8HdG63lu_8Mvyxjr1IGJNDbLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=861 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 impostorscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110080074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 14:38:15 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 10/8/21 10:17, David Hildenbrand wrote:
> > On 08.10.21 08:39, ultrachin@163.com wrote:  
> >> From: chen xiaoguang <xiaoggchen@tencent.com>
> >>
> >> The exit time is long when program allocated big memory and
> >> the most time consuming part is free memory which takes 99.9%
> >> of the total exit time. By using async free we can save 25% of
> >> exit time.
> >>
> >> Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
> >> Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
> >> Signed-off-by: lu yihui <yihuilu@tencent.com>  
> > 
> > I recently discussed with Claudio if it would be possible to tear down the
> > process MM deferred, because for some use cases (secure/encrypted
> > virtualization, very large mmaps) tearing down the page tables is already
> > the much more expensive operation.  
> 
> OK, but what exactly is the benefit here? The cpu time will have to be spent
> in any case, but we move it to a context that's not accounted to the exiting
> process. Is that good? Also if it's a large process and restarts
> immediately, allocating all the memory back again, it might not be available
> as it's still being freed in the background, leading to a risk of OOM?

I argue that it is good, at least in some cases.

Depending on the type of process shutting down, restarting it
immediately might still be slow enough that no OOM condition will
arise.

and those are the reasons of the per-arch hook to determine when it
makes sense to do things asynchronously.

> 
> > There is mmdrop_async(), and I wondered if one could reuse that concept when
> > tearing down a process -- I didn't look into feasibility, however, so it's
> > just some very rough idea.
> >   

