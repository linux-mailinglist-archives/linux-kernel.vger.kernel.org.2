Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F63649D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhDSSbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:31:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240963AbhDSSa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:30:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JI37RX035305;
        Mon, 19 Apr 2021 14:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+GrMsbAbHcemcVqibamdzeH4T45MipgcS1pGANDliFU=;
 b=f2x6LB5eobuWZj7QgJGyXI/MVIO6rSTeVv+DbjpgFV6mD3zS7MYxk6L5Hu4YpRI2SfJ/
 nn8qNqEk/QkzkRdKerxJwb/19yzndUleuYR4sSWkXf3HM2klu0Vel1XA1lsnOH6mag+K
 sYTWKHMjOjxe9zNYqXKq6uCAHCrnw/Jl+TZtv73Wn7AFGBndMeGdhGZZETeu8/+xCMNd
 KBbVNtbek4tv64Ca4SbgY2/3fSv5cFy3FHAxMPJ4ilhB+hBR+wma1TC6b/vVj/Yh9xTC
 oDeWfcdlaEFa2pYNQgxRvzQt2yu1dKWHvWZaIGdOSG8w5URNrRmfIcc4oXREaDlj2UMM qw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 380d7dt4r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 14:30:20 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JISevv026255;
        Mon, 19 Apr 2021 18:30:19 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 37yqaa0xqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 18:30:19 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JIUItu31850992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 18:30:18 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76B84AC062;
        Mon, 19 Apr 2021 18:30:18 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1B8CAC059;
        Mon, 19 Apr 2021 18:30:17 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.78.157])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 18:30:17 +0000 (GMT)
Subject: Re: [PATCH] powerpc/pseries: Add shutdown() to vio_driver and vio_bus
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210402001325.939668-1-tyreld@linux.ibm.com>
 <f326def4-0db0-f924-1700-dd7be3154153@linux.ibm.com>
 <87im4ldrft.fsf@mpe.ellerman.id.au>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <59bd8028-cb1a-fdf6-74ce-68e868e4f486@linux.ibm.com>
Date:   Mon, 19 Apr 2021 11:30:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87im4ldrft.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s8WA5X0vf7pSbMdon8W6mtkvDPUAD7D_
X-Proofpoint-GUID: s8WA5X0vf7pSbMdon8W6mtkvDPUAD7D_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/21 5:30 AM, Michael Ellerman wrote:
> Tyrel Datwyler <tyreld@linux.ibm.com> writes:
>> On 4/1/21 5:13 PM, Tyrel Datwyler wrote:
>>> Currently, neither the vio_bus or vio_driver structures provide support
>>> for a shutdown() routine.
>>>
>>> Add support for shutdown() by allowing drivers to provide a
>>> implementation via function pointer in their vio_driver struct and
>>> provide a proper implementation in the driver template for the vio_bus
>>> that calls a vio drivers shutdown() if defined.
>>>
>>> In the case that no shutdown() is defined by a vio driver and a kexec is
>>> in progress we implement a big hammer that calls remove() to ensure no
>>> further DMA for the devices is possible.
>>>
>>> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>>> ---
>>
>> Ping... any comments, problems with this approach?
> 
> The kexec part seems like a bit of a hack.
> 
> It also doesn't help for kdump, when none of the shutdown code is run.

If I understand correctly for kdump we have a reserved memory space where the
kdump kernel is loaded, but for kexec the memory region isn't reserved ahead of
time meaning we can try and load the kernel over potential memory used for DMA
by the current kernel. Please correct me if I've got that wrong.

> 
> How many drivers do we have? Can we just implement a proper shutdown for
> them?

Well that is the end goal. I just don't currently have the bandwidth to do each
driver myself with a proper shutdown sequence, and thought this was a launching
off point to at least introduce the shutdown callback to the VIO bus.

Off the top of my head we have 3 storage drivers, 2 network drivers, vtpm, vmc,
pseries_rng, nx, nx842, hvcs, hvc_vio.

I can drop the kexec_in_progress hammer and just have each driver call remove()
themselves in their shutdown function. Leave it to each maintainer to decide if
remove() is enough or if there is a more lightweight quiesce sequence they
choose to implement.

-Tyrel

> 
> cheers
> 

