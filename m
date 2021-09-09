Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6E4044F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350699AbhIIF3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:29:02 -0400
Received: from mail-mw2nam08on2068.outbound.protection.outlook.com ([40.107.101.68]:37729
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230449AbhIIF3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:29:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3eXNrKE2Fs5pHbK6AB6nEILWHWpLGItwksZzSq2G/h30wwiU1wiVx/0VPp/r2Q9dlGjPtjFJpvVUgrpKXPyjre+rLKXGTYR1njoMK/y6UJHWN12jWfGJagJq4FeBvnnW2eLL25PmUD7Anm4UknbHDJZ0tQkNO/H6Nf5R36S7MdEllhNel0Udn6h/r3aHZMSqKFwNrqhV0ZmeJCyv8gzYvZCVgP4/xYL335dKPGb9hlenBe+jZq80SZcQ8mJ1u5WpLaFeK1QrYTYY6Z6UObEOojNt2Q+UlieqvCIWaNBbjY3BP7v/7ngS9n5UzTdF6/hGkJYLTQvEH0gWpZqy4pkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AGLj/w+z7FyraDRiAKPy5M9vyffZ1LXxB5SX+aBKGm8=;
 b=DSoqk560/RjW740gvW8ay5njaW7jntFwtLgXdiMwWL03AOSMAQM0lv5g+LjBVfA5+MzhRSAc+aV2WawNCMLsqUYPjFUwu63HpRu/BVAWY1GjOZa+bNsa1BGec5VA3m9vd9SXOxHNcVA+85X837ZeXaLsIv/POcK4x4gMQIIWlZ49hq+Fs2V5nEWcB2/3hzQLQBEIs8rmor59EAcd6gNeJPj4izZMlCVsfEuFlsz+19+hJRGiSxasXIS9UiwFxfGVwheQWb1dnkCa6llMZNOVb1d7zhNLAyGTMQaOlesd2VhR1Z3Gop08307jp8MpIwDHmN86kUvgn5ZIrjZfq83cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGLj/w+z7FyraDRiAKPy5M9vyffZ1LXxB5SX+aBKGm8=;
 b=Dq5RUFwW1qCsglh/kpdmZkmA69etjii1ZVwT/5/prHjcxypCEe57vSIS3sAcbt8j+6iAlLBBC5d4UHo1e250iorPH+vSuUFOK12VD+x/QRbf5WfeCPvQqRaTppIdAnkQhQgO6ibRj7O+AvU8WvaxUPkVzJ+9czOyXWhjjtG1Mz4=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19; Thu, 9 Sep 2021 05:27:49 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 05:27:49 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6ubJ2WAgAAA8aA=
Date:   Thu, 9 Sep 2021 05:27:49 +0000
Message-ID: <DM6PR12MB425005AE652C12F04E66B5B8FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
In-Reply-To: <04b52ef5b63abf25e6d50fd5bdfa90727e100a09.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T05:27:45Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ed04003c-f7d6-4a07-b0d7-90993546df0d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea4a9472-9be7-4edd-eb20-08d973529027
x-ms-traffictypediagnostic: DM6PR12MB3740:
x-microsoft-antispam-prvs: <DM6PR12MB37409DDFB616838C53BA11E6FBD59@DM6PR12MB3740.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u4mwuVVbdq2DCSZchLoLcBT00KZnjgeExgFTXO7Kp+edpFOSG7kpTSejHziZ6TFD1vwv+tSnp2cvEJwYzY3aUBG3Rf2kGwj6a3Kc/bxNdsFlwDh2u9OGapTJEDyKe0pgGC7URcyRti2VmaOXdrprHHWRP9ZzL7qA+aOQ3qJI9P1rnD60f806s+11fSp204VhwhBbf69wAP9yf8/pM0XqM5wT/J/L6SNQc5RPVhqjKjV6i2g1vr3n6fb0zlE3OqxwzooH49NuU8Ni+rAbXfORMcR0FjFNza7VUZceZ7i66D+YyTr89Xb1BrOwiV/lxFsVGN5y+CLhsV6rCsosk+cIwkjD6L697/2+a3k54OUq3v8vHXP7QQSdGGuCI5qHY+OppZ1DUGsGDX/G0Lc8a30AWvNL/9FMMFTxK+mIEPZiFymu4f3a0itxD8kIDHd3HCKtxmeg5DDsBDAoHZYLEi/2eSnZuaLcB+E+nGQfD7PHQohge5ey2dzhq9DzVRexn+mdgG/dVWmxxUmtoqNZnjBPWLy9On/ci6swt1ZPVmQM4OH3FNj5XiLTIS7zMCsAT2p0+QQX/z6z9kaIiyyxyUdoolpBX8UJ1DVdC80DyEBC0jDcxkm1cvfto83aYVkLJ6EYtaLZRGkdCnRojxLMIvuonYsSOavGwuuHYpKnBS7Tqt+T/2otRGik+aZ2hlSwgUdxtIjsQaRm5obdqKXzZ15PWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(9686003)(55016002)(66476007)(64756008)(66946007)(86362001)(76116006)(66556008)(66446008)(52536014)(7696005)(186003)(6506007)(71200400001)(122000001)(38100700002)(33656002)(316002)(110136005)(26005)(508600001)(8676002)(8936002)(83380400001)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G1f/AIN4fNfWfXvWi2Y0XIyziKXYBcWpST6JtXrk9YRdStKKgPJHnlSt4Qt2?=
 =?us-ascii?Q?RAnSJvHzfVKsOnJrJtuqFfT2J/epd0dqSKxKB/5h6TGHaTu2OfkP23567zVB?=
 =?us-ascii?Q?JEWA2c/U4ZLxVUze2TWf9cmoZ3qEEuYVahfg6ZJfDZM57C+t+aIqB23nDfmW?=
 =?us-ascii?Q?jiGVi/NLmPxZAed6z3aCUu4x7yE1IGvCtNemTGzWLYV0IbXSngAhLb1Ay1+z?=
 =?us-ascii?Q?zS1Fo2Pla546pQqbNcAmnqxCiLEWukA72FhV2HRddjAU7FA8rFH/8W8bRUZi?=
 =?us-ascii?Q?7NoWHgUuZ9ekUHs/yNOWDdasEa0TgEVkdC5yHZwmBhnTr+mqWyrV/cvKRVVZ?=
 =?us-ascii?Q?JYJ9YsOewWff9zpaQpY8ees5n1SM/fkTPvfc81TgdGdZmrjoKZgscb3uiDWg?=
 =?us-ascii?Q?bKEAZtLxaKeKlP4+wZaAwhTb9TXZew6LP6whh8BACOLwazEUcvFujNoiPhCw?=
 =?us-ascii?Q?rJyq+8ptnCsAAK+xgtnhkNeW069HCzu0XNFcU8GwQ5EFmQlA3zYbPJpWRPwc?=
 =?us-ascii?Q?HqN3liNbjnAz65lgY103wH+yHawoLAoskxzg0UGVRfkn8fwbFiVPHFK+7FAu?=
 =?us-ascii?Q?EpxoFcwTgF5VhD84M8II9OSB1oNzxcbDBOViZse5JnugpR3W5DboX/2eEmhf?=
 =?us-ascii?Q?On114RKlBL/iL0tQ+sb//9WksiDuo11JoURB9HaqV25Cyf1ObWbwUGnDps67?=
 =?us-ascii?Q?UwO5kxvigEoYJcDbu4hLkYm1B2ohn8izK4qOrOKln0ucaRNWRxx0Bvn81i25?=
 =?us-ascii?Q?PD7fzB7RvJN4qGuzvFgaMjgc0zM2SoHeTkNGSoG0uY/nuwVrD8ss2dvxogMs?=
 =?us-ascii?Q?+kZgN8gpxUnNSYZr0ChbgJ3sUqmPb4CPxMTk5Stc/ToQA9b+RFpEOmOiGk/t?=
 =?us-ascii?Q?rXZ5iGqFP96MJ24ht/9lOtjSEkq7QoqJhlBQ2iwzPsSHPXasYcnqYbYTrI5A?=
 =?us-ascii?Q?rylmIb3VXICLwTUmHhyGe6MglwLC4SR2cTTrnMkU4NbC55S8rcjJb1+heQzm?=
 =?us-ascii?Q?nZmnWqMk6FXa/7iHTuPPhna3ZTj+KfSEanWb9gfzude+9B6AwVkmntArNrI3?=
 =?us-ascii?Q?Lxhkx1JIooVGMLLM8glOFnrdcB838h6NMDNLyT4XCBZWeUHtnkJTKWAw4PfJ?=
 =?us-ascii?Q?eT2t/iq7V0AHnm/ArKN8AHE7P+GbQPAB+9l1aTZTXFqXt0FJBEx0TPe0NgnJ?=
 =?us-ascii?Q?EZiCTXIfpFgqcMU60BX3DyNxe4n99YjRmOonFlAY5LaGrPqRZtRtHOv+yOu3?=
 =?us-ascii?Q?xYuZEmHE0DgO7j2pftflUaiXFfphasnOoUwSeP0qdVt2NhExsItmTSnhkqgw?=
 =?us-ascii?Q?VjN9vn9QeO1C7mEIi6men1m4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4a9472-9be7-4edd-eb20-08d973529027
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 05:27:49.2205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xJCir2snzcTxIVuJFYJl9GQc8u5ngwLo+7ZEbNdopWj0nNQts6svkWBFI8hmqWfpz3wcQdJ7elTFCLH03cY9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



>-----Original Message-----
>From: Joe Perches <joe@perches.com>
>Sent: Thursday, September 9, 2021 1:06 PM
>To: Yu, Lang <Lang.Yu@amd.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Rafael J . Wysocki <rafael@kernel.org>; linu=
x-
>kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>On Wed, 2021-09-08 at 20:07 +0800, Lang Yu wrote:
>> The key purpose of sysfs_emit and sysfs_emit_at is to ensure that no
>> overrun is done. Make them more equivalent with scnprintf.
>
>I can't think of a single reason to do this.
>sysfs_emit and sysfs_emit_at are specific to sysfs.
>
>Use of these functions outside of sysfs is not desired or supported.
>
>
Thanks for your reply. But I'm still curious why you put such a limitation.
As "Documentation/filesystems/sysfs.rst" described, we can just  use=20
scnprintf(buf, PAGE_SIZE, "%s\n", dev->name) in show functions without
such a limitation.

But you said that " - show() should only use sysfs_emit() or sysfs_emit_at(=
) when formatting
the value to be returned to user space. " in Documentation/filesystems/sysf=
s.rst.

Some guys just try to replace scnprintf with sysfs_emit() or sysfs_emit_at(=
) per above documents.
But sprintf and sysfs_emit/sysfs_emit_at are not totally equivalent(e.g., p=
age boundary align).

In my opinion, we add a new api and try to replace an old api. Does we need=
 to make it more
compatible with old api? Thanks.

Regards,
Lang =20





