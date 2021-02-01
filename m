Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C7A30B3C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBBABF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:01:05 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57094 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBBABD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612224731; x=1643760731;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=chEsZ+DozUGloMfzp68hLD/iA1dIlaW5VcjlDw4fIo8=;
  b=jUrZGOsZOLL/M84DjaFLmr5nOvFZ/QOxz+lTLmtStAvgPXC/wTY71squ
   jWRr1ABsvmfOC4uaoflTtWQeeelAn8tatVn85dCM8Bh7riFT+b5wflq1G
   B3RZAoXJmeuxOxTdKdk1mh2yFCcAT20aH0TAvTTue87/IUJrZdOqpvNNg
   DR3t/3SkSaj4AgwsUwe1hRYZlkt6LUd7xxzr86sL0+od88l722bgRFt5B
   /DBGQvqULg+BkDrzUSiSq1hnIUCbopCQHqpG8XpyjtK+0cjKPuYEbDVfQ
   RZ/MGR/7VNPbaYCd6ung5x1uszggByPT9Ufstj7YwgyAa37gJh73gKBIn
   A==;
IronPort-SDR: JJiu9DzH5rZpRkAdgvdrSDkLr0KfwEOuQSldQEcnmo7VRniBkxqsiRrzfE7nOeH4uckQjik4Rl
 n93s3zqBH4xzP72YYO8P5ddBM4zilpq0JKetdPeEHeL4DWsDPPaZXaoxuZo/iGjywHu8VQuFub
 gv9eIm/xkWtRHUxEiGhLR3NEJxrriisDicwH/xW14MHzqniQEdOhwV2LJRI0Ro8/pEFk9gOsaw
 KKvtvqu62C4mWtOCXhHyOLdeEUz/Ls+eE5L9v+x7TO2XYVckIjL+Yov4+WqSf9mr7SyXxnZyGX
 664=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; 
   d="scan'208";a="262934664"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 08:10:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWi8V9iOP7w6/U+IGZGcWMKiw1u8YMFFCe72yP3XzEybXHOjOEH34GKA2631mURVnWh9fom93T7p9EGj+36VQSy9Bn1fdKoBEagBIXk5lhL//ks2nh8s7+d61h8m5pCS+tJnyEV5S47Rn8RpIVocNq1XjtqSPJeqwG+b5C+/G3dNWoUt21T38qzWYtHYfpnVu1AZ17FvFHcUCRINUuq5jZ9SOgewm0RIiJF6qOHcSp1PEaLSRUCfkh4RvFGGLTL4F1Ejom8yiCCZZSjuZSs2eXScwF+JTBusOs819kCKUOhL8b2qMUDVzyJhNRdtrOmejRzsCyesJ23LxRx/x+yyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2kA+OEqDlJx+MRWnayE84h38FwM0AmYw4SNEZA0Fes=;
 b=bFywsFDLV+5Ca8gN5FkwfpdUzsGtrfCnA4f7fTDuYg+ggLk5tUQHkGcCPCaTd22EDl90myuDwfS8b10X/EKYf2C7XZQpvK7JZXfsFPsepw0AG9Y4sAc/pwjR1w4MAjfTvbImpA8poWQDLolUztDIbKnFFiUbMVjprE1E7znoDriO4uxuksRO+L8+fwe9GZqac82pe6aHDG6R3yyx1b87H3DccsbQfEVDUeCs4DaLlXe/QmF3/P4m6HdhpwYxtr9Wy7Nl/eIsqtCvQOR1ensU1J09Dh4nJdg4i6gZJ6OGAKkeveNd1nwtsfA13FrZxre/AwzO8xHLoKjXsUfgazx45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2kA+OEqDlJx+MRWnayE84h38FwM0AmYw4SNEZA0Fes=;
 b=Dn6auezsNVquj7sonYQ24atQFBegmudT6nkyRP7Eby9+H7h5UvNpYM1Grdndp1pkoxjI+WXDapVVlkqFCRpePDb0f3G6/98lh0KSRtsMiDwrCSsjnY2PYDR43kZFkrzAtD1Tjclb5gg36XQtj93UtXsKVhSf3oeM9TQS/FVU9Fk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7437.namprd04.prod.outlook.com (2603:10b6:a03:299::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.21; Mon, 1 Feb
 2021 23:59:52 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 23:59:52 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jianxiong Gao <jxgao@google.com>, Keith Busch <kbusch@kernel.org>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Saravana Kannan <saravanak@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marc Orr <marcorr@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Erdem Aktas <erdemaktas@google.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
Thread-Topic: [PATCH V2 3/3] Adding
 device_dma_parameters->offset_preserve_mask to NVMe driver.
Thread-Index: AQHW+MlMS+CdGrPDf0+u8sqUqxCqGQ==
Date:   Mon, 1 Feb 2021 23:59:52 +0000
Message-ID: <BYAPR04MB4965AAC6C59013D475093D9486B69@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: debd626c-7b9f-428c-56d5-08d8c70d7758
x-ms-traffictypediagnostic: SJ0PR04MB7437:
x-microsoft-antispam-prvs: <SJ0PR04MB743706916B77071E77B5464786B69@SJ0PR04MB7437.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhARgJgCpZMpp/UQ+xk9H8W9JIOaKqlPx1ictHtcm0ecnWZz0Sal3lNH/opFnExhiiY9DPc4IXhnWOhiJDIWUpddVrGIYCxdHoecTjVMm/WP9SoSGc8tmpYBPG0fAieFjCmsSeO480POkWMlxfUOKXrkxCx8HEy9znPqEBT9s3T4W6r+J9KIGc1GEblI0y7YfIPzV0vetvDwlLE7KKW86tWo+SjLXv2ZNzNKZusHFofG6so0PlXzMF9RDquK7fDKzgwSO9hkmf+QYIkE7c70D0LVAULX4VxS0DPrS/iLe7H0M/dHucQSJey4ShStgmovUmbFTa/Uq08J90kuMjzTR49wfLhtFOztaRKonli1F4iMjbZ3P0Z14bhzmq26p1QLmPeUNvRl/nHJ9hKO/rN0HaT5dzwX6LMmNaVjnlagALNUaRbZtg2CS64piSpdDwr4Uh0jpNIvbo+y8aqgh6rOvw8m1SCjPePAMmo3KfisPtXzVUndvBTu/BEr6jbSrAF5l2ihB3W/AHdzZzLibG4XFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(33656002)(55016002)(5660300002)(8936002)(9686003)(86362001)(4744005)(66476007)(316002)(64756008)(66946007)(66446008)(186003)(76116006)(7416002)(7696005)(66556008)(4326008)(53546011)(478600001)(2906002)(8676002)(52536014)(26005)(54906003)(110136005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?b8EdK5PM1hLtuy9eI3NTxUPtEX5Z/d8hUcnxC3Qmr04c2C5s9mB0tGdGHq/f?=
 =?us-ascii?Q?LUNopHehhpXUrNZT5+4kV9dE3uqJ3vfk6UmSZNoB+L1Al472A104/0cRUiOo?=
 =?us-ascii?Q?+U60J5iOLsfF4/zO4RLeNQZ3mR/sQTa/utJcydUjunAhjCwet0KADt7+mB5s?=
 =?us-ascii?Q?wdCgkS/HyfZeXYGe+4ISVULwrL4WG4PMkH0s/SXHEpxsnaoNoYBvM8OCVAaH?=
 =?us-ascii?Q?CGnnCAJ243SgA8XsGJUpSfFrpKkdvLzsIHYgvfwDTgRIFXq4diw/FyuATjyN?=
 =?us-ascii?Q?E7P21ok/hnOl47syIh2MIV702rRaoQJD3XTq24sMwgtrDuZjzfx2K3ht+Na4?=
 =?us-ascii?Q?eQIXdqeEP01wh9Y8+pMchhvZ6EC5g/DPK6pJWp+g/4EJsvyYW7I5edcwCg9+?=
 =?us-ascii?Q?9detoMdVttP1TAcznjtorABlzRAUY5QxVRjKnevFwqVPA477uidWypY736dQ?=
 =?us-ascii?Q?/mfT2S1Ddn4nZu0ESn42ecwFRgy6SCdNxwwuvHN+zJ/IrMiaUOwR8Bu/I9sW?=
 =?us-ascii?Q?b09xPj7ivCkgO9oEyQ/XgDz+5ysbluYFFMmu5yvjEXlxIrdlGCX/TXwdBKA0?=
 =?us-ascii?Q?eIlC4xb+Ry+BfztN4Btb8UDa930BwvQ9hFq1Llw4gPFIM/L9bin4LJlXmjFH?=
 =?us-ascii?Q?WdEtv5UEo7qraBHmN3Uj4ZlN/lskAOXho1bG5Z1YoyR1u8j5nWQkfYRhFJxs?=
 =?us-ascii?Q?1HE4LkpcNe9lHe6ssXjHzSZkcMi/eIFR+qrEDl/gO+GZUEaJikcLhwT1Vjk1?=
 =?us-ascii?Q?Mxr3La/oHu2ogk//iJoKDXGmDk1TTIA8gLkX9EdDJPwhusE2CrKXCvjzxVRE?=
 =?us-ascii?Q?GWRnsAr/XSr7Bcp4rlcb9So7K84gv/2ppgnO58dgfPF/XIrezWSquQBXo8DT?=
 =?us-ascii?Q?P0NOwf0bjK97M1bk28KLd1vw/lJv/9YbvDwvIbRCFwQVmS0rgDMVc1/u5bVy?=
 =?us-ascii?Q?ND54j9UYHuvUuMTA74yImXEi80cUkeAv1z9sl3OO/n7YdzWtumA1LIZ7W/Yt?=
 =?us-ascii?Q?275frz1Judhsgo5aoAXwrrqOxw2my8Hv3zR+1xiCpBpmK/hu06HMSuWfIbHP?=
 =?us-ascii?Q?B2r35m3MFpgK+egoIZaRDisNCAedUA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debd626c-7b9f-428c-56d5-08d8c70d7758
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 23:59:52.2146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEHmV1gOVYFF6JDyQvp1qwLBEIQJFR4JjA9XR2lJ/nPbpuoHpryM5Lz8N3Y3qEFDWI6/wFSCatVo3j0ohB9w1iXax4nEqNQnaR2+DUnIivc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7437
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 13:27, Jianxiong Gao wrote:=0A=
>> Why is this setting being done and undone on each IO? Wouldn't it be=0A=
>> more efficient to set it once during device initialization?=0A=
>>=0A=
>> And more importantly, this isn't thread safe: one CPU may be setting the=
=0A=
>> device's dma alignment mask to 0 while another CPU is expecting it to be=
=0A=
>> NVME_CTRL_PAGE_SIZE - 1.=0A=
>  I was having trouble getting the OS booted when setting it once during=
=0A=
>  initialization. However when I rebased to the latest rc6 this morning it=
=0A=
>  seems to be working with setting the mask on probe. I am still testing o=
ut=0A=
>  and will appreciate any idea what may cause the nvme driver to fail=0A=
>  with a single mask.=0A=
Based on the Keith's comment it needs to be completely avoided in hot path.=
=0A=
=0A=
Did you get a chance to bisect the problem in the rc6 ? We need to know the=
=0A=
root cause otherwise it might happen again after we add this patch.=0A=
