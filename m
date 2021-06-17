Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC20C3AAEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFQIoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:44:55 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:57380 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231158AbhFQIoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:44:54 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H8YjtW032544;
        Thu, 17 Jun 2021 01:42:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9E7KzM949/89tUuv1Wt+bSv33H/5KK74fGXDJO08gLE=;
 b=N1V3qIBEwB+j3qgFAtg9YZUgE6XlO/BWUWOfj9FelLwZTbm5XBZ/wUNlaLNEnhTegn9e
 Yw1PqJB31gUeDXLQ6qvEi/hxmcI/4+v/F6d5zPIL9bfaIq9tBe0fP1PZzHhcZuKj4BfZ
 MqiXPXLWmIgygTHfDopFOINGyEVvz5gYLkfC+JuOVPuWBW6El8uTVOfayIxK9B0ii3Kx
 +zGjO31Op1sjoe1lBu6yuhKmppzfYTM4jMYSRHnJgSJGgbFOCgM4E8hu9o3MLSTzc1UH
 H/el4Fs5Z3CD9FfuMehaftKL8LFdIA5W9U7WpVYvk7LMedOEEZiUrTg+81Gijv2ir+rD Dw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3975jm725m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 01:42:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+4weqTQ84vO0GGSAFnENBQ5CPHurkluyxNxuylBTGmRJ1AI8DLgDlO5Q8eLr7dqs4vlKDm03BdkX3uLEdHVh5ri9feXK3oocbDdSDH4nAYhq1ZZ8wg6pcyIL3ini9K9yGPqeo68VLripHGLuIghlCtg/PKqg/jo7vv1HgMe9aX2YAu/D1VhjiZF+RpuwnknN9dSXQ1MMSBnSh3sZG60DA7n2KTifMJ0A7GD9mZaYDGN3RGoPwU+bo1ZuNjOr6HHndNwd6PoBMRgEhf4EXc/ufRLaBrovDK5rLYwEVz4OsvbO3KtspZc+qBuuCVPKGYQKEmuoeOP0wxAbuQ3Jy8EeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9E7KzM949/89tUuv1Wt+bSv33H/5KK74fGXDJO08gLE=;
 b=l2F5+j9cPho+4FupYwZMoD5GQpDqRE3wpzP/gi8P42+fRWyTizFu1zA49CdNvJWk1tMaNQ3L02U4m4Ets+YeFdI9DnQblKWeVxcSdubD5hwyHljW/FsBl/rKNl9mBqNhysbuFsvCItM4Gh1PpjeCX1KaNYmpPBsIJKUMMmbeiJg/Eg1KgBtXD706LmXLe3qiTdJ2y9fvbdP9etzQSe9/nhtEHw7BGi297uKiU0mdIdi8k1XJfBoVGjpWaELIPYFzutfVB+quamSOIV4sxq/75BHCA8XMzY2AUYhQxT5rtCK0+KIhJ6iKK9Xfcl7KQSgaTy+5oLiYA/zPoUxa3G86Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9E7KzM949/89tUuv1Wt+bSv33H/5KK74fGXDJO08gLE=;
 b=h7bsTNpQJsCoC0xylwFQCqJHUUJWKWlqMOy0x6mI54gYXA+pyWt4gA6O34B1DMDA6PbB7Bn70GkuuWcM2bvWE7B+vLQ9+nDXMvg7aIR7S1y+IuAfRj5VF46Qaa2V8AxoHmpWScF3LrgMndlIuUdGuFCGnNeml1taYD7ekfDfVXM=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR0701MB3795.namprd07.prod.outlook.com (2603:10b6:910:92::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 08:42:29 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4096:aaf6:cdb7:ba46]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4096:aaf6:cdb7:ba46%9]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 08:42:28 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Nicolas Pitre <nico@fluxnic.net>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 2/7] i3c: master: use i3c_master_register only for
 main master
Thread-Topic: [PATCH v10 2/7] i3c: master: use i3c_master_register only for
 main master
Thread-Index: AQHWxuCK9YC2+rNE30iVVcs2nY9FcKnmXNiAgAZffLCBHy/NAIANK1GA
Date:   Thu, 17 Jun 2021 08:42:28 +0000
Message-ID: <CY4PR07MB27570948E3536C160662AEEAC10E9@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
 <1606717066-3785-1-git-send-email-pthombar@cadence.com>
 <2s3n7419-1nr9-8885-882o-7qrsos6qq6q@syhkavp.arg>
 <DM5PR07MB319618AFCB415501CD33741FC1CD0@DM5PR07MB3196.namprd07.prod.outlook.com>
 <YL/7XP1fs/2bRiTM@piout.net>
