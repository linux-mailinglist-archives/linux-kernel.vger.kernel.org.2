Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7976D33BA0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhCOOHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:07:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231415AbhCONyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:54:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FDfc6W015275;
        Mon, 15 Mar 2021 09:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IMkMB83HLmy5GJEh4yVZw4JAkAog+mf2q4x9F90mJgI=;
 b=cMzteEjfhRYwHOz8o6jqUHdrhzPveQZYZjiNkm/QdgFqjxC5b95qOJcctO28qUa5iJ9X
 49FlFZ6lXlp2oGy9jcLowut+DWuoSbbHb+O9SY7VVCB71FUpBqa6sTRM80CGgl1MsVwk
 y8305yv8MU7Ycg50EZLROaSLyTlQnAkFDZRt3+Mm9zyZYY5ii6dumaK9/I5mbF3OKAp2
 VxuhmW8A5dZu4xLvZ96FiI2Ld2pKDgtpuIMzuTdvCdCrqv2k5DPsJifroOjE6hgZdPZR
 fz1jkcsDOEsCxe2RCiqZ2ud4ZKyKa6Gy7EywvO0w8056sYJWpKIIwslugfMiZmAuSCWw Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37a83y98mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 09:54:21 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12FDjrXO038483;
        Mon, 15 Mar 2021 09:54:20 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37a83y98kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 09:54:20 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12FDq5Zs005166;
        Mon, 15 Mar 2021 13:54:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 378n18hwrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 13:54:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12FDsFwW46072170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 13:54:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D318942049;
        Mon, 15 Mar 2021 13:54:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B93D42041;
        Mon, 15 Mar 2021 13:54:15 +0000 (GMT)
Received: from [9.145.154.43] (unknown [9.145.154.43])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Mar 2021 13:54:15 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] gcov: clang: drop support for clang-10 and older
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
References: <20210312220518.rz6cjh33bkwaumzz@archlinux-ax161>
 <20210312224132.3413602-1-ndesaulniers@google.com>
 <20210312224132.3413602-3-ndesaulniers@google.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <b5df9160-0c7a-8e68-dee5-569d4c4c8d8f@linux.ibm.com>
Date:   Mon, 15 Mar 2021 14:54:15 +0100
MIME-Version: 1.0
In-Reply-To: <20210312224132.3413602-3-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_05:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=797 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103150096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2021 23:41, Nick Desaulniers wrote:
> LLVM changed the expected function signatures for llvm_gcda_start_file()
> and llvm_gcda_emit_function() in the clang-11 release. Drop the older
> implementations and require folks to upgrade their compiler if they're
> interested in GCOV support.
> 
> Link: https://reviews.llvm.org/rGcdd683b516d147925212724b09ec6fb792a40041
> Link: https://reviews.llvm.org/rG13a633b438b6500ecad9e4f936ebadf3411d0f44
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
