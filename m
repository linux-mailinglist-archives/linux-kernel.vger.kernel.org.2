Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B2440BE49
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhIODew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:34:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230004AbhIODeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:34:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18F0Tu2d015659;
        Tue, 14 Sep 2021 23:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BRjAQIdENxqRUy9PFv5aAg1MPkBvqrtMXYjCJQcsNdE=;
 b=Kl9f2kL4qw3Qc0uuiCRCmrg5r3yOkFZD9Ha22gpnC9L9Mp3mJVjaGqr+I1wAQg9UrkwE
 tvDTWYjcC4trSZkw88kGVwuaC5C8/JzbIUedNlQEDWDKmgC7NtYwqyLsFKboNRFXhRWd
 VA/I169MwJkPqocKej6N3FXUyLve6OsUMcG1n+y5vmA75ajntZgxSbYeN0EKzY/hXP1D
 P+TsdtXhM2OL8NQ4SqjkuLbg2/4afUp8nPsqw9qFNl//bq2sGyr57bknyg5TaFR+S7pw
 CWPt3nNCDj7dyp4ygxp0ysBPFYpKE1x7D84w+mG8SeMglYpbpXRWSJWFdmCqdCXkjYVW Rw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b36bftwha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 23:33:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18F3XCgN011738;
        Wed, 15 Sep 2021 03:33:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3b0m3a1mf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 03:33:22 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18F3XK3s42991878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 03:33:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E90DD11C04C;
        Wed, 15 Sep 2021 03:33:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 450A011C04A;
        Wed, 15 Sep 2021 03:33:19 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Sep 2021 03:33:19 +0000 (GMT)
Received: from [9.206.163.168] (unknown [9.206.163.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5263C600F5;
        Wed, 15 Sep 2021 13:33:17 +1000 (AEST)
Subject: Re: [PATCH v2 07/29] ABI: sysfs-class-cxl: place "not in a guest" at
 description
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
 <88ce67c9eed1ae08af3d3992415032723184af9e.1631629496.git.mchehab+huawei@kernel.org>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <3334441d-03f0-5d21-49d3-84e87a5eddc5@linux.ibm.com>
Date:   Wed, 15 Sep 2021 13:33:13 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <88ce67c9eed1ae08af3d3992415032723184af9e.1631629496.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ODydiBoNOxTCJj2e_ZKxDXlgzfX2ghS
X-Proofpoint-ORIG-GUID: -ODydiBoNOxTCJj2e_ZKxDXlgzfX2ghS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/9/21 12:32 am, Mauro Carvalho Chehab wrote:
> The What: field should have just the location of the ABI.
> Anything else should be inside the description.
> 
> This fixes its parsing by get_abi.pl script.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Looks fine to me.

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
>   Documentation/ABI/testing/sysfs-class-cxl | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
> index 818f55970efb..3c77677e0ca7 100644
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -166,10 +166,11 @@ Description:    read only
>                   Decimal value of the Per Process MMIO space length.
>   Users:		https://github.com/ibm-capi/libcxl
>   
> -What:           /sys/class/cxl/<afu>m/pp_mmio_off (not in a guest)
> +What:           /sys/class/cxl/<afu>m/pp_mmio_off
>   Date:           September 2014
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
> +                (not in a guest)
>                   Decimal value of the Per Process MMIO space offset.
>   Users:		https://github.com/ibm-capi/libcxl
>   
> @@ -190,28 +191,31 @@ Description:    read only
>                   Identifies the revision level of the PSL.
>   Users:		https://github.com/ibm-capi/libcxl
>   
> -What:           /sys/class/cxl/<card>/base_image (not in a guest)
> +What:           /sys/class/cxl/<card>/base_image
>   Date:           September 2014
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
> +                (not in a guest)
>                   Identifies the revision level of the base image for devices
>                   that support loadable PSLs. For FPGAs this field identifies
>                   the image contained in the on-adapter flash which is loaded
>                   during the initial program load.
>   Users:		https://github.com/ibm-capi/libcxl
>   
> -What:           /sys/class/cxl/<card>/image_loaded (not in a guest)
> +What:           /sys/class/cxl/<card>/image_loaded
>   Date:           September 2014
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
> +                (not in a guest)
>                   Will return "user" or "factory" depending on the image loaded
>                   onto the card.
>   Users:		https://github.com/ibm-capi/libcxl
>   
> -What:           /sys/class/cxl/<card>/load_image_on_perst (not in a guest)
> +What:           /sys/class/cxl/<card>/load_image_on_perst
>   Date:           December 2014
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read/write
> +                (not in a guest)
>                   Valid entries are "none", "user", and "factory".
>                   "none" means PERST will not cause image to be loaded to the
>                   card.  A power cycle is required to load the image.
> @@ -235,10 +239,11 @@ Description:    write only
>                   contexts on the card AFUs.
>   Users:		https://github.com/ibm-capi/libcxl
>   
> -What:		/sys/class/cxl/<card>/perst_reloads_same_image (not in a guest)
> +What:		/sys/class/cxl/<card>/perst_reloads_same_image
>   Date:		July 2015
>   Contact:	linuxppc-dev@lists.ozlabs.org
>   Description:	read/write
> +                (not in a guest)
>   		Trust that when an image is reloaded via PERST, it will not
>   		have changed.
>   
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