In-Reply-To: <YL/7XP1fs/2bRiTM@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lZjVjZGRjYS1jZjQ3LTExZWItODYzMy0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcZWY1Y2RkY2ItY2Y0Ny0xMWViLTg2MzMtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSIxNTk0IiB0PSIxMzI2ODM5Mjk0NDEyODc4MzAiIGg9IlhqTlBvUU9NUzIvUitEU1dtdW53MUxmQjdPRT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6bbee71-65de-48e6-83dc-08d9316bd71e
x-ms-traffictypediagnostic: CY4PR0701MB3795:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0701MB37953378F370D921BD6E2C6AC10E9@CY4PR0701MB3795.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/yiGgbvbOrXCxhjqSIW+r2UHNiBSglgM8WL00w3TJBt9GJjsY/ZIj0UaioW9pNRrpmU92JmUvqT645IR252v8uKr9L0+M1wSGmleqwBEoAohAXh0Gfp2eDfaTG7GX+p/CQHfjFux1lgYof5UbrKVWDPvoWctv9SsT6rlPjl3tFYoBJ38Slqn/LwBzDRKGmJsAlGL/TzDKxn2P+qr8rRv8eXJDZUdqV4mmIZ/Qi5jE5KAnez0W3RFI2C59pNP4IWVrs7jbwXZSCAb0rlyCnGvNisuDPyotIZ6Aw9WTEBtM6nBAGYnm4O2HXZft1IBDEMSnNUQwQ2S7li6NGlQRmmBJFh9uFqICr2IV2h++YVXso8YMNxXBiyS5G/FqK37zLm5JFpHxL73AIt71CJAKrKqeF4DhiNmXtMtDzirrT98McflXLS38Iz58z8AsWeVgExpn0QRwEwuZrv4WRkxFMe044RFX0pAOzbhfTqbNtks9jLTurl8/m4QgIzP4xdN33JMY2Aagr7vLn0YBlbRk8WkEaOwYK7uo02nKHEg7oRXJdmLb5y4iettEh/u33E/g5ednumJRUyg1JY9cjJkujoIWG6hNGtVgiNhSpz+BKBq/N0gY6HQ1RbTobNVF54qHGU1k9woS4g8LEVXqA53Hv5jrm1WLDv896Ejb1Jqs5rxpk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(36092001)(71200400001)(52536014)(478600001)(5660300002)(7696005)(186003)(4326008)(66446008)(64756008)(66556008)(66476007)(6916009)(26005)(6506007)(122000001)(38100700002)(2906002)(8676002)(66946007)(9686003)(33656002)(83380400001)(316002)(8936002)(86362001)(54906003)(76116006)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ZWC3zuMKEcunXC35YdoBcoofxQ6SJQ1nPOcq5rM2RqpILGhCP6LDPUe2hNd?=
 =?us-ascii?Q?ID3Wr2GxD6gaRKX7gpb68DVNgRO3becDmKnmPM+n5uQrAML98nNhTwNKPahl?=
 =?us-ascii?Q?8hS8DwFOEZN9Y4VsZOmT4cGdeso0Z4CIDdgg4oW4JRsNb3aaTPD+U+qUpjXB?=
 =?us-ascii?Q?7k+1nmIM7SoDOJ48phB//xhNDalBXiqrKfVeSd64MjZyvYPK1sGujcZqtIFb?=
 =?us-ascii?Q?eohexJ6ucIru79TJrSYUilmaBT+pzpfc3g73ec+GFrr16HFxc3bH7jLMRQd4?=
 =?us-ascii?Q?T9Y8UsfWSo6h84der7kkUT8FKnBjcpthqDV3WnV/vd52+HLZ9HpjOXV1VCUW?=
 =?us-ascii?Q?0Wal0y6E7sOYPf+QVXW2R9aAiXOb0jvmG7RNqz0vQ/J/lshYxyh1K8Q0XQm4?=
 =?us-ascii?Q?eIu+0VBSN1Y4XDQcqmaVdBDsaPGiGypAPyY5+SPzMLAb3G3J9936A/ajgmgT?=
 =?us-ascii?Q?TETyufwkSBK3L4o8XlN/1jfupdOkwU5TL9APa1f55Z+4SYuvDD845iVwJTju?=
 =?us-ascii?Q?8R9aZilPSimV5fKXVTx0K+pCjhiEYQsJFJay+tk98GxMQ7ko/SAEMvc+Q10C?=
 =?us-ascii?Q?kgQ+ssWGNJQm0FEtQjtCAJqHDolsogj6/GVSxsltR9OzLt699v5JGsZ6RmH6?=
 =?us-ascii?Q?3tas9bHmrIjDHCYsmDC3X8ljs4u0dxaWSNR/4bw9f1uq2+RikfyyjCKixeGg?=
 =?us-ascii?Q?4z3Fz6EiUZoIUMzofsiT6Aj6mhhIajqlytMMXJiolJzSGJaIZx/BM01DdqNw?=
 =?us-ascii?Q?8loql8W5JXGJ1OA7auIZtzyffno72EmaJLWuxJuAs74/yZztKW1ap28OFkwE?=
 =?us-ascii?Q?yUwkDGpGUeA4x7t4gkE1lH/HfR8bqnjkZG8QvuiZ9fc8sgYwpX53BX4a5pFa?=
 =?us-ascii?Q?N9xFt42EkZ6Pyl6ca1jEey1fqz4qoyQpmZs3enwi8iILrO11p6idCbiOOJcJ?=
 =?us-ascii?Q?6OXFHUPqdQrUZ4VZMs9yJINuzcAP2s1dvJ2OTUk+SuJZAL6TmbmhqKw2DfrU?=
 =?us-ascii?Q?krXYKQUIN90xiV2Uwt/JNs2j+0Tb/ald6zxV4v2eS8pFY/wIEAqsG93z3hAE?=
 =?us-ascii?Q?lFwjo5ZXkomuOvuqOk01d3cj8aAn9Rtp/weZZtwGEcz5vclT8Np0WshrWQnl?=
 =?us-ascii?Q?/lYdYph8tf9y7l9oAa9xFCpVd5eVIp96sPBnlWCLy+w2OeUr/qM5ZTPY0ja9?=
 =?us-ascii?Q?/kTyaKyy75ddSveq1GKInID5GFtq/MHi/3SFjiLrCD7wHBR9SFhK+d890G6a?=
 =?us-ascii?Q?wjJp8ZVfCADuk7UP9dpzP/cMisTRPtnm7RGpbmuUeh9Ql7dJBx/h2BQuwvvc?=
 =?us-ascii?Q?gqQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bbee71-65de-48e6-83dc-08d9316bd71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 08:42:28.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEug6SxLHR8etDmKTmAH/wJ56otvbLCODEcUEtRLZUC/K4+9NRIDFEn+inC+1nzGnN73uMxRQZdrvfoYCRBOOO1Tah51uk+bLAMcYc9bRK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3795
