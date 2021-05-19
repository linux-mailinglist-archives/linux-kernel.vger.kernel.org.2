Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614A53887F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbhESHDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:03:40 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:44964 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238909AbhESHDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:03:30 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J6m1gw031998;
        Wed, 19 May 2021 03:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=hykrRV4BVrgiY09aB1VoKP4Sdb12Lt3dtHg7hpBaOgA=;
 b=h+5mf1+BY9uTNUWtIoNa8sBQnwcoT9h2+GisbcjuB6ZNnhXs7SrQGo78rMKqA/VC2K5C
 a6WgBgzK2uz346BMCkSiCtdqbg6/XEYgQ3qnoPwyASd3bjMsPWNjJMQ0j/oEf66hl42I
 J8VN5LlnUPJvP8w0GDoku+LJKNexs7TAhTFhgfkDzTmVfHJKjqd+eo6wfeBLpOT9Og2b
 5WeaD9z8e65E+W9HSy/tDRuUiR1tBryvtB+zLnE3xgr75bSOjTQpFQB9fh/duHqTVsi3
 fIm3kOw7+DBF39MYeShR+8b2KCOKdnibyj6fYZy7qLaPYY0I3SRWd7PTCWM1zc7YQZm5 Rg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 38ktd77ygc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 03:01:25 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J6oar8068010;
        Wed, 19 May 2021 03:01:25 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00154901.pphosted.com with ESMTP id 38ms7bk83r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 03:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJhbgacdO2QqDbyT4lOfr07zYH4CmigJ6YYlpA8WU76AqylusmtBVfkOH+YAj9rqBvwVIo5WQKv7KZSakawDZDRv6o/w0MNzbnMW0eskDs4auPXE9nekeXDBk6kXAuXMV2nZbqV4JhD+IJel2iM78L9a0bvR0l6vAHSvywCZCkGHwS5usUkcCp+2s0fT5v6vQkA0Ba80PSQvHmiq0jj6111n7Pe0+71v9a++X3671gGZsBdepUWY9zwtSTgkIgXyynnQGMsM88RvYFzmIbnSlmbo+LtWlByLpZIpDUiGLz13XEjc1rsL9ecpyE5p8L5vqohLooD5zQrQTKcGu8F+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hykrRV4BVrgiY09aB1VoKP4Sdb12Lt3dtHg7hpBaOgA=;
 b=B7xv4GCZgZ8mhdZtPOhBrl6LM+LjoW3vxRiRmJwttfhaZ0AJw6PgZ1d+WAx+FG1YQSOq1n79iim4UbqlrTfLnZhyTXdZGXBAB8Y/6ONhHxFHSov5H980zeI32PY3oi2TvcLLpsZKAktBe0qXiCD2I8RYcPXPi/R8/U+h7cVbsIY3AnM7qheN7tnALV7aWuzmkq3XL/lU5NM7y+1JXcyBcmlr4grMmMYoCkPjxEVoxVMixynFl9xnEVzzQD9WNF5rXAO7E3mNHT9swqcLSOfZFRGZRY2D1Iw/5tjTkVFlp3kb57EKOLMv4KXXG1b0nVNyfngVURse8HfLTqxerVHPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BYAPR19MB2520.namprd19.prod.outlook.com (2603:10b6:a03:12e::15)
 by BY5PR19MB3923.namprd19.prod.outlook.com (2603:10b6:a03:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 07:01:24 +0000
Received: from BYAPR19MB2520.namprd19.prod.outlook.com
 ([fe80::536:b962:fd71:93df]) by BYAPR19MB2520.namprd19.prod.outlook.com
 ([fe80::536:b962:fd71:93df%7]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 07:01:24 +0000
From:   "Wang, Crag" <Crag.Wang@dell.com>
To:     Greg KH <greg@kroah.com>, Crag Wang <crag0715@gmail.com>
CC:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "mario.limonciello@outlook.com" <mario.limonciello@outlook.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] thunderbolt: add support for authenticate on
 disconnect for new dock
Thread-Topic: [PATCH 1/1] thunderbolt: add support for authenticate on
 disconnect for new dock
Thread-Index: AQHXTHoT+AjeR9uczU6we2KJHAyrRarqXkGAgAACJ/A=
Date:   Wed, 19 May 2021 07:01:24 +0000
Message-ID: <BYAPR19MB2520C07472D09E38A0944713E32B9@BYAPR19MB2520.namprd19.prod.outlook.com>
References: <crag.wang@dell.com> <20210519064146.58454-1-crag.wang@dell.com>
 <YKS1y3UNnXeslWd+@kroah.com>
In-Reply-To: <YKS1y3UNnXeslWd+@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Crag_Wang@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-19T07:01:22.2435136Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=cf66b495-65e0-4837-9151-0035fe45fe14;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: kroah.com; dkim=none (message not signed)
 header.d=none;kroah.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [2001:b011:5c02:d8d8:ed01:4bea:6cba:87a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73e60ef9-d88f-416b-fb26-08d91a93ea39
x-ms-traffictypediagnostic: BY5PR19MB3923:
x-microsoft-antispam-prvs: <BY5PR19MB39239B67B84A73DF9B74BFCFE32B9@BY5PR19MB3923.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B77AXeZWKd3TaJhauVAk4Xp9s8vUUpmsEAE3KPrexkRmpw9/2M40RZPkGHymmZFaQKAP7W0/Z5tPWt+n1QYkO+bIgZqrDXxPkCjoVkdbvURVFHqP9QjfqCoW/Tm+1iZOk3rLbiq5ywGjfTfzPyduPPbq8o3bQJaeUad5jGhF+Jm8aRqeaZWEF9Rl0JiC8hPH++s0mJh8+MrGwA0owCBei7scxlRTMUhEvzpR4XIsHhfi7a88HDMnhVJEDVIywa+D3Adq0BeGKXjiP+iVHffoXI7BEQkAUl6sc0EwGID8SwSOASnYupuTWRC7RSjIAo3y+jZxagnHkAoR70YPBOW7kdSpxGCseCT2fJ533pBKl5SIC8bwUEWq2u0Qe4EnxYhlqN7ebh3q9NJO5uWUkfwD7QTGQ4sPpMEG0N/pwo/PxbobNYJGwfM3K3cba3slaKc5ixPRtHjh9ZREfhlAD3FzMlOtZAcxt4/wxEuWuingHKlK5qi0xp9jgNNy55ZKgxFthf9WQvQ7BojhEL7B47P7M+7A1owvlhEuzfQTL8Pyyov0p/RI6WlBXMqoK69i+C4BOenm3ODnybAL4P6iX3Ayjb9EoHqpawBVVlBYrylsyX8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR19MB2520.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(4744005)(8676002)(122000001)(55016002)(9686003)(4326008)(52536014)(6506007)(186003)(86362001)(53546011)(5660300002)(8936002)(38100700002)(54906003)(33656002)(71200400001)(7696005)(66446008)(45080400002)(478600001)(64756008)(110136005)(66556008)(316002)(66476007)(76116006)(786003)(66946007)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5SegxaIuyCqYx32+meAJC/pCi4G/a98uRfQvcS3u4LG3NRuPoxaXpSXtN+J1?=
 =?us-ascii?Q?X9vRwg3EAV1r7oz5aD+smD6hZOV7eTcMqTPeMU99ev1vxtQx++TLoszse6dM?=
 =?us-ascii?Q?2DfVYbIauSM79CV6AEDMaKyFLbD1Ru/ogBtAjI3sLWKQ4Z+i9cjkDkNz7VYx?=
 =?us-ascii?Q?xwnDAdPDOX12Zd4q+wOweIQCTDCHmHTDH96UbRTyyIKUQEqDH7crObFqUPT/?=
 =?us-ascii?Q?kQD1NzcG9sXWvFA/y9WUGUdY+CM4kqD0mn+eIR4ZnNzyIyutOJ+nuljtXICV?=
 =?us-ascii?Q?HU4u6lqOKnBj4HJ0pmjojdsyeXzm+fpCqzS4Df5kCgo/ewhPaEuDl+HaN0pl?=
 =?us-ascii?Q?32FxQUnc2qVv1km+FCd1lQXV7y4jXoUZYIKJHFmhmbm064d8EOoCPBMoZkBJ?=
 =?us-ascii?Q?e4zVQ+GYsC7+2dMDetoPGVsj0lhyljMnMcUB5qvIYe+nBCxMHHfFMUKn0P+M?=
 =?us-ascii?Q?bMTsg5gLW0+gWFTc0+duTYQAIHQmrLC5/5BFLpXlAww3f7xYxVjl1fPgb2/k?=
 =?us-ascii?Q?6sJ4uwwslrhCCHSRn41pgD1BhCzHC9ytBB5fN9zPaWIJmaZ18JGOP6UcB1MB?=
 =?us-ascii?Q?zlktM9f5ehyZ7iSYaA72J536sw1NBMlwBrmIVAQGrkhEra9ZDk1lO/5iXiwD?=
 =?us-ascii?Q?1jTsrL2U9GBiYrfWC5C2BeXnAeutPheHozOyk84yFF/JEJbzPN+wGX+ykSkN?=
 =?us-ascii?Q?laf75ImsyTJJqqscYQFfOZv0hNp0WhBhCzGnMD0PTJ3221HvzwJOk8SalK/2?=
 =?us-ascii?Q?8RX9lR4ZPFLN1T3WGYAYvWvGK0T6b+HLoV5oLNzOFwYl9kEE+sQI2MHWPEiV?=
 =?us-ascii?Q?9Km4NPOiuYbmlRVirXBXDnyiDZb6mSu+zviJZ0dMjluA1TOx/ia3MuJD1Yjg?=
 =?us-ascii?Q?huY8liw/TKmo84H8IK4w1SwcSNMMjy8PVeXd4yP5V/4etVQv/dUKMOC/0g3i?=
 =?us-ascii?Q?McMgqSzGRG1y5Plh2b2TsLSOT44WOjWc1+v1DanZTS7JDFsLL7ig0H3AzDNE?=
 =?us-ascii?Q?OhsR1aj2qFSneYLw1pAsb/GKm82P/Bw4wYZsyp8+1MQD6OivYrHZWaSITMsp?=
 =?us-ascii?Q?KJBkGMNKjTLMbaZKkMtF6Y2ulBmtQV4h/ep0+j+uROXdsX3ZV79CwgptOT1C?=
 =?us-ascii?Q?9Tyt5aeEmLL6r5fyhZ+pfvJtc+PfCDEZHvc+ZkMF1X2nitYcQZFAd8r2UtDQ?=
 =?us-ascii?Q?6vRYz5zMi+XYbceHSQzBYqp+XwLN9LW5+7GOlJysdytdGeROcHwk2Q5clDYf?=
 =?us-ascii?Q?BOMDGK6TYFENEv3lM731rvxA/vvoEtbHuzGod3BYJ3BN5mu3nYe4q8LdR8Xe?=
 =?us-ascii?Q?EbmNZBDo63YEUoZlK0bD/3XPYO8LwvJ16qmHHNIQP3ZL0atJCaYW+4WAgCXG?=
 =?us-ascii?Q?3llkio3q2xDxcSKduKUbfSuUqAFC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR19MB2520.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e60ef9-d88f-416b-fb26-08d91a93ea39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 07:01:24.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMARgDwSeKMPnxJ9DLEWxQ3F8vo0wsPaZ7UZZDio72TDWblwQdvbbJVQbhmqc6VUOd+jQ8/MfH6VZyZAT7xV1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3923
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_02:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105190050
X-Proofpoint-ORIG-GUID: 7orMmVPmdANAhaVyYtj5G809jcaI6Aez
X-Proofpoint-GUID: 7orMmVPmdANAhaVyYtj5G809jcaI6Aez
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, will resend patch with change description included. Thanks.

Crag

> -----Original Message-----
> From: Greg KH <greg@kroah.com>
> Sent: Wednesday, May 19, 2021 2:53 PM
> To: Crag Wang
> Cc: Andreas Noever; Michael Jamet; Mika Westerberg; Yehezkel Bernat;
> mario.limonciello@outlook.com; Wang, Crag; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/1] thunderbolt: add support for authenticate on
> disconnect for new dock
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Wed, May 19, 2021 at 02:41:46PM +0800, Crag Wang wrote:
> > Signed-off-by: Crag Wang <crag.wang@dell.com>
> > ---
>=20
> I can't take patches without any changelog text, sorry.
>=20
> greg k-h
