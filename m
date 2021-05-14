Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99884381140
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhENT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhENT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:57:39 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:56:27 -0700 (PDT)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 14EJsk7N020051;
        Fri, 14 May 2021 20:56:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=XG33eIJsrxMuT05lfy2r+Ra69gUMWaEBJ5U51RLR3KY=;
 b=FcCtdqZeVXCqT1YvD3OwgyBy00Q4CNMEJaeDqsA6rKwfy0GJPoVnxmJjF8Okfr83gpc/
 eo7o2gl2xMYnXSIWGPdqcao11UzfOq0xMEfDxEOSbVv6ihgwhex2nh4HIsEI2RhlQIrA
 7OYDYcmJAjDEEwMlb/hQvnItgHM7+vtXFgSFtW9aQpcdbkuiNKigVQSByGj3bdGC6Vt3
 K1z8Bf9RmnDuQqVWXqkyZp0M0HPTJO1BYwuV05LcxvaoqeF5zZIMDa/U9QUsRpZR2r2R
 xyRvXMp0+E9D1pWSqxcQnOXkL2ve7SmAWnoMyQT/XOQen+YGBKQsqarGWZC9tDeLAHkF 8w== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 38hhtwv6jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 20:56:04 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 14EJsl7K021768;
        Fri, 14 May 2021 15:56:02 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint2.akamai.com with ESMTP id 38gpmrn6qv-1;
        Fri, 14 May 2021 15:56:02 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id EDEE92666A;
        Fri, 14 May 2021 19:56:01 +0000 (GMT)
Subject: Re: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log
 with debug messages
To:     Joe Perches <joe@perches.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
 <6d55670d-2f06-d768-699f-5a79cece6ce0@gmail.com>
 <d181b674-66fb-1719-e3c6-e4217cf5519c@akamai.com>
 <59985635-665b-773f-de8f-b15fe3f60196@gmail.com>
 <1789b1da-7a0f-9fc9-6ed2-ff68e2306342@akamai.com>
 <204a99e1-de7a-4434-0932-45f1b507e9ec@gmail.com>
 <5a416031-ddcd-7ef4-ec33-47134bf064bb@akamai.com>
 <7cc30a8a6644bb60e5f3358e89253d9fc783fe54.camel@perches.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <e0116c3e-21a3-50a4-e9fd-cb227ef0b63b@akamai.com>
Date:   Fri, 14 May 2021 15:56:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7cc30a8a6644bb60e5f3358e89253d9fc783fe54.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_10:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=765 phishscore=0
 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140154
X-Proofpoint-ORIG-GUID: OAb3dx6iElzXp6GMMTNJNL8hEVJr6V41
X-Proofpoint-GUID: OAb3dx6iElzXp6GMMTNJNL8hEVJr6V41
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_08:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=736
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140155
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.19)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/21 1:38 PM, Joe Perches wrote:
> On Tue, 2021-05-11 at 17:31 -0400, Jason Baron wrote:
> 
>> That said, I do see the value in not having to open code the branch stuff, and
>> making pr_debug() consistent with printk which does return a value. So that
>> makes sense to me.
> 
> IMO: printk should not return a value.
> 

Ok, the issue we are trying to resolve is to control whether a 'pr_debug()' statement
is enabled and thus use that to control subsequent output. The proposed patch does:


+	printed = pr_debug("e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
+	if (printed > 0) {
+		e820_print_type(old_type);
+		pr_cont(" ==> ");
+		e820_print_type(new_type);
+		pr_cont("\n");
+	}

I do think pr_debug() here is different from printk() b/c it can be explicitly
toggled.

I also suggested an alternative, which is possible with the current code which
is to use DYNAMIC_DEBUG_BRANCH().

if (DYNAMIC_DEBUG_BRANCH(e820_debg)) {
    printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
    e820_print_type(old_type);
    pr_cont(" ==> ");
    e820_print_type(new_type);
    pr_cont("\n");
}

That however does require one to do something like this first:

DEFINE_DYNAMIC_DEBUG_METADATA(e820_dbg, "e820 verbose mode");

So I don't feel too strongly either way, but maybe others do?

Thanks,

-Jason
