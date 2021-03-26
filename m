Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2777134AAC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhCZPAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:00:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230391AbhCZO7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:59:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12QEljTa083582;
        Fri, 26 Mar 2021 10:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AS6eW86kgLOTiFOOTSd0EIVSd5PzRbFjIJX/ejOgIV4=;
 b=ZGtRHB3yp38AJR0PDUWxCCjF/SGelvjqx/ANZwKBit8PVXEDdI2mEvD5ADw2bvVg+Xwb
 aovEX138hRSxW4mgvF1oJfH5kktgdqiCX9x+meRU/+wHKl56JCxWfiIdFYO3beManOuJ
 zZTKRFRejeVo8rL5Xg7nZGKLCYGxBF55E0WkPU3TObJ1TCaEIm1ThUXLkRfF5wUKPYD0
 rr0MeX0zNsUqfNNRsLPMzm/q/FaWiXYKvRlOoermNRioxyBRkqsu3GfwApu1ZlI5VMGK
 zkLIpwq/5t5u5nV+kWPCMHgIFUdfedokNLpzVqWDJAxMoTZz52odY7srWiqKuYrETjhO JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37hhpm0ahp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 10:59:25 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12QEoHxE104028;
        Fri, 26 Mar 2021 10:59:24 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37hhpm0afe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 10:59:21 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12QEqMI4023765;
        Fri, 26 Mar 2021 14:59:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 37h15a8rb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 14:59:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12QEwvrr31785324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 14:58:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46D714204B;
        Fri, 26 Mar 2021 14:59:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3B1842042;
        Fri, 26 Mar 2021 14:59:15 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Mar 2021 14:59:15 +0000 (GMT)
Received: from [9.206.172.36] (unknown [9.206.172.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A8658605FD;
        Sat, 27 Mar 2021 01:59:11 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: powernv: Remove unneeded variable: "rc"
To:     dingsenjie@163.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     dingsenjie <dingsenjie@yulong.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210326115356.12444-1-dingsenjie@163.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <c9c208e3-dec3-282b-b782-ab8574be16a9@linux.ibm.com>
Date:   Sat, 27 Mar 2021 01:59:05 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210326115356.12444-1-dingsenjie@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yt5C0hhkCVtEn2FV57hY2eum73jgBzmn
X-Proofpoint-ORIG-GUID: UxMYX0yhNppBQB38iOXNSTjWrUwsqRZh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_06:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 adultscore=0 suspectscore=0 impostorscore=0 mlxlogscore=939 spamscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/3/21 10:53 pm, dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
> 
> Remove unneeded variable: "rc".
> 
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>

This looks obviously correct and doesn't raise any checkpatch warnings.

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
