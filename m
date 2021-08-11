Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C840E3E946C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhHKPUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:20:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232635AbhHKPUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:20:04 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BF2jn0054591;
        Wed, 11 Aug 2021 11:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=3WzDokDLJexQHoOQsmrorWkTcqNQXXScQWMzbJ2FIPw=;
 b=gC87rhPOrIUJme04pTDgV2Vg/KW4T6SODO13OjQGaYZwHYl/nIL2N2IoWQMkwt9oFXFg
 i2QJU1balrJIrlOUJ4EiHlpGXn1ZNA576sV4eiR43YDZJfVHjIhKpoJdcCENuMSD9196
 QTKQBskJmmTcemvJqRFuT8GxytWpmT83eTsN7JUqCcxDDWJB4s+ZI/j38m6Ki06Fg7hU
 giwqwqDJiwkAfAw8vn9KCaoj5opGpyxa/BJAt1uCwdWJK6BfvGHNhnSmM+vvpI6e13NI
 sNQK0Vl8Xde0ad5Uec45ztWPMImhn5iGVNnf3nJiRWMwIJ6lwADbWj6htxWBz0VoqYuo iA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab8kmdhmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 11:19:39 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17BFCpDb022376;
        Wed, 11 Aug 2021 15:19:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3acfpg838y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 15:19:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17BFJYon52036048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 15:19:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2544A4053;
        Wed, 11 Aug 2021 15:19:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7840AA4040;
        Wed, 11 Aug 2021 15:19:34 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Aug 2021 15:19:34 +0000 (GMT)
Received: from [9.206.147.74] (unknown [9.206.147.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 489CB60152;
        Thu, 12 Aug 2021 01:19:33 +1000 (AEST)
From:   Andrew Donnellan <ajd@linux.ibm.com>
Subject: [ANNOUNCE] [CFP] linux.conf.au Online 2022 Kernel Miniconf
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     lwn@lwn.net
Message-ID: <e7e0d0c0-799f-28b7-2a2e-418afe809f24@linux.ibm.com>
Date:   Thu, 12 Aug 2021 01:19:23 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IitmhZlCi8J0xzqWXanC6e3vCy6S1rtf
X-Proofpoint-ORIG-GUID: IitmhZlCi8J0xzqWXanC6e3vCy6S1rtf
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_05:2021-08-11,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=852 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LCA2022 Kernel Miniconf - Online - 2022-01-14
---------------------------------------------

The linux.conf.au 2022 Kernel Miniconf Call for Proposals is now open. 
Start working on your talks!

Date: 2022-01-14
Location: The Internet (again)
Submissions close: 2021-09-05, 23:59 AoE/UTC-12
Submissions: https://linux.conf.au/proposals/submit/kernel-miniconf/
More info: https://lca-kernel.ozlabs.org/2022-cfp.html

Significant changes from last year:
- All miniconf speakers are guaranteed a free ticket
- All talks will be 30 minutes long
- CFP is now being run at the same time as main conference CFP process: 
if your talk is of broader interest consider submitting to the main 
conference as well

***************************************************************************

linux.conf.au 2022 will be held from 14-16 January 2022.

Due to the ongoing COVID-19-related restrictions on events and travel, 
LCA2022 will once again be held online. (Silver lining is you can speak 
or attend from wherever you are without flying here!)

The Kernel Miniconf is a single-day miniconf track, held on Friday 14 
January, about everything related to the kernel and low-level systems 
programming.

The Kernel Miniconf invites talks about up-and-coming kernel 
developments, the future direction of the kernel, and kernel development 
community and process matters. Past Kernel Miniconfs have covered topics 
such as memory management, RCU, scheduling, testing/CI and filesystems, 
as well as community and process topics such as licensing, developer 
workflows, safety critical processes, and so on.

We invite submissions on anything related to kernel and low-level 
systems programming. We welcome submissions from developers of all 
levels of experience, and from anyone connected with the kernel whether 
you are an upstream kernel developer, distro maintainer, academic 
researcher or a developer who works further downstream. The focus of the 
miniconf will primarily be on Linux, however non-Linux talks of 
sufficient interest to a primarily Linux audience will be considered.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
