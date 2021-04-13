Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389B335E6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348006AbhDMTEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:04:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347972AbhDMTEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:04:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DJ3eOZ161635;
        Tue, 13 Apr 2021 15:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Vf/cF5FC1kOSwf8zl1ouMavV5ViZPqPX/Q6h46xeuaM=;
 b=L4O7BYu8IkzWo8eVPRSlCDfB9qei00iT+RWDPKhMR+fGwaW4Ll7wUbZY0toPbotgU/0p
 ghqbl1UAnHzotFx9ABFnepqt0znj/boGKk/y2su7o9Nub20Qm1SrHpQVpkCzvaTrXvJE
 E1U2TpybykBXEvnPA9UM3qrfGfKQhTSmJTFQMrZ7wRdc//WqZlLS77NXrhmaJVxPBJsR
 i1IezfgjLxPXhyR9IVQ57K1JcFV6Kkg5by4sTHOC2YE1JkB4Q8qbF4O54DBVAB0JC3ZP
 NWYMJccrJwM9j7zZZ1P+Y+UXsAbW0cInNQR8A8LOSAoijSa0i79ArgaIR+fW4FfNugUA zA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vtnthn9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 15:04:07 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13DIr3lL021020;
        Tue, 13 Apr 2021 19:04:07 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 37u3n99vp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 19:04:07 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13DJ46Fr24772952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 19:04:06 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BFBF2805A;
        Tue, 13 Apr 2021 19:04:06 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6AE828059;
        Tue, 13 Apr 2021 19:04:05 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.117.75])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Apr 2021 19:04:05 +0000 (GMT)
Subject: Re: [PATCH] powerpc/pseries: extract host bridge from pci_bus prior
 to bus removal
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210211182435.47968-1-tyreld@linux.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <e36a28a8-12ff-5816-bf90-87fab97933ad@linux.ibm.com>
Date:   Tue, 13 Apr 2021 12:04:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210211182435.47968-1-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gZm65Vb7GLTfZqO-Y6sqmUdJae8CUD0Q
X-Proofpoint-ORIG-GUID: gZm65Vb7GLTfZqO-Y6sqmUdJae8CUD0Q
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 10:24 AM, Tyrel Datwyler wrote:
> The pci_bus->bridge reference may no longer be valid after
> pci_bus_remove() resulting in passing a bad value to device_unregister()
> for the associated bridge device.
> 
> Store the host_bridge reference in a separate variable prior to
> pci_bus_remove().
> 
> Fixes: 7340056567e3 ("powerpc/pci: Reorder pci bus/bridge unregistration during PHB removal")
> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>

Ping?
