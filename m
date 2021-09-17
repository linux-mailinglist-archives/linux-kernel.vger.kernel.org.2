Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57485410040
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbhIQUPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343892AbhIQUPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:15:32 -0400
X-Greylist: delayed 1401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Sep 2021 13:14:09 PDT
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CCEC061574;
        Fri, 17 Sep 2021 13:14:03 -0700 (PDT)
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HIUNZM019594;
        Fri, 17 Sep 2021 20:50:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=t/UzDs41fhr/3WPUQPzQWLJyBc+toDLsiW1RT3rjUQY=;
 b=b4V3xSa5nkxkYKYs73IUMzAqAbUbLkBs5rL+628BoNrfIj7Gb0KJWfp3kxrQ/2sm0YGB
 azyUt5EXvci2Q/VmdPVZfcmK38suFrmxp3juY2H3Bj/+cK5RxejZ6zJnsHkILwv8MP4E
 wI42Bt3g+YyWCxP4gqtKvgOoydBnPnGHz2XtlmtAtnLBYG+6pDJJGy5ExWdJWRhmiJDa
 oqfMHWVtxRBKRMAtXM2p0mo1iHvaOYpXA1VYWuKlOoD4fBrWShH1Bh1v+cq/DvK93+QO
 W2/HCK3oOths5YtVmXwOQ64JKe3Xi2UIQmaSLGk34/5AX93M03TctLdzzmM+EP5/fITC 4g== 
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 3b4hdecu3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 20:50:37 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 18HJnYcx030675;
        Fri, 17 Sep 2021 15:50:36 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
        by prod-mail-ppoint3.akamai.com with ESMTP id 3b3n2v6dcu-1;
        Fri, 17 Sep 2021 15:50:36 -0400
Received: from [0.0.0.0] (unknown [172.27.119.138])
        by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id A6A9111D;
        Fri, 17 Sep 2021 19:50:35 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] Documentation: dyndbg: Improve cli param examples
To:     Andrew Halaney <ahalaney@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210913222440.731329-1-ahalaney@redhat.com>
 <20210913222440.731329-4-ahalaney@redhat.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <ff05cae4-8fa7-d1b6-795e-3bd85316774d@akamai.com>
Date:   Fri, 17 Sep 2021 15:50:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210913222440.731329-4-ahalaney@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-17_08:2021-09-17,2021-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170118
X-Proofpoint-ORIG-GUID: fOdtlFq1dLt6ug-7p1TkzhtqvLDHUtPg
X-Proofpoint-GUID: fOdtlFq1dLt6ug-7p1TkzhtqvLDHUtPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_08,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170118
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.31)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/21 6:24 PM, Andrew Halaney wrote:
> Jim pointed out that using $module.dyndbg= is always a more flexible
> choice for using dynamic debug on the command line. The $module.dyndbg
> style is checked at boot and handles if $module is a builtin. If it is
> actually a loadable module, it is handled again later when the module is
> loaded.
>
> If you just use dyndbg="module $module +p" dynamic debug is only enabled
> when $module is a builtin.
>
> It was recommended to illustrate wildcard usage as well.
>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> Suggested-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>   Documentation/admin-guide/dynamic-debug-howto.rst | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index d0911e7cc271..4bfb23ed64ec 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -357,7 +357,10 @@ Examples
>     Kernel command line: ...
>       // see whats going on in dyndbg=value processing
>       dynamic_debug.verbose=1
> -    // enable pr_debugs in 2 builtins, #cmt is stripped
> -    dyndbg="module params +p #cmt ; module sys +p"
> +    // Enable pr_debugs in the params builtin
> +    params.dyndbg="+p"

If we are going out of our way to change this to indicate that it works 
for builtin and modules, it seems like the comment above should reflect 
that? IE, something like this?

'// Enable pr_debugs in the params module or if params is builtin.

The first two patches look fine to me, so if you agree maybe just 
re-spin this one?

Thanks,

-Jason

> +    // enable pr_debugs in all files under init/
> +    // and the function pc87360_init_device, #cmt is stripped
> +    dyndbg="file init/* +p #cmt ; func pc87360_init_device +p"
>       // enable pr_debugs in 2 functions in a module loaded later
>       pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"

