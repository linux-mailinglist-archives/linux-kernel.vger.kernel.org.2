Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0825E33837A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 03:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhCLCTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 21:19:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhCLCSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:18:46 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12C23xXl105826;
        Thu, 11 Mar 2021 21:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p3ypu1ejMryN6s5IcLxscclbR3IP6lxDn5yAbrFar7M=;
 b=Nv/viPH3JNT14ITKbZ1phGPG7pbK9Byh2AkafYGTHawJ6gYjZDaeCR/4TI0txDxFYKgq
 bVDO0pRMfdnEpamOZ+eslS7NcwwRv9hB2222eIUTPclU5RJdJCVEIzTPYxEjQR7bziUx
 hbT7il1rprxEVwhBaO5ke3oQHtbmPTf+JJUTeOtpRDqMS8VakLOeXL3hyaHhtv5pzqRJ
 EOQjO18Kt3nQyLesMo1YWRVROyVtKm8M7sdB7yKG/7NgkYQm5QdllSZSeGW642jO8QN4
 y0/wkM2mZPBO2oVrPAWrfPiernn0HJYP6gFSr/cBq4RGCAjizQYHiG3zYbW2J5MU+nk4 zA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 377y0brfqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 21:18:39 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12C2IbMC001898;
        Fri, 12 Mar 2021 02:18:37 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 376mb0svub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 02:18:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12C2IJOK31523102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 02:18:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BB26A4060;
        Fri, 12 Mar 2021 02:18:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28E6AA4054;
        Fri, 12 Mar 2021 02:18:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Mar 2021 02:18:35 +0000 (GMT)
Received: from [9.102.35.195] (unknown [9.102.35.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 568BC60237;
        Fri, 12 Mar 2021 13:18:31 +1100 (AEDT)
Subject: Re: [PATCH] cxl: don't manipulate the mm.mm_users field directly
To:     Laurent Dufour <ldufour@linux.ibm.com>, fbarrat@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clombard@linux.ibm.com
References: <20210310174405.51044-1-ldufour@linux.ibm.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <e4ca7a94-60cd-ce74-dd75-da7f7348874d@linux.ibm.com>
Date:   Fri, 12 Mar 2021 13:18:25 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310174405.51044-1-ldufour@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_12:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=642
 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120013
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 4:44 am, Laurent Dufour wrote:
> It is better to rely on the API provided by the MM layer instead of
> directly manipulating the mm_users field.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

LGTM, thanks for picking this up

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
