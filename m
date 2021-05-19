Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9593E388625
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhESEtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:49:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13944 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhESEti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621399698; x=1652935698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kMKQX467sML4wPsV6jKfUGOjesCOFTicdd73l1dE9rw=;
  b=DKsZuGAbD8I/CxaaZm5ZaPsyeyKMiBkIiL1D8ijmd7ipEYvLDFr2g5BV
   lWv2BeAXkFQ7K0SVQfOeiH+Qp15j/EtA4d7lO15tPMAP/H0vdMErRARsk
   BvtULbsyIVFkZ1VKLNBgnqyNeaQ+Uxqabgf7WmPjuu3ff9PoSlRfvcn64
   T0Z1utGjM4mHlqxmNeQ5zuS60scN3CL8vIkiyh28DyZWSF0I03fkzdwoX
   hB1GF3QayXlZYfy2totHsRwcXvY3Z9v2+/60Csv4W3cKJcEuFUMM9AymO
   vXZ3T4q//GDoFP9QfAaDtk7Ga9HGtY7lvnnnXxg6MLWhISD/laj48OyWp
   A==;
IronPort-SDR: vINM9BGcHIk50Y2sbQLSTpRzQs069ElLk3wvNwzltHInHl+EPY/5GqNsVwrZId4iKW3R/Y3lqi
 ZtlFd2n9w0flTXHbs7Tu5fcgoMRQUAFfRbdfE+ubVjzXJc9oA5BTO+iN0JU0D6ZnEVoOwhtJU5
 0+a0IZ/ZvTEdE9VEVosMmZ2nrU6UO5XFxz7UyYczXG+2x+J566ANsTN6Zc3OUqopZnghaNwVjo
 75jJnsz1Z5/OaoEnCoAnGDw+ltS6nZ0PizcG/Ia/Zc+2PMZzmiJ1rmiTlUE8d6fXVkeyvmowBD
 fjE=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="173276770"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 12:48:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnKvfG7mNg7BuuqyyeJnwG02AuLtQhINtN0H74t+kkGKVhXKuG58pHKGqXtHnZSLI8ohIe3sOaQS4eYbwSbY8lUCC+E7TBy4wJaNxXe2kW+Nz1QxTApqfBIVIRm6U3tdEnzo16E93xiR68jj2UgkyOa9yygSN0ymQE67x5SOsBzgOLzcme20+Z0gXLjOP+WPGQ4k/GtNlFrADH1/9zZEj6Gzq9ER4E8BcYab3XK6vVQxx/SvoUWsEoFwacLdCbQ5NVCpttzmxaKbGL2xovPDd4p+kL6iRmas+bJ7cWkm1QdKHckK29/w2QAz4cfd+Dz/s/4HB9bWNzexEoxenXfRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMKQX467sML4wPsV6jKfUGOjesCOFTicdd73l1dE9rw=;
 b=LyXepgBB+ji0jpFmHxE8puuozu6CNAvdVuoaZHBKT9IoHVRJ5i0WM61OJDS5FTpnyxIaA9++xqnIZRLzXTbp3bp/CorKWyYh3odSoccaD7230cr5b7cpqzlnJ7xRBZ+k1U7lEDoTsQ0365u+AKOTTUOfRBsL8pCIRgxhvPkevf1Qr2d4ZXQb2IwoK/PLlAwZVL2z2PlPIh7I9REFol2uJfrnfbPz3954b1vpggWfRZzCEu+srDTOWAiFBY++z1oDOVIKWU/HQGq+6HEys0HEig0kOlrhXFVDDhQAIDdHDPaBQ7nu6z8uzQHE0craXrPvhqe8xdj04AWkfz24pIMsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMKQX467sML4wPsV6jKfUGOjesCOFTicdd73l1dE9rw=;
 b=Qnc9BB5H0agy1Px+qLc2nGR+M9IjvCB34wYlvrmOdJaUd/pV5xookMoHiXfNukKUvygBCnFJB9EU4oBfbHdHmTKeyOOEPSl58ORw2W7M++tTVgNRi8C0g1Iwvl+vQmZX8nbOMvxYnOJn0dpRVdSXc0ic6dxxHygslUTFLkKUemw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 04:48:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 04:48:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Wu Bo <wubo40@huawei.com>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "amit.engel@dell.com" <amit.engel@dell.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH 2/2] nvme-loop: Fix memory leak in nvme_loop_create_ctrl()
