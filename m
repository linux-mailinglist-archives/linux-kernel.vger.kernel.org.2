Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A54414F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhIVSGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhIVSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:06:04 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7404C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:04:33 -0700 (PDT)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.1.2/8.16.1.2) with SMTP id 18MHgXEP014239;
        Wed, 22 Sep 2021 19:04:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=jcdEcrP+5y+ElOaxqBnq6pN8hD6WVH7XmRChoU2VlVU=;
 b=HRWx11JjxPV90qrB/kBcGW2YSm3mztt4FQgDoZhsNpWelR6sPVyPt4vq9fdVCgGRXCIl
 IbszExub1Z397ocXLRqWBe7QBeWZdorwBVqdPgiBaGuQ3/PRYvVAOo/RpmJPMUGMNrLd
 dNQ6DAs9rJHy+xm2PCGjzEc3AiSxXJ4aZv2cpfrW8FeGcMpy3JbavxH8rYJRfllJ6KMq
 2oQVtsCQJGCXi7rcFpy/berVAA20CwHg5oGha4U1pNdXb/oB+d0yUPbECUxEo5dy6VoU
 qo/3+0rLmpqywLCmwEdirhXuly6Q/gzePkEM5q8ADiBvxgmrZcrgcTBcKGl7bS94PhOf BA== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 3b7xa8p10x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 19:04:27 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 18MHoZbk025387;
        Wed, 22 Sep 2021 11:04:26 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint5.akamai.com with ESMTP id 3b7q801daw-1;
        Wed, 22 Sep 2021 11:04:26 -0700
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id C2A45275EE;
        Wed, 22 Sep 2021 18:04:25 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] Trivial dynamic debug fixups
To:     Andrew Halaney <ahalaney@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210920205444.20068-1-ahalaney@redhat.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <6acfb61d-4aca-ac59-7fc6-d18b4c623765@akamai.com>
Date:   Wed, 22 Sep 2021 14:04:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920205444.20068-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-22_06:2021-09-22,2021-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220117
X-Proofpoint-GUID: 4Q997L-8KqJIZt0owHfhWYmM7aFjxdxS
X-Proofpoint-ORIG-GUID: 4Q997L-8KqJIZt0owHfhWYmM7aFjxdxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_06,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220118
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.60)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Series looks good to me.

Acked-by: Jason Baron <jbaron@akamai.com>

Thanks,

-Jason

On 9/20/21 4:54 PM, Andrew Halaney wrote:
> Hi,
> 
> Here is round 3 of some trivial dynamic debug improvements.
> 
> v2 -> v3:
>  * Use a more clear example in the cli param examples
> 
> v1 -> v2:
>  * Use different example when showing misleading error message
>  * Justify dynamic debug scanning the whole command line
>  * Add patch removing ddebug_query
>  * Add patch improving cli param examples for dyndbg/$module.dyndbg
> 
> v2: https://urldefense.com/v3/__https://lore.kernel.org/all/20210913222440.731329-1-ahalaney@redhat.com/__;!!GjvTz_vk!E6HzrtWvnWiM_KOORWtK46YQNqqO5npPrKi9LrU8F1CdWgS2w6dxfzi_clWo1Q$ 
> v1: https://urldefense.com/v3/__https://lore.kernel.org/all/20210909161755.61743-1-ahalaney@redhat.com/__;!!GjvTz_vk!E6HzrtWvnWiM_KOORWtK46YQNqqO5npPrKi9LrU8F1CdWgS2w6dxfzhcL6__NA$ 
> 
> Andrew Halaney (3):
>   dyndbg: make dyndbg a known cli param
>   dyndbg: Remove support for ddebug_query param
>   Documentation: dyndbg: Improve cli param examples
> 
>  .../admin-guide/dynamic-debug-howto.rst       | 13 ++++-----
>  .../admin-guide/kernel-parameters.txt         |  5 ----
>  lib/dynamic_debug.c                           | 27 +++++--------------
>  3 files changed, 14 insertions(+), 31 deletions(-)
> 
