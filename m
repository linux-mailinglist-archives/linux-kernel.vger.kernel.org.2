Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FCF3B0735
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhFVOTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:19:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230160AbhFVOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:19:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ME49u5086993;
        Tue, 22 Jun 2021 10:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ScBQ+UH0oFMRYhaMFq6xohXskTsBIXXTspZdPSW4Oxk=;
 b=VleM/ma1L5gLGwQbbxbXz9YmrfXn10GSQr4tjucZKKem4075m4dfJ1BF5bi2l/ObyF/C
 Fx7K2PJG0hr+YpPsN5Atbo+GaEqfrnaaOSy7ziHTXfyMykKwIBla0Vne+ivI9rW3ORY5
 Jiuic45ZChh9uk2wfw5GWLxSeJ/nMaqSH1IpqA2P8CcOm9KpyQeqR3w6Yrs8MQCP6iFx
 4AYWsN1dE63WWX5dIEieKS1IAm7ysISVPAjqtHwaya7fI/bD9A3PRbByZAbk4+/FfVxx
 upaQW8RkP/pZrvrK+PkFfFipnKGRp88qWn0ORqegJufaJxOd/5K/bTMQ/lEkGaZmELG9 Gg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39bf2xw158-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 10:17:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15MEDAal006418;
        Tue, 22 Jun 2021 14:17:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3998789gs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 14:17:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15MEGwKg18809102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:16:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9A60A405C;
        Tue, 22 Jun 2021 14:16:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DAD4A4054;
        Tue, 22 Jun 2021 14:16:58 +0000 (GMT)
Received: from localhost (unknown [9.171.76.220])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Jun 2021 14:16:58 +0000 (GMT)
Date:   Tue, 22 Jun 2021 16:16:57 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/speculation: Use statically initialized const for
 instructions
Message-ID: <your-ad-here.call-01624371417-ext-0601@work.hours>
References: <20210616201823.1245603-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210616201823.1245603-1-keescook@chromium.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kq96S8FKTOxaCZsF_ZehFZXXY8FrVSK5
X-Proofpoint-GUID: Kq96S8FKTOxaCZsF_ZehFZXXY8FrVSK5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_08:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=805
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 01:18:23PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> confusing the checks when using a static const source.
> 
> Move the static const array into a variable so the compiler can perform
> appropriate bounds checking.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/s390/kernel/nospec-branch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks!
