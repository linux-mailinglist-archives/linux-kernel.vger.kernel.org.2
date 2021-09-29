Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBADB41BFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244615AbhI2HZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:25:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35023 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbhI2HZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632900214; x=1664436214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zy3rTbK9d8q5ffVoOPGm0eliFJTq0WzfY2XrVvvdCd8=;
  b=Wnj0AayTkaGFTQeCyaLWd3CxSH+dt4Ek7QCbFEMAZv6sd+5g2DMgaZKz
   +LLrYz9tAn2iJ1D1kcMaY1tYOgPlPlfZQU1uBc4r8bhVOQe/aAcPbVO7J
   57RYx6Gns2aPx+FReNNi11vYlYmfmKDF0R4AjWz9+/ECVOoGeXQLR/abj
   IVuZY9DWxcMFzaiMKOZPBHkWOue+Idzt1+tiFyH0vvy1NLq8p46eTPwHe
   RBECkkTTmbfat7zfCDWwbsj2rWcGVucWG9S4S5TFzHM30vq8Y7YGseva5
   qjZ5+9IrvMcukPmt3u0PxKah5fPxMFVvezscvoEVs0pUAR2kv8dn7nDAu
   w==;
X-IronPort-AV: E=Sophos;i="5.85,331,1624291200"; 
   d="scan'208";a="292921319"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2021 15:23:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCgMkX7F72odHCwnuX6Y6I+JAMNG0F4PdAjO5Jj/Mc0yZQHx5upydVq2qxmcIsyT3Tx6Aj7gt5+szr+6vxvC0un1zdqM/uhE/4f825Ro+3o2ifP5AfuM//QDAcqLBN/kxmPpi3RXYxd02TNYL+S+5fgi5XLuAygypUxy1sRnZ8i+t9UvFcV5oveBTsmyqdsroQNtDhIaI7uYpLau52E+s/p4Xet8ftHxk9NQ5f72AGo5exIhwwTpXLD04jMsNDxidSQrjeXElzy0C1XYLRyD8l5jwYl4UQVj8PBqPau/ALEei5jcjUohQ6/MmJsQdFsxKfwl0YQd/y7VLAL8apqXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0VtSiKjRBBy8dhFxA6bXKjDrzgGzWWvv+nxXnyJ/P14=;
 b=CORBtive+ozX+f+bWRm6A5QU4RROF5oKQZsQiWor+9BW0rUSPUwvzwPqV5x+6e2qkW7E9bSvn59zIgG4tTyjRzdjyos3j42yYNCJtoWGEaeVYgpuM5CcKCFyJzQG0MOnW9wrm8O4Yr7itPWdyYB6fyvKrC7S6cIjR+8PIncK7VB40J3OJVwVHC1TVaW7lxCoSMq1C9URHXBdXUWhZadXUMYL7OYuud1MhsIaWhFfgHtHRGJLI64DYLVDD4AISgtcbyYmnmrCHMsq3kXJNMgp+F6OwUbkqPe6KtFIsB+EbvG0HdOvvoYFxvdwtWXKnWjqxjL+cVus6ft09V9DYZhEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VtSiKjRBBy8dhFxA6bXKjDrzgGzWWvv+nxXnyJ/P14=;
 b=XlAEL/4kMt3p1TUfxn2lo2x9cBUsSn48buAZ/wGFBQUBxhm3Y4lC6LSCa/CkUyBsE1wGJ7TjJsc2dvKWgzYPor8Q/vhM7EQpMYVYTs3PqHa0fmrc00XFxIckFc37UEkpvY/YV/o80oSLlp6J9f72TZqZup9Kox7bCMmI98rWY88=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6795.namprd04.prod.outlook.com (2603:10b6:5:24f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Wed, 29 Sep 2021 07:23:32 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59%4]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 07:23:32 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 16/17] ABI: sysfs-driver-ufs: Add another What for
 platform drivers
Thread-Topic: [PATCH 16/17] ABI: sysfs-driver-ufs: Add another What for
 platform drivers
