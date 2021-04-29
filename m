Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2336F18E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhD2VJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhD2VJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:09:22 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664CEC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:08:35 -0700 (PDT)
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13TL3mFR006092;
        Thu, 29 Apr 2021 22:08:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=Idipjsa1i0CoALY9EIRlOritl8cj51s+F1wvxdQIA4I=;
 b=Q+6Y6YvIgMr+/zaLKkuyi0BMiKITIL2L8yrA3cIl72heLJy1bA5dREZM5xDj8mEgdXoG
 xgpAaCOtSdN+g5/qQTLMJacAJMZaNweru+A30KNM/y1sKf1YNCtP4C8GASuAoEFVPdO8
 cta/PbFv2C7ULGjBVexEOiOw4jljsDnhNHb3hw+c/CA//7m2pWAHpmoUfOWaqBM+5HhA
 VHpb5vA95YavnGyrwNVY84SxsMzU3vHlKNydjzbNU35beECV2Qx4sI2sv4ExK2OEL3OM
 HWLbccwNOwgffdRoYI4e3Fc2c+TQOom8J8x9/S7lYSsQMNkVmu6oo+C2BU+9sGZplgfU eQ== 
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 387nkduear-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 22:08:30 +0100
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 13TL44A9012551;
        Thu, 29 Apr 2021 17:08:29 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint7.akamai.com with ESMTP id 387475wc2w-1;
        Thu, 29 Apr 2021 17:08:29 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 8036C60633;
        Thu, 29 Apr 2021 21:08:28 +0000 (GMT)
Subject: Re: [PATCH] dyndbg: fix parsing file query without a line-range
 suffix
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Shuo Chen <giantchen@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Shuo Chen <shuochen@google.com>
References: <20210414212400.2927281-1-giantchen@gmail.com>
 <a053afb1-bd3c-78f2-6414-e43014692a56@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <a98d420c-500d-2790-0ee9-71f4690c24d7@akamai.com>
Date:   Thu, 29 Apr 2021 17:08:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a053afb1-bd3c-78f2-6414-e43014692a56@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_11:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290135
X-Proofpoint-GUID: olkSgo2fn4_aMmB1_vgT4oIJtShxIBdV
X-Proofpoint-ORIG-GUID: olkSgo2fn4_aMmB1_vgT4oIJtShxIBdV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_11:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290135
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.33)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/21 12:38 PM, Eric Dumazet wrote:
> 
> 
> On 4/14/21 11:24 PM, Shuo Chen wrote:
>> From: Shuo Chen <shuochen@google.com>
>>
>> Query like 'file tcp_input.c line 1234 +p' was broken by
>> commit aaebe329bff0 ("dyndbg: accept 'file foo.c:func1' and 'file
>> foo.c:10-100'") because a file name without a ':' now makes the loop in
>> ddebug_parse_query() exits early before parsing the 'line 1234' part.
>> As a result, all pr_debug() in tcp_input.c will be enabled, instead of only
>> the one on line 1234.  Changing 'break' to 'continue' fixes this.
>>
>> Fixes: aaebe329bff0 ("dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'")
>> Signed-off-by: Shuo Chen <shuochen@google.com>
>> ---
>>  lib/dynamic_debug.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
>> index c70d6347afa2..921d0a654243 100644
>> --- a/lib/dynamic_debug.c
>> +++ b/lib/dynamic_debug.c
>> @@ -396,7 +396,7 @@ static int ddebug_parse_query(char *words[], int nwords,
>>  			/* tail :$info is function or line-range */
>>  			fline = strchr(query->filename, ':');
>>  			if (!fline)
>> -				break;
>> +				continue;
>>  			*fline++ = '\0';
>>  			if (isalpha(*fline) || *fline == '*' || *fline == '?') {
>>  				/* take as function name */
>>
> 
> SGTM, thanks !
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 

Hi Greg,

I acked this previously and is an important fix.
Can you please pick it up if you haven't done so?

Thanks!

-Jason
