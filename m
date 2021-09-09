Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58AF405843
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354975AbhIINvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:51:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353078AbhIINtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:49:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189DXH0B137036;
        Thu, 9 Sep 2021 09:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aHmLrGKCpOfmOXQoBz5ULgtv6Cw18Ia5KPZID91EpHU=;
 b=R9XH7jJyZDADwKnTAoE7e+/sGPOy9ssW+KW1X8fkj8hMxkjentsZUrhWiWDDcK3f++J0
 srPZRVVTSEuNtPeD870hrf0rhdRW73ekPZysSC7CYrk9E1+Q7TKhtU34J/f6uD2rotKB
 D9Xbt5QfMr5faMWJhYWwGw6Cy8fkw/COa7NLzNaVsL2DaR3Q9Zf8PYN040UoGUoLjAZW
 E8bI91aSN9s0WzNI3BRmN7e/NeentmLYyNLt2xSBWzgSMnQEIP8336q25DHcYDTgNA/a
 PAtjr5UZSk1gG4zTm6D+YDMgwwgtQWwxPhrFzUtima8bIOWjGH2HZzJQ8VoPD9N3KP5y Tg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ayhwr2wm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 09:48:19 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189DfQuE023113;
        Thu, 9 Sep 2021 13:48:17 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3axcnnxj9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 13:48:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189DmE7Q52625678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 13:48:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6FD54C066;
        Thu,  9 Sep 2021 13:48:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35F404C058;
        Thu,  9 Sep 2021 13:48:12 +0000 (GMT)
Received: from sig-9-65-72-231.ibm.com (unknown [9.65.72.231])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Sep 2021 13:48:12 +0000 (GMT)
Message-ID: <3d781672e8b195ee56a6b04f5133684fcbd6a0a8.camel@linux.ibm.com>
Subject: Re: [PATCH 8/9] ABI: security: fix location for evm and ima_policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 09 Sep 2021 09:48:11 -0400
In-Reply-To: <27f568bf8973afb9c7aa023e96dcd4f50b07a188.1631112725.git.mchehab+huawei@kernel.org>
References: <cover.1631112725.git.mchehab+huawei@kernel.org>
         <27f568bf8973afb9c7aa023e96dcd4f50b07a188.1631112725.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ExlwC8CIYhDpdeTQ1NXewoz2MhLflxWn
X-Proofpoint-ORIG-GUID: ExlwC8CIYhDpdeTQ1NXewoz2MhLflxWn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_04:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Wed, 2021-09-08 at 16:58 +0200, Mauro Carvalho Chehab wrote:
> The What: definitions there are wrong, pointing to different
> locations than what's expected.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

What is the purpose for the asterisks in the file path?

thanks,

Mimi

> ---
>  Documentation/ABI/testing/evm        | 4 ++--
>  Documentation/ABI/testing/ima_policy | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
> index 553fd8a33e56..4b76a19b7bb4 100644
> --- a/Documentation/ABI/testing/evm
> +++ b/Documentation/ABI/testing/evm
> @@ -1,4 +1,4 @@
> -What:		security/evm
> +What:		/sys/kernel/security/evm /sys/kernel/security/*/evm
>  Date:		March 2011
>  Contact:	Mimi Zohar <zohar@us.ibm.com>
>  Description:
> @@ -93,7 +93,7 @@ Description:
>  		core/ima-setup) have support for loading keys at boot
>  		time.
>  
> -What:		security/integrity/evm/evm_xattrs
> +What:		/sys/kernel/security/*/evm/evm_xattrs
>  Date:		April 2018
>  Contact:	Matthew Garrett <mjg59@google.com>
>  Description:
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 5c2798534950..2d84063d196f 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -1,4 +1,4 @@
> -What:		security/ima/policy
> +What:		/sys/kernel/security/*/ima/policy
>  Date:		May 2008
>  Contact:	Mimi Zohar <zohar@us.ibm.com>
>  Description:


