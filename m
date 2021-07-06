Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A30C3BC7AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhGFIR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:17:26 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:34816
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230257AbhGFIRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:17:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+xJrettdEO/CYbzokUGcp5LfVmh0wPRW3/Y5HsZe6aEeDEIVhxOuuFhEuLopm2f8gwwCcRIrLhhRSpU670RLTvvsxosBc7JzLXE3oEd7Qn5uqTSeRgh2S7iY0j4edhflxmynJ9KWFqlFTLOvm9qq99vCi6q1x3UvI4fcaKO+dU0W7823e9hQseEZPWHdXqYOTMDuIs6H33osdRKNGgeEzvYlaanP7qNwjMpHfhHm/tDRQWO8sJyW7ceeg8+FEP4aF6szi88xGkMzZ8IwDdfnW5mcNn0iQWeHtMmhBKO8E2CttxlqG2c7yP+xVb9ejq3/VMEsjCwzIbvIHExtgPywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f34brGayqZByRY+wG15/ZeRGQqvAO7gZkUjxauK1zWs=;
 b=Jf9Lp5ckEGqUJzErtf5PRWgfbzLYN8FStvW42pAlelo5KdhA1SEI/CKY67rc2lQ0v5j3UjuQ0YEQZ/PRDcIzXbBh2On1aB6KFZJlR9cEZyz044G2JvbdLgM72qgvlVpeQXr3V6TZPy+aP+CyOujipYM6//5zWV3XyTPkrvWQJ792LLg0YOT1+WawS4m8qgI6mC/OdkXQ2zR+SbWUYFIasXwOgPDoeWGjwlcIcXPV25RS2ez/fYIThF6ZvhdBs5AEHAOeeIf+gWu7QT+YuOsYvkeWkt9SpJ7sOx+yCtdWZov64uBI9x5isvG++qEWBXplPi7kTB4g8xVV6CZvfv6Ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f34brGayqZByRY+wG15/ZeRGQqvAO7gZkUjxauK1zWs=;
 b=mBo0kJiQtjvl5JhRfBsD9aH62g9t53rVRbLDJc6bTmhyUjVm7XNo7A3dB6HAVjWEESZzZbXRO8jq/Awnfg3V0Rp+jnoisgIaTY3Ib/aXKDvybh620QP6HfVdeQy/PqZ/7nR9IbIrnzi5dET1WomF2Hi/ONIJ0cHBotL98KxOLyk=
Received: from BLAPR08MB6900.namprd08.prod.outlook.com (2603:10b6:208:325::21)
 by BL0PR08MB4580.namprd08.prod.outlook.com (2603:10b6:208:2b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.29; Tue, 6 Jul
 2021 08:14:45 +0000
Received: from BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516]) by BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516%7]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 08:14:45 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC:     "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Thread-Topic: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Thread-Index: AQHXcYbB/F8jcejucEauG3F+rz+Qo6s0K71ggAAGAwCAAAHSoIAAEjWAgAAT3wCAARZ5IA==
Date:   Tue, 6 Jul 2021 08:14:45 +0000
Message-ID: <BLAPR08MB690035C831CF24DE356DEF6FB81B9@BLAPR08MB6900.namprd08.prod.outlook.com>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
 <20210705101554.GA12803@lst.de>
 <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705104208.GA14891@lst.de>
 <BLAPR08MB690003D5D175FC784DE844F8B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705115349.GA20266@lst.de>
 <20210705130456.GA239714@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210705130456.GA239714@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-07-06T08:14:41Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=c44b2b1b-992c-45c2-9287-1e0921c1ac0d;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bf60e6a-a2cb-443e-69d8-08d940561d47
