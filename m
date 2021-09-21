Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB21413825
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhIUROG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:14:06 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:48535 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhIUROF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1632244357; x=1663780357;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=16YU7KkjpiOEAKPRsxoOGSp6GaxRIbNZG8DW2Dc8Nxc=;
  b=Jyjo6k/LTyjXmUSUThCLMCe+36gC6HfzJ/Uc/z2iuIEP/Lk/HO6sRkti
   Rr4OFuDgxJyIrUNai9VQueFt1tlVnS8Eg1mEgKlWaICQJRl6P7bo/0vN3
   B2Nf62YwG5V+ont55l2GJhT9h1x7pW/aj4TcenD/GNTmwilLl1iVgySc9
   g=;
X-IronPort-AV: E=Sophos;i="5.85,311,1624320000"; 
   d="scan'208";a="143494894"
Subject: Re: [PATCH] iommu/arm-smmu-v3: poll cmdq until it has space
Thread-Topic: [PATCH] iommu/arm-smmu-v3: poll cmdq until it has space
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 21 Sep 2021 17:12:29 +0000
Received: from EX13D03EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com (Postfix) with ESMTPS id 947D5CB307;
        Tue, 21 Sep 2021 17:12:27 +0000 (UTC)
Received: from EX13D03EUA004.ant.amazon.com (10.43.165.93) by
 EX13D03EUA004.ant.amazon.com (10.43.165.93) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 21 Sep 2021 17:12:26 +0000
Received: from EX13D03EUA004.ant.amazon.com ([10.43.165.93]) by
 EX13D03EUA004.ant.amazon.com ([10.43.165.93]) with mapi id 15.00.1497.023;
 Tue, 21 Sep 2021 17:12:26 +0000
From:   "Sieber, Fernand" <sieberf@amazon.com>
To:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Index: AQHXrt3+ZWYnaFhO3kmkBSrWrVwBSauurBkAgAAMX78=
Date:   Tue, 21 Sep 2021 17:12:25 +0000
Message-ID: <1632244345526.44611@amazon.com>
References: <20210921114338.1144521-1-sieberf@amazon.com>,<c1c10203-ffd3-25f9-f2c6-9cee3458aac9@huawei.com>
In-Reply-To: <c1c10203-ffd3-25f9-f2c6-9cee3458aac9@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.90]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
> But is the polarity really correct? That is, if we don't have space,=0A=
> then exit with success (the function to check for space).=0A=
=0A=
You are absolutely correct, this is a mistake that I made as I was resolvin=
g conflicts while porting this patch to iommu/next from 5.4 where I impleme=
nted and tested it.=0A=
It should be:=0A=
=0A=
> -             if (!queue_full(llq))=0A=
> +             if (queue_has_space(llq, n))=0A=
=0A=
=0A=
> what is llq->state->val?=0A=
=0A=
This is an other oversight for the same reason, llq->state->val has since t=
hen been renamed llq->val=0A=
=0A=
Will fix both of these in the next revision.=0A=
Thanks and kind regards,=0A=
=0A=
--Fernand=0A=
=0A=
________________________________________=0A=
From: John Garry <john.garry@huawei.com>=0A=
Sent: Tuesday, September 21, 2021 18:22=0A=
To: Sieber, Fernand; will@kernel.org; robin.murphy@arm.com=0A=
Cc: linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;=
 linux-kernel@vger.kernel.org=0A=
Subject: RE: [EXTERNAL] [PATCH] iommu/arm-smmu-v3: poll cmdq until it has s=
pace=0A=
=0A=
CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.=0A=
=0A=
=0A=
=0A=
On 21/09/2021 12:43, Fernand Sieber wrote:=0A=
>       do {=0A=
=0A=
I didn't follow the full logic of this change yet ...=0A=
=0A=
>               llq->val =3D READ_ONCE(cmdq->q.llq.val);=0A=
> -             if (!queue_full(llq))=0A=
> +             if (!queue_has_space(llq, n))=0A=
=0A=
But is the polarity really correct? That is, if we don't have space,=0A=
then exit with success (the function to check for space).=0A=
=0A=
>                       break;=0A=
>=0A=
> +             /*=0A=
> +              * We must return here even if there's no space, because th=
e producer=0A=
> +              * having moved forward could mean that the last thread obs=
erving the=0A=
> +              * SMMU progress has allocated space in the cmdq and moved =
on, leaving=0A=
> +              * us in this waiting loop with no other thread updating=0A=
> +              * llq->state->val.=0A=
=0A=
what is llq->state->val?=0A=
=0A=
> +              */=0A=
> +             if (llq->prod !=3D prod)=0A=
> +                     return -EAGAIN;=0A=
> +=0A=
>               ret =3D queue_poll(&qp);=0A=
=0A=
Thanks,=0A=
John=0A=
