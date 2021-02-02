Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16B630C915
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbhBBSJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:09:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhBBSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:07:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112Hwttq049156;
        Tue, 2 Feb 2021 18:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Z5cro2I0XZpcPjuoKz+bxRcBd/3u1+Ursu+G4V+SMeI=;
 b=WiLTi4+pxTbMP6r9+t7YBT2eQVGD3gIz6iCXUGIUhHvqwX48jGUkWJGzx3D3opuOm1rw
 zkpPJyb0zuwtiy5wiUQq2Jyr5QW8/nnTLIXLRlD4rFKA9N3zN/0VbC8JWTBSF1xuW4SV
 MTIE8XVr5esWFXGiy7OIAHyichtyvDHOKquhVonJphmjEPabKRBy5/6lftWJyq4sexqo
 6pzrvU8BSuC9xm+vGIytluX7V2F8IIuwCminqni/HuGV2Cgi8LEpPhEJmONjb2nXsWvw
 gPMjiJxtFE2HQtZ3kVYN27roQuIKC6epqsGkxTSCvj/DQnmilTdqbQ0KxV9DWfBVV6c5 hQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydkv4yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 18:06:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112I0E1S181455;
        Tue, 2 Feb 2021 18:04:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3020.oracle.com with ESMTP id 36dh7rxssw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 18:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVmhmUuibaA0N/B0uPb/QwBoRODi85+JHSgj5HlhqckJ9e98PAYaPSGzmzOaphR/oIOHU1PmJ9BQRVGElgTFAZiaaLco02khGvJ5eGp+fLgObjY1CNMAlq7ndqPeH0YTxZ1XN3j/zCUZxZpD9/3W+khey0nt+CNUK8zwO+hRTziPh/kUAg73WxBYB+CloTLlcQUVDM8AdKwRe6C94BlauTJsPo1cJ6GHKEWFO6zq9DXwdWz2hgd58ZfboryrHzbtSh57B1vyCV4/bdpZHxk/Gl0ewvwzukP6+OYN2NFJkEzn7IXfVuVGKK/IEc/TuvPLJYkEcniZX3LrRooqJD8AKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5cro2I0XZpcPjuoKz+bxRcBd/3u1+Ursu+G4V+SMeI=;
 b=D+BT9/s+UoBUW2bXh9uOV6+XXE4n1de0XJ7LqWNfQclh7XNHKhaZzS+do5oqyAZdqVFQyxUkisUyD74hKxUBmhxmo1u+btUf/iSjDBG+lXeX5AgA/NY63dbeUXkNmuSscR+EhKjsoOw/2FxHpK9mx1zYvYVpzkRV+pGR/iyRd/sr6b3Q4pw2cB20ALQR1vSg3DubC5UNqHQ2L/SI2NaT+SJgW1RbJynfWkTL9nLXjuEIES+KT2dqJ2Xsf8Nc3BU8ZWDoG7NIYQ4YtsJNmC8VCROXf7DlVM95y1e6dMbBmL4peUrsH/jblMfbmANUSZ+IfLneMuE17+ey15bPwpo46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5cro2I0XZpcPjuoKz+bxRcBd/3u1+Ursu+G4V+SMeI=;
 b=EeAdnAleJuZqJXcvsKkB7pTVGJEqzT65gtzVzMpRzt/ZRjySOhRarylgj2EWQaCCT6C1ho9e8hONbBu/OqVxN9RZcbgl58BeSoWPXy1GkTr6YzNjKPxNVdRzeKm/ts2Tg1p57FzJjoW3rKNhThjp3mxLQW2/MTJcADtMqPltS2M=
Received: from BYAPR10MB3270.namprd10.prod.outlook.com (2603:10b6:a03:159::25)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 18:04:14 +0000
Received: from BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::61fd:7c42:26e6:1e15]) by BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::61fd:7c42:26e6:1e15%3]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 18:04:14 +0000
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Yang Li <yang.lee@linux.alibaba.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "ssantosh@kernel.org" <ssantosh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] : Re: [PATCH] firmware: ti_sci: rm: remove unneeded
 semicolon
