Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9A3DAB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhG2SuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:50:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229672AbhG2SuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:50:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TIhnjb096174;
        Thu, 29 Jul 2021 14:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GPcnWxEBukLzUxX48nng7iWbwV7pxLeK8ohKXg+66Ag=;
 b=VzwWNRq9LE1m9F/xGmIRJkheaTT2kclUIU+qKyodzspIIXKssd4BiSZ9AS6Be9WhffdD
 dgIybHfKo+NbCsbyt2roLyUHU5ihzsn1YUhZoeJ3Z1jPSK0hSLnqPsVAmRwWNhLXDETM
 b6/pUR8MpzOqPMROaXu3VCs0rXL8YMAYDkb/uX8b7UnPMaQW35IyMNk3kg4ura1u2QUt
 tg6SObP5DB9s/Tzg0QDvPz0clFgx6RQ+7c9fnQ/qE3e6T5maLQAvuefXvoo2SGQDS+Xq
 VqRo6EVv7+7toQMyczpFZDbZU6ywiKk6WGUyIAEMwEIP1U/zyOK/p6e6gYTBjUYUKyQV nw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a40nwhqr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 14:50:17 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TIRG86021483;
        Thu, 29 Jul 2021 18:50:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3a235khpps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 18:50:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TIlTLf24379862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 18:47:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 865BBA4057;
        Thu, 29 Jul 2021 18:50:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46419A4040;
        Thu, 29 Jul 2021 18:50:11 +0000 (GMT)
Received: from osiris (unknown [9.145.2.68])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Jul 2021 18:50:11 +0000 (GMT)
Date:   Thu, 29 Jul 2021 20:50:09 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: move the install rule to arch/s390/Makefile
Message-ID: <YQL4YR08dqYRApqU@osiris>
References: <20210729142338.446002-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729142338.446002-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r2IJ0Bf4Jsnqcv892CmY95AjTa42Tm-0
X-Proofpoint-ORIG-GUID: r2IJ0Bf4Jsnqcv892CmY95AjTa42Tm-0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_14:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107290115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:23:38PM +0900, Masahiro Yamada wrote:
> Currently, the install target in arch/s390/Makefile descends into
> arch/s390/boot/Makefile to invoke the shell script, but there is no
> good reason to do so.
> 
> arch/s390/Makefile can run the shell script directly.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/Makefile      | 3 ++-
>  arch/s390/boot/Makefile | 4 ----
>  2 files changed, 2 insertions(+), 5 deletions(-)

Applied, thanks!