Thread-Index: AQHXs6f5Yuh6nmqV7E6a9UXcE4axwKu6iE1ggAAQsYCAAAUzgA==
Date:   Wed, 29 Sep 2021 07:23:32 +0000
Message-ID: <DM6PR04MB6575B12DCA2D78A387E61852FCA99@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
 <bc61469964bbcabe38d12aa88f2734d38a8741e5.1632750608.git.mchehab+huawei@kernel.org>
 <DM6PR04MB6575E3C9D13E8B41627240FDFCA99@DM6PR04MB6575.namprd04.prod.outlook.com>
 <YVQP1btICr0TJusK@kroah.com>
In-Reply-To: <YVQP1btICr0TJusK@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e050f407-7a21-40bb-e2da-08d9831a0ad4
x-ms-traffictypediagnostic: DM6PR04MB6795:
x-microsoft-antispam-prvs: <DM6PR04MB67952BAFE2D712B0422407EBFCA99@DM6PR04MB6795.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egkeeep3spkxQuL0GiyrPstjd7LU+TXsfxbQ45EWF1WFYd6bIYN4jUwbedlsIRw5LEW7/xRYYhi3YQd1+dFPemIOvi6e7cNfy2XZI6vgmAQZwDPtRJJTjjiYuIWKKMZFHTCTbWIYNKxX1aWYViL0rRESCh/r41BMtsGuK5V5o54blFSIWcpIqNiRJ3LhuD/Y+w5pUVGtTECRD1Xqy02/zOV+R+Vd+DbV0O6R9+a0V5VE36ZOWzx932fionfAz74iXcSmbjFI/WXO0BSznBCvSgIEfeZmiqyxb8iD6sn2MQGfm0hqHw0O51SXqLz3EMox/x+XHzIQj1p+ooF2v3yMeEZv+TMpWqaZ/P8zRFN0AYXZUwRGy5c4JTgGO0NSqyouz0aDEIXE6bMtRnT1h5iPAvs1wm+w6WcMTQxm2GF8juCK6e675w/I6rxBOmMHx8WO5NBiGpxXXc0Ed8ucT9PoI5tYY7rhdup0YA/NsrLeSP3fWFY9ql4IMpcSut7XQU5vo1y//kRLU7P1XYZdl+6bgmocVmRNXDYElbOZSBqu2wDTYsx1s/G6rL1aPOvD8hev99RyPb/iG/xMWJDxjbhnmyVMq3a9i2MMrDkF+BwPJzQVGFJ4CyZVIqXwurn3obhPax9cPhkhgOCADTDZWgWxWZPfa3OcUoTSri1Tmi6WupI3BtRPz7rKOqaoSU61J1Zub8WabAnHCn6siVH51/yiew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(55016002)(66446008)(64756008)(66556008)(508600001)(26005)(86362001)(6506007)(71200400001)(66476007)(76116006)(66946007)(33656002)(2906002)(6916009)(54906003)(186003)(52536014)(4326008)(7696005)(5660300002)(7416002)(122000001)(38100700002)(8676002)(8936002)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m38JLqwP0cWIu48Zfp7WikgDrs1bbvLr0fiE43Tspn6SJitWLkXKtTUNVVml?=
 =?us-ascii?Q?hAuCC8LfnVmbMsilAOwKKmGWoKFjG7f/8N1xYyUSMxPHPzAYESsq59CuGMMG?=
 =?us-ascii?Q?cE/4nsPJRBTErHMRPpr77HZMS+cFlFXiQpFOl30tLVlxRGbEi3NOSwnHXOXn?=
 =?us-ascii?Q?mrI0FroZT2DB35wFlxR0jdPDjDSHR/G88aIk28KCx/ofjU9nPzRZ6WSRItYS?=
 =?us-ascii?Q?NkKO8YXL4iY63XshNkBzoeKenIDt25giT+N+Y6Cymn5TFnszpDZdurIIKnTj?=
 =?us-ascii?Q?1AMJ6dFA6euX1FHbYWhZcWDlbgA1rRz9QZVzefZc4HMiHuJaZ5fOzMgko6Ge?=
 =?us-ascii?Q?wUPughckX+llhKhRpTfY9hvVaZuGRMUAUmZK1v2Ta1SjLpfVSaeyJcK9mXuY?=
 =?us-ascii?Q?xg9TsX0TLaagNzzQnKNfLkUcZcj/IB2Qves+acuUUH1LAq5W82uQ85nrd3DD?=
 =?us-ascii?Q?nXyrAwBqH295IId/P/1iiAIkCUo3SnWSz5EJSXbZJdpymSltLWaV9RMDL/NI?=
 =?us-ascii?Q?reqnwksd7vmjFgeDa48GeWWHzhJkR+VhOfOBeY3J10s0SYIBwmJ1DjfO15hS?=
 =?us-ascii?Q?A8twQh/efivALPJbTASTUq/l1570R2XuQG2Xta69WnZGaxaXA6M9VppQ90z6?=
 =?us-ascii?Q?u90k6Y1gys1Zi8aCS4apctVh5L8krthmfNM5lIfJBQaNSdfYIPMCPPEyCLA3?=
 =?us-ascii?Q?1J36r3o+A0P/DlK0vVl7d2icRHW3EhH70SArGDlXvNP+dmwQAWo9S913YMy0?=
 =?us-ascii?Q?s6T56mTb4zbC5TrxTT/EzcOkOgkkHxt5h9bJDaMQ5w1/DHvp/hsbSBEWMwrJ?=
 =?us-ascii?Q?Qct42m2/BdQSYuM8gT/yWlQHslFSAj7WX7JSw2kyolsFiFIBbB/Vh0exGJL8?=
 =?us-ascii?Q?lTt2JTnPec01iX6Ag7HRilAa6qn/CQkh7usgvOCnv0Bgn9j9zSfwqjWclg6n?=
 =?us-ascii?Q?NA3wKdeTVB5sViWrLKPr6MetMZwAb0+G+YpPpmjRxTBn7yH25YIPo0QMiPBm?=
 =?us-ascii?Q?cOLrT/Zi6iN3BWHcn+4jcKil+rPCS8Y7SYMeRESYrEbICOix0jksNCHoHQOm?=
 =?us-ascii?Q?8CkxAXMCTP8AE0y613oD+jt7op3BhYtGa0i4W1wteTLlEaveagm3tND7Jxmm?=
 =?us-ascii?Q?6ehoSfCFz3qcP7cbmkzYQet/EIBVpbFG9tQqTcEqhCAsLE/McR6dVvE6LmqL?=
 =?us-ascii?Q?4bXx6oodD5AnQjp2cq9x1xJRgjjNFB7Je/BSAJEABpg2ozoIHeNBA/P3qc/I?=
 =?us-ascii?Q?XyXeaW3i0bL9QuWETJ6C6ox06kr0Gfmnm+K9XOD41FWZX2TcYyGJID0/5/T5?=
 =?us-ascii?Q?zX5brHN7oh1stmklgUykytVM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e050f407-7a21-40bb-e2da-08d9831a0ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 07:23:32.2991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2DDpsi1FFwZu6FP4WCEB+JlVvgwP3MIpvFVOm9XWcE1/ojwgg6idactsUqQUY1uww7T58vaHdazwX36CaS4gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 29, 2021 at 06:32:40AM +0000, Avri Altman wrote:
