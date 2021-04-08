Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8678E358D20
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhDHS7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:59:34 -0400
Received: from mail-eopbgr1400120.outbound.protection.outlook.com ([40.107.140.120]:9184
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232804AbhDHS7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:59:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7qNP5YOA1MxMwRhqee0ut2Gr6kNTGxsGLDRuTYforX4C6D2SQkqaOjDcoepWWvSKx+YuzDt6422p/o3Phw5PUAs+WN86Qrw4dvks6mx5lXvDvnm0lqaP+B/GebidN/72psltxrm6N/2qkzL/QbINOvGfaeoEkSWT0JaT6xCT9ABpb/85KC7rs1Q5vy7jD6f8wtlorRnCuazabw4tH00+df7dn81X+kxtLh/5DvugaLwEYbwJTiSI5JAgIkrLt02JWX85XrJ8K1ffpJyBc6jHKY2hLziSPwg2zDa8znGdyexlso4JWfIgOXmCftEbhrT1+UondZ9RpPy9mIOUM7E8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY2QG5NeYcSh+SvrLvM/FZKRehXisAF4WEDv4CbSjLw=;
 b=ATS5fIXNYEmuVyU1hwl/ABoQzAWd7q7kGD+YclVnVaE0XwWyI+vpA4C+IAoEr95fk+8DABteIU7y9FizX+hwaQPT/jKmOaC6pi+PGuGMZrYli75s4+A2kgRd2SSkFX+l2fBZugkBnQoq9rNKTw6dARjbODC5TNAR39Bt6P+PrFmLXVUobqcGY9DUy6MbdrauqVPkgiHOByU+5HMis+k8ZvZrxRrl6aEo7azoBW1hsKQuLRfxcDNstOSHEIry7u88e3So4p/7WYnZjRRFeMVVSzf31ZAVYhL/nExe9T5/bX5p7gC9fVpz5rJQ8uwAnLlRocxp6l7v6VNcXPvFffEKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY2QG5NeYcSh+SvrLvM/FZKRehXisAF4WEDv4CbSjLw=;
 b=ACVROPsShmk8Ky71CfdZ4RauTNyUeI9QI5pmfBVuJaDj+6EU0oPQkpIOKfYNzDKeuqkRHO+BdPog6whgvMnk+poy00U7w3beKtgk3qMNO0qB7RYZmy/JJ4FG2osbm+503r2bwYy43D3Jk37cfG5T7KbYTBwVGz2nQmNPDC9MUmI=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSBPR01MB3093.jpnprd01.prod.outlook.com (2603:1096:604:17::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 18:59:20 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 18:59:19 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXLBphHjneZXXdB0ur+8N3VlMUXaqqJv4AgAC3vHCAAAllAIAAAJzwgAAD8ICAAAu6UA==
Date:   Thu, 8 Apr 2021 18:59:19 +0000
Message-ID: <OSBPR01MB47730D5F401A895C84849CCDBA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <1617846650-10058-2-git-send-email-min.li.xe@renesas.com>
 <YG6hOuOO5EL9xTwH@kroah.com>
 <OSBPR01MB4773182AF8FD263D65D52949BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YG9DPEyOIXqS2Vss@kroah.com>
 <OSBPR01MB47730AA300DB8DBE08E74FEEBA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YG9HDbMu3EbS3ekW@kroah.com>
In-Reply-To: <YG9HDbMu3EbS3ekW@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 914c7bb7-aeb9-4ea9-be30-08d8fac06a77
x-ms-traffictypediagnostic: OSBPR01MB3093:
x-microsoft-antispam-prvs: <OSBPR01MB3093F77DCC9517845AD77182BA749@OSBPR01MB3093.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYFS3is0eIp59q4uWmx0tcclq0qzwV3Ugm9Uf0o+wtUikzki5S1ZTRw9j4XUHr0lnmx9l+IGVsbB7wJe/JIyyGfC7s9DkvBa9j1j7G/OxQ0K/O/psgxNcv5PBBNSsh0vSsckkH4mII5HF1yF7sBAHe2S9pKD/WzPD/+YO9D+pLGA+8t3X3h++NNK1N1qNVgKjpyKbQJVqyCnwC7B+2HhdsVKbshDCfovZu9qRAngisimKza3gSczEyGCSIdRPcdC8xRBRUFZ1w7aAsOkD5G9IFKKCKy6FVZkuE6QxCc95jHuw6PKV5yvMsbRQZWVUAAWe5Y+m8sSQiX/DdFT5w3d9Eeb5nthnalWEdzbIIskECeleArBj+dy+f+IZii5gQoguM8z+NL/9hV4Ia2E/5+wR5hJkwH3xYqUrIGa45PBPw3jE8xjCFbF28/ZxVQyxGviJYHIFbB1DV8tBNy7s9hroHQ6lbu+WIrqmrYK819DHec0EznfZfHLL1IDBgnqN+CGWHD9YclziQkRnQACAOW2v/FjGKYzMtAPniNXHSlzNUiwRUq47ATkiN4fm+2HZBD3F83ZbbaxojW/kJy1ZXmspmuwRWnAQ/o6JOeA1HBSjROdsLdhSqUQ/LNRRqmCJUNVXCu2i7aqHSAD0J312YCbANUvPMMuOJhJAFvWzUjDwEc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39850400004)(136003)(346002)(9686003)(33656002)(8936002)(2906002)(38100700001)(86362001)(55016002)(83380400001)(4744005)(6506007)(8676002)(478600001)(71200400001)(66476007)(316002)(66556008)(66446008)(64756008)(4326008)(5660300002)(76116006)(54906003)(66946007)(52536014)(7696005)(6916009)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5PAzubFT6FkMxV4JMM7CjgXNnzCm1Hr152zcCAsK0XGV3Opbk33vxBZTI49F?=
 =?us-ascii?Q?SdJQIy51VhQ3FyHU4rH6R/e+Mw+13lhhOMv7/ECpL8Qdeg7CIhWLSnZK92xd?=
 =?us-ascii?Q?RfOe+gIShOgxbSA1GdwOvvod2XsDH5DbJKPgK4a01rkyiVlyKizpCudeR5xx?=
 =?us-ascii?Q?EPeHV0aXE+s/wYWIrDcgHrhmeRTdz5ML89PuDeJVAaTmtIqnlZ+/4a12F/sK?=
 =?us-ascii?Q?1zARdWwYyjwRtip7wV3ODG02zdJQEm8Uol6eJZA5S/iO7zcHR+yN5kglJwtI?=
 =?us-ascii?Q?H0EUDADBTa7ki4+5TAe1M2s1A7lU7cSC3WqXQHyWrIC8KRG6rkGa9rhioso6?=
 =?us-ascii?Q?esk4c3xiOqp81d9XFy2rStua+lTeGpiOpQymKJx+A8tUxbkUSAlyOdylVbAg?=
 =?us-ascii?Q?VFSvVuwwcTEGo8ckFftC7Zay8m09UIxW6Lr+kSJNhwaqVCBObBzCIfuil+9F?=
 =?us-ascii?Q?Yuwt/d+GPV9/nxrBC4w4IMMpoJIY8BQ8fw8ipW//l3otAXzWOxL1mFx0n3bp?=
 =?us-ascii?Q?ARkVny+cquNTPNzhw2UsIKxO3KpnWqmFw6Pod08RtCOLReXlinrc8Jb6Hrgi?=
 =?us-ascii?Q?BhNtYk9ZTxtcfbk86mYTH+aJFhzI3rchK0mRJLSHK3ie0Xx9su0pycsEYwy5?=
 =?us-ascii?Q?8P4KO5aJdM8gm8OvcRsYSKd9piJhBjm5UFhXT9KWDrAPqfAmmvky5DQN1N71?=
 =?us-ascii?Q?Dk4kC0myZsM+wdz+AjSqcPYp5je6v9Ya1rJpAvlj8+hH9VN+YzpXXy8c5TNu?=
 =?us-ascii?Q?LF0eHWsVvMOqpznjHQvZi0JtPz4QygavWLksI8O+FKKd9/mB53WKeKC92yux?=
 =?us-ascii?Q?UwoauhNvVICSTvOo4I13bMKQXEultwU69oB32k9AgFUkeaKvR6eXCcpwPvNj?=
 =?us-ascii?Q?xctlutoY8OEhBAHp8hFrwvfia36JW/4o8XJXaJ8pkt84pzb71qgPGm/xeTYk?=
 =?us-ascii?Q?9cqH9YAErKrqoIZgctLLtLdvyxIgucLWHkpm5hSnZA5iTFCEA/IApu5FwgrM?=
 =?us-ascii?Q?zYpmKqlMAathHAL/7CvByqbFoTaCEsfllBBOlAZnMxpwN9+Gye2WeJ0Ujgcv?=
 =?us-ascii?Q?uU6ZO00MgWejUI4CHkk0nutY+ANKTgVff+Txc1TOKzLMhtXnCYF7jgGO274d?=
 =?us-ascii?Q?8TY1CQ70BIp8WJ7ae/73di/6X7L/ez7SQJER+5rR4ThWVVTvE5J1Dk1y4S7i?=
 =?us-ascii?Q?FlWrWlKBqfDe+7gdJ9Kpf+rvmOxN0DkMX3S4UB3JvLgZRDkVqrlfnKV27FwX?=
 =?us-ascii?Q?lKxnCv2vfrWKue15CDGiYHuL+EmxUyzIsa08p1w0jELzRaWsW12OICzJWV9w?=
 =?us-ascii?Q?dpS0EcHzcnftspFbVqTV2PDZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914c7bb7-aeb9-4ea9-be30-08d8fac06a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 18:59:19.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSfaNp12o0dqagzUOWr3NH0eG8GT4Ykii0xXxl86o14j5F4XwJdIeqGm1J8AbIi0VMovcmoSW8aPwmZqwgxbfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> But what does that have to do with the misc device?
>=20

Hi Greg, MFD driver is the start of everything. Once MFD driver is loading,=
 it will spawn 2 devices, =20
one is for phc driver, which is under /driver/ptp and the other one is for =
this misc driver. =20
Both PHC and misc drivers are operating on the same device.=20
They are both calling exported functions from mfd drivers to access the dev=
ice through i2c/spi=20
and the register definitions are located in include/Linux/mfd/idt8a340_reg.=
h or idt82p33_reg.h
depending on which device was found by mfd driver through device tree node.
