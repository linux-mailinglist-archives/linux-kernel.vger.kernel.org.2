Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09BC424ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbhJGALi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:11:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48766 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230360AbhJGALg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:11:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196N6cMw024113;
        Wed, 6 Oct 2021 20:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NghlO+jDH5H1KC7mat4T3H28xnmH4VAEkQ/xmasyNS4=;
 b=exep+GLZYXlIUF+fboOCasktpCbm6hj/Ik2uGBCBUb2gWeaVJXsXbxCdcR2+JlLd36M5
 /+bVyGE9cvH/KfAVeDZetF/08KaeZjayyYwQE9omJUzkSBkT70F8b2NUSIBeIGMJuqV2
 AbeqlYW/ejP/+tHUjtQ7iwYtRSjBb5Fdc1r5J0jCw68XIjoAsXEgiPqYQr2DwM9RIw9L
 FpWZGoA8HZg917LbCNSKAb32dybhUHYCFGqCWoYpXGTIusoW4nUw/UZYgnaPkQyoCnSP
 GGCpc/XrF43h+eeoi7xBBKru6z7b791A6/iDCKXLFnjdLVGFLHlUo4BcZsroXpignvIC Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhgqhxsq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 20:09:39 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19700dvi024605;
        Wed, 6 Oct 2021 20:09:38 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhgqhxsq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 20:09:38 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19706vU8011680;
        Thu, 7 Oct 2021 00:09:37 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3bef2ba9hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 00:09:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19704BxU56361386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Oct 2021 00:04:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 713804203F;
        Thu,  7 Oct 2021 00:09:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17B3742042;
        Thu,  7 Oct 2021 00:09:34 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Oct 2021 00:09:34 +0000 (GMT)
Received: from [9.102.33.41] (unknown [9.102.33.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2DBA3600B3;
        Thu,  7 Oct 2021 11:09:32 +1100 (AEDT)
Subject: Re: [PATCH] Documentation: Fix typo in testing/sysfs-class-cxl
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211006155017.135592-1-sohaib.amhmd@gmail.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <bc74b269-6c93-d1fc-0f3c-f078ec70bd35@linux.ibm.com>
Date:   Thu, 7 Oct 2021 11:09:31 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211006155017.135592-1-sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tw1kv9MER9trXFDQHDBkrZhu0rJ2lpr9
X-Proofpoint-ORIG-GUID: 7ezZjb9dQkzGDxfZ3MjE3xunKYYerdrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=927 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/21 2:50 am, Sohaib Mohamed wrote:
> Remove repeated words: "the the lowest" and "this this kernel"
> 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

Thanks for catching this.

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
