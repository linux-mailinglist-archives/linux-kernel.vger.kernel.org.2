Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5404031653F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBJLb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:31:26 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13874 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhBJLYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:24:21 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ABGRSE005965;
        Wed, 10 Feb 2021 06:23:34 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0b-00128a01.pphosted.com with ESMTP id 36hrmbk2uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:23:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw7ZWkU/X9M7GxrK5ML5tnvKYtd2JPdK8FHVmVUWY/JycdS5386/b1Tq+0BgYn+qKa0nxY80ZXIGsO8RCNJfE8VHiRXa7sEwsaCwSUWBmvZ2cnWnPz9200mAYTNorE4//v+MYNswvv3Wb06DZeoofE4aV+N2YynEncZoHYXoa5gXOGotu8K2+3E/k/zy59dhcRyFfhfLE/4KPfYlUNND/K8sf+wCitwJSgWinzvE5xZIb9SWWDFfIJIZH7kFi8bvDOhzXSwLJ7Q0cDQWQuZAKTkk4yk2eEXNBHHkI1BGMO9H3SFKOiyF8nJErvN24N8CgreEWlyaKD72mFQaOZxqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tchY5CDs2B0GtpLr24jgCDKvPxjWcVUbICugkee9Ic=;
 b=czNyTdjHOyi/hV5TnRQZdatduBDESuw5IiUfOm7x1WNfkDb6Po045LY3eAfcfAmVlosC7C0HTE6DM15JXirHMaWtUav5Nf1H8oaWNPL97P31HTwnet1i98hNqq/poY2j1kmvRqjTNYogCBp/U1NnREnAsPmKUTe4lmiGgfpNMxnTzcVR9T21ccu9kP/LrBN/8w/cmbX/GXs7WhUKaWHpNPXPKoTbbv25O3eblsRl8PWbrBxePWpcFTdfxjY5gnb6UD8gcds9enMZbQkPI1JMdRLqm40X9SkKXOhpXldJNXj8YKxW/p54FWMk2saMqZqTJndVc1irwyehUAy7JyK2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tchY5CDs2B0GtpLr24jgCDKvPxjWcVUbICugkee9Ic=;
 b=aZoewooGtHGnd7WpW84eTi6oh3cJDfgmbo2KxkSKVfs5+BR/WRMsw1zX9+8Mw15KOhICcXWFo6Kkbh/EwK5dqbVUKgj6x/6xw0xzirnfg35jjA/2AsMUILieprtKGtE2oUXuJWDqhfjQrZ+m7z0NI/vaGwfkxdzSIrmTWi+3F5Q=
Received: from BN6PR03MB2628.namprd03.prod.outlook.com (2603:10b6:404:59::11)
 by BN7PR03MB4499.namprd03.prod.outlook.com (2603:10b6:408:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.29; Wed, 10 Feb
 2021 11:23:32 +0000
Received: from BN6PR03MB2628.namprd03.prod.outlook.com
 ([fe80::b03b:90d1:6c60:d143]) by BN6PR03MB2628.namprd03.prod.outlook.com
 ([fe80::b03b:90d1:6c60:d143%10]) with mapi id 15.20.3825.030; Wed, 10 Feb
 2021 11:23:32 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH] MAINTAINERS: replace my with email with replacements
Thread-Topic: [PATCH] MAINTAINERS: replace my with email with replacements
Thread-Index: AQHW/5u6oRAZp2s07kOu+f9smt0jBKpRPung
Date:   Wed, 10 Feb 2021 11:23:32 +0000
Message-ID: <BN6PR03MB2628C9EA3ADA848308341179998D9@BN6PR03MB2628.namprd03.prod.outlook.com>
References: <20210210110116.49955-1-alexandru.ardelean@analog.com>
In-Reply-To: <20210210110116.49955-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcGRh?=
 =?us-ascii?Q?dGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUz?=
 =?us-ascii?Q?NWJcbXNnc1xtc2ctNjZjMzE5Y2YtNmI5Mi0xMWViLThiMGUtZmM3Nzc0MjFm?=
 =?us-ascii?Q?Y2FlXGFtZS10ZXN0XDY2YzMxOWQxLTZiOTItMTFlYi04YjBlLWZjNzc3NDIx?=
 =?us-ascii?Q?ZmNhZWJvZHkudHh0IiBzej0iMTc3MSIgdD0iMTMyNTc0Mjk4MTA4NjUwODU0?=
 =?us-ascii?Q?IiBoPSJ1ZVRHVmgvMTVlTjBYNjB5WlBXbklveDgzMGM9IiBpZD0iIiBibD0i?=
 =?us-ascii?Q?MCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFJWURBQUJtNVJ3?=
 =?us-ascii?Q?cG4vL1dBZlR2aUNBdVA0Yis5TytJSUM0L2h2NEZBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?UUFCQUFBQXhqZ29Pd0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFCZkFI?=
 =?us-ascii?Q?TUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhBWmdC?=
 =?us-ascii?Q?aEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdV?=
 =?us-ascii?Q?QVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29B?=
 =?us-ascii?Q?WlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCaEFISUFhUUJo?=
 =?us-ascii?Q?QUY4QVpBQnBBR01BZEFCcEFHOEFiZ0JoQUhJQWVRQmZBSFFBYVFCbEFISUFN?=
 =?us-ascii?Q?UUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBY2dCcEFHRUFYd0JrQUdrQVl3QjBB?=
 =?us-ascii?Q?R2tBYndCdUFHRUFjZ0I1QUY4QWRBQnBBR1VBY2dBeUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:252b:e901:6129:7321:ae26:2341]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5200e881-2a11-4384-a12f-08d8cdb64c94
