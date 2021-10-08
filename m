Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3AA426E49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbhJHQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbhJHQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:01:25 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F66C061570;
        Fri,  8 Oct 2021 08:59:29 -0700 (PDT)
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198BhAbl013887;
        Fri, 8 Oct 2021 16:58:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=nQT0pDQBnSAmGfU00nYQ1XuliE6Sr0B1tRWRP1GZ2aY=;
 b=oanX2LJjyOcaCxF/jLUOM0UGnOTQG6V4GtJ+JvHY6Xn7m4AuRkVz+J9AJcOErgMOT5cl
 oTECgZDogkzBtKd3KWHpbcNECEHsJTaCqiXuWpsujgx8wV/rfjnzYrYQl/pbOACeHZI1
 Y+XjG7VQZo99U3FR1V433OEXwdN1gYGL94YecFqbET7+ccuOuXIG6w3Lawg3JZgs5FOV
 PCfRgjvVnFoNdiFWpGgxvRQ/40VfAwSfPbWvN2nVLKB+N0gGdH8G9BNZIfQT72t5GfTj
 wT5Bxbl2YTU07eqW4EC+JIimrYwP/kl5Lo5OZwocLDo7coSQG7S+IKvAGohx0+jCPjBF 5w== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 3bjcvrghfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 16:58:59 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 198FZJVX012015;
        Fri, 8 Oct 2021 11:58:58 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint4.akamai.com with ESMTP id 3bgu753suw-1;
        Fri, 08 Oct 2021 11:58:58 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id DF56C600D3;
        Fri,  8 Oct 2021 15:58:57 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] Trivial dynamic debug fixups
To:     Andrew Halaney <ahalaney@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210920205444.20068-1-ahalaney@redhat.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <670b5afa-0d76-7e78-2b31-f1d4355dd026@akamai.com>
Date:   Fri, 8 Oct 2021 11:58:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920205444.20068-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-10-08_04:2021-10-07,2021-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=985 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080091
X-Proofpoint-GUID: lActKJ14HslglU07grPBbxiI67Uk2y6g
X-Proofpoint-ORIG-GUID: lActKJ14HslglU07grPBbxiI67Uk2y6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=892 clxscore=1011 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110080092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Greg to this (should have added him earlier)

Greg, if you are ok with this series, we'd like to have it added
to -next.

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
