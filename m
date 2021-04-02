Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0E1352DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhDBQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 12:45:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38230 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229722AbhDBQo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 12:44:58 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 132GXp6k149512;
        Fri, 2 Apr 2021 12:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=gkdE+H6UoslkeqtMNb7IPN0mwGr/JpXzRpWAcK7ID8g=;
 b=cmxmgJYD6zF37Ml4Xm7Xvxgd52NeOf6pcYAvdLxICgKmSQTV7ZVPNB0LkY5kelvuZ7Vm
 tgczNHZzYFVjm11/QyHlLm4qQHZrbxf1/KJ31b9KXLnUL/IAG8IUiL5bFBUtnou1NVuQ
 SglAwVLdBvCGk0yf2IHjEYZV//OvzQtUvqlSwLNvHU4IOsp7VfHLQNGfIhGp8VM1B7bZ
 8YQDMyjPMcSHyjLlcWHGoVo4uz81/BSVc6hWJXsKINu/j/VnBA2Xpk8d06Usr4AdVvnG
 4WHiMHTxhO5MLMCPPZy8LM+FtRtRlSj9qayJHQi7mx2adBf0uCdVh7rcuFVgg0CSICAi ng== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ntw1sgyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Apr 2021 12:44:34 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 132Gh6IT007334;
        Fri, 2 Apr 2021 16:44:34 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 37n2984607-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Apr 2021 16:44:34 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 132GiXVh31392050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Apr 2021 16:44:33 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D32152805C;
        Fri,  2 Apr 2021 16:44:33 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9156528059;
        Fri,  2 Apr 2021 16:44:33 +0000 (GMT)
Received: from localhost (unknown [9.163.15.116])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Apr 2021 16:44:33 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     cheloha@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] pseries: prevent free CPU ids to be reused on
 another node
In-Reply-To: <d06106d3-76e6-f5da-e3b4-db13c6bfee96@linux.ibm.com>
References: <20210325093512.57856-1-ldufour@linux.ibm.com>
 <87a6qgbyk6.fsf@linux.ibm.com>
 <d06106d3-76e6-f5da-e3b4-db13c6bfee96@linux.ibm.com>
Date:   Fri, 02 Apr 2021 11:44:32 -0500
Message-ID: <877dlkbpqn.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HJD8wR6yREK7Ai04wfNu96h7_W125uRM
X-Proofpoint-ORIG-GUID: HJD8wR6yREK7Ai04wfNu96h7_W125uRM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_09:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104020116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> Le 02/04/2021 =C3=A0 15:34, Nathan Lynch a =C3=A9crit=C2=A0:
>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>> When a CPU is hot added, the CPU ids are taken from the available mask =
from
>>> the lower possible set. If that set of values was previously used for C=
PU
>>> attached to a different node, this seems to application like if these C=
PUs
>>> have migrated from a node to another one which is not expected in real
>>> life.
>>=20
>> This seems like a problem that could affect other architectures or
>> platforms? I guess as long as arch code is responsible for placing new
>> CPUs in cpu_present_mask, that code will have the responsibility of
>> ensuring CPU IDs' NUMA assignments remain stable.
>
> Actually, x86 is already handling this issue in the arch code specific
> code, see 8f54969dc8d6 ("x86/acpi: Introduce persistent storage for
> cpuid <-> apicid mapping"). I didn't check for other architectures but
> as CPU id allocation is in the arch part, I believe this is up to each
> arch to deal with this issue.
>
> Making the CPU id allocation common to all arch is outside the scope
> of this patch.

Well... we'd better avoid a situation where architectures impose
different policies in this area. (I guess we're already in this
situation, which is the problem.) A more maintainable way to achieve
that would be to put the higher-level policy in arch-independent code,
as much as possible.

I don't insist, though.


>> I don't know, should we not fail the request instead of doing the
>> ABI-breaking thing the code in this change is trying to prevent? I
>> don't think a warning in the kernel log is going to help any
>> application that would be affected by this.
>
> That's a really good question. One should argue that the most
> important is to satisfy the CPU add operation, assuming that only few
> are interested in the CPU numbering, while others would prefer the CPU
> adding to fail (which may prevent adding CPUs on another nodes if the
> whole operation is aborted as soon as a CPU add is failing).
>
> I was conservative here, but if failing the operation is the best
> option, then this will make that code simpler, removing the backward
> jump.
>
> Who is deciding?

I favor failing the request. Apart from the implications for user space,
it's not clear to me that allowing the cpu-node relationship to change
once initialized is benign in terms of internal kernel assumptions
(e.g. sched domains, workqueues?). And as you say, it would make for
more straightforward code.
