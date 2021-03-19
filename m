Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AF934233D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhCSR0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:26:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhCSRZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:25:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JH2o33083296;
        Fri, 19 Mar 2021 13:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Z2NhcHaeuUhIS9SDhxJh2ob1volSnUGX3h80P18tMVY=;
 b=owWhywCDBNeQe3TTdvwthA/WK794t2XhEALSaQdYYm8wgjGNTVczGFeMemzwHgUhUoiP
 +7kdxMa4Hmsv9OJytA17WzsVpglxQR+TMz6UBs9TDTVZXF75uLzmePv3nkWqS8ZeVaxd
 90+271DECiX37hFpm1FyZyqcvzggUEe/ePop4/3enZMFuKEn+j6Vlca6qEd48KmvPbk+
 0lxcEf0MR2VvrqrDvtfUd+AKR875Ak2NALYXfWpkqBgEMCNgHAGQqNr22k9lJx29e+Q7
 2FEoQ8MVwu9Bt3v79iQ+4YDV1XaxqftOkcY0ZoBNiproSaKVQCuMz8O1+n2ryZtSiE7q bQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37cybyskj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 13:25:27 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12JHI4FM010572;
        Fri, 19 Mar 2021 17:25:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 378n18b56r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 17:25:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12JHPMAR23855444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 17:25:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B34824C04E;
        Fri, 19 Mar 2021 17:25:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D4484C044;
        Fri, 19 Mar 2021 17:25:22 +0000 (GMT)
Received: from [9.145.68.105] (unknown [9.145.68.105])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Mar 2021 17:25:22 +0000 (GMT)
Subject: Re: [PATCH 1/3] gcov: combine common code
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes.berg@intel.com>
References: <20210315235453.e3fbb86e99a0.I08a3ee6dbe47ea3e8024956083f162884a958e40@changeid>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <816c7845-2ba5-2af2-6632-842f8d207633@linux.ibm.com>
Date:   Fri, 19 Mar 2021 18:25:22 +0100
MIME-Version: 1.0
In-Reply-To: <20210315235453.e3fbb86e99a0.I08a3ee6dbe47ea3e8024956083f162884a958e40@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_06:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103190118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2021 23:54, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There's a lot of duplicated code between gcc and clang
> implementations, move it over to fs.c to simplify the
> code, there's no reason to believe that for small data
> like this one would not just implement the simple
> convert_to_gcda() function.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I successfully tested this patch set using GCC on s390, but had some
problems using Clang with gcov-kernel (which seem unrelated to this
patch set - still to be investigated).

The removal of duplicated code definitively makes sense and this
approach looks like it will help make the build-time test I have in mind
for gcov-kernel easier to implement.

As such, for all 3 patches (not sure if it makes a difference seeing
that this has already landed in linux-next):

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>


Regards,
  Peter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
