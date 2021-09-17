Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4044100F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbhIQV4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 17:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhIQV4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:56:03 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3386C061574;
        Fri, 17 Sep 2021 14:54:40 -0700 (PDT)
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HIUN41019594;
        Fri, 17 Sep 2021 22:54:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=UnXkc7guJm5ab+bR3+B5oisv4F3I1czrKU1XKInJrys=;
 b=I2p+w1wK3XfquGwAkIFR9RdE4Qyc8Df2/lEMf2F7K34SkxN8TKR13j4TBNbUQPN+f7Dj
 F1y/KSmUncBFxXXDWOS+L99Eh+aKThBezZEiZMAbPP9dP/pwkB8YDH/wEo0EQQ9Dol6h
 Vu9pvLVP1DY+FRm1mJ1mWywDX/lMI3YkRrSEiuo/jKH+C/3PdoB1fPn2vpOvtFIivsLf
 ULDzd9jbLqTmpdrhNY0diolv6ev2B1UW2fyFD644j1bY21W8qyw/clJHjOv35+YBnrdA
 1XY2x7QRQxG39qA8iXSBZ/u/a3tmCYIznSjVtBuSY5IH/2bQOsb+PRSNnD2jETk2EKnc Zw== 
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 3b4hdef30p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 22:54:36 +0100
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 18HLoqYe031099;
        Fri, 17 Sep 2021 17:54:36 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint8.akamai.com with ESMTP id 3b32mb4upk-1;
        Fri, 17 Sep 2021 17:54:36 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 8A02360168;
        Fri, 17 Sep 2021 21:54:35 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] Documentation: dyndbg: Improve cli param examples
To:     Andrew Halaney <ahalaney@redhat.com>, jim.cromie@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210913222440.731329-1-ahalaney@redhat.com>
 <20210913222440.731329-4-ahalaney@redhat.com>
 <ff05cae4-8fa7-d1b6-795e-3bd85316774d@akamai.com>
 <CAJfuBxzrJwr17-RWZzhw90pKXZ1hL5kepuzvt1Di=JyekMJf4A@mail.gmail.com>
 <20210917205341.5bayndskygan6qrd@halaneylaptop>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <088053f9-3113-66ce-9717-8afd84c48e53@akamai.com>
Date:   Fri, 17 Sep 2021 17:54:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210917205341.5bayndskygan6qrd@halaneylaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-17_09:2021-09-17,2021-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170129
X-Proofpoint-ORIG-GUID: LHGGqVoytQKqOimSGXNm1oajZNFtbKU7
X-Proofpoint-GUID: LHGGqVoytQKqOimSGXNm1oajZNFtbKU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_09,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=931 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170130
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.34)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/21 4:53 PM, Andrew Halaney wrote:
> On Fri, Sep 17, 2021 at 02:30:09PM -0600, jim.cromie@gmail.com wrote:
>> On Fri, Sep 17, 2021 at 1:50 PM Jason Baron <jbaron@akamai.com> wrote:
>>>
>>>
>>> On 9/13/21 6:24 PM, Andrew Halaney wrote:
>>>> Jim pointed out that using $module.dyndbg= is always a more flexible
>>>> choice for using dynamic debug on the command line. The $module.dyndbg
>>>> style is checked at boot and handles if $module is a builtin. If it is
>>>> actually a loadable module, it is handled again later when the module is
>>>> loaded.
>>>>
>>>> If you just use dyndbg="module $module +p" dynamic debug is only enabled
>>>> when $module is a builtin.
>>>>
>>>> It was recommended to illustrate wildcard usage as well.
>>>>
>>>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>>>> Suggested-by: Jim Cromie <jim.cromie@gmail.com>
>>>> ---
>>>>    Documentation/admin-guide/dynamic-debug-howto.rst | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
>>>> index d0911e7cc271..4bfb23ed64ec 100644
>>>> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
>>>> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
>>>> @@ -357,7 +357,10 @@ Examples
>>>>      Kernel command line: ...
>>>>        // see whats going on in dyndbg=value processing
>>>>        dynamic_debug.verbose=1
>>>> -    // enable pr_debugs in 2 builtins, #cmt is stripped
>>>> -    dyndbg="module params +p #cmt ; module sys +p"
>>>> +    // Enable pr_debugs in the params builtin
>>>> +    params.dyndbg="+p"
>>> If we are going out of our way to change this to indicate that it works
>>> for builtin and modules, it seems like the comment above should reflect
>>> that? IE, something like this?
>>>
>>> '// Enable pr_debugs in the params module or if params is builtin.
>>>
>> I dont think params can be a loadable module, so its not a great
>> example of this.
>> it should be one that "everyone" knows is usually loaded.
>>
>> conversely, bare dyndbg example should have only builtin modules,
>> then the contrast between 2 forms is most evident.
>>
> Thank you both for the feedback, good points.
>
> Does something like:
>
>      // Enable pr_debugs in the btrfs module (can be builtin or loadable)
>      btrfs.dyndbg="+p"
>      // enable pr_debugs in all files under init/
>      // and the function parse_one, #cmt is stripped
>      dyndbg="file init/* +p #cmt ; func parse_one +p"
>
> Work for you both? I think that makes the advantages of $module.dyndbg=
> more clear and makes the usage of dyndbg= stick to strictly builtins.
> If so I'll respin this patch in v3 of the series.

Fine with me.

Thanks,

-Jason

>
> Thanks,
> Andrew
>
>>> The first two patches look fine to me, so if you agree maybe just
>>> re-spin this one?
>>>
>>> Thanks,
>>>
>>> -Jason
>>>
>>>> +    // enable pr_debugs in all files under init/
>>>> +    // and the function pc87360_init_device, #cmt is stripped
>>>> +    dyndbg="file init/* +p #cmt ; func pc87360_init_device +p"
>>>>        // enable pr_debugs in 2 functions in a module loaded later
>>>>        pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"

