Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB453F5722
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 06:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhHXEZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 00:25:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbhHXEZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 00:25:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17O43CPW085744;
        Tue, 24 Aug 2021 00:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Coin3WGo/HkRZVv62d8sp4FPOcbrHTmp5FCdIg5kxGQ=;
 b=S3VtqgGEiaNEJuU2/xAKwCgjb7ubPnLioLkVNPkm8DBtzalRcgQeFh4aekFJl0vc+ImS
 ETMhMvJwBGOsW+oWf1zOc4u5QEshpdfGJi9q1IBlg0xXFaRaJRD49ACOxNDbivSbdIQ3
 SA3iUSrTG2+3lTZpHIXcWRGvoxNsjat3n5q8OYdnbVB/09ZW6fjmyDIu1/XsaR0Qr02u
 t50fGkpJXnVjbqF9IYbsQttPOV1QEqu8Spnp/7ItBVNKgH8oho20F4lhgU+mWPZ+4/F2
 m9fQrGynj6sj0oBdvUb5N8Hp0T+qo7hCzwnTp0+oOlP46jZKSHnMEq4WOiUn9QOSnt8Y Kw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amhw7hhs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 00:24:25 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17O4HvhI002368;
        Tue, 24 Aug 2021 04:24:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3ajs48vbg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 04:24:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17O4OLth17236468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 04:24:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAFC142041;
        Tue, 24 Aug 2021 04:24:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B3BC42047;
        Tue, 24 Aug 2021 04:24:20 +0000 (GMT)
Received: from localhost (unknown [9.43.24.142])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Aug 2021 04:24:20 +0000 (GMT)
Date:   Tue, 24 Aug 2021 09:54:19 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Subject: Re: [PATCHv2 1/2] kernel/workqueue: Make schedule_on_each_cpu as
 EXPORT_SYMBOL_GPL
Message-ID: <20210824042419.fssp7zrnnz6ffgyt@riteshh-domain>
References: <5afc2a0c4da65e71ccf24fe65396710d34fc662e.1629751104.git.riteshh@linux.ibm.com>
 <YSRUNzVEig80IBtq@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSRUNzVEig80IBtq@fedora>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LDcjF0OZOMwMhfV9SoqxiUmZXE3qEqdv
X-Proofpoint-ORIG-GUID: LDcjF0OZOMwMhfV9SoqxiUmZXE3qEqdv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_01:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 mlxlogscore=782 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/23 10:06PM, Dennis Zhou wrote:
> Hello,
>
> On Tue, Aug 24, 2021 at 02:12:29AM +0530, Ritesh Harjani wrote:
> > Make schedule_on_each_cpu as EXPORT_SYMBOL_GPL
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> > [v1 -> v2]: Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
> >
> >  kernel/workqueue.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index f148eacda55a..993f8983186d 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -3309,6 +3309,7 @@ int schedule_on_each_cpu(work_func_t func)
> >  	free_percpu(works);
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(schedule_on_each_cpu);
> >
> >  /**
> >   * execute_in_process_context - reliably execute the routine with user context
> > --
> > 2.31.1
> >
>
> I think you missed the point of Christoph's comment. I agree with him
> and don't think a test justifies exporting of this particular function.

Got it. Based on the comments from 2nd patch, if in case this will be required
I can open code this. (I initially had this open coded, but then I found this).

-ritesh

>
> Thanks,
> Dennis
>
