Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5623721C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhECUpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:45:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229620AbhECUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:45:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143KYMpo186529;
        Mon, 3 May 2021 16:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ycEUNIdqN1E3V0EBHHLHNqsish6lO7fMt0rocjGPDpg=;
 b=K0gk3gA0ysJuiqqqI7B1EuyuwR3TaL80FW/AiMqvSWJWTI2MonKJm4uP5DZqaWlnFzBr
 SzgAxMp5Tv3UhtZpfmNp+XMKuaz6M8Ezk3D01qh/hJR1IDM0EzKS2OHHqmBN2OT+uxDG
 BL2J7uaDe1n0S5ZOvD7YBcjT9DSkdtNUR48Rq1ohVzyWS+OT5FWFSWiBj91Mg/Suj3kJ
 YaiwaU2U/u36ICYtN35prCnePzUkG7g9tbbs2F7HwPHQDZ27/JGMyEReq4uidSGydWu5
 nasryFFmPm1bTuIPbONJtvbo+88eq/hv5nYfe5uSAFwkbw/0Xj3XmHqv+rlWw5aX2NdO Ng== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38aqn9991v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 16:44:12 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143KhZkj003386;
        Mon, 3 May 2021 20:44:11 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 388xma0qkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 20:44:11 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143KiAng43778422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 20:44:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D950E124053;
        Mon,  3 May 2021 20:44:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5465124052;
        Mon,  3 May 2021 20:44:09 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.113.121])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 20:44:09 +0000 (GMT)
Subject: Re: [PATCH v3] pseries/drmem: update LMBs after LPM
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210428094758.28665-1-ldufour@linux.ibm.com>
 <87fsz95qso.fsf@linux.ibm.com>
 <9d29bf8c-9e97-c179-6897-8e25fa4eb516@linux.ibm.com>
 <271ef351-b89c-ba68-3b6d-baa24cc0021b@linux.ibm.com>
 <c87e17d3-8956-9eb0-6f8a-ae316ea75f7e@linux.ibm.com>
 <1eac9540-e8b4-53be-1f27-4c36f92c8a5e@linux.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <bdc510ff-f9f6-b032-0f0d-52a274fb9dab@linux.ibm.com>
Date:   Mon, 3 May 2021 13:44:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1eac9540-e8b4-53be-1f27-4c36f92c8a5e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DzQv9rEISax9ilyIRMNpXJKXCV4p75Vn
X-Proofpoint-GUID: DzQv9rEISax9ilyIRMNpXJKXCV4p75Vn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_19:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 10:28 AM, Laurent Dufour wrote:
> Le 01/05/2021 à 01:58, Tyrel Datwyler a écrit :
>> On 4/30/21 9:13 AM, Laurent Dufour wrote:
>>> Le 29/04/2021 à 21:12, Tyrel Datwyler a écrit :
>>>> On 4/29/21 3:27 AM, Aneesh Kumar K.V wrote:
>>>>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>>>>

Snip

>>
>> As of today I don't have a problem with your patch. This was more of me pointing
>> out things that I think are currently wrong with our memory hotplug
>> implementation, and that we need to take a long hard look at it down the road.
> 
> I do agree, there is a lot of odd things there to address in this area.
> If you're ok with that patch, do you mind to add a reviewed-by?
> 

Can you send a v4 with the fix for the duplicate update included?

-Tyrel
