Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0C34CF67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhC2LvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:51:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19168 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbhC2LvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:51:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TBX4dd078904;
        Mon, 29 Mar 2021 07:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=8INBHVcr1Z6ZyixXIgG1q5wWIeqEi84G0EU5SaLxyl0=;
 b=f/z0s9ltXDk6NDAqB992NzosVWsNuep7PmiGEr1z9j45oQsd+oDvmt3JIvLJlSqvBIjL
 IS6jCK2Y2CnQbepURCRyCx9lQOK8wYQUcf5JEkuxyvJw4D4WkifRfpEA2r+oEMC/EteP
 ROYoegO8lo1avQpB+ObCNj4Yazh35iXOhjVdMZeLmHL6TERJAr0j5Xnp1tEXrfyUpq+j
 BXNIoFDz/19riSZVDpHrNjs4QA8rlZ5/67m4KynSg1oq9sqF6BiEiUyL2DvZOXIobMr1
 VqpFX4fKUU4wMdoVrMA1IntR9U2QqSkFc6SZTi9YMg5kVAyqT8/5yD2JYujJMcpOMtJT 2Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jpbv90g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 07:50:57 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12TBlrBT011271;
        Mon, 29 Mar 2021 11:50:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 37hvb8gwwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 11:50:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12TBoYPu35914182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 11:50:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65047AE04D;
        Mon, 29 Mar 2021 11:50:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0425EAE045;
        Mon, 29 Mar 2021 11:50:53 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Mar 2021 11:50:52 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] entry: Make CONFIG_DEBUG_ENTRY available
 outside x86
References: <cover.1614884673.git.luto@kernel.org>
        <d5b13da88adf4e732a07fe709263e572cb5ca8de.1614884673.git.luto@kernel.org>
        <20210308101347.GD7951@C02TD0UTHF1T.local>
Date:   Mon, 29 Mar 2021 13:50:52 +0200
In-Reply-To: <20210308101347.GD7951@C02TD0UTHF1T.local> (Mark Rutland's
        message of "Mon, 8 Mar 2021 10:13:47 +0000")
Message-ID: <yt9d7dlqw543.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tPIdqn6c8-81xZrdvxtEdoDEIBkVQO3f
X-Proofpoint-ORIG-GUID: tPIdqn6c8-81xZrdvxtEdoDEIBkVQO3f
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_08:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=722 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, Mar 04, 2021 at 11:06:01AM -0800, Andy Lutomirski wrote:
>> In principle, the generic entry code is generic, and the goal is to use it
>> in many architectures once it settles down more.  Move CONFIG_DEBUG_ENTRY
>> to the generic config so that it can be used in the generic entry code and
>> not just in arch/x86.
>> 
>> Disable it on arm64.  arm64 uses some but not all of the kentry
>> code, and trying to debug the resulting state machine will be painful.
>> arm64 can turn it back on when it starts using the entire generic
>> path.
>
> Can we make this depend on CONFIG_GENERIC_ENTRY instead of !ARM64?
> That'd be more in line with "use the generic entry code, get the generic
> functionality". Note that arm64 doesn't select CONFIG_GENERIC_ENTRY
> today.
>
> I see that s390 selects CONFIG_GENERIC_ENTRY, and either way this will
> enable DEBUG_ENTRY for them, so it'd ve worth checking whether this is
> ok for them.
>
> Sven, thoughts?
>

For s390 that change should be fine.
