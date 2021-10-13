Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6193C42C1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhJMN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhJMN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:56:52 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6284DC061570;
        Wed, 13 Oct 2021 06:54:49 -0700 (PDT)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.1.2/8.16.1.2) with SMTP id 19DDN6af004835;
        Wed, 13 Oct 2021 14:54:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=sMP+jJB6SWg9fLjAmeom2/nDG2YfFwUo6uWVt8nwc6Y=;
 b=JNdCVimbsquDOkU/VbvdSwCpFP6q1ZrHxtQFzFH9vUOPzDSXj+ZrAQ/cqA/6SJ1YyyXg
 JIxGkfA6HiY3hUPLJOb8F6w6vEAKAa1iBme58jHeoAPACyA/ZfvIdq7DgXLvg9w3d169
 nOuxHsWEiugq7wfu22WbPEpyii++cPSPncwYyOOKBPXhF/4cklJif+lRjqkzd3F3UWaT
 lXNv+QRBES+5GviFouU9fU0Xg8nqPS9n98voMpYSC99UF6XyxLFa2yN1mrn26yLnFxXs
 XV1id6bOnq9gOqUgSdmEBlZfZ+fCCmKV6J2VcXFIbsKaa577aI8t0EVxBRuikY+kbh7o 3A== 
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 3bp09v8u9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 14:54:37 +0100
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 19DDoBP1024035;
        Wed, 13 Oct 2021 09:54:37 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint7.akamai.com with ESMTP id 3bn97e80ag-1;
        Wed, 13 Oct 2021 09:54:37 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id A01D4600B8;
        Wed, 13 Oct 2021 13:54:36 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] Trivial dynamic debug fixups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210920205444.20068-1-ahalaney@redhat.com>
 <670b5afa-0d76-7e78-2b31-f1d4355dd026@akamai.com>
 <YWBrXZrqdoETlqWG@kroah.com> <20211008162707.nc6vr22srcmga5fp@halaneylaptop>
 <YWbEm1Eq8BlpIQ7V@kroah.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <9f8b253d-6db2-e6bb-5bc5-b39ec23a2721@akamai.com>
Date:   Wed, 13 Oct 2021 09:54:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWbEm1Eq8BlpIQ7V@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-13_05:2021-10-13,2021-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=366 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130094
X-Proofpoint-ORIG-GUID: QcSu3Ggp3HZp7jbuhygVGfD9OpFVARyC
X-Proofpoint-GUID: QcSu3Ggp3HZp7jbuhygVGfD9OpFVARyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=244 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/21 7:35 AM, Greg Kroah-Hartman wrote:
> On Fri, Oct 08, 2021 at 11:27:07AM -0500, Andrew Halaney wrote:
>> On Fri, Oct 08, 2021 at 06:01:33PM +0200, Greg Kroah-Hartman wrote:
>>> On Fri, Oct 08, 2021 at 11:58:57AM -0400, Jason Baron wrote:
>>>> Adding Greg to this (should have added him earlier)
>>>>
>>>> Greg, if you are ok with this series, we'd like to have it added
>>>> to -next.
>>>
>>> What series?
>>>
>>> Have a pointer to it?  It would help if it was actually sent to me if
>>> people want it applied...
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> Sorry Greg, that's probably my bad.. still getting used to the kernel's
>> workflow.
>>
>> Here's the lore link: https://urldefense.com/v3/__https://lore.kernel.org/all/20210920205444.20068-1-ahalaney@redhat.com/__;!!GjvTz_vk!A7QQa1yGOtgSmhzn52NLhZuRbLxxMCyl17_8RiqsehjeAG2AAsYl7bgWgK15Pw$ 
>>
>> Did I do something silly when sending the patches? I basically
>> just added everyone manually when using git send-email.
>>
>> I found who to add via:
>>
>>     ahalaney@halaneylaptop ~/git/linux (git)-[master] % ./scripts/get_maintainer.pl 0002-dyndbg-Remove-support-for-ddebug_query-param.patch                                     :(
>>     Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:1/2=50%)
>>     Jason Baron <jbaron@akamai.com> (maintainer:DYNAMIC DEBUG)
>>     Martin Kepplinger <martink@posteo.de> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:1/3=33%,removed_lines:1/5=20%)
>>     Andrew Halaney <ahalaney@redhat.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:2/3=67%,removed_lines:4/5=80%)
>>     "Paul E. McKenney" <paulmck@kernel.org> (commit_signer:14/89=16%,authored:7/89=8%,added_lines:44/527=8%)
>>     Thomas Gleixner <tglx@linutronix.de> (commit_signer:11/89=12%)
>>     Andrew Morton <akpm@linux-foundation.org> (commit_signer:11/89=12%)
>>     Peter Zijlstra <peterz@infradead.org> (commit_signer:8/89=9%,removed_lines:13/137=9%)
>>     Will Deacon <will@kernel.org> (commit_signer:7/89=8%)
>>     "Maciej W. Rozycki" <macro@orcam.me.uk> (added_lines:90/527=17%)
>>     Muchun Song <songmuchun@bytedance.com> (added_lines:28/527=5%)
>>     Viresh Kumar <viresh.kumar@linaro.org> (removed_lines:14/137=10%)
>>     Robin Murphy <robin.murphy@arm.com> (removed_lines:13/137=9%)
>>     Randy Dunlap <rdunlap@infradead.org> (removed_lines:10/137=7%)
>>     Lu Baolu <baolu.lu@linux.intel.com> (removed_lines:10/137=7%)
>>     linux-doc@vger.kernel.org (open list:DOCUMENTATION)
>>     linux-kernel@vger.kernel.org (open list)
>>
>>
>> per patch, and I just hit the maintainers and the lists specified
>> since I figured the commit_signers don't care. Did I goof up?
> 
> No, that's all correct.  It's up to the maintainers to then route your
> patches to the proper tree.
> 
> If they want me to take them, great, I'll be glad to do so, but I need
> them to send them to me :)

Ok, I will re-send the series to Greg.

Thanks,

-Jason


