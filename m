Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8837A788
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhEKN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:27:54 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:15722 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKN1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:27:53 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2021 09:27:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2102; q=dns/txt; s=iport;
  t=1620739607; x=1621949207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GMcVz6oa8XHZRJ8L1UxMsj0eQ1hXvwcI+IoSNGH+Lj8=;
  b=aOxh3XdwXS/KZI9MeSF7eeCXdFiqtvp9UPknsOidNXvo6XzKbQ/BYHt7
   ZhJ4ojobpAJ+W61OrP5rbHN9O1xumZVY5uH9Xo2eoU6uY+7Eqf5//1/n5
   rcWT9Mx6pbAh1jhKj2crmlMPcvtLRGiqzazYkRD3OaW2ea4O+DOoEFjz3
   A=;
X-IPAS-Result: =?us-ascii?q?A0AZAAAohJpgmIkNJK1aDg4BAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IFDBwEBCwGBUlGBWDYxC4gEA4RZYIh4A5VKhA6BLhSBEQNUCwEBAQ0BAToCB?=
 =?us-ascii?q?AEBgRYBgzkCgXICJTQJDgIEAQEBAQMCAwEBAQEFAQEFAQEBAgEGBBQBAQEBA?=
 =?us-ascii?q?QEBAWiFUA2GRAEBAQQnEwYBATcBCwQCAQgRBAEBAR4QMh0IAgQBDQUIgmmCV?=
 =?us-ascii?q?gMvAZ4MAoofeIEBM4EBggYBAQYEBIUwGIITCRSBJgGCeYpnJxyCDYEVQ4JfP?=
 =?us-ascii?q?oQLGwQcg0uCK4FReQGBDoEGPnqRUoJ3lU2RcQcDgxSdVBCDV6FbLZUFghahX?=
 =?us-ascii?q?gIEAgQFAg4BAQaBVDiBW3AVO4JpUBcCDo4fGYNXihhFczgCBgoBAQMJfIlNg?=
 =?us-ascii?q?TYBgQ8BAQ?=
IronPort-PHdr: A9a23:UvSagRLrnJcVNDrqTtmcuZUyDhhOgF28FhQS9Z4ujb4Icq254Z34M
 ArS6eg+xFPKXICO7fVChqKWtq37QmUP7N6Ht2xKa51DURIJyKB01wwtCcKIEwv3efjtaSFpB
 sNdUFZj8ze7OFJLEdzyIVDevy764TsbAB6qMw1zK6z8EZLTiMLi0ee09vixKwVFjTawe/V8N
 hKz+A7QrcIRx4BlL/VZ9w==
IronPort-HdrOrdr: A9a23:nVt7ea4iGMc5mpqPeAPXwQmBI+orL9Y04lQ7vn2ZFiY1TiXIra
 6TdaoguiMc0AxhJ03Jmbi7Sc69qADnhOBICO4qTPSftWjdySuVxeRZjbcKrAeQYBEWmtQtsJ
 uINpIOdOEYbmIKz/oSgjPIaerIqePvmMvD6IuurAYOcegpUdAc0+4TMHf8LqQCfng/OXNPLu
 vk2iMonUvFRZ0/VLXKOlA1G8z44/HbnpPvZhALQzQ97hOVsD+u4LnmVzCFwxY3SVp0sPIf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi/ISNi7nhm+TFcBcsvy5zXcISdOUmQ8Xee
 r30k8d1gNImijsl1SO0F3QMs/boWwTAjHZuAKlaDDY0L3ErXoBerl8bMRiA0fkA45KhqAj7E
 qNtFjp6Ka/RCmw7hjV9pzGUQpnmVGzpmdnmekPj2ZHWY9bc7NJq5cDlXklXqvosxiKobzPPd
 MeQP003swmPm9yrkqp9VWHy+bcH0jb3i32D3Tqn/blmwS+sEoJuHfw9fZv1EvorqhNP6Wsz9
 60RJiAuos+O/MrUQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,290,1613433600"; 
   d="scan'208";a="712785291"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 11 May 2021 13:19:38 +0000
