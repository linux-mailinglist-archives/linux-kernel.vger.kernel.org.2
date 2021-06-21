Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49433AF20D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhFUReW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:34:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17184 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231252AbhFUReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:34:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LHUT4V059089;
        Mon, 21 Jun 2021 13:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dN/oN0n9tLV8UYomMqhhtIvx1sfbdn8AhVSokNCO/6g=;
 b=OHmCp7QT3CPbjGpUtWV7P996093GvTISSIaYbrMOwTRb1guoENQ24KNAgFmHLVweLmug
 wSgwdIT81QwXxQp2InBMszRcr3MX1fh3fRqlk2VU3xgI149ciR5I20CItJ3khgenEWFb
 33rOXRRxztyv4zInOGMCGcR/Vr45H5QMmEryytFuTS+7q5R2rEnk2wKr5XpY1dsv2+aM
 0ziivzMI4jkJUbvXCQ7v8V7sii3HoS6YNu00XHQTY0uhNlhnAFyjdyff8nRz0Zq3b3QZ
 qejGVyV9cUbqN5XSAUEB9QD+yxHGDn+ubA/dwpD9mtGhs4YegS2nhvtszWp6tjTYWqti VQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39aup3qqb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 13:31:57 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15LHETPt019177;
        Mon, 21 Jun 2021 17:31:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3998788j4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 17:31:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15LHVrcw23331192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 17:31:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3576EA405B;
        Mon, 21 Jun 2021 17:31:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38637A4060;
        Mon, 21 Jun 2021 17:31:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.77.196.19])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jun 2021 17:31:52 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <CAKfTPtACzzoGhDFW0bTGgZRPB=3LR6kSwuUOrcKDFTAJ7BhTFQ@mail.gmail.com>
Date:   Mon, 21 Jun 2021 23:01:51 +0530
Cc:     Peter Zijlstra <peterz@infradead.org>, Odin Ugedal <odin@uged.al>,
        linuxppc-dev@lists.ozlabs.org,
        open list <linux-kernel@vger.kernel.org>
Message-Id: <14EEE4A4-B2B1-4D0C-B2F6-BDB7C11B05DE@linux.vnet.ibm.com>
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com>
 <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
 <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
 <CAFpoUr2o2PVPOx+AvatjjUvqPTyNKE3C6oXejyU3HVMmtCnzvQ@mail.gmail.com>
 <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com>
 <CAFpoUr0iWFTq2grtnX_EH6KnZLZQCg1o6_yv1gfDK8WdbHmUCA@mail.gmail.com>
 <CAFpoUr3Wy9raHx+Dc0S8TB_Xi=E+Epsh_pA3DEFZP4eKf7s07A@mail.gmail.com>
 <20210621162243.GA29874@vingu-book>
 <CAKfTPtACzzoGhDFW0bTGgZRPB=3LR6kSwuUOrcKDFTAJ7BhTFQ@mail.gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A57L-lTFSpwIsTbGCYyBbkxDN9_wFonX
X-Proofpoint-GUID: A57L-lTFSpwIsTbGCYyBbkxDN9_wFonX
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_10:2021-06-21,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Any thoughts Vincent?
>>=20
>>=20
>> I would prefer that we use the reason of adding the cfs in the list inst=
ead.
>>=20
>> Something like the below should also fixed the problem. It is based on a
>> proposal I made to Rik sometimes ago when he tried to flatten the rq:
>> https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/
>>=20
>> This will ensure that a cfs is added in the list whenever one of its  ch=
ild
>> is still in the list.
>=20
> Could you confirm that this patch fixes the problem for you too ?
>=20
Thanks for the fix.

The patch fixes the reported problem. The test ran to completion without
any failure.=20

Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

-Sachin

