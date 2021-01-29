Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765B9308BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhA2RdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:33:14 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:43746 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbhA2RaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:30:05 -0500
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10THRJdg011541;
        Fri, 29 Jan 2021 12:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=iWJzVg7DD+4FjUK6r3BSEeiRmnPpqkzDgqqnv9QZWlM=;
 b=huv0xr6r/UoF7FwBD1dQ6PIKagvdIf82vbbDcrRhzlmEFgYErIlTxyITLqwbXMC11qin
 wWdlV7wrsd0hFb3c/eddyhynvd+9IJn6z+2Ohlibo2GnDxk8BEpSErJde9EG+tzHdj4E
 w44iteAs1PbaIXFCAzh2Otp7CIN7FoRrtesqZ7tTQsz2FkP4UAgX1kFSu/XOmF2hmjlK
 J6TLMtjnTj91CnQAI/uCSKANTzkJhJTB1HQDm6MXfpEciCm65d6OKEkskBeBm0+wLJIK
 lmVXzXsuo98DyheQrGv910tUxlJA0k1EogktFIwokRCfW5m2IOiiAISklqqD5icvSlbG ow== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 36cb0nt8kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 12:29:15 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10THOo6l041109;
        Fri, 29 Jan 2021 12:29:14 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00154901.pphosted.com with ESMTP id 36931ynhtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 12:29:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvEwWQlCwpu8x/0bnGX4Lk78ERGUa54KKKynk75jqGnE3aZiIIE7ORQ29xImNjf5cNB+wnRf4pGbWWgvFQDYVJ4rAtg7w6fDP2ndiSDsJ+xkuNSs7+NoJVfGTcSq1zVLyW3XN2/fyXAHPVepsuLqdE8KxwQzJMPJgkS8iWCW3/ECBMUt+c8tJicL2BWUosZTcH59kFImZ+epklGKC4DD97pDEToj0j//XQImnKGJx+RMS0ZUcUeqIORLj9Cnqkdr8eje/S7WR7xc5bWe+PPtGi+NA5PdfmtlNh4/NEv4cT99P03OU78wgodGY08c0OfRIdQowqWitbFIv929nYpZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWJzVg7DD+4FjUK6r3BSEeiRmnPpqkzDgqqnv9QZWlM=;
 b=P+kLzZuDIR8Lv6PH5QhaLauu+2ZXC5eLFGNQYqbdh6GxNDjI2stAEgQOdrT3aF9F0xXAokvzcXRZpByA+jq2JKnWNyEWC57ceozsy6OW4w+UQ0ZiTZ1z/OCADl4kYy2oOBBEkxe6OYtgIzDm3LieFwZbjsvWY36T4+ZlyLcWr8suEWI17/QrJFKGmj0qR6ltnDfzmNa1cCZluovawE3OlN15Tol0kcDZk4ENev0VaN4ygwCOnDiDBgRoLfiQU1CPjnlt6A3W0jbJCQGvzNzIbEO87TNIwBMz447xxLgOC/KQvcC4zS2Crj9NB9LS0tbi1+ddL5+qgzEpWW2BB/j67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SA1PR19MB4926.namprd19.prod.outlook.com (2603:10b6:806:1a6::18)
 by SN6PR19MB2270.namprd19.prod.outlook.com (2603:10b6:805:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 29 Jan
 2021 17:29:13 +0000
Received: from SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50]) by SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50%6]) with mapi id 15.20.3805.019; Fri, 29 Jan 2021
 17:29:13 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        "Yuan, Perry" <Perry.Yuan@dell.com>
