Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B304148A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhIVMTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:19:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230171AbhIVMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:19:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MATFER000821;
        Wed, 22 Sep 2021 08:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=uMYhEeygqZi5Bwzzgs/wBmN00eG/+HzNUrlxCC/8yFU=;
 b=cX4dEBT0AnGfQi+DA2vdBY+rslRm8IDqYg9dtCProkPlYuM0wOCgOvJzzML94RbcWEZ5
 luPQcAypAzwbBpfIGxqlsdx7eZV+mPbuhbtmJVqx5fVeGyff7JKiHQkgKAChR95asQh2
 cJEehcHzNbW/NkiXo6hCsO6wQv6qBu/Io6tVRm1P5w410j+ZR2MdxyAN4qirxHk5HRNI
 DvNsSt4W0vjzPdvZRkjGLtlIoHwxDoG6f3r//IT0uEFuOxhP+A+vOBdxiPZUhixHJ+5/
 p8Aj7r3KYtbuYVCBl5vvw7tGF9j4ZUZh1caI5LxKWD6rrsvhf33k96moE3iDf54HxvDK yA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b82seaceb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 08:17:57 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18MBvrRg018051;
        Wed, 22 Sep 2021 12:06:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3b7q6npdp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 12:06:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18MC1wok61079918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 12:01:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A26CC5205A;
        Wed, 22 Sep 2021 12:06:45 +0000 (GMT)
Received: from localhost (unknown [9.43.116.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3B47C5204F;
        Wed, 22 Sep 2021 12:06:45 +0000 (GMT)
Date:   Wed, 22 Sep 2021 17:36:44 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] powerpc/code-patching: Return error on patch_branch()
 out-of-range failure
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <4940b03de220d1dfe2c6b47a41e60925497ce125.1630657331.git.christophe.leroy@csgroup.eu>
In-Reply-To: <4940b03de220d1dfe2c6b47a41e60925497ce125.1630657331.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1632312365.br7s4l3kzi.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q2cbP6JIy7G3VzrP8OqV0bT7VbWPnbun
X-Proofpoint-GUID: q2cbP6JIy7G3VzrP8OqV0bT7VbWPnbun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_04,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> Do not silentely ignore a failure of create_branch() in
> patch_branch(). Return -ERANGE.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/lib/code-patching.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


>=20
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-pat=
ching.c
> index f9a3019e37b4..0bc9cc0416b8 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -202,7 +202,9 @@ int patch_branch(u32 *addr, unsigned long target, int=
 flags)
>  {
>  	struct ppc_inst instr;
> =20
> -	create_branch(&instr, addr, target, flags);
> +	if (create_branch(&instr, addr, target, flags))
> +		return -ERANGE;
> +
>  	return patch_instruction(addr, instr);
>  }
> =20
> --=20
> 2.25.0
>=20
>=20
