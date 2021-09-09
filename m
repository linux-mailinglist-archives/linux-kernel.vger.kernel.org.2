Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A297405EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhIIVgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhIIVgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:36:05 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72F5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:34:55 -0700 (PDT)
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 189Kpnn3001964;
        Thu, 9 Sep 2021 22:34:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=5sxjvJQm9UVCIOl9Adtj/oLLY2/hpsXlms3YjCn+yCA=;
 b=Vzphj/G+c5qW8AJbt7r543ykjoIMqCPlo27ROzDiywkZiCOqxYlNcwaFc3sYmaHle6dq
 FqgkFiLpsmruQs+2TB3+wQfhik6dlPWK1gOW7CZKiaPYNLBBEsKjeSMGQ5qK4iCUmrZW
 nIyQDkSDcucrdy1/+zoFRl87yzmjF6o9OeJwjTo9Mbz4jEAO1peVVOpdZyWKFuaFTa3x
 t4yh/gM+p3PIv6APf6UZuPRbKPUzPU0LEkinPkuSYHYsU8eObC7oCtJWJnGoY2/770E0
 /jqCNEN7SOWR2gWvjXvBITKRdEFrHcr85JcsxlXuysuWJUzraYrEcTI1GZ8ckxk5v3wu Zw== 
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 3ayhvgbn52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 22:34:52 +0100
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 189LYgd1013925;
        Thu, 9 Sep 2021 17:34:52 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint7.akamai.com with ESMTP id 3axcuge4qp-1;
        Thu, 09 Sep 2021 17:34:52 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id AA3C760293;
        Thu,  9 Sep 2021 21:34:51 +0000 (GMT)
Subject: Re: [PATCH] dyndbg: make dyndbg a known cli param
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
References: <20210909161755.61743-1-ahalaney@redhat.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <0849504a-b7ed-f448-6d66-1a9fd5ad70ce@akamai.com>
Date:   Thu, 9 Sep 2021 17:34:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210909161755.61743-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_08:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090132
X-Proofpoint-GUID: wef05ZFZiEr9Vv2tRheVVWe49vFJQiLK
X-Proofpoint-ORIG-GUID: wef05ZFZiEr9Vv2tRheVVWe49vFJQiLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-09_08,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090132
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.33)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/21 12:17 PM, Andrew Halaney wrote:
> Right now dyndbg shows up as an unknown parameter if used on boot:
> 
>     Unknown command line parameters: dyndbg=module params +p ; module sys +p
> 
> That's because it is unknown, it doesn't sit in the __param
> section, so the processing done to warn users supplying an unknown
> parameter doesn't think it is legitimate.
> 
> Install a dummy handler to register it. This was chosen instead of the
> approach the (deprecated) ddebug_query param takes, which is to
> have a real handler that copies the string taking up a KiB memory.
> 
> Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> This is the last valid param I know of that was getting flagged on boot
> if used correctly. Please let me know if the alternative approach of
> actually copying the string is preferred and I'll spin that up instead.
> 

Hi Andrew,

So I think you are referring to the string copying that ddebug_query= does.
I don't think that works for 'dyndbg=' b/c its actually looking through
the entire command line for stuff like <module_name>.dyndbg="blah".

So I think what you prposed below makes sense, we could perhaps add a note
as to why it's a noop. As I mentioned it needs to look through the entire
string.


> Sort of an aside, but what's the policy for removing deprecated cli
> params? ddebug_query has been deprecated for a very long time now, but I
> am not sure if removing params like that is considered almost as bad as
> breaking userspace considering some systems might update their kernels
> but not the bootloader supplying the param.

I think it's probably ok to remove at this point, especially now that
we are going to flag it as unknown, right? So I feel like that change
can logically go with this series if you want as a separate patch.

Thanks,

-Jason


> 
>  lib/dynamic_debug.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index cb5abb42c16a..84c16309cc63 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -761,6 +761,18 @@ static __init int ddebug_setup_query(char *str)
>  
>  __setup("ddebug_query=", ddebug_setup_query);
>  
> +/*
> + * Install a noop handler to make dyndbg look like a normal kernel cli param.
> + * This avoids warnings about dyndbg being an unknown cli param when supplied
> + * by a user.
> + */
> +static __init int dyndbg_setup(char *str)
> +{
> +	return 1;
> +}
> +
> +__setup("dyndbg=", dyndbg_setup);
> +
>  /*
>   * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers the
>   * command text from userspace, parses and executes it.
> 