Subject: RE: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
Thread-Topic: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
Thread-Index: AQHW9mP0cWNChGE38Eu6VwA6sJM74ao+255w
Date:   Fri, 29 Jan 2021 17:29:12 +0000
Message-ID: <SA1PR19MB49265FC286F5D09F88F2A054FAB99@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <20210129172654.2326751-1-mario.limonciello@dell.com>
In-Reply-To: <20210129172654.2326751-1-mario.limonciello@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-29T17:29:09.2447069Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=f2e2fe84-58fd-4854-9e04-f2330771d27f;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c48815c1-5c7c-4251-7106-08d8c47b6530
x-ms-traffictypediagnostic: SN6PR19MB2270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR19MB2270BB858EEDA3B3146CD1DDFAB99@SN6PR19MB2270.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tccFACtrKLCEYFmay+fH0ZhjTjzu00e52aoCrDITuupY36aa0mkJMewSDAVr50jDNMzx8cgS+5Za/kmpOSi+aMgTgSlUYg+O6c6Aex6ADlS27YzGTzump7ZwiOJOQvcuETE+wEzFabL1ZCr62gk2MWmN9XTuAVQgl9Y4L8Apd73phksMp6uJmy95tXjFVNr7lv5k5eslbnPaixlCgEY8Moxp6ZMAY/PXLorOBSbTYq7au/S8yWGhVwQLUO3/zvVqSAR6RrStO1/x3W9gjbveWyPd9Ah2ZqmeZM+kUcOVBMDo+tlS3F6AI6UucFvXYzrvzqLwRPFmau19kBJIoOl75l5+dPFfZtY+AJvZynnc4FR33IbgU8TjZMxD9j9GnvFHwTYex6wRYlrzdoweWBiYg9WFkxiZ4bRqJRb+cPI8UP833XPsPiPbQAQGNxHYs4FX2hGMl5uVlp2geKVzIsnHCdPpRv1tI5HSsIG986hKTs14dIgfwOeoUpOq1lnEN1C2Fs/jvWbCy8wZ/aLYZht26A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4926.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(7696005)(186003)(26005)(786003)(6506007)(54906003)(9686003)(71200400001)(8676002)(107886003)(33656002)(4326008)(316002)(66446008)(478600001)(86362001)(66946007)(53546011)(5660300002)(52536014)(64756008)(76116006)(110136005)(66556008)(2906002)(8936002)(66476007)(83380400001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QrxI4NZCctUEKGz7uj5khozqentd/Q2rE7Asg5E3rf2ElrzxetRxZlBueRE/?=
 =?us-ascii?Q?L2hhc9Lm3YldAPzhn5dpoqNDtJn0RFbzEYbn3bHrO//H0/k/QDMrj0jFMl5S?=
 =?us-ascii?Q?lrhi7gLseWDEpWe/AQ7t8d6EVZLwSjqVV0SbWUdVd9EwdsGNlWgZDd+T6/c/?=
 =?us-ascii?Q?aiFdlMawKUwN0TQsjkRqWBJzQPznpIwq8cldxDxDlUSi7yZ6xIH4jozr70cn?=
 =?us-ascii?Q?N+SB2cYsM6zywSeg/sf0laLonENpbWsgPHJlvfMQrG8d2nHze2d1iCRSzyf7?=
 =?us-ascii?Q?bhRSOS3W45T4njLDmXO4+t5Z8kGg3z6Q1AdLnNXrxg2D4/F2ncBj2cc/UrwO?=
 =?us-ascii?Q?MqrI4/k8t6GTNoMRH/QdXWXUYIIrJV/D9i/Gbyg1jkI9p2WEL3TaXOknyNRe?=
 =?us-ascii?Q?QBOcDmgDNtFuY9dK2gcvV8zwEtb9qP0x+csPLiERQp7bjjVpZFXCMpGu69t9?=
 =?us-ascii?Q?/mzScyRWhcgyiQDTvnzbnyT9omsM9pSfpSpApX6azocPthPeytGJQmPNn0GF?=
 =?us-ascii?Q?JDRN7d0/quI9lr3xnkFAuhjPqfn/Gqkv4LhVFanGZC6j3WTYnTyqPKamnO4j?=
 =?us-ascii?Q?Vey+LE8hd6frM76H+B2HfZw6Ea7eJYYQVSOOxtYyakDGnNSYr36I1pOT+6SM?=
 =?us-ascii?Q?tO8bX1m/pISQJPUtK0iWllqQZs7BswQxZSAaoW/bosQHfDzw2VwiNMM9me6S?=
 =?us-ascii?Q?rb7ziNrsBaqQqITZQXdBXpCZLyoY2hmdfhare1pkh2+I/OlnE+6nHTknE8ID?=
 =?us-ascii?Q?4OByRQ0ZzvCpXOGcnYcQVdChiWoszWc8lQjWeoz0UnrRgWqaFZE6x8zt7j6J?=
 =?us-ascii?Q?uwxUFbudFn0sFgLWNjp+9XtS52Z1L4g12/C5TJZl+KwcOK9aS3r6HQDnk0o/?=
 =?us-ascii?Q?rwuaN1kvJaOmY1C0NIY/PFYrbTivY/O/fpnDJceJ+k4q4GzfQ/nmlcsqT5OK?=
 =?us-ascii?Q?NTjPYGdaLpCxdVfqV9PF0dBJpoDqICD6qQrigRLTKdIpSvCxaPyGOkLFa1YW?=
 =?us-ascii?Q?KixUpjByRSKm8fIFjXoZp/XixVuEJAehrcV7zxlwCZiJkPonlgoIfJGViZAX?=
 =?us-ascii?Q?P6hOehkN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4926.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48815c1-5c7c-4251-7106-08d8c47b6530
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 17:29:12.9505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUoGUQd4+O7ZQJ5hk0i+gq5TeeoereFvlRGDQcxJJHdL+04eqbMYoPG/CNQXKdneEydnbq/iLUK5eFAOcsFP7CWilsdQTRSfaOFqlyrcxj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR19MB2270
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-29_06:2021-01-29,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290085
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Divya, +Prasanth, +Perry

> -----Original Message-----
> From: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Sent: Friday, January 29, 2021 11:27
> To: Hans De Goede; Mark Gross
> Cc: LKML; platform-driver-x86@vger.kernel.org; Limonciello, Mario
> Subject: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer derefe=
rence
>=20
> An upcoming Dell platform is causing a NULL pointer dereference
> in dell-wmi-sysman initialization.  Validate that the input from
> BIOS matches correct ACPI types and abort module initialization
> if it fails.
>=20
> This leads to a memory leak that needs to be cleaned up properly.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/platform/x86/dell-wmi-sysman/sysman.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c
> b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> index dc6dd531c996..38b497991071 100644
> --- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> @@ -419,13 +419,19 @@ static int init_bios_attributes(int attr_type, cons=
t
> char *guid)
>  		return retval;
>  	/* need to use specific instance_id and guid combination to get right
> data */
>  	obj =3D get_wmiobj_pointer(instance_id, guid);
> -	if (!obj)
> +	if (!obj || obj->type !=3D ACPI_TYPE_PACKAGE) {
> +		release_attributes_data();
>  		return -ENODEV;
> +	}
>  	elements =3D obj->package.elements;
>=20
>  	mutex_lock(&wmi_priv.mutex);
>  	while (elements) {
>  		/* sanity checking */
> +		if (elements[ATTR_NAME].type !=3D ACPI_TYPE_STRING) {
> +			pr_debug("incorrect element type\n");
> +			goto nextobj;
> +		}
>  		if (strlen(elements[ATTR_NAME].string.pointer) =3D=3D 0) {
>  			pr_debug("empty attribute found\n");
>  			goto nextobj;
> --
> 2.25.1

