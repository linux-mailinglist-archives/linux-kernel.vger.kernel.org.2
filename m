Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43C8391076
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhEZGOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:14:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232734AbhEZGOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:14:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q64EUF013326;
        Wed, 26 May 2021 02:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=HEh6jiRhEKHTKOcKijy1XwvxEAL7bFyMz0AfMl/HghQ=;
 b=Q4sB5iHU40TBoxxVec8MTMi7eaRf9uTzUK9+j4thgxQpVB6bKGJPtBRXdEkSU5j7HSUH
 ShcJiulF5cllD858yclxwzG7R8dltgP/N2uJZe9O/Klogr2z4nclL2v6H0BkhabEiiZ8
 fSb2XWv1Fyb2b5+o6wr5RCim+osN2wThsatx3k9H83wOXPzJ7cSo94OkxovQJGl0HiJ9
 iUpL7I1b3pUnlQdpDjdZrqU5rtNs6ANgvlHqBkuwlyYGnl1y4VhYQ8QkG/CTQHKLTxva
 r+bu7ClkB7PE3MDAu8jTwZgXhKUKt/+vlY0gYWlfV8JDBVawdBqQJ68nGfaFRxcSHXxA 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sgev0mcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 02:13:09 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14Q64HAk013582;
        Wed, 26 May 2021 02:13:08 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sgev0mbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 02:13:08 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14Q6CQJC002713;
        Wed, 26 May 2021 06:13:06 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 38s1ht06dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 06:13:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14Q6D2Zk26607958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 06:13:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D94BBA405C;
        Wed, 26 May 2021 06:13:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FEBBA4064;
        Wed, 26 May 2021 06:13:01 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.85.126.125])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 26 May 2021 06:13:00 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] perf vendor events: Fix eventcode of power10 json events
From:   Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20210525152736.GB2135213@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Date:   Wed, 26 May 2021 11:42:58 +0530
Cc:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        maddy@linux.vnet.ibm.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, mpe@ellerman.id.au,
        ravi.bangoria@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5960AF7C-64BD-4E57-BA6D-08AA9932B063@linux.ibm.com>
References: <20210525063723.1191514-1-kjain@linux.ibm.com>
 <20210525144215.GA2135213@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <20210525152736.GB2135213@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
To:     "Paul A. Clarke" <pc@us.ibm.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: koH-ecw_P2N0alB5FHKm8Ve0RZ14XCAX
X-Proofpoint-ORIG-GUID: rhyOl8TBPd5YISrdFAxBctYknR2qzSfT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_04:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 25-May-2021, at 8:57 PM, Paul A. Clarke <pc@us.ibm.com> wrote:
>>=20
> I lost the original message, but Nageswara Sastry said:
>> 1. Extracted all the 244 events from the patch.
>> 2. Check them in 'perf list' - all 244 events found
>> 3. Ran all the events with 'perf stat -e "event name" sleep 1', all =
ran fine.
>>    No errors were seen in 'dmesg'
>=20
> I count 255 events.
>=20
> PC

Seems while extracting I filtered out newly added ones, so I got =
244(255-11).=20
Now checked with all 255 events. Thanks for pointing out.

Thanks!!
R.Nageswara Sastry=
