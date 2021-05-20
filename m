Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E49F38A0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhETJUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:20:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230458AbhETJUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:20:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14K93HYJ138017;
        Thu, 20 May 2021 05:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=tleZC2hya9RBqm4qrAUzBWw8YcdKoAgMUeBDZ71H3H8=;
 b=Vcp9ME0HjVQtCHWyeE/V/PSD10WekATW4F97ZXtvqM5NmUu0/x6vI2XKiIqeuvJ+6yKZ
 kLFjxaJZKkVEr7pY6RY9NaZF1kzKogCgB5c2eyXtHc4Y18YxxLWfNEy0hd03Aru8/xQr
 NbldsRqQOEA3W8QFLGQT43kZN3Wy6CuFuGBqk5L5IJl1+rg9hMwSic5NgUgw8MCm0s39
 DtgrvLXMJd83DAYkpmFBu/tsaNKyHCEtQYO3fDVLDuff6HLezhsgbDraEV/A/lCltXzn
 rzhipu+F0l4QBFK79V/TV/k/gSZIQMlUkB7y/6hg9VQXd2wQWZtEl0CDeJZ6jhhEOer/ QQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nmqygkjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 05:18:20 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14K998mq008871;
        Thu, 20 May 2021 09:18:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 38j5x81dat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 09:18:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14K9IFoQ59113976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 09:18:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27F03AE045;
        Thu, 20 May 2021 09:18:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A05AAAE053;
        Thu, 20 May 2021 09:18:14 +0000 (GMT)
Received: from localhost (unknown [9.85.120.117])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 May 2021 09:18:14 +0000 (GMT)
Date:   Thu, 20 May 2021 14:48:12 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] kprobes: Allow architectures to override optinsn
 page allocation
To:     anil.s.keshavamurthy@intel.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        davem@davemloft.net, mhiramat@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <40a43d6df1fdf41ade36e9a46e60a4df774ca9f6.1620896780.git.christophe.leroy@csgroup.eu>
In-Reply-To: <40a43d6df1fdf41ade36e9a46e60a4df774ca9f6.1620896780.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1621502039.xhb8rgk83c.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TN-9W2ygPmu9Z093LdAE_EPBFOKaiAbE
X-Proofpoint-GUID: TN-9W2ygPmu9Z093LdAE_EPBFOKaiAbE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_01:2021-05-20,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> Some architectures like powerpc require a non standard
> allocation of optinsn page, because module pages are
> too far from the kernel for direct branches.
>=20
> Define weak alloc_optinsn_page() and free_optinsn_page(), that
> fall back on alloc_insn_page() and free_insn_page() when not
> overriden by the architecture.
  ^^^^^^^^^
  overridden - courtesy of checkpatch.

>=20
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
> v2: Added missing prototypes in linux/kprobes.h
> ---
>  include/linux/kprobes.h |  3 +++
>  kernel/kprobes.c        | 14 ++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)

LGTM. For the series:
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen
