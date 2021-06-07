Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B5039D934
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFGKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:01:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7636 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbhFGKBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:01:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1579WwUI007233;
        Mon, 7 Jun 2021 05:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dw7MVFGoNgek+G2LBkaQJaC2KNjLwfxxCkZI53VrBJU=;
 b=P6sNZLIUmaSocdAYghfq0JPueYzVtMBzuQJDwm097v8Cx044UGiF1EiVCzptkLz6a/qQ
 Dx5rIKWGBJ2VLli+3RUQvExtYBMWe47HCVWMQyAus9rhE1N+fxmN+pM4IKoGLF2GKIAl
 urlr/3aOrwwbAI24tgLNG57LE9wjtwIUxttXuNXlHlRPtqII23o+JpUwtr4/IB9AELGf
 +LoG1dtq/Y7wmkmBnaSNOlOfyaqMeLNN00TyDdWDQ/B1C6RnZHNCRPJe/8tAx6IBnSlL
 vuGT3vrvcphusah4Bqex1wFVPirbKsTyRseKGhXU1Y5LOBgpk5zBLBNIY1gjYkfVk/My iw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391c190kb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 05:59:49 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1579rKgc010266;
        Mon, 7 Jun 2021 09:59:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3900hhrtvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 09:59:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1579xj1426476942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jun 2021 09:59:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7F405204F;
        Mon,  7 Jun 2021 09:59:45 +0000 (GMT)
Received: from [9.145.172.247] (unknown [9.145.172.247])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 94F9252051;
        Mon,  7 Jun 2021 09:59:45 +0000 (GMT)
Subject: Re: [RFC PATCH] gcov: add basic gcov_info validation to gcov
 initialization
To:     Luis Henriques <lhenriques@suse.de>
Cc:     linux-kernel@vger.kernel.org
References: <YLZYwgs5hyzFZMlw@suse.de>
 <20210602102455.11724-1-lhenriques@suse.de>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <f0148fb8-1779-a18e-315c-87df31d3154f@linux.ibm.com>
Date:   Mon, 7 Jun 2021 11:59:45 +0200
In-Reply-To: <20210602102455.11724-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -6WPxLfW4V6SXPmpCDF7oqT4PzvtdEDS
X-Proofpoint-ORIG-GUID: -6WPxLfW4V6SXPmpCDF7oqT4PzvtdEDS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_07:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.2021 12:24, Luis Henriques wrote:
> Add a basic gcov_info struct validation helper to gcc to ensure we have
> sane from the compiler.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Hi!
> 
> I know this won't really validate the gcov_info struct, but it will at
> least prevent kernel crashes in simple scenarios (such as the one I'm
> seeing with gcc 9.3.1).

Thanks for your suggestion of adding validity checking for the gcov_info
struct. The goal you aim at is definitely something that we want to have
to reduce the impact of fallout from changes to GCC's gcov_info struct.

In my opinion though the approach you described - looking at the
contents of specific fields in gcov_info - isn't the correct way to go
forward. Since you cannot know how gcov_info changed, accessing any data
in it is very dangerous. Even if there's no out-of-bounds access (if the
struct's size was reduced) the field you are checking could have moved
elsewhere so the meaningfulness of the check is very limited.

In a previous discussion on the same topic I proposed a different
approach for a build-time check that would fully check the compatibility
of kernel code and GCC-emitted gcov-related data structures. See:

https://lore.kernel.org/patchwork/patch/1393585/#1592411

Unfortunately I have not yet found the time to implement this approach
but it's still on my to-do-list.

Regarding the cause of the error you're seeing I'll have a look at the
corresponding GCC source to see if there's anything that could be
causing the issue.


Regards,
  Peter Oberparleiter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
