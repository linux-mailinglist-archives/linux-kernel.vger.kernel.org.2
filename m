Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04618305BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbhA0Moo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:44:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2246 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232611AbhA0MoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:44:00 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10RCZawV108007;
        Wed, 27 Jan 2021 07:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ojGtJ6N2GdxhtC8pfh2lC0vHOoGyUbbJvkCs0aZGLCg=;
 b=gX07+E2Ky53MFlZNag4EBHwZw/XJ41TFxAosn5YXSaHANRURDKdm/PaXJOrFNvVEDyOH
 T4qdiMRkQiUQAtbWF5L6PhxRZia32T+sWMUZUeCSq/fjccFePsC3AiNXXylHtJIZTOfY
 kmzHV6P3ElKAkYRgCOiK84o6VG/2syFjrP8/QcNjQlwvTJLQufY3TrpafurzZcNP6TIV
 F8x79R/QOvBmZ1wF+Tw7Acrb7xRksFMQTAQUF8inG+sIkELyuwnVMHjnrwakPVvrB5lX
 mmgw/VfvqArCw0KDvOWFYzxTvFum4qsn2ZmAtzNrf+k4dSeezuIaUUcqxxd+dIZRFdzl Lg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36b2qnswqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 07:43:17 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10RCVmPC013335;
        Wed, 27 Jan 2021 12:43:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 368be8bt2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 12:43:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10RChCwh42992068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 12:43:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A1B142041;
        Wed, 27 Jan 2021 12:43:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F310F4203F;
        Wed, 27 Jan 2021 12:43:11 +0000 (GMT)
Received: from localhost (unknown [9.171.68.8])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Jan 2021 12:43:11 +0000 (GMT)
Date:   Wed, 27 Jan 2021 13:43:10 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/tape: Fix spelling mistake in function name
 tape_3590_erp_succeded
Message-ID: <your-ad-here.call-01611751390-ext-5985@work.hours>
References: <20210118113222.71708-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210118113222.71708-1-colin.king@canonical.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_05:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=984 clxscore=1011 malwarescore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:32:22AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Rename tape_3590_erp_succeded to tape_3590_erp_succeeded to fix a
> spelling mistake in the function name.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/s390/char/tape_3590.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
