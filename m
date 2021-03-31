Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4918F350882
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhCaUwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:52:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229615AbhCaUvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:51:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VKXZEO128247;
        Wed, 31 Mar 2021 16:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hlfKVk43adYZo5XtpAT2DR3O6Hesu1fmqxgDa1s08AM=;
 b=bavVfejljcls0fYCoKpUiMYfS/fpLXN9jGoNJzAY96bWK34wyB+HUTUcqFJ0q2bz6ABp
 3nX9hnnA8yy4NTh0b8zET6OaWjgQpr+N0K2duJqBTMEQcrNjuzVDFALysEv9KwXRthFQ
 MrV69hDHzmU5uxrA4q4+Exmv5W4QL7p2ARwEc0lDCZd8Hhwkrq9KO9Q/jkqGrcCraZhV
 y63jWBDGwGXdxWILHGYPEMHXtCKqlyr92V9HJVx/EK05F2dyDtthj8Zg1ywZ3RtahKXA
 eRub89x+SRfcKu3G5mzabBngst89ViZPh5mhHDft0oENYAhgVh2refEgg1hfeekq5nbx sg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37mb6egywv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 16:51:21 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12VKglGS024005;
        Wed, 31 Mar 2021 20:51:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 37matt0w6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 20:51:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12VKov5a27525498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 20:50:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64154A4051;
        Wed, 31 Mar 2021 20:51:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23022A4040;
        Wed, 31 Mar 2021 20:51:17 +0000 (GMT)
Received: from localhost (unknown [9.171.77.178])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Mar 2021 20:51:17 +0000 (GMT)
Date:   Wed, 31 Mar 2021 22:51:15 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: User stacktrace garbage when USER_STACKTRACE_SUPPORT is not
 enabled
Message-ID: <your-ad-here.call-01617223875-ext-7005@work.hours>
References: <your-ad-here.call-01617191565-ext-9692@work.hours>
 <20210331103749.01a7c283@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210331103749.01a7c283@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S5wQB9zkNbZ2k8rdvXt_zppAqduJJht1
X-Proofpoint-ORIG-GUID: S5wQB9zkNbZ2k8rdvXt_zppAqduJJht1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_10:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 10:37:49AM -0400, Steven Rostedt wrote:
> But after writing all of the above, I think I found a bug! It's this:
> 
> 	size = nr_entries * sizeof(unsigned long);
> 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
> 					    sizeof(*entry) + size, trace_ctx);
> 
> 
> I said the above commit did not play a role in output, but it does play a
> role in creating the struct stack_trace entry. And by making it a fixed
> array (even though it's not used) it added 8 more entries to the stack!
> 
> This should fix the problem:
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 3c605957bb5c..507a30bf26e4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2985,7 +2985,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  
>  	size = nr_entries * sizeof(unsigned long);
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
> -					    sizeof(*entry) + size, trace_ctx);
> +				    (sizeof(*entry) - sizeof(entry->caller)) + size,
> +				    trace_ctx);
>  	if (!event)
>  		goto out;
>  	entry = ring_buffer_event_data(event);

It does! Thanks for the explanation and for the fix. I wonder why nobody
noticed and complained about that since v5.6.

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
