Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FAC3AC1D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFREQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:16:54 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:8222 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229475AbhFREQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:16:52 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I47nla028563;
        Thu, 17 Jun 2021 21:14:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=TqlqapH1j0aLVUmulCeXzbtEnu23O0ToIssBZ4N+VMw=;
 b=o2t2H+mEXWggcLCYVdfb/A6IZuLc1ZspsLJLeusEv6JhykBYgPwFtolqYlFGDBBFAs/b
 To+9nsHOK2WzSqQUzmcVwqfBOCc4+nYI9QhawxNYoeAFgIm0tcXCjAibTraKp8eWXEjQ
 UfqTVKXsIEqv1wcMusaNMCBWgausBmeluZ5jZDyeLXH/iTixitwia3IX9wROu/cXOppF
 X5iN+x7/siH1cEu7L7AqSMxCaJq/j4xiRfEQQsqZU8vvfLlwcruxDm+fdYwM/YZNrzpH
 1kuHdQ3Z1Sf2MVPkx0r0NkPGqzpUr9JL2YBOgjChAc0NvYGq/U6Jl5GW9buAYeCIxYer kQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 398eycs09y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 21:14:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLJcwUXl7FGe5eq4+vi2Dx5zdN//DTxIj7Oze4ecj0GDTgfPdfGIGoIGXX7raGDbDJ+BDdUuRvNQ0M6rKhd1wzcCVDfR+rNnao4XL0JtkzBJhCVM+LadNJ5gf6ZvQJ0wDmAK0c/Lf0VkDj5sltbd8hoflNC1aQV7znM0Qk305PJLuCnXTqZyLHQ+IJR7Usnv8QS7tB+t9N3IfS/4sgh1cGWDglJIdXMP7AWuZPtfkuxI3dpzuBiizp0PfgIKuAdr5Atos/9LGhiriKRxEWz3wHZA6PuPFwdDZc34f5ECmURbVe0H02mhjCA2KH6jLVYNTJsJMAB+gr+4eORMdGELAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqlqapH1j0aLVUmulCeXzbtEnu23O0ToIssBZ4N+VMw=;
 b=CLwLVGkeg/m9ChPPq7f+cawMhrdceyEWTy9MgKt+yczbb/v5pNlJY/r3UGt1jqo+k5xXT4AQ5p/syTxDBY1YQBEysgcj6NCwoDJtC4V6USvaAByp/8M23ApARImID/h9JOrn8RIgOe2/94DtK4HPhE6IZDPdu1IDDFWsUMWU6jECMFJwmdfPIqCIfiI3eDcsHawZhJkzANbN9K/1ntyVjbyZLLMwWt7pJogBpCEaVcnI1+AOxX08DZf5gWnkNEjFrlksieqAfVdcM5nEpcjMm2dZfU7uA2hS0A+4uLUXn+2Yy8i+zAeJDiEKCBBJqDAA4xgxH0xpJGdcuStrRbXDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqlqapH1j0aLVUmulCeXzbtEnu23O0ToIssBZ4N+VMw=;
 b=3GYIfi8s4o8VEcIXVeKJNraF6qknFQ/m7g6M/ggDKxdTpBj0lq0Kxr2vmCwFD4lxAEh1rfeBHbifoc7h4J77szoo+u6DpqnbkWxtNrsImLoUw0r1EACe6ACr1DpNGVSJTfYOasx0VzpTgXzvtCKtksyN0fI0dAS9xss312YddLY=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5303.namprd07.prod.outlook.com (2603:10b6:a03:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Fri, 18 Jun
 2021 04:14:34 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::21a3:4648:fcda:e438]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::21a3:4648:fcda:e438%4]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 04:14:34 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH -next] usb: cdnsp: fix error return code in
 cdnsp_alloc_priv_device()
Thread-Topic: [PATCH -next] usb: cdnsp: fix error return code in
 cdnsp_alloc_priv_device()
