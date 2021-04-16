Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDE63627E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbhDPSrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:47:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237334AbhDPSrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:47:32 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GIWcfJ060292;
        Fri, 16 Apr 2021 14:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xCA7nZY3Oxc9YHCfTsbKNHm63QLhRgdRs9Sq2eLex3g=;
 b=F4GM6m2lYbtUrhjIBo5dWglcilu2INVgj2nxXYTWb1PdP+zJXmDaymZ8oru1oyON2oMQ
 If6Thiy5LV0L7lWotfmPt5ctMwJwnj7/e7nT1xTq2rHhQdfxG+2Bm97lENKnjI/0C8Oy
 9Ttj8OYMRRKawYXQtFMNW2GpY4qB82laE5Gzk9lHo35Br4uqnF8b0R8r0KUv9ktiftNY
 Rsco9g8NCF/Id7AM1FXNxxk9V6FjRqm60YuZwKMK98Gp0+R5flgcjI/w1hBrWelGeiqQ
 NYb9LfHWk+xv7SyXeUr25W6NHILfxMn3BPLim1VboUEystIG2NVqljRb914BlTJT4Iud 1A== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37y7wv7kw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 14:46:54 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13GIXiim020719;
        Fri, 16 Apr 2021 18:46:53 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 37u3narfhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 18:46:53 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13GIkqwU23462266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:46:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D8C7B2067;
        Fri, 16 Apr 2021 18:46:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96DCFB2064;
        Fri, 16 Apr 2021 18:46:51 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.122.125])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Apr 2021 18:46:51 +0000 (GMT)
Subject: Re: [PATCH] powerpc/pseries: Add shutdown() to vio_driver and vio_bus
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210402001325.939668-1-tyreld@linux.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <f326def4-0db0-f924-1700-dd7be3154153@linux.ibm.com>
Date:   Fri, 16 Apr 2021 11:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210402001325.939668-1-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _U6q_4lfulD3kRoiWB3DiRXAoMhGzQcj
X-Proofpoint-ORIG-GUID: _U6q_4lfulD3kRoiWB3DiRXAoMhGzQcj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxlogscore=947 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 5:13 PM, Tyrel Datwyler wrote:
> Currently, neither the vio_bus or vio_driver structures provide support
> for a shutdown() routine.
> 
> Add support for shutdown() by allowing drivers to provide a
> implementation via function pointer in their vio_driver struct and
> provide a proper implementation in the driver template for the vio_bus
> that calls a vio drivers shutdown() if defined.
> 
> In the case that no shutdown() is defined by a vio driver and a kexec is
> in progress we implement a big hammer that calls remove() to ensure no
> further DMA for the devices is possible.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---

Ping... any comments, problems with this approach?

-Tyrel
