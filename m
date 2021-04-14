Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CA35EC31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347402AbhDNFYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:24:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345956AbhDNFYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:24:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13E53oSD048940;
        Wed, 14 Apr 2021 01:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=ZXNcef9HhIw8CQ/oyjT8H90mcUTWDFkyPmQay6v4kyU=;
 b=PteWUTUykO0PLrH1dDFwO2MC1IumcXgyL8P+TeBl1sjRt8blhRH9e0nd9LVtdiVrQ3ky
 SYTMtoOZbKcpsnMTGEz+StJvnpJeLb+ex3dT3xJ4cfyTaaG9ixNCw9wEGNK/0RgB7oAW
 ZwW+g+YV4EZzc2eOVf3TVhdo7A7DIRb1ENeFlKAJFEO2OvOZfih6AUrH2BJWS9jqFHq8
 n6HLZUCUqBvTLnT4fMF9Ms4pS4H7SiEQN7c7huR7C0/16bY1tmjpy8EiP85qp7Gh6StB
 UO6JhjdoQF1bZqpIymaHPee9Xe4wtzBEYL7fZ0mPVGSULw8dW1aGjI1YrMhqLBTQQYiH 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37w7sdvjpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 01:23:43 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13E5HntN095002;
        Wed, 14 Apr 2021 01:23:43 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37w7sdvjpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 01:23:43 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13E5KtCs014404;
        Wed, 14 Apr 2021 05:23:43 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 37u3n9xjsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 05:23:43 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13E5NgIF10289728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 05:23:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ED6EB2065;
        Wed, 14 Apr 2021 05:23:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D87E8B205F;
        Wed, 14 Apr 2021 05:23:39 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.77.205.193])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Apr 2021 05:23:39 +0000 (GMT)
X-Mailer: emacs 27.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, jniethe5@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] powerpc: Rename probe_kernel_read_inst()
In-Reply-To: <e2fbccd1a0b4e8ed7e12936e03be76588202c7a0.1618331980.git.christophe.leroy@csgroup.eu>
References: <857ceb23b6a614aea2522e770b067593d5f9e906.1618331980.git.christophe.leroy@csgroup.eu>
 <e2fbccd1a0b4e8ed7e12936e03be76588202c7a0.1618331980.git.christophe.leroy@csgroup.eu>
Date:   Wed, 14 Apr 2021 10:53:37 +0530
Message-ID: <874kg930di.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h5Fop8qgyL9NvRPzr95NH2Lmu-9tAK3E
X-Proofpoint-GUID: Mc4n80NnfrTdkRAM1VJUo4p-c3ZlUomN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_01:2021-04-13,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> When probe_kernel_read_inst() was created, it was to mimic
> probe_kernel_read() function.
>
> Since then, probe_kernel_read() has been renamed
> copy_from_kernel_nofault().
>
> Rename probe_kernel_read_inst() into copy_from_kernel_nofault_inst().

At first glance I read it as copy from kernel nofault instruction.
How about copy_inst_from_kernel_nofault()? 


-aneesh