Thread-Index: AQHXY4TqkOOVD8MpV0qrZV8PcYwsyKsZJ/7A
Date:   Fri, 18 Jun 2021 04:14:34 +0000
Message-ID: <BYAPR07MB538123BB52A4F6323B9A5633DD0D9@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210617143103.2175477-1-yangyingliang@huawei.com>
In-Reply-To: <20210617143103.2175477-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYWRkY2E5MjktY2ZlYi0xMWViLTg3OTAtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XGFkZGNhOTJiLWNmZWItMTFlYi04NzkwLWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTEzOCIgdD0iMTMyNjg0NjMyNzE2MjczMzc0IiBoPSJjbndjblY1aEVlTVlHekJVMUc0VHNjRFNreFU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab3028f4-a587-4d3f-91c6-08d9320f9438
x-ms-traffictypediagnostic: BYAPR07MB5303:
x-microsoft-antispam-prvs: <BYAPR07MB53039FA28DAEC28B7A48CEC3DD0D9@BYAPR07MB5303.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xdnJeDTbwEAEW6YeXFhxAmf5BS3QQNwjXcGETAorms9a1f5kG2QhnLYOsKXnAIo6fQa9m18O08+Jw+f5gJE1n+DQdsx5mRbltbNlhlSKN2Q6frgLbXhdYN/GCaSEF+2JhdBQSMSHQnOqLU6DGM4+Hkc7BWD+bVVJ2vrzZAeAAeLYRgTatoSxpHxRx7Wq2amBfbxcHAnJCgcVqbfu/81L+UoTaZ6JHKMUAlU4YUzYyrpaCD/ff69gJ1E8EgtS53H538iFibarCNrS/Dcx0Q6jiVn2lCIUq/qIOxOmAuU4rE3LFlQ+Xpvp8Nn1lr+XPpu+UEVXUv9LdpHQQL2En0O1yDGNsjsidXGIAu4BPapG4KpiMzqFjrkLmcHOFg9r+RUG1KwU2rFacHQtvM53kyY8PPB6FTjo3XqhveiXV5pjNf3HIrqhaQfyKeZ+S0ipAMq796hoMz1VCZlz6+7OeYdXZ6q42/Se0BOIcNfPxqH0Q4O1MeUqkySnCMMtoaxTV+CGvtmcSOXr1h53vgji9zagjf1ADO5wdG2seHGUHNoBIrh5n2bSCDw9YGI9itsPJ6cB0R3Oi91MmlKwMHV9DHf4MdWT7r9Mp2qe00eTlHE3Y98TYljr1WbrBNSKGQKXnCFUuKuC9Q/g9Kfsvfl0zPBCUJe0e19cumIvb/iZlApqmAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(36092001)(76116006)(86362001)(186003)(38100700002)(26005)(4326008)(478600001)(33656002)(66476007)(66556008)(55016002)(9686003)(66446008)(64756008)(83380400001)(6506007)(71200400001)(66946007)(8936002)(316002)(5660300002)(52536014)(110136005)(8676002)(2906002)(122000001)(7696005)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WufgZ9cN+7Ve7F2a57BcaHcad9rOevs0JBJWyppdD6PqkhZhGp4jFKReKV1K?=
 =?us-ascii?Q?J1LAzgf/bsuEEpxrQGV7Og3lkN0fLIab2ewpJfupWvOYthgkxtfyzPkqEfHY?=
 =?us-ascii?Q?t0R1N4ueiyzwgBAgJiOLzA8FelvyC3lRpBObLHNQKXmzdVttjQ2ybLQpX2ZN?=
 =?us-ascii?Q?Jbw+6cP6J90KSS308hlRN7sY7BBlmu+D/QVBQT15utqPIHFTEZpju2b9zIcP?=
 =?us-ascii?Q?96waGovHwT3iAbQc/zIwTDJJuULWxM95fHAx4n4P3fjIJiyOdG2LdhmeTD/p?=
 =?us-ascii?Q?+Fi08XF7KzWOTEWgdGEklKSu2nJbpNuYuasJXq0zbXxyE8quALi7alccEJyS?=
 =?us-ascii?Q?gkwuE/E1IWC2Vl69T2eK37WnUJ6sYAtcieTn82tZdar3DQxfpK8sN5Nz5F6v?=
 =?us-ascii?Q?vfBR4zQHmqp/6TDWNgIPVDr+r3CwL/tOdD8u101VMEfGUc3UUCuCfCmwubkp?=
 =?us-ascii?Q?pwavLJiza+1AKNEHyWokwgw8GrqNrSBZqDd9nN4p2k8DtiwBF9+tSbU9QCo4?=
 =?us-ascii?Q?giyi3BHwndQHt64a3Y2bZFJ64QLGN8CNjxdaSqdXUVoTCsPq77m2O7BVypGA?=
 =?us-ascii?Q?vAy0H3sHPcRyfTSejm604SdLZqToulLZqfiGnidk4EFaQ6GAXpkX249pFnBz?=
 =?us-ascii?Q?0fJnbwhCk9JCohXypwQLKILiZeg4+6pmQC7fq4CxLW8zsQ9bo/GvJAeMZqwU?=
 =?us-ascii?Q?Gz4Tj4cbA+/1Pc8evqB0l3zs0wZCB+7z+yftbwtjrabPxB0Er2kOyHIeyupQ?=
 =?us-ascii?Q?3SAtf31Om+s7SIVFobBVu7XR49YT4dIEu/18xpcTnWhGPQh7idAUaIfxSA9n?=
 =?us-ascii?Q?XUsDil4zX1tsXCiuKowDP2f5IabXz0kwpyiwVD47ANI0vasS3yFCLFw+ZwD9?=
 =?us-ascii?Q?oZhW4JCQkhu0ADnHAoiwI4SaN+Exw5bnTWoVFldNdq65BplldHb81o4Un4O2?=
 =?us-ascii?Q?eanHSMSH15pRm2qAoC5bsPqUWZaqboBDJgKbbf0D/QVfraboSn3KqXs8erXK?=
 =?us-ascii?Q?Bv9GEYedF62FsPWMtEi1pXLNrt4f8X49tuLeATRZQESkcbJZwRdsPuMF1J9E?=
 =?us-ascii?Q?pvwcVpMOhyQIiu8MejfiG2+FnrFDHHPw+CwHr44iIE9qFiSBx6lnPf9pFuvm?=
 =?us-ascii?Q?acgwZk+xOeJR6VmZTQ7y2ntN0WTgJFAAiaTxC6DHVa4iiBFFe3zTXwmoVdYQ?=
 =?us-ascii?Q?0A+VN2mrmPX53T8Dq1gyyuZc4qHIoxPx2rIYC+1PStNJYPAiy/6xd9RiuAtB?=
 =?us-ascii?Q?DFLhAcDghI2fhgHnzoeZPTQr1kq0UdppKhl7yG0VzMCe+qRKj3Qrl6LmErD7?=
 =?us-ascii?Q?nm1R5hNMe6/5UJW9RE9BuvRg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3028f4-a587-4d3f-91c6-08d9320f9438
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 04:14:34.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tQ1seb3NHbyQ8UQTNTQM9VBYrTnw923COAS4Zheuz7VCk85iGgwqGZvR82go7KLIX66NCq7W5KYzNYEWoFEJGieY2lOx5ysUvM031rXMIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5303
X-Proofpoint-GUID: 3FrjgvvckUoRFPLX6AHrsdavnYCAtuMZ
X-Proofpoint-ORIG-GUID: 3FrjgvvckUoRFPLX6AHrsdavnYCAtuMZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_17:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>If cdnsp_ring_alloc() fails, cdnsp_alloc_priv_device() need return
>error code.
>
>Reported-by: Hulk Robot <hulkci@huawei.com>
>Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Pawel Laszczak <pawell@cadence.com>

Thanks.

>---
> drivers/usb/cdns3/cdnsp-mem.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
>index a47948a1623f..c87bf3513844 100644
>--- a/drivers/usb/cdns3/cdnsp-mem.c
>+++ b/drivers/usb/cdns3/cdnsp-mem.c
>@@ -694,8 +694,10 @@ static int cdnsp_alloc_priv_device(struct cdnsp_devic=
e *pdev)
>
> 	/* Allocate endpoint 0 ring. */
> 	pdev->eps[0].ring =3D cdnsp_ring_alloc(pdev, 2, TYPE_CTRL, 0, GFP_ATOMIC=
);
>-	if (!pdev->eps[0].ring)
>+	if (!pdev->eps[0].ring) {
>+		ret =3D -ENOMEM;
> 		goto fail;
>+	}
>
> 	/* Point to output device context in dcbaa. */
> 	pdev->dcbaa->dev_context_ptrs[1] =3D cpu_to_le64(pdev->out_ctx.dma);
>--
>2.25.1

--

Regards,
Pawel Laszczak
