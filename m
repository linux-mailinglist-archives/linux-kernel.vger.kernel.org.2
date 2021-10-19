Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42694432D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhJSFop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:44:45 -0400
Received: from mail-dm3gcc02lp2103.outbound.protection.outlook.com ([104.47.65.103]:6442
        "EHLO GCC02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229527AbhJSFoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:44:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfK6mbW3DwwcTxa1E8RV5NhXqNLmUuwXI2pSBc43nPo5kDNscmzE1748dsQLL93Bgt5ejl+Rs2uTDcZjOr3RatPUiY3LR4FmXpjRQFd8hns4lyhELKSf/vUsHxEt2UqVALCe1Egmz2ipQNA9Uf4WbBdu1qpDjarkfXEuO39agFtohgdKVO2Umptro+yiaPhY3OXwX+HOFAqnD7ClaQ+/+ZyWltPNULCpTVqKGd3bZCz9Fdut7kZwR4w2PZs8mYGPnawr0geFgcHtOgvXGUTkZSOSg19xD64PE68RzEMHkeqqJDA+n8cE/48Hld+l+cMyu4xALcIUPi9/RrrOtu5Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQjs1AZiZs3f/oNPDlKamoth6vq6BbPVBTcdS+e3qOo=;
 b=ALG4SXe5JMbzlUUSQLUO059ObDhP0LShJrt44R7fQlNSirNHoCKBHW3twy8F3r6/uX6HGcjygxKDYq2YCXxQPxM5LIfydln0BD39/67RtxFmSpcmypZpWjMZdtYSiB+S7u5YHe/+gdIcget2knn+Ub2TS7s4qzK7TE5r3ljDBq3rTgGkD/tnT2qO8szOfgXKJwjuNdfn3uaQqpfM+YnO9Kjux8B50LgtxbXAh1EAi5RSuEiemwV7HnT1YTBuls8FqPXOYIHBFSQWDKuHTIwHohK8Zv5969DGLaxo6AuBU+J8S/NqYii4GBoLFLjKsj/6foD4LRrC5zNaZ3xteIaQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQjs1AZiZs3f/oNPDlKamoth6vq6BbPVBTcdS+e3qOo=;
 b=IMv/kmqTzcfWUzOUimu13SU43lW5pbNAPQRTqM8CDLNUs3g7RPlhq6n2EcOriEu5i8AVOL5wT5FdUaXsd0CVfoL0OIgsUkF6+lX/SRcQ+fBjyyLACbOo17fYKKQ2KP7fLxOt1x/uo+D4M7/HCHlAr5uGoTe/+4LjL1l+63zYE6Q=
Received: from SA1PR09MB7440.namprd09.prod.outlook.com (2603:10b6:806:183::14)
 by SA1PR09MB8589.namprd09.prod.outlook.com (2603:10b6:806:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 05:42:28 +0000
Received: from SA1PR09MB7440.namprd09.prod.outlook.com
 ([fe80::b0d6:a789:37f1:1995]) by SA1PR09MB7440.namprd09.prod.outlook.com
 ([fe80::b0d6:a789:37f1:1995%2]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 05:42:28 +0000
From:   "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Thread-Topic: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Thread-Index: AQHXwevE+jBPDZzzYE22a/VOYXutsqvZx2uAgAAKYFM=
Date:   Tue, 19 Oct 2021 05:42:28 +0000
Message-ID: <SA1PR09MB74408633E36AE3C97B4D2CA7E7BD9@SA1PR09MB7440.namprd09.prod.outlook.com>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
 <7f334e4c-0e71-2005-854f-c2d4e068ef85@roeck-us.net>
In-Reply-To: <7f334e4c-0e71-2005-854f-c2d4e068ef85@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 7a63ed15-3f07-61d2-d2b9-8c11b6d7470e
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nasa.gov;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5db77696-fb6b-4391-8ab4-08d992c33ce6
x-ms-traffictypediagnostic: SA1PR09MB8589:
x-microsoft-antispam-prvs: <SA1PR09MB85892C2C4891911AAB78A245E7BD9@SA1PR09MB8589.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q4JRbgH79Ivn+q1iS63bci6IRU5r99bxTfLD8DW6zdMUwanjMK6mKgM0VC3J89q5iAGy7r7tZREQj/XApwoO+yYzD3bqxNzorcpwXcOyGRF7pcPCesqKuTIOT1OwIJUqIVuOC0EjvoPOrEihFt/5Sveh2zv2I//mSXCsQdRxnPYTmrhcbH0AILwZeP06KTieKAWiCnGuC3yB3v+qFpn5NHnoo3av6qSi3+PPPUASCSrGB+7D1OLOYLYM0cNLHCaLAjYtpu11VxDf2WHGyzQWRuHs/YbPn/cXHY6pZDd94PH8zbvixuvKM0zqcxjzMouSaCLlIMRCD4yV5mpMx/5VaKcCgaYfH0pa0DBnDZbrSWUsPgxAFJtxgaMkM0kEMaw/5ds3HTRRU9p/2ZaR22RMrmrXpX41BmlCnNKdwaISG4zX7sPLkypxV4BlAExkQ1q3G+zRInrR+enl6CpSZbO8YYuhAD+CY91IwXTqqm5Mvl9JcGhiSFmPMikui4yS6MqVPdLjxJPf2z53MiCbrgiPOL4kKp00g2+nojUIPLv9jWv9bg61wmDzlwD8NLSSq0FUnuw0AKBCIZqPBRrYaLNDkfGU3ZhM6FNqsUm+WV9c10ejuwnYjxJGEnWtMbh+XUP6Zx/dbUX8sU0n9VxXoUXfRLlqwip6VETbQKgFlsRqMh+v3nmvPs2Gsx8GCH1Rckx5pSQYbJpQ74iuaz5e02gSEg755oVpOCNCEn+muCJcsxGqRPZjMNNAVKaIMaJvK+uK4YT1y5IQrKE19l8eQXHtBxlvxDjP6zFzr2s0a4QVMO0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7440.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(33656002)(8676002)(7696005)(9686003)(83380400001)(38070700005)(38100700002)(91956017)(2906002)(54906003)(122000001)(55016002)(6916009)(66446008)(66556008)(66476007)(508600001)(4326008)(6506007)(26005)(53546011)(45080400002)(8936002)(64756008)(86362001)(5660300002)(186003)(316002)(71200400001)(76116006)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Np7+mLGLNpB2SRGJwBMbAvOiiAmZNOIc0UzjAMXglUaMaoF9DdATRDFgsG?=
 =?iso-8859-1?Q?AzJfmcvcMBL3EJWXFIS6i5MX7cbQoWdVpF8O5HQeNtKPZ0VZPoCRfabuiW?=
 =?iso-8859-1?Q?QbEQA+1zJC8EUSqeHPFjXU7v5cZE27KqBfhCzKn6AyPsRVxEHu1m5zSwQc?=
 =?iso-8859-1?Q?ereqnzXxfc9zPHLfuNxl+ZfmG7zuIlNbVOYs4xJ6E3JRdQXyeWqeTzN8US?=
 =?iso-8859-1?Q?FC8mnXnpt1hD1GFkc5CVRlrvAZ8swGIkuq/NY8hmBPB2EIuZC5YngiAn/a?=
 =?iso-8859-1?Q?ndy2aTVxgGUtoA3sjoFnpZULWA3wVqV69RyIGqCm9OFDCshLusnpExOnDf?=
 =?iso-8859-1?Q?6yvFU5b52BWOSWvPbEK3j0iwzsMlbjkZdSUJ8vrgoHOWXWY5qgOOSe5+cU?=
 =?iso-8859-1?Q?S2cKAZBuDhduQUiJ7I1yfTTcChtKiu9hW8cq1FLpWv0faJC0gGTGH2ZntX?=
 =?iso-8859-1?Q?44iY+bPmKmMXe+ENw5VQjqAQt3sU1DVQnRRyiMPFbt16A1UsK79uYZeWxE?=
 =?iso-8859-1?Q?/CoR3g7ieMZail7EeMK6RDf/EXXRXC22wtvSwKwkvZanuHq+uOQiAvGWpW?=
 =?iso-8859-1?Q?oDq/5xGdfwejyc2AfMUNfyr7+1sRVuWZNsqE3Yj0niJCuhINVBC0w+d8EQ?=
 =?iso-8859-1?Q?F9rNH7KDj+1Hs2hhZx7LFyAb6Ch0ojGEv3QxYcE1K9LwFN0DZbZPCZFsWL?=
 =?iso-8859-1?Q?+kTZRxJ1wHkP8yFyPz7/PqSGhzxVGmytvuF1Z7bKtky9QS+HMrAt+ur3Ab?=
 =?iso-8859-1?Q?dlqC+pU/3QCKOqvfcxBEWbbjR5p03Z6lvRyL7XePOMqRm9tX7D9G+pxxaj?=
 =?iso-8859-1?Q?sSw9RZ2iyPCkk4KfqaGd+sB4lpUcuLnLpv2lBtKB+JHF8k7wpOrF7uMTP+?=
 =?iso-8859-1?Q?Cin9OetM/hIaCHmMmm+4SKRZV2rFbpjp7yGitBYx1p51Wh7hJtjii4cajL?=
 =?iso-8859-1?Q?iQ52zKUWWBnK5eqXstl/XfSknl4N5bv462KpSRQA/Y2dG08sPxcdD6w/UO?=
 =?iso-8859-1?Q?1AntjRTBUt2+AUEnoUC7FFlHHgzbLwysP3iLEpU1TfNfkewJXPhMlF0Y1l?=
 =?iso-8859-1?Q?LDIBU4ioS6QDLV+G0ablHaCIXEcWgRCMI8qRTX9Lgqs1xwa/FbKmSHfX5R?=
 =?iso-8859-1?Q?HqOCQtFV9AgzFecYv+hWINs2QTKNt1fP8/uKFfqh2zEC5Tg1V45RYJA6Ui?=
 =?iso-8859-1?Q?p9SLJEp/1QragcizR9PotqksJVru2K5aImYhFkUZ//SWEDv5ebaCweSreM?=
 =?iso-8859-1?Q?4LfcL4IxZ1t8bI5iRBHNJ2z0C5kqc2CmNIv1Go/SWgjeK4Za+b26JY9H5a?=
 =?iso-8859-1?Q?f805Dm6LNgq+ucao2Gw5MffZyhX/CuQmo+tqAT0LVi241/8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7440.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db77696-fb6b-4391-8ab4-08d992c33ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 05:42:28.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB8589
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter,=0A=
=0A=
I've tried testing the patch by checking out the most recent commit's versi=
on for tmp401.c and applying the patch. However, the temperature values see=
m to be to low <1000 for each read.=0A=
=0A=
If I'm understanding the driver code correctly, I believe there's two place=
s of interest that might explain the low values=0A=
1. In tmp401_update_device_reg16, the final assignment to data->temp[j][i] =
overrides the patch's assignment to data->temp[j][i] in the tmp461 branch=
=0A=
2. In SENSOR_DEVICE_ATTR_2_RW, the temp2_offset is at (6, 1), but the newly=
 added LSB array does not contain the LSB address at (6, 1)=0A=
=0A=
Regarding your most recent email, I will try the lm90 by changing the drive=
r tree entry to "ti,tmp451" and I'll let you know if that works for me.=0A=
=0A=
Thanks,=0A=
David=0A=
=0A=
From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@r=
oeck-us.net>=0A=
Sent: Tuesday, October 19, 2021 12:56 AM=0A=
To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hwmo=
n@vger.kernel.org <linux-hwmon@vger.kernel.org>=0A=
Subject: [EXTERNAL] Re: Potential issue with smb word operations for tmp461=
 device in tmp401 driver =0A=
=A0=0A=
David,=0A=
=0A=
On 10/15/21 10:43 AM, Wilson, David T. (GSFC-5870) wrote:=0A=
> Hi,=0A=
> =0A=
> I am reporting what I believe is a potential issue in the tmp401 driver f=
or the tmp461 device specifically. I am new to reporting issues, so I apolo=
gize in advance if I've provided insufficient information for an issue repo=
rt.=0A=
> =0A=
> The problem I'm encountering is that when I use the tmp401 linux driver t=
o read temperature values from the tmp461, all of the read temperature valu=
es end with 996 (e.g. 33996, 38996, etc...).=0A=
> =0A=
> Looking further into the tmp401 commit messages, I see that the driver wa=
s changed to use smb word operations instead of separate byte operations. A=
lthough the other supported devices (i.e. tmp432, etc...) are noted to supp=
ort 16-bit read operations in their respective datasheets, I see no indicat=
ions of 16-bit read support in the tmp461 datasheet, which is supported by =
my inquiry in the TI forums (https://gcc02.safelinks.protection.outlook.com=
/?url=3Dhttps%3A%2F%2Fe2e.ti.com%2Fsupport%2Fsensors-group%2Fsensors%2Ff%2F=
sensors-forum%2F1044935%2Ftmp461-linux-driver-support-and-16-bit-temperatur=
e-register-reads&amp;data=3D04%7C01%7Cdavid.wilson%40nasa.gov%7C2bf9c723497=
6452dd4a808d992bcc836%7C7005d45845be48ae8140d43da96dd17b%7C0%7C0%7C63770216=
1780144423%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJerajTZnSdtQgGlVrfm3IOLNpQcoV=
Keg5haNU8h1aDs%3D&amp;reserved=3D0).=0A=
> =0A=
> Reverting the driver to the commit before the smb word change, I am then =
able to read temperature values that do not end only with 996. As a result,=
 I believe that the tmp461 support may be partially broken by the switch to=
 smb word operations.=0A=
> =0A=
=0A=
can you try to instantiate the lm90 driver (instead of the tmp401 driver)=
=0A=
and let me know if it works for you ? If your system uses devicetree,=0A=
you might have to select "ti,tmp451" instead of "ti,tmp461".=0A=
=0A=
Thanks,=0A=
Guenter=
