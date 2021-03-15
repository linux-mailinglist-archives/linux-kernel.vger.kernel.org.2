Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A2F33AA4D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCOEKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:10:17 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:21932 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229672AbhCOEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:09:59 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F47tQQ019780;
        Mon, 15 Mar 2021 00:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=dqj8y/SLxzCCc4KKlnygu8L9UMKMU0fG6w5XrX5syTI=;
 b=r1sxNTcV9h8yqaWN4TrTGWY4hDl7KbQbsiqGLui/3g0i8/BK/tDvkeo2xq3ZMIL3vhPs
 k+ZpVicToaC4uAhuQ1Cbani7ZgT9M5Icw4Hjk29qiG7R+ajiiQQ5W6h1uWzw0NV7Z6W8
 I1dgU5+p+lgBKF/d/lPhG7FGRgGX6Jd1iivQnhGXjmcWFsUx1N+UmqZZgt9pg18SX4lz
 fci92pRhFi2usGtj1upxT+gf+P+IH8d0UfSK2xLR7OogYciRHdA1pEF6cA10Vfa4YVxg
 QyZEYkvxjzshtHZlHxts4s81oLoAyyh3EG9fCeMC8m8It1PvBEbKlgXxvenJaL5FAX7m tg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 378se1jrcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 00:08:59 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F2cf69076392;
        Mon, 15 Mar 2021 00:08:59 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00154901.pphosted.com with ESMTP id 379bx6hwtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 00:08:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cORCpJXU/4kH5r5ZobfdZBfLcf3Cly6lo/TE1X1tu+Yz+31dzBeritVNAP7ymojcHeS0A/+6NIGwhlfHULptC4wpXSVWk0DOwPL3pWmoPx3r/QvYmQqYCefpN1Wn8eIKqiRWgsc3t1Htas+WjWd28FZV1tX3f/zLaTb1Omq7XjDfVlAcWCCPChvKXVqVg81ay1rZgGUxlzmmiAoKiGkR7GsYpp38UmJS9yYianDHnoWKd38QBq94DCqZDLOY6DSCmJJzhmyU2p7kqDDqQJS/78M63Na+NC3A5ErY3NdP6ZdUOYmRnNwnim4AMuUtiC6Mo5KIX/uBzQ2zn0qngqHsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqj8y/SLxzCCc4KKlnygu8L9UMKMU0fG6w5XrX5syTI=;
 b=V+tLqiGrIpI+KrioeU6kp2pvFdp0eOrIv0t6v5uJOrb+tExsijH0e7eujuZTl9OHNrWALb8pLygBEWOA28241I9aYLEcKSJwKdajDTr4fz+5fTKUXaSswn33GinFbGD0YbQglU22+R+kaBqqbr+Tm1+45l98fmHhA0IHYWr8Zq73SPuslEN2PudgofcEDT6ynidbFl9mXUzlOrAdJ6WZY86xLfwA8UshqI7KZ/UN0VJHQ930/rDxipJT7dU79oNfgpYwHSrsyIeHH8MaBRt5ELw7KQCkxFBIIleF6X1DmYDdBX6XP+66nvbp7HwG6n/oyZSKenvQ6jiKahXW4p/jDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3676.namprd19.prod.outlook.com (2603:10b6:5:1dc::25)
 by DM6PR19MB3932.namprd19.prod.outlook.com (2603:10b6:5:22b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 04:08:57 +0000
Received: from DM6PR19MB3676.namprd19.prod.outlook.com
 ([fe80::249f:83fe:c8e3:4be3]) by DM6PR19MB3676.namprd19.prod.outlook.com
 ([fe80::249f:83fe:c8e3:4be3%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 04:08:57 +0000
From:   "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Prasanth, KSR" <kosigiprasanth@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
Subject: Recall: [PATCH] IOCTL support for dell-wmi-sysman driver
Thread-Topic: [PATCH] IOCTL support for dell-wmi-sysman driver
Thread-Index: AQHXGVDrFrzkILYdR0auXcH3Y9RFTA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Mon, 15 Mar 2021 04:08:57 +0000
Message-ID: <DM6PR19MB3676E9DEB16043D9D204913B826C9@DM6PR19MB3676.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [49.207.203.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba406881-8ea5-489a-58f4-08d8e7680e2c
x-ms-traffictypediagnostic: DM6PR19MB3932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB39328B3BF28EFA8E8C07BFB0826C9@DM6PR19MB3932.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ShFoUu+PjN2X+Lcz80SWW0ezcYY3V9JX8/lsAhL3pQs2TJj6SCBQeIs9KaRZ2ge3udJg9iz5bGbwAsmfMWz3fbUEO80JKws4m2M2OSyhN8ohld3+Qpaxm0HUyt7jTXR8CPwA+cmzLQrjga6+D4JXAKjHSJSoTTLjqW5KEGP90txkizPpBNVcW31rhGwpum6ppGp+9FNFyk63xWZj2p/UljPoB6A7/qg6nisFSLmckt8AMg7G/CMd4QigsulgogyW1kI5N5Lbox5SXho2Sjni7QV+7s2jM2DqOg5JUhvDXNekSVZupf+rn4UQr31g864tfLwcawm1L96Ih2g0F/7woyQt+fER17dWYj7EKlrtcfHOeAXuA1cOlzFP4GIWw41YFrJrtwPjbwYa1W2/v1Pp4xoy1ZpCcfeSHIh21OslH6koemPgfJWWQRB7awB4WVtBwR7nfsSFpXY6pxj2DYH3mqQaxWmfi7HWMCE5lGfaFoiNJVZgzYZjCZQHEUL7+a4e4ZnCJN5mToFi0M4/tImoriGaqRs8v/DdnXzDGulD89z5noLWXSDkL6gWo5p6Cql
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB3676.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(107886003)(186003)(83380400001)(76116006)(55236004)(71200400001)(86362001)(66946007)(6506007)(786003)(478600001)(316002)(2906002)(4326008)(33656002)(55016002)(52536014)(9686003)(66446008)(7696005)(54906003)(8676002)(66556008)(26005)(110136005)(66476007)(64756008)(558084003)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RGJX4jJqTnxUoDJWuFum3OPLWLmwDqothQhuKlpDL12au5aksAdybe/kdJfZ?=
 =?us-ascii?Q?vPs0RgwYIQpNcCRU80rwlS044Qb8HpZwg5m7YbdNYg2XQmCKnoeIXsd1p5Iw?=
 =?us-ascii?Q?CCs5ja4034+Yy6EMwQlvwtYOScXb4DTx74Ck/W7a5pm+PX0qFMyQgDynw+2I?=
 =?us-ascii?Q?mTeCldZMJTOsOGq5F3Pan42D7h0aKkIJDcFXe4dNaAb20qqBtU/X7alsdTfF?=
 =?us-ascii?Q?rVuojkgNVkrJI77weAuwBmOdehkSw2e90CeOhGj7bUUu5wuFLrS+cA5BoONK?=
 =?us-ascii?Q?Eh/aEPZu8WqNzRt+L77X87fKuEr1xkEEB91akBrp1PZ3ltl5wr/imyF4VazO?=
 =?us-ascii?Q?ke2ujeOoehLglV36rYc85EKLOjaWrJ1p5s9ziztcedIm2lrNP1VqYy5vJsGy?=
 =?us-ascii?Q?pgPdfQNwhCwC/F98/2Ltk66upPzUGpBzN/U6GCYlVGSxBwyl6RSpWa2TcheQ?=
 =?us-ascii?Q?fVrL3+8aoPAtrX4WEQjoGK0U8C/3Jb1HuKKak9ytvXHH01guJ7g0LEkHBRmJ?=
 =?us-ascii?Q?FNoGaz6Btqpx+mfeHvpUySevrgVyAAhZeB5iMtIWl5cIxUH6o6Vin5gqdw3S?=
 =?us-ascii?Q?GU6DGalfKHWezBsxgoxJg/C/eqQB8sK3NEKvk3dyh+DkHRzhKhgIUZxifo6W?=
 =?us-ascii?Q?q0DcDFu+4UpUbVxNyQNNW2FbhIOY6UDCWoUgafARmXC05qw6eMoxiHNb83VB?=
 =?us-ascii?Q?iybtlPZA5V/SeAa1BJAqk5IAo5Uy3Tktwee60LXdutYy3Z3E217Fgl46DCcf?=
 =?us-ascii?Q?1q/m/ZYU3sHMT/rPGY7DZCC/dsP/rIlRpgFrtwr7ID7FeAEPFkA6Gdp87ykr?=
 =?us-ascii?Q?owWP+pR4LSRbnwkyS0mc7BNkneJ+9ecbX4alyvgBZdnyEjZziRnl55khs2hC?=
 =?us-ascii?Q?6x0bvocZ81bslT1NpLQOiAf22dH32YLZu+JvDhvV0B/wYcs6slycPAlLsIhr?=
 =?us-ascii?Q?I4FGPFRvKaA7ORty7Z6snWpPNzbmH4hevsdnztEdcrrXoylxa8Gp+jeCuFNB?=
 =?us-ascii?Q?xu24utJXAYjLauq9juOmXtvTOgV9DjLIMyl0bZsM5FmxAFmCaCcOTIb23uyh?=
 =?us-ascii?Q?R8d9bWnQZA2sJYCnyj8C6vxWRsojwsAUxix/aF2INbIWUVR75cYpdmfV2sVx?=
 =?us-ascii?Q?s6lGflCwiZgXYExaD2A0H/mudZgDD4khRa4GwDvtAlCKrt2L5z1b7OgOcRBJ?=
 =?us-ascii?Q?aZuS/Z+v6julCBErc6QkX+HMq+usFYqrXcEElyXNnIGvZ62pwMj1iqK8AAms?=
 =?us-ascii?Q?wW8zHmpydLweYrH4VT4fbggWyj5pi4WICPMgSdVb/32PJ+2Tx12xVBhEIZyQ?=
 =?us-ascii?Q?mj3mo8MEbUg3TZq6sMADkxcx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3676.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba406881-8ea5-489a-58f4-08d8e7680e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 04:08:57.2498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xR1qujTswybFtt3M+AFHzxdp+kUFQD+mL4B3GLCV/UXj+EkaM8Sj0DE4yMHqgne3aCDki9yM/yQOdRtYhE3PMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3932
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-14_04:2021-03-12,2021-03-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=448 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103140095
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=563 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150026
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ksr, Prasanth would like to recall the message, "[PATCH] IOCTL support for =
dell-wmi-sysman driver".=
