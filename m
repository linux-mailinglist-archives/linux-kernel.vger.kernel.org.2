Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CA432CD28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhCDGq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:46:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235726AbhCDGqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:46:51 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1246Xqu2122962;
        Thu, 4 Mar 2021 01:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=SKj8p0Wy5StrDDJd5ZVzg+H925Pw3oe6kC8qGUan/fw=;
 b=hV/Ed6eYLPfhv7AL4scsFN6LYn2r4dKafYRHSzJaF1C2tZ1Lg1sPAXJKuOmxTt8Ys3Kj
 v6SzDfLTDycmaQ2UKsGtaAoDbN3E2GvI1dS9iNQH8lbwzLCDiQfXyJ/fSau8aVpA2zdC
 jOpG4aWMuv2H+lsD696PWluvz3LOe3L8Pdj5oyhjJcFYs60Chx8AMhlDEN/DOb59L0Fo
 19S2AQ1pjqXbuvdzT3P1XJN37hJ9E9wX03aEro0OQW/WQxz6iXYeKkeX1UyyNLxl7pig
 5DGRomcojP1UA1ig3XZ2px09nTeAmHYmxLAegjTFabDS+Jw+WqqROpDh3CazE3U3uHIi Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372t7d0gxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 01:46:08 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1246Xp6g122924;
        Thu, 4 Mar 2021 01:46:08 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372t7d0gws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 01:46:07 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1246dcbR011510;
        Thu, 4 Mar 2021 06:46:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3712fmjff5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 06:46:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1246k3qS63373770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 06:46:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 611634C040;
        Thu,  4 Mar 2021 06:46:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 578EF4C04A;
        Thu,  4 Mar 2021 06:46:01 +0000 (GMT)
Received: from [9.124.219.3] (unknown [9.124.219.3])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  4 Mar 2021 06:46:01 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] perf report: Fix -F for branch & mem modes
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20210304062958.85465-1-ravi.bangoria@linux.ibm.com>
Date:   Thu, 4 Mar 2021 12:15:58 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, namhyung@kernel.org,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8831E43-992C-44BC-9CF7-BABAE8C0F5BB@linux.vnet.ibm.com>
References: <20210304062958.85465-1-ravi.bangoria@linux.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_02:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 04-Mar-2021, at 11:59 AM, Ravi Bangoria =
<ravi.bangoria@linux.ibm.com> wrote:
>=20
> perf report fails to add valid additional fields with -F when
> used with branch or mem modes. Fix it.
>=20
> Before patch:
>=20
>  $ ./perf record -b
>  $ ./perf report -b -F +srcline_from --stdio
>  Error:
>  Invalid --fields key: `srcline_from'
>=20
> After patch:
>=20
>  $ ./perf report -b -F +srcline_from --stdio
>  # Samples: 8K of event 'cycles'
>  # Event count (approx.): 8784
>  ...
>=20
> Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Fixes: aa6b3c99236b ("perf report: Make -F more strict like -s")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks for the fix Ravi.

Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

> ---
> tools/perf/util/sort.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 0d5ad42812b9..552b590485bf 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -3140,7 +3140,7 @@ int output_field_add(struct perf_hpp_list *list, =
char *tok)
> 		if (strncasecmp(tok, sd->name, strlen(tok)))
> 			continue;
>=20
> -		if (sort__mode !=3D SORT_MODE__MEMORY)
> +		if (sort__mode !=3D SORT_MODE__BRANCH)
> 			return -EINVAL;
>=20
> 		return __sort_dimension__add_output(list, sd);
> @@ -3152,7 +3152,7 @@ int output_field_add(struct perf_hpp_list *list, =
char *tok)
> 		if (strncasecmp(tok, sd->name, strlen(tok)))
> 			continue;
>=20
> -		if (sort__mode !=3D SORT_MODE__BRANCH)
> +		if (sort__mode !=3D SORT_MODE__MEMORY)
> 			return -EINVAL;
>=20
> 		return __sort_dimension__add_output(list, sd);
> --=20
> 2.29.2
>=20

