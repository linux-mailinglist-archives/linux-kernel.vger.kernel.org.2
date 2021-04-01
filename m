Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FE0351FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhDATYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbhDATYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:24:06 -0400
X-Greylist: delayed 1329 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Apr 2021 11:32:32 PDT
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26946C04B808
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 11:32:31 -0700 (PDT)
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131I92Tl012835;
        Thu, 1 Apr 2021 19:10:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=80msk2kv9/Tl4nZ92EVrWwKM/D1LiiodQE+LvJBI1ho=;
 b=ByQ4QzmX+gq83kPuP0/a757dffYPU2slRZMyCXNshpkCQ9IeEnXhI8WNgy16bM9/+QFg
 K1RoK2NAZ853zAy25hEcY5L8QUXB0o+fN6b2e3+6ZSv6DHC4vR18KnTGTNZQI8NU9xCo
 W4Gym5+Qj8vSoTMy5IVFYT8qiwzAJYRf//bw5g4wGOHQV799tyjHHq/J/MVhZ5XPxirh
 51N1k0lzdc1P+CtVaJEXQt6gf22dmlhcuJd1u8Q0YiDdZYvJGCxt/6AVPGOpy4tKFE6f
 pALltuuQRodcemayv7jMR5TWFhHimgXnM0iuctoaM0NeDZ0Px3KBS9irHSomom/D2BiT gg== 
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 37n2cx60uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 19:10:16 +0100
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.0.43/8.16.0.43) with SMTP id 131I4xBk004447;
        Thu, 1 Apr 2021 14:10:10 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint8.akamai.com with ESMTP id 37n536eb36-1;
        Thu, 01 Apr 2021 14:10:10 -0400
Received: from [0.0.0.0] (prod-ssh-gw02.sanmateo.corp.akamai.com [172.22.187.166])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id CC42C6060A;
        Thu,  1 Apr 2021 18:10:09 +0000 (GMT)
Subject: Re: [PATCH] psi: allow unprivileged users with CAP_SYS_RESOURCE to
 write psi files
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20210401033156.7262-1-johunt@akamai.com>
 <m15z16r583.fsf@fess.ebiederm.org> <202104010039.A134EC56@keescook>
 <m1v995q4l1.fsf@fess.ebiederm.org>
From:   Josh Hunt <johunt@akamai.com>
Message-ID: <0fd5d9b0-4c9e-2dfe-a8fe-1d1def8a6122@akamai.com>
Date:   Thu, 1 Apr 2021 11:10:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <m1v995q4l1.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_09:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=995 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010118
X-Proofpoint-GUID: AQEkAcEsoPK0dMkRls_VFEYowJlDPhmG
X-Proofpoint-ORIG-GUID: AQEkAcEsoPK0dMkRls_VFEYowJlDPhmG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_09:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=982 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010119
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.34)
 smtp.mailfrom=johunt@akamai.com smtp.helo=prod-mail-ppoint8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 10:47 AM, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
>> On Wed, Mar 31, 2021 at 11:36:28PM -0500, Eric W. Biederman wrote:
>>> Josh Hunt <johunt@akamai.com> writes:
>>>
>>>> Currently only root can write files under /proc/pressure. Relax this to
>>>> allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
>>>> able to write to these files.
>>>
>>> The test for CAP_SYS_RESOURCE really needs to be in open rather
>>> than in write.
>>>
>>> Otherwise a suid root executable could have stdout redirected
>>> into these files.
>>
>> Right. Or check against f_cred. (See uses of kallsyms_show_value())
>> https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/security/credentials.html*open-file-credentials__;Iw!!GjvTz_vk!B_aeVyHMG20VNUGx001EFKpeYlahLQHye7oS8sokXuZOhVDTtF_deDl71a_KYA$
> 
> We really want to limit checking against f_cred to those cases where we
> break userspace by checking in open.  AKA the cases where we made the
> mistake of putting the permission check in the wrong place and now can't
> fix it.
> 
> Since this change is change the permissions that open uses already I
> don't see any reason we can't perform a proper check in open.
> 
> Eric
> 

Thank you for the feedback. I will spin a v2 doing the check in open.

Josh