Received: from mail.cisco.com (xbe-rcd-007.cisco.com [173.37.102.22])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 14BDJcca026891
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 11 May 2021 13:19:38 GMT
Received: from xfe-rcd-004.cisco.com (173.37.227.252) by xbe-rcd-007.cisco.com
 (173.37.102.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Tue, 11 May 2021
 08:19:37 -0500
Received: from xfe-rcd-003.cisco.com (173.37.227.251) by xfe-rcd-004.cisco.com
 (173.37.227.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Tue, 11 May 2021
 08:19:37 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-003.cisco.com (173.37.227.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3
 via Frontend Transport; Tue, 11 May 2021 08:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXAb1Ll7IF8Ndur+XRRXgtYlue0Khq+YTs6esarYMla+xv7QCr8vzrJfY9gdwh7IyY5BC7nNUjop5EIUibQoUcmRpYeRcReCW+ksOtwocE2mLwGREryl+kFG8OSv1p7aWnUvyFANBsnm7x0rOV1S1i/0mJu3GGFjfWe6wuWReJJHb5KSVAT69/2eNiSmDuyaq9pIOvF/eFjm5T+nPQY/gCoVirfEAvsdGAghK56Kuqt0RZItrzrpdHMitIuPRbyB23RI9zQqSEXnwpvgxl19Ujn3bscwV4h5RjM42vXpvgarfJiolwOoN6rWfcXQ9Kih9i5rfz1g4u+pF50q4BDDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zc0xlkCTHbswHaaovKrInPXtkCnlLqX228kkee1+zc=;
 b=mZ7meSKX5cRRnP8kpJXAqUDmTEGMa+cC2p3/aT8fuXrLZ4ooct4tcGnCMAcnc0RModMZ6p4gAFN7bGQKN0q9koF/Y4ZDkI/5m0xZEVf3Fwkc2GhdvtLcBRlWFxDo3NAP4pKZQNepAGoDUqvA//wRgnwF2WfFvredGX9fWeYIisGkdwbIrgNu47PjBxueLhKpjt1/K6v2/vH8/unaPt61NO3GRzoAySLasKGkMjH8IwnbZ2363MjykWyJtqtDoE+BbhN0PLEnaNTVLzwJb+DaAVHsM55TM2EapNposkslJZioR23N9W8KWqn3QQjSAQEflKrmXwo7aMF3Ut4YGPz11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zc0xlkCTHbswHaaovKrInPXtkCnlLqX228kkee1+zc=;
 b=wDz3pzF8ABN0qiKrDLz42CdbGonXg9pZTtL5lhyr5/C4tvp3XfMYWTmwWU7NE2j1SKKEpvcLu5pcV1fu4SwQb6ILuXUqMNze/WYCJcyxM7oFJdA4zSaP7FVTmazyRJ/RsVrAlWNoZELHDnopaZSDEI7rs5yGA+XucEByu7f9r+k=
Received: from DM6PR11MB4594.namprd11.prod.outlook.com (2603:10b6:5:2a0::12)
 by DM5PR1101MB2234.namprd11.prod.outlook.com (2603:10b6:4:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 13:19:35 +0000
Received: from DM6PR11MB4594.namprd11.prod.outlook.com
 ([fe80::3c3d:41fe:af7a:684d]) by DM6PR11MB4594.namprd11.prod.outlook.com
 ([fe80::3c3d:41fe:af7a:684d%6]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 13:19:35 +0000
From:   "Gopalakrishnan Santhanam -X (gsanthan - Altran ACT S.A.S at Cisco)" 
        <gsanthan@cisco.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Daniel Walker (danielwa)" <danielwa@cisco.com>
CC:     "HEMANT RAMDASI (hramdasi)" <hramdasi@cisco.com>,
        Christian Engelmayer <christian.engelmayer@frequentis.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fsl-usb: add need_oc_pp_cycle flag for 85xx also
Thread-Topic: [PATCH] fsl-usb: add need_oc_pp_cycle flag for 85xx also
Thread-Index: AQHXQ2WrrZKg9g8qfkiceh4bDTF8bKrYSF6AgAYAVFA=
Date:   Tue, 11 May 2021 13:19:35 +0000
Message-ID: <DM6PR11MB45943EA963111B0FE6A85C1CC8539@DM6PR11MB4594.namprd11.prod.outlook.com>
References: <20210507172300.3075939-1-danielwa@cisco.com>
 <20210507173659.GA784066@rowland.harvard.edu>
In-Reply-To: <20210507173659.GA784066@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=cisco.com;
x-originating-ip: [72.163.220.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 500e1113-c1b4-4b46-42d0-08d9147f6bd6
x-ms-traffictypediagnostic: DM5PR1101MB2234:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB2234BE2B7C78FEB22F7922FDC8539@DM5PR1101MB2234.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YxenMK8MMqZzwcdf3r5OsfbefaXRIcs6um9B8zMTXEKlOohyIE/Shfr7DG//zfQX+clL+OEsjsPnQN/nVKpNKLOJ6NTOT+G9M+CU9acImBkcZDBAFjU5OalZ5n6EVasdNDz4XI0X7Cn8V8+ZkVIlkAZg8pn1G9AbO/uI2EaK6XRkwjh9+aIBsF900nUu+s4NKc4aju6NTdQmyNwivT1HhzuxUTJOw2lV6J8fxivVw/wJWxCWXZ97TGXzljRYypxcsACzTOT6AoV5dHUiOYaQ/KtmauDycSKmRh3xNBxZgiOXLV9ihcmSxsGoNPyhKsFBMgyPN0UoKLMNtTRcOYl2GeSJ32gJSqOCWQ8DUjoZkPBiaDCqKWrQ3m/0jSngJEeicVhBg6LQHJhQ917Zk1PF7afdjTJyUYiFjqpuXaor3XrQofO5aIYjiyVLHnmuOp3PKbx2vevZeJHYbq+jIARWf5sB+Ir+nV+zoXYuHck9dOB+7Iy/tmYx7jUhQhR95+2GDKrgm2Ht8mukE/3ARzkOdqCbyK/9cXjnUwMpwD82cM9VtqaeZyhheQxiil71hzbkAjmpx3z3zEcmn7cbQTGv2oxf9MBEx2wb0JNhelKYRk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4594.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39860400002)(376002)(66446008)(8676002)(64756008)(2906002)(83380400001)(26005)(7696005)(86362001)(66476007)(33656002)(66556008)(110136005)(55016002)(71200400001)(6636002)(66946007)(76116006)(54906003)(316002)(186003)(53546011)(8936002)(38100700002)(9686003)(4326008)(122000001)(6506007)(5660300002)(52536014)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hismizQbP+ea9bRo03j8Ta/gQ8vjSSBxEjneKIa/WCBJC2SNvMTEYnomZFKn?=
 =?us-ascii?Q?CcYE8/JWgERuxwEbT9M/0P3M6Ox0tMCCyL7WfNrE30hPPGq8zFqrX4c721ov?=
 =?us-ascii?Q?cjXFmlN148ExoCWd39k0dwgJ8iQ9Sht02r+8x0A6szL/m0O6r3zugfn/yPYi?=
 =?us-ascii?Q?8m0DsmaK+yCkrbGuuvmjA1we8vRyAy2cYq1v9Tj6Gm5gMWL1W/kcnRnzryfI?=
 =?us-ascii?Q?YLhFiK796btj4ny474QmMqwRzO8VXIcFrrxR1cj1px5UVXip+kn99GFJp30d?=
 =?us-ascii?Q?2P21Nc5Cxiw1wJtz0Dj1rAqjg6PgiwQgKHAg12IjWnkJiaW7zw4kgZEV+OQt?=
 =?us-ascii?Q?XfAfwlmP13bKqaEKShrDCgZCYTyXN5GFVwxpp+mVTOBjkoMajvGAXE7nmntV?=
 =?us-ascii?Q?TJf8/CZVtirVbdVk78v5jLVL0L2/f+IALS9Tnvc7Zao8f4rjMTY4XNPU7pAk?=
 =?us-ascii?Q?PSyrEnNozBMDQna+8ihblSyzVxSv51N7HoQuIBrH2Su6issjPVLji6tMmlSP?=
 =?us-ascii?Q?eEK6s3ByIky9dE+JZqi18JGXqTlfU4gHp7PadWFMY8abG0+Zp/9hV/JBKQ0x?=
 =?us-ascii?Q?lrZzKrM9iFHyfSs9Bct6OdLH2cuZjaJV7Jq1ucLvXhLYKc63d0NKzFhQmDAy?=
 =?us-ascii?Q?PGuc45O8o/rMUxLrCY407JWapeiDNkQGxtpE2n0e4pIeniK6rCMmLB3oUKzB?=
 =?us-ascii?Q?jdQ8Ks2j6cAUNeKFUfNRcolowRI4rDXNtwu5/Mlv7WamGV3Kpne3UfvPzAOb?=
 =?us-ascii?Q?wNJtm0ARG+K3+6caj3su2UPydx08iRhs1AdgzByR/mFKU1HA09eTQcRseqVs?=
 =?us-ascii?Q?SK3/ROcMcyFx6Ebq6ft+eKk6AaGj8BUzNFn7XdZObSHAoaupUqjvq6WtfDQY?=
 =?us-ascii?Q?aaAdnqMP3BjpCtVTyCzD4i39NIawnLkkuJItBFROGgjZjTqHxAltak8NPu31?=
 =?us-ascii?Q?G9G7EKlEfeteR7QKGKXLcwagZrDNcPKogQmfSwYwqQEXfsI+V/+hbq2SWNAF?=
 =?us-ascii?Q?fp4yhDzCT0rGBBJdSMtp9GRh9ZaSDRpZ26tkUUlJqxeypOFi9Jsjnij/Zcwo?=
 =?us-ascii?Q?Wa0rylJUMSaT1hz6/aQJVtYCRPL1HGLn2+8aDbtOWVmEiRsvHi+QlxqCY/+2?=
 =?us-ascii?Q?vDbDK44bHfTF7431BdmzLMEiWTyd37PsD7bbARPChaBLKDUR/16yavANMbk9?=
 =?us-ascii?Q?W0/TONl6OI2X2A20gF44TeRoLiCPJ+6g1sLWjPnkE7NUMN3VfSjhjcXkPz36?=
 =?us-ascii?Q?jBduVyNELO+l+mVTF0/IC4lLMGMILbHKIYC9jrcKh7nUAUMfGT7bsk4QqVmP?=
 =?us-ascii?Q?ytjF8GwWwIxtkcdOA8ba5LYl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4594.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500e1113-c1b4-4b46-42d0-08d9147f6bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 13:19:35.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RooTAtgMMYBkOrGkK52aeMD+/C+OpfkSwOBGZDM7/bZ3xneC+9WKDUOKzaEfNfPGueErapIsiCgRx7/Qnpd2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2234
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.22, xbe-rcd-007.cisco.com
X-Outbound-Node: alln-core-4.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan

Thanks for the review !

Yes we have to change the comment as well.

We will update the comments and resend.

Regards,
Gopal

-----Original Message-----
From: Alan Stern <stern@rowland.harvard.edu>=20
Sent: Friday, May 7, 2021 11:07 PM
To: Daniel Walker (danielwa) <danielwa@cisco.com>
Cc: HEMANT RAMDASI (hramdasi) <hramdasi@cisco.com>; Christian Engelmayer <c=
hristian.engelmayer@frequentis.com>; Gopalakrishnan Santhanam -X (gsanthan =
- Altran ACT S.A.S at Cisco) <gsanthan@cisco.com>; xe-linux-external(mailer=
 list) <xe-linux-external@cisco.com>; Greg Kroah-Hartman <gregkh@linuxfound=
ation.org>; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsl-usb: add need_oc_pp_cycle flag for 85xx also

On Fri, May 07, 2021 at 10:23:00AM -0700, Daniel Walker wrote:
> From: Gopalakrishnan Santhanam <gsanthan@cisco.com>
>=20
> Commit e6604a7fd71f9 ("EHCI: Quirk flag for port power handling on=20
> overcurrent.") activated the quirks handling (flag need_oc_pp_cycle)=20
> for Freescale 83xx based boards.
> Activate same for 85xx based boards as well.
>=20
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Gopalakrishnan Santhanam <gsanthan@cisco.com>
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  drivers/usb/host/ehci-fsl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c=20
> index 6f7bd6641694..c7d74c1a23f5 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -387,7 +387,7 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
>  	/* EHCI registers start at offset 0x100 */
>  	ehci->caps =3D hcd->regs + 0x100;
> =20
> -#ifdef CONFIG_PPC_83xx
> +#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_85xx)
>  	/*
>  	 * Deal with MPC834X that need port power to be cycled after the=20
> power
-------------------------^

Shouldn't this comment be changed as well?

Alan Stern

>  	 * fault condition is removed. Otherwise the state machine does not
> --
> 2.25.1
>=20