X-Proofpoint-GUID: WzX8c86hSylx_A8TmiAAyeEPwh_45lJr
X-Proofpoint-ORIG-GUID: WzX8c86hSylx_A8TmiAAyeEPwh_45lJr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_05:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thank you for review comments.

>On 08/12/2020 05:47:51+0000, Parshuram Raju Thombare wrote:
>> >This looks a bit confusing. Here you're rolling back detailss in
>> >i3c_primary_master_register() that were factored out in
>> >i3c_master_init(). If i3c_master_init() is successful, then you
>> >shouldn't be undoing its things openly in i3c_primary_master_register()=
.
>> >Instead, there should be another function that does the reverse of
>> >i3c_master_init() here.
>>
>> Every function do its cleanup in case of failures.
>> And if any failure occur after successful i3c_master_init(), we have
>> function i3c_master_bus_cleanup() which does the major cleanup.
>>
>
>The point from Nicolas here was that the workqueue is allocated in
>i3c_master_init so you should have a function to destroy it instead of
>having to do that separately in i3c_primary_master_register. The same is
>true for the put_device. Or you have to ensure i3c_masterdev_release
>is called when i3c_primary_master_register fails.

Ok, IIUC, it is just that we need separate clean up function.=20
i3c_master_bus_cleanup is used here to call driver cleanup function and
detach + release devices from bus, and I am not sure i3c_masterdev_release
can be used for that.
Better alternative is i3c_master_unregister(). However, it doesn't handle
the case where device_add fails, as this function unconditionally calls
device_unregister which call both device_del and put_device.
