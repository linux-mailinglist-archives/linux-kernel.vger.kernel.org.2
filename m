Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE609423FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhJFN6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:58:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10268 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231403AbhJFN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:58:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196D7fbU024906;
        Wed, 6 Oct 2021 09:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rXNaV/0f7il7/eTa9er7Fi91jO8PQW/CTUv7iJ0o5Ss=;
 b=Led9y1fpcrm+mdDhe9Hl/YrF3wU4sCas3seQL+PTX4yQKKfgYhPQVZkt24CTGeBbLzcb
 JT3dA8G/5vifqma5YqK9Q1UovNu4XXFO2cY8ladcBZrI/MkEqUqAL8m2vh7yh3UbR4mY
 A6YspETUQWbFVQtQbBHDCrGSjwzB5zaFeF5SwUKQ4UABN8ek50ClqcyrL39b56l8WzxA
 JuJMnHLAfLheYnprBbYiRQRD6qV+tr9/0lzXM2Vug2lNoq0PpvsL15oMnsDmMeYPMpY5
 3XAz1o4QSyWpViu15t+h4SINGfZx6qGLc5C79ERDW3+TGI5pZqCyDxJQhXXVP2Grg6a5 Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh38b4ntx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 09:56:22 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 196D9kXH030915;
        Wed, 6 Oct 2021 09:56:22 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh38b4nsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 09:56:22 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196DqgaP020613;
        Wed, 6 Oct 2021 13:56:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3beepjx7sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 13:56:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 196DuFTj46334436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Oct 2021 13:56:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FCE3A4083;
        Wed,  6 Oct 2021 13:56:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9A9AA4071;
        Wed,  6 Oct 2021 13:56:14 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Oct 2021 13:56:14 +0000 (GMT)
Received: from [9.102.60.13] (unknown [9.102.60.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 811916036F;
        Thu,  7 Oct 2021 00:56:12 +1100 (AEDT)
Subject: Re: [PATCH] docs: typo fixes in Documentation/ABI/
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, Gioh Kim <gi-oh.kim@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20211006132104.105288-1-sohaib.amhmd@gmail.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <03e16fd9-e60f-ff4d-71e5-1b687aab65a5@linux.ibm.com>
Date:   Thu, 7 Oct 2021 00:56:05 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211006132104.105288-1-sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PQat3iTg2_FDv0ZxUq3H_tI3XBe1uw2a
X-Proofpoint-GUID: 3RPZpzN-NBgRadkEr8k5Ui6c_R4pd5yk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_03,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/21 12:20 am, Sohaib Mohamed wrote:
> All these changes are about to remove repeated words from severals place in the Documentation/ABI/ directory:
> 
> - In file stable/sysfs-module:41: "the the source"
> 
> - In file testing/sysfs-bus-rapidio:98: "that that owns"
> 
> - In file testing/sysfs-class-cxl:106: "the the lowest"
> 
> - In file testing/sysfs-class-cxl:107: "this this kernel"
> 
> - In file testing/sysfs-class-rnbd-client:131: "as as the"
> 
> - In file testing/sysfs-class-rtrs-client:81: "the the name"
> 
> - In file testing/sysfs-class-rtrs-server:27: "the the name"
> 
> - In file testing/sysfs-devices-platform-ACPI-TAD:77: "the the status"
> 
> - In file testing/sysfs-devices-power:306: "the the children"
> 
> - In file testing/sysfs-driver-ufs:986: "the The amount"
> 
> - In file testing/sysfs-firmware-acpi:115: "send send a Notify"
> 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

Greg's already pointed out the line wrapping and that you may want to 
send this as multiple smaller patches.

For my particular part:

> diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
> index 3c77677e0ca7..594fda254130 100644
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -103,8 +103,8 @@ What:           /sys/class/cxl/<afu>/api_version_compatible
>   Date:           September 2014
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
> -                Decimal value of the the lowest version of the userspace API
> -                this this kernel supports.
> +                Decimal value of the lowest version of the userspace API
> +                this kernel supports.
>   Users:		https://github.com/ibm-capi/libcxl

Looks good.

Acked-by: Andrew Donnellan <ajd@linux.ibm.com> # cxl

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