Thread-Topic: [External] : Re: [PATCH] firmware: ti_sci: rm: remove unneeded
 semicolon
Thread-Index: AQHW+YdIU3Y/gb3Eq0K8DQiHuSU5P6pFKJGA
Date:   Tue, 2 Feb 2021 18:04:14 +0000
Message-ID: <029DEE6B-2308-4B8C-83F6-092134629AC7@oracle.com>
References: <1612247013-17381-1-git-send-email-yang.lee@linux.alibaba.com>
 <20210202171653.yvyazvuhzhqrq2eh@regain>
In-Reply-To: <20210202171653.yvyazvuhzhqrq2eh@regain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [138.3.200.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d364804-f88f-43e0-c63e-08d8c7a4f376
x-ms-traffictypediagnostic: BY5PR10MB4385:
x-microsoft-antispam-prvs: <BY5PR10MB4385864E37C88512D0DDFF4B93B59@BY5PR10MB4385.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDeqgbDXnpDdpTIcvad9fZo4zqTmZBcBbJNS9Ahrj0trGHpjA+p6EFD/FhA5t88/XwfM1VzkVyfR/Rk0Ww0U/d9Xg8byyE/T5eswsIscTtQsRW79Ejg0iXPt7Skvcvu2eiPzpKHQlL13hgmpBz5b9LFW8niUc4RcD157P3rmIqjNKKkG/+16yZG7w6ABXdCAwMn6p2Ojh5BegPNx4REM3yMJYylHeng5nHI9zwtFcmFjTbGdWSfbGKuO3mliv7nOjEPToO6aQlGp78ETYa5V929Vygbh+CTs5DD96J6nJHfddqUSLjXnffhj3lG3U0yqGz+/sYZ7mX51V5UfPSVxYNtckDbvB7VU5AJFa7RFvX08DSp3Z628uCg4sJyzHxBX7W+S22IlhUgga0THE8XYaTeT0ltoiQ4NYz/DN9BBZFs0p5CfJ5OhHysDdQDVYdZVZWm0WtIfixsGuqoqWOXcoJyshbZox72G1yfVdLBFo8EObCpBefSshBork/cjmSMbP6u+PelDkvJaTRzCFn1v7oEu3xZbuKvLQDVCvfZpMKgFJKhBbuQQpIlkaGfTZ+MjbJkIo5SILL5qtT0H/5JHDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(66446008)(86362001)(44832011)(186003)(2906002)(66556008)(76116006)(54906003)(8936002)(2616005)(316002)(33656002)(83380400001)(4326008)(5660300002)(6916009)(64756008)(71200400001)(66476007)(53546011)(8676002)(478600001)(36756003)(6512007)(26005)(6486002)(66946007)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Lsz/qMs8QPrmCzenWIKjFycqpoqgV4pPiuLpTC53LkWRwZE2v5iUwfV9sb+Y?=
 =?us-ascii?Q?Kf8ksaDGBnmmxeRQ6sPY1QfSdPoVovb7rnMb2kB9bFm6eBBfS+rUuBBVvHv1?=
 =?us-ascii?Q?r6crUwNmj1udU3bXFthRrx02h1KTKkk0hOTZF5I1k8y3cMV/q28fsu+xvyLh?=
 =?us-ascii?Q?DGbfjRyOwTAPI4BOrsH4V3Fgl2kBtp9Oh8qTStTge7dn/Vb/Ps5Aa9Pkuymb?=
 =?us-ascii?Q?JB7msCcXI4udQAO4GUwclNF9S/uZ5DNbFPWv0HyqV/7Mo0u4IkWt3z8sSip/?=
 =?us-ascii?Q?4w6oFjCeXW3lI56IVybMIeWUl9Ki77iqXm0hEtooA87lmj9fHbmcopqocMze?=
 =?us-ascii?Q?iYkvrZ5hOjkioavMgtWfgyVYhVUJpVoW+QOEqEvqoF8H6rgJVctFyCJoxStj?=
 =?us-ascii?Q?zbRiBZ3/EYfIktqjLRyOzRT+SxFi+6F4Pq9nHD9jqJHmOfR6fw0rvwQ6yebX?=
 =?us-ascii?Q?TfFkW7cJlEymMyjy/nTDnC2JWcK1LcY1kdlyrcll9v6tHpyqWkujybDRq8Yf?=
 =?us-ascii?Q?CCD1HubehzKqye4WAAfebOTma+jp9yGxcTzUyCh7YXvraX/xOzihVpNHOK2D?=
 =?us-ascii?Q?e56LFJTsbENydjCUKBUFSRC2KuJr1xiqPMUUQ8EDesncVnZlIGe6nZJhUJwR?=
 =?us-ascii?Q?oUvtn/odM44mS16+9YvtSKhXjBpA6NMVizz15f2/+zzuqbVaK/JmjYzqvzDj?=
 =?us-ascii?Q?22nc+PN4qDXd2qeVBuY4FgCvfuNjjf9p2p1U0tgYudndG40endULsxvs82pZ?=
 =?us-ascii?Q?Lw00SuPhH220Fiz9GJ418Lpw+XohQ3ha6lHztG9Uaev7rKZjXZ6Wu5J0MXF0?=
 =?us-ascii?Q?IXEAgEfT5CRCAXWDZlFsDV3JAqxabNKC2rJu2PtH/aBPZ1TgyLLUR8DXGnx/?=
 =?us-ascii?Q?Le0XZG5Sl0ojjjO5qexa5seAjsQU4afYLLcD3GKNsg26uEuKg2PZC0GsPaFH?=
 =?us-ascii?Q?Fp2rtV9DXXphPLyfPrWBHnwj1vjuAKJ7izI1tcT+Yx1AFnWXmpMN2M+SJt45?=
 =?us-ascii?Q?GlRW5OGJxD2Q9qTr0tPwkTfPZHyPVMaqpPM/wHkX3dRwIZo1cUvApivxlNW9?=
 =?us-ascii?Q?vEyzOfcV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82A0F84F59E8E444A562B6B55EE254E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d364804-f88f-43e0-c63e-08d8c7a4f376
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 18:04:14.4697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43IFJoiL6kpLr6+MWsaMQ+Nwdz/zb9PW8QRiilm1uSOl8iJdBnA8t/hNMPGWls8ptiBziIAR/m0mjpgYDQHMOv64ygwtQUkR+1oZldDa6HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 2, 2021, at 9:17 AM, Nishanth Menon <nm@ti.com> wrote:
>=20
> On 14:23-20210202, Yang Li wrote:
>> Eliminate the following coccicheck warning:
>> ./drivers/firmware/ti_sci.c:1762:2-3: Unneeded semicolon
>>=20
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>> drivers/firmware/ti_sci.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index 235c7e7..5ae2040 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -1759,7 +1759,7 @@ static int ti_sci_get_resource_range(const struct =
ti_sci_handle *handle,
>> 		desc->num =3D resp->range_num;
>> 		desc->start_sec =3D resp->range_start_sec;
>> 		desc->num_sec =3D resp->range_num_sec;
>> -	};
>> +	}
>>=20
>=20
>=20
> Uggh.. thanks..
>=20
> Reviewed-by: Nishanth Menon <nm@ti.com>
>=20
>=20
> Santosh: I know you have send your Soc fixes for merge, but will be
> great if you could pick for a future version, this is minor enough not
> to bother the stable, I think..

Yes, this can wait for next one.

Regards,
Santosh=
