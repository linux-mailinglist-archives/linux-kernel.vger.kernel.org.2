Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D53DF402
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhHCRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:38:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33742 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238227AbhHCRiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:38:22 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173HWptF087804;
        Tue, 3 Aug 2021 13:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TCbWjUes1nMwS2rcYx9EkBy9sx391NeStjD5HTtMch0=;
 b=CTE45sj5a2HPaxcsvCQtV0+JwNUWCYbgEhAXZDW+iFa98jic3VjyFrn75bRfKKY6ht3H
 ktjCSVLuho37uFAw6kp+gYLHHdoQsKd/ZEXwwAlas/S/eFBLmFmQUPZ5bKRgbCMnLo07
 EXBAG5jmLgv/IDrrEXt/mXxX4gwiO0LhBekuLpxv17wtDBoXuzL4w04cFDpt1i/sdg/s
 dxpdytiCk374AtSw7EPRUggtJSpLb6jMIneV1PkrHbaA7LGIIVjjS3/Tz8vWVr0ds0yk
 lZ4Bxs/tzo+dE83Xeq8Mil447QygLMHKSIqpksYEMbBPrg+aGjtqsWsibvX7lvj2XD4y VQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76c3qry1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 13:37:54 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173HXQJj030228;
        Tue, 3 Aug 2021 17:37:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3a4x58eu52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 17:37:53 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173HYs8U32440674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 17:34:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B67CA4064;
        Tue,  3 Aug 2021 17:37:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B6C5A4054;
        Tue,  3 Aug 2021 17:37:50 +0000 (GMT)
Received: from pomme.local (unknown [9.145.42.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 17:37:50 +0000 (GMT)
Subject: Re: [PATCH v5] pseries: prevent free CPU ids to be reused on another
 node
To:     Nathan Lynch <nathanl@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210429174908.16613-1-ldufour@linux.ibm.com>
 <87v94mii3z.fsf@linux.ibm.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <1bfe14e7-0742-fcae-72f7-de7874232ee1@linux.ibm.com>
Date:   Tue, 3 Aug 2021 19:37:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87v94mii3z.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3TQF_fIQAJ3cyBZ_1hpK3gbsV4RlNGoY
X-Proofpoint-GUID: 3TQF_fIQAJ3cyBZ_1hpK3gbsV4RlNGoY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/08/2021 à 18:54, Nathan Lynch a écrit :
> Laurent Dufour <ldufour@linux.ibm.com> writes:
>> V5:
>>   - Rework code structure
>>   - Reintroduce the capability to reuse other node's ids.
> 
> OK. While I preferred v4, where we would fail an add rather than allow
> CPU IDs to appear to "travel" between nodes, this change is a net
> improvement.
> 
> Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
> 

Thanks Nathan,

Regarding the reuse of other nodes free CPU ids, with this patch the kernel does 
it best to prevent that. Instead of failing adding new CPUs, I think it's better 
to reuse free CPU ids of other nodes, otherwise, only a reboot would allow the 
CPU adding operation to succeed.

Laurent.