Thread-Topic: [PATCH 2/2] nvme-loop: Fix memory leak in
 nvme_loop_create_ctrl()
Thread-Index: AQHXTGhkxUsID6AnQE+f4B+QMV11jKrqO41b
Date:   Wed, 19 May 2021 04:48:17 +0000
Message-ID: <E4551D62-F184-4AE9-9349-2A9C2FC886B4@wdc.com>
References: <1621400470-593256-1-git-send-email-wubo40@huawei.com>,<1621400470-593256-3-git-send-email-wubo40@huawei.com>
In-Reply-To: <1621400470-593256-3-git-send-email-wubo40@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [70.175.137.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89654904-9579-49ba-fad5-08d91a8151fe
x-ms-traffictypediagnostic: BY5PR04MB7122:
x-microsoft-antispam-prvs: <BY5PR04MB712245EB76C8FEFAC8A98D5F862B9@BY5PR04MB7122.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jd39NwanpYrcmVaPs7uFMIBW0FpkUiXwK4goyWiz3vJLT94LLPtKITApzUV3yCRFKq4pzOBFFvZtL6IIQYH94xjfdCwwV/1y4S6w6YiI0PVo2C1aBcOjRikgDuyc3GL1EKsg8ZVBPRQ7L6qaGnJtj6ltSRuc5Eh4wS1WxePJ3h7RIqG8hUEu/QLWOmtslU3hNBj9dP09a4/4fWN6tOx2NT83mgc73ThJIggjinwwmfgUf04vdhmHs8T2TfkbnwjYby4PFhRaYmPuPMKdnhRkvqDi5bJJq06GrCH2KnBnVLxV6SCmw17jw4bMsagXoAQ2a3YjstW49VeXbnS459KZdFV5itYpcGrbJMUDMyAe776sTvTM7xbOnn/o9BpN8jg3nB9ufwSDpEksmDXCt9bNHl1oPcy3nm7925hdy/x6A3/poJZhvCRMqgZNAXcTpZjafgao36ydFIPNZWJplcw/TJfliYG7Tffp/FWn4Jyr6xFyc1VzU0+xZd0Fp/w6B6GTNpeJRY+tP2Bp5FoupEApjvD+gjRAmIIUS5PjYw6fA3GWmWZMZ/WEKR1dRkTqhLYWL0vbYvkyddCUiioqIvPHbTA++71tqIjjf/90IB1pGxgFSkcyTiMvCNXdVUwSFMvnFM28U1Ini5SIdJ25r6Ty9o+dfESkmAnclszRVcQWSO4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(76116006)(71200400001)(8936002)(8676002)(122000001)(66476007)(66946007)(66556008)(66446008)(64756008)(6506007)(6512007)(186003)(53546011)(54906003)(478600001)(4744005)(6486002)(4326008)(2616005)(316002)(38100700002)(26005)(6916009)(5660300002)(86362001)(2906002)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BIB9P0eW4mCBIvXg47fXhfvOL5/nRv8fhp2f93rk39RhdGkP6rrZpKGkGmKA?=
 =?us-ascii?Q?uSBTwhavzeAlGkJ3Y7ARM1l2dxX6rE3AOfP2PH+oXwdL1B0LQF6jiIqpSRU4?=
 =?us-ascii?Q?hYEnJ2vt5ItkcAR5zKNjHODCQonzGRZFvNXsbj6Vy34tv9q21kxLlgK4KNHk?=
 =?us-ascii?Q?v8UyZCivk1aQB68FOybpMVe7E91KCCk6R5jWgb2n7Ltq5JfE5gLrqzYcaa52?=
 =?us-ascii?Q?4v/o8GFD2lFr1s1TwZPRXlERc4mBHILbBvjRbujrUMijquVLneQsDVjDMTcC?=
 =?us-ascii?Q?pMC6wQkiDZgNyiP4MRcuLuCtoFkHaqUmQXNGYeWLBFIx2w50NCFIlxUoMqAH?=
 =?us-ascii?Q?2zZLeT9GLF9qAv1sNQxEJWVowQCpl6gFoWEK0wfuOf4DmoXEfyp9Id6tCn/e?=
 =?us-ascii?Q?IqrQq0lG5eWMj9/i0XKfUKQ6JmozfLbcb9Lui9iDD1ewi0F7ZJdHMcDZiMUv?=
 =?us-ascii?Q?cA2qG8h5x910G8GPH0WkFc3sZU8CV31/9APPy7hb9mvIiPNt2Fteg8xeoyme?=
 =?us-ascii?Q?lO7Z5XHpzi2QTulgU0xtfmk0WuEfcob6xAmqqOvBVJXDQgOD8E0lPZ/T8DgQ?=
 =?us-ascii?Q?4ktA2L1N9VzydSrwY/zaUXU5tilrHQr5asjvj3pPMpLlLZlGrTVC/H98i2el?=
 =?us-ascii?Q?i6hMIjpbkEmAYwQGZwYdNXVmB7wo5IjCWhWe0xbo7k6S27oS8OcmSCKa4glt?=
 =?us-ascii?Q?5v7Y7j0zot0xSaHYMHVGS58fkDMA5Hso2jNUPkSw92dxXWHk8uxI2o/4RzGC?=
 =?us-ascii?Q?+h/MXC6BN+0FxqPIEJifgTpS74547EE6CDfqvSvuWpqlUYC72frfXG7Ef1GG?=
 =?us-ascii?Q?y6puBO81r29JdqfRIm94o3Ac/dAQXfZ6A5VzBW2JQ9mQepe7/+3ck4g0hSbw?=
 =?us-ascii?Q?D0uHdLZ0sKFZyKrw3C5Vta3BbtgQHc3fGu8bdMHjyCzgWoLctSHEw1DeSgD7?=
 =?us-ascii?Q?olC7IaWJD+Htwo/S36f/KuXU6iyXdnZZCO6HXro1BM9UpE51Neh1p6JVoWb/?=
 =?us-ascii?Q?UzMxce3zhNWuKnD65fSie1/pSlWzjLVxwtMGsufkaPNWY9tkhGCGNIXvJ50b?=
 =?us-ascii?Q?fEM6/MNH53f4Y7aitMUx4VY6E1iGDNoLgXnLjpoEwAQOe/bvRo4fpU3Ttl/E?=
 =?us-ascii?Q?Ufjw6u7BMTMsBnlgcypwGhGez2hiOrHd69rAzUHJaACqMfbYWxoWdcLGMx1d?=
 =?us-ascii?Q?7O9TUc2iWTZbe/vseAJFIM90Daikb0Hm71Tzb0Q6sbcZx2IdCFFJdImYJ8KJ?=
 =?us-ascii?Q?lWNj/65rxA4WkuNLDmP//NICAi0nYbIFDvSwP3qnO58RXWKWSCSmh61zMLF6?=
 =?us-ascii?Q?3FFXz6b69nDJe8ClnDMIKcvM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89654904-9579-49ba-fad5-08d91a8151fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 04:48:17.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9VKIoAaoaisOA6QjjkndPAz+U+8kwYG5MnnJGQnytNDmUrGTBAUsPlAK/0O12MB0QcEoF3hTv8rFEi8TbPA59z5fACzRe7WkaOkChSMdDmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Sent from my iPhone

> On May 18, 2021, at 9:35 PM, Wu Bo <wubo40@huawei.com> wrote:
>=20
> When creating loop ctrl in nvme_loop_create_ctrl(), if nvme_init_ctrl()
> returns fails, the loop ctrl should be freed before
> jumps to the "out" label.
>=20
> Fixes: 3a85a5de29ea7 ("nvme-loop: add a NVMe loopback host driver")

Please make sure comit logs lines filled up 72 char and
Commit hash is 12 digit.=20

See the commit logs in the tree to get the better idea.=20