x-ms-traffictypediagnostic: BN7PR03MB4499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR03MB449972B35135EE6FFF8CE256998D9@BN7PR03MB4499.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ScFbO3Ek6CR1Zechb3OioT5WIu1wRbmtmYgmR5MaU2gv3uI61ioW3H7YKgP6rt1TvjcFewuGkc3EKUlR6UWT9weXy6wz/KRKKwlq9XtFoIErDBl6QcUWvIH9bcZ6VVC849u3xnLjddBapom6nUsoqYfbi41gQx6nXJuo9stptAJh/LtRK23sAIafLI8Rv8mVCfh+m2Agx6MbYke0L0999t4UtiYYT4XNySSF6q7QgV2nZrTFCdAkxbMWlwiCgHlXiI1hKKqj2DF6lzvCboMEQ5CH4/O81QtUSsTJSIvE1SH6aW/3sKENAMownCY08QUE6DP115mssRBc/2DbzIFB9WlOhbh3bwAjAnDex8hIcc9m9QZaxfGBa9LGCksl2fssaf7F4xZghjDOG3Ljf8930R+A82eH8I/jFAhUm7ipRpe4rm6JsCDTmtbUtXZf7QRhyh8NWGpIL8Jc4FCcQuVhrneSji/FOy1hE41dwsdbxUALY4wPxix9GfEf5NfeCPjzhdRG9ZsW3q3rrstGVlv2WmF9e5x0g3Z2OT7ZvTq+tVLHqkoHdVdzKGRkurt+YNSrp9fC/YJxiDuy7H23Jwav6mwSBQwmH6MVMBjzB0QUg5E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB2628.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(376002)(396003)(346002)(478600001)(4326008)(33656002)(186003)(76116006)(7696005)(52536014)(66446008)(71200400001)(66946007)(9686003)(55016002)(2906002)(54906003)(53546011)(316002)(6506007)(107886003)(86362001)(110136005)(8676002)(83380400001)(66556008)(8936002)(64756008)(5660300002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5DkbVnuJLTB7RlV2c6/VBDh0dF/tZtEWnL5fNAW5ajPYNGtD61sCgHLoVy9q?=
 =?us-ascii?Q?NeqLvozWlu+56COQAw8zwiM2+YfLTqQvWdvE6CuwSvFrrmotrz/LgFz+dWyV?=
 =?us-ascii?Q?t63juVch+4bB4wnp7z7XeuTOJItZJ7kHYJxYLU32an9fTuCu/p2n/haw4wti?=
 =?us-ascii?Q?PjErvt7xopuSCVKeUTjD2tbGEkEtmHg2bnPuJNyo2lTboruXmZdQH9Jl+v5p?=
 =?us-ascii?Q?Tj/tzQTzC1gQeZG1cj3+M4MtAZCWGO9XU/LF2BPIn9611sZirqPP+tLdP8z4?=
 =?us-ascii?Q?4jz5QbAMQFyOXTwW+fzHXYyi1V2EtSR17i5r93my1aSyy471Rx8WsCBBrJV1?=
 =?us-ascii?Q?RCW6LXv7DLILbNwAGocHcYJ3DMaZroPu7gaElBy7JnY6POCF4IlEadmJJVO5?=
 =?us-ascii?Q?lqOsmNuZkCcsxFJLtKVZZLalciFgtFUiaE4r6W7+ZFolRAwe7F6BkVyCz6Ph?=
 =?us-ascii?Q?ySWQTnQUophC0bTvTyN/Lcogdx5G8RenfvHsjkGuaACj/Dh8XJ/mZGfz3a/4?=
 =?us-ascii?Q?GfMValvYgUTwelu1YkG3blLKW5rxjcxmjrTXOVzLbHIr4/iY9IFbzfQoS7Id?=
 =?us-ascii?Q?UptdPNsTpf8kNi+1uP5di0TMu3BrdSTBG55MJVSe1QdXCy2VzJClb1tAjd2s?=
 =?us-ascii?Q?xNVueNmIUHHPSsRHt4bxydwcUEWqvMrMeGZoVibrNOBPAx7o5NMQrR3V153J?=
 =?us-ascii?Q?0eBF1E18TylY2w+PYAzcNB/FptxD/WRMtya1xCW0/nSBOA9mkvsrW482Xwza?=
 =?us-ascii?Q?T+dkfr01XFfQ/OEhCVpNz5GpAJdgnm/PEkwSdsLWRSioWYFk5QNbErXdyAcp?=
 =?us-ascii?Q?mtLGl3ma22qMRr1hRKLBeH9450UgYI0Yrhp0n8Q7NXz8mODQDPEoWMXHQzXd?=
 =?us-ascii?Q?KpHA9ackxE8i+VPbKnORymNDNGvxN8gK/sosHEzrjIVu56fITbEvesAnWhs6?=
 =?us-ascii?Q?97uZcR+jVSwsQzYmtc+16RQWrt6foRgRFv3GoPpHzv4ZfP7SJl9t2xdeV9aV?=
 =?us-ascii?Q?U9vrRtyOkTxFT96/H0WsJnMNqwBtSNMafarXObIG0N5d08/qR9GYjdZN4Pqw?=
 =?us-ascii?Q?RQj+VuhIZcot6EiVRLyNMaHP3kZXau6Ez8R5dZQJfEE+fX6KhK0CRHj7qU/T?=
 =?us-ascii?Q?oa7XG3k+9FP+gHHH+W2UKhg6VMw4J/aL+anmHe/m2UMqODr1ccgIyLWI3Xm9?=
 =?us-ascii?Q?biQ0iwwSQiCWMpfpdT8DtFdw6nDIjyaRbS3+e5/5YGpnzaWioi6xFvFKAVKF?=
 =?us-ascii?Q?+FHzVIFsJvN4QAbi3pd6owwPIyy/lONJN3fpareuieNipYrW4c8vYyjG2kxf?=
 =?us-ascii?Q?AZXhKsGYnc+lUnz4bzG3y/J352IaQISu9DDjZDUQb8Ve0+jSAEPr3E7okdCM?=
 =?us-ascii?Q?JchhgaaNV/Libf6dY4DQKJqz0nw0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB2628.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5200e881-2a11-4384-a12f-08d8cdb64c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 11:23:32.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLq5wyJSI/t2QBTjbJ9p1JuGOPcKmDYAGQZ5SOQB8toxWp6wrurgJjtpqYPoTIZ++Pt6ijmEsYcC9SZpMcge9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4499
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Sent: Wednesday, February 10, 2021 12:01 PM
> To: linux-kernel@vger.kernel.org
> Cc: gregkh@linuxfoundation.org; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>
> Subject: [PATCH] MAINTAINERS: replace my with email with
> replacements
>=20
> This email will become inactive in a few weeks.
> This change removes it from the MAINTAINERS file and adds the
> people that
> will be responsible for the parts moving forward.
>=20
> Signed-off-by: Alexandru Ardelean
> <alexandru.ardelean@analog.com>

Acked-by: Nuno Sa <nuno.sa@analog.com>

>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e697044d34d6..97a91fd7948d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1016,7 +1016,7 @@ F:
> 	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
>  F:	drivers/mux/adgs1408.c
>=20
>  ANALOG DEVICES INC ADIN DRIVER
> -M:	Alexandru Ardelean <alexaundru.ardelean@analog.com>
> +M:	Michael Hennerich <michael.hennerich@analog.com>
>  L:	netdev@vger.kernel.org
>  S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
> @@ -1024,7 +1024,7 @@ F:
> 	Documentation/devicetree/bindings/net/adi,adin.yaml
>  F:	drivers/net/phy/adin.c
>=20
>  ANALOG DEVICES INC ADIS DRIVER LIBRARY
> -M:	Alexandru Ardelean <alexandru.ardelean@analog.com>
> +M:	Nuno Sa <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/imu/adis.c
> --
> 2.17.1