x-ms-traffictypediagnostic: BL0PR08MB4580:
x-microsoft-antispam-prvs: <BL0PR08MB4580585A3C8B2E063F883656B81B9@BL0PR08MB4580.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W8IUcKi25k/xRzoaiiSU7Szgwz1x3E+hsT6kCH4bdCBgD7tjKUeBNSaieRz4So8eC5oxeshgZNAmKdgD2945IPcSh+CeV0artyjkAGf0EO2wy8KPuNZFVvALCycXZLyXv0DC7BbwhEoCFcPUDM4lZnskwpbB0xWXAAsBrAvKNJtTKKafgvxcrqpMDS2yOaFiezUoBobMPs+R7OThOSVs7KIvSxsnJL5Om8F6Q24pXkiFNyGiG0S4nm7Ecqi4Ng/f9kIfQHZqfp8gbiEyzhfQYGA1yUxDgCGE8aZr0OvZr1lbYNDpX5LWv/7WVh7lymLKfZLWOP7Ir5B4a7K3DWDUiesJ2Jls/rpAvS4bbW0ySlohZyY70LmiBdjjeLxk4iiQF2B91ZvhVsb5kb2lFTtPps2cZJtcfQrtjDsd8pX1hWfAIpgroX+fWpK1TKVUhxxVVm6ucK1SywIE6nIEAwK9QkGSy42rXfp/Hf/Uz1LqIkKnVvpU7EpAzasrFj7YcaIBTsfwQ78MUiqKijEZUQUl3PL2Usyd4pkaVHS+0qjQBdcjgtikAsf25FTmTbR6A6U/XFmkyBHMIbNL9NDwhFnBLBssOU1OvPnlFx0uHx+cr2qlmH/LvYGrfeH8ZB1iBO3sjGvqFGTF5hi/5vFwbbvaBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR08MB6900.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(38100700002)(122000001)(110136005)(2906002)(4326008)(64756008)(66446008)(186003)(33656002)(66476007)(5660300002)(54906003)(66946007)(66556008)(76116006)(26005)(9686003)(8676002)(86362001)(55016002)(6506007)(316002)(71200400001)(478600001)(7696005)(52536014)(83380400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?STOHM8vO9tVrJmhUa/10WGKPLObv3gw409kLqrqwGRT034u9O0jst3Qo2lrE?=
 =?us-ascii?Q?2yb7ifz30Erkcm1xzm7pWwWxDOMD6heO/LKkPgSfvrLKqSqBPL4KuXJN+5cG?=
 =?us-ascii?Q?pUNupTsLy42mWYF3n4HEJ3sZFMVF5RElN5jMkX3rZ1Et4mw7FHfaJGqodINK?=
 =?us-ascii?Q?Ar1dwB5SNXaWRZS+2KT/f79gOKEdOSrGhsxPHEdjMDOfFptIj6nPvv1Ek4wj?=
 =?us-ascii?Q?SDWDY2jfbQn3X6qWTv4dygCqrCUCMYP60tMqVVRDtn5/BBPJssHfXz99jkg0?=
 =?us-ascii?Q?ZY/zhAx9HSS7cjAr4hj7vN4Unp4X8/xmgJLdLtDjiuzBFcHPESP0sCW9ZAHT?=
 =?us-ascii?Q?x/Gm2Qu8X4iKGlGPiNOwi9Mx72vKNkiyuCTx4/tuxauunxUhBRYs/wCrBL7d?=
 =?us-ascii?Q?vs37GrTPcbZQGIrWcZvnZQZiX0UTk7J5FPp9HmMU0wZYhSFFtg62ll/LWRnr?=
 =?us-ascii?Q?t+Hm+aMT8EmqlspDHogWI8lMBob+MjOR7ceAG6YuPbpe8zRVGeSzUvnldZQO?=
 =?us-ascii?Q?S1DJT8vdGTEaFq2xS6ck/TqU//Q5A8QlSM4/iW1kV1Jr1fZJg6fR+qa46Kcc?=
 =?us-ascii?Q?A4HccOeZpcT3jKAV8zaN5w2kIb4emsuQSxhGPqptkmLSbflFLfDbnCQC27Xq?=
 =?us-ascii?Q?lhTlU8CxA5fgskW9Zsrs9BUfwAPWfz6KWCyD2rMrVe5tV2LfRPBHuwTffzJz?=
 =?us-ascii?Q?FtzB+fAxrVvnGl/081WH6P3H3SuS5w+0CPze3I4Eo2GACHGmDEPFSrsmhMXK?=
 =?us-ascii?Q?IWYP5zb5e3kZ9xsIqqG7yab69cx5122nA4M3S0k2P7YO5iBklkqbhEN6UZWc?=
 =?us-ascii?Q?BYm0xeQ4YG4dydn9L4sAkmUomxai0Z4Zf6DuiV6HzESUWJ7C3msHJ3Yihnlz?=
 =?us-ascii?Q?MAA+gSJ9jLpWAfjFO8xnc/r/NkeuEQR4mMJP9nD1uOymoyGa2RB1kJwz8z9l?=
 =?us-ascii?Q?Eiqdkf2nLtzTeZcQSXJl9DE+qsv257578B8shg8ZpSGQFkh4XIw6utEIKmIN?=
 =?us-ascii?Q?+0JQA1+xswdNgW2iHku8mUKO1lm2Uo0aHsHB+tnAzr9IJLuJsS/QQJlzD9ai?=
 =?us-ascii?Q?h10FL/GLTMwbQgB24U0K3hiX+HiwYdn8yzZsXcRu1W90C1PTP4IL6mWSGSfb?=
 =?us-ascii?Q?ZyfHDK9n043mlYPLK7BArQk3A4xV8S5PznWJyGOP1Pf0LsDC019nVUiHR5Ww?=
 =?us-ascii?Q?dnNpBwHvnyzEdyIznmF4XrnN8UpcbTVh8AVv5dvL/+DCgzAnosYfM486qCCG?=
 =?us-ascii?Q?GdNeo9D4OCgE9/uXPfCApBwwzGwGrbTL05QdXWO6irjKBJT5om1gc9bzGLkn?=
 =?us-ascii?Q?NQxsCBf25RrW4HsXzO0vdelI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR08MB6900.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf60e6a-a2cb-443e-69d8-08d940561d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 08:14:45.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZcHIeJf70tfgwutnP1vVRKZVWiRngXfRYY8BnLfTXhYE6ivaj9oV4QSuGUImi5iKy+bI/b6apokwzcIE30pXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR08MB4580
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micron Confidential

Hi,

>=20
>=20
> On Mon, Jul 05, 2021 at 01:53:49PM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 05, 2021 at 11:15:51AM +0000, Shivamurthy Shastri
> (sshivamurthy) wrote:
> > > For systems with passive electronic components to handle power-
> loss/battery-removal,
> > > CC.SHN=3D10b will help to achieve safer shutdown with relatively lowe=
r power
> back-up
> > > requirements (at lower cost).
> > >
> > > The module parameter gives flexibility to the host to decide shutdown=
 type
> even during
> > > boot failure.
> >
> > If you have a device that always prefers an abrupt please introduce a T=
P
> > in the NVMe technical working group so that the hosts automatically
> > do the right thing.  Requiring sysadmin intervention using a global
> > kernel parameter is not the way to do this.

The abrupt shutdown notification is already part of NVMe Specification.

>=20
> Is it the device that wants an abrupt shutdown or the platform? If the
> platform's power is running on limited back-up supply, and could inform
> the kernel's power management subsystem of this, then a driver could use
> that to determine if the quick shutdown is appropriate.

Yes, the platform is running on limited back-up supply. In this case, abrup=
t shutdown
option will help to achieve shutdown with relatively low back-up requiremen=
ts.

Please let me know if you want to include the abrupt shutdown as part of=20

static const struct dev_pm_ops nvme_dev_pm_ops =3D {
	.suspend	=3D nvme_suspend,
               .....


Thanks,
Shiva



Micron Confidential
