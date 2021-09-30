Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC6541D7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350048AbhI3Kmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:42:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4021 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349873AbhI3Kmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:42:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UAUPRo006123;
        Thu, 30 Sep 2021 06:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4ybqJxaoY6ZlbdRrFNDirPiZBDFbSWcR3c9/NdWfwAk=;
 b=O1rsYPe7nEyB/ZVeAc/OfYTCd6XT7nGGgePhkcnc2b6KjMaW8t0IB42nZS+12H/4/vYo
 nf6Ao8nnxCFPbqfECWtK1iyK87G1HqYctFg8MkIeo0qsoK5NODX8bElTZDbm330ExJk5
 rKZtUnSsK4TvN3xSmYmKeiQ+FiryBL9XjYmV1tYMwDvVXXuBlHZ9gOZxVUpmS95+SXTU
 uhr0RlFuV/XmaIyg2HEpxqxO/h0D8LxwjaD+tJIPHFbYrO//RTU4DuHbdAFpiovkR/H6
 HgFreXv7D391ESeuUusfgHfhTG3Y6Jz31qa9QKx0Gdn2IBP6HVnOW7/z7YDMr3zj3DRN /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bdbhy05kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 06:40:50 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18UAenct010571;
        Thu, 30 Sep 2021 06:40:49 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bdbhy05k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 06:40:49 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18UAc86P032664;
        Thu, 30 Sep 2021 10:40:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3b9udajfre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 10:40:48 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18UAej2m2359832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 10:40:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FD4C4C08B;
        Thu, 30 Sep 2021 10:40:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02EBD4C081;
        Thu, 30 Sep 2021 10:40:44 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.93.90])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Sep 2021 10:40:43 +0000 (GMT)
Subject: Re: [PATCH] perf tools: Suppress 'rm dlfilter' build message
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210930062849.110416-1-adrian.hunter@intel.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <9bb7e02d-1394-4b1e-f955-97f2f9f9f6f0@linux.ibm.com>
Date:   Thu, 30 Sep 2021 16:10:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930062849.110416-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BvmQGf54L2d7DAWx0u3p7L1tuvVTpvla
X-Proofpoint-ORIG-GUID: snCbMIyvBp4d-Ap49Y4DHhr7B4BrMAOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_03,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/21 11:58 AM, Adrian Hunter wrote:
> The following build message:
> 
> 	rm dlfilters/dlfilter-test-api-v0.o
> 
> is unwanted.
> 

Hi Adrian,

> The object fle is being treated as an intermediate file and being

Just minor nit, it should be `object file` not `object fle`

Thanks,
Kajol Jain

> automatically removed. Mark the object file as .SECONDARY to prevent
> removal and hence the message.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Makefile.perf | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index e04313c4d840..ab8cb17d9ec5 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -787,6 +787,8 @@ $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
>  	$(Q)$(MKDIR) -p $(OUTPUT)dlfilters
>  	$(QUIET_CC)$(CC) -c -Iinclude $(EXTRA_CFLAGS) -o $@ -fpic $<
>  
> +.SECONDARY: $(DLFILTERS:.so=.o)
> +
>  $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
>  	$(QUIET_LINK)$(CC) $(EXTRA_CFLAGS) -shared -o $@ $<
>  
> 