> > > The current what expressions:
> > >         What:          /sys/bus/platform/drivers/ufshcd/*/...
> > >
> > > Doesn't actually match what (some?) platform drivers actually
> > > export. For instance, drivers/scsi/ufs/ufs-hisi.c actually creates
> > > the sysfs struct for ufshcd inside this directory:
> > >
> > >         /sys/devices/platform/soc/ff3c0000.ufs
> > >
> > > Which has those aliases:
> > >
> > >         /sys/devices/virtual/devlink/platform:fff35000.crg_ctrl--
> > > platform:ff3c0000.ufs/consumer/
> > >         /sys/bus/platform/drivers/ufshcd-hisi/ff3c0000.ufs/
> > >         /sys/bus/platform/devices/soc/ff3c0000.ufs/
> > >         /sys/bus/platform/devices/ff3c0000.ufs/
> > >
> > > So, add another What: for such files that will match the device ufs
> > > entries, e. g.:
> > >
> > >         What:          /sys/bus/platform/devices/*.ufs/
> > On some platforms the suffix is .ufshc So Maybe use:
> > /sys/bus/platform/devices/*.ufs*/
>=20
> That's confusing.  How about describing why "ufshc" is used in another
> entry?  You all must have picked the new name for some reason to
> differentiate, right?
It's a platform thing. Better let the platform guys answer that.

Thanks,
Avri

>=20
> thanks,
>=20
> greg k-h
