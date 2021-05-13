Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BE637F044
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbhEMAOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:14:25 -0400
Received: from mail-eopbgr1410059.outbound.protection.outlook.com ([40.107.141.59]:34880
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353147AbhEMALn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAnESDGbNJ9R3S6CMQWbEBn5v+OY0oDjwjolqTh9mulxkbF7y9YGLmlBLlP5MvTePQT2bP4ghnQUz++XnGLJVLbOc8JUMi97dLLt2p1NHaGSmRqYcS2l7Q2asL2DlqJ93qv3nz5URGwmcpXN0eD1yKnwEVqK4llRB7zp7cJNm7lGa6uCO5mmc5TieYtIJ9Ht7cR0JDgVmvu2Eei7Hkw15bnlihQBrF+WILoDdaZwg4X0DpAsSGVnmj2J/Py339cFsmG6FuG49DeyqXzJnuZ7jpch54zcm+NrXmKp9cXs4Q0SpBz5qyCy4WqTt4P4KFP2Ly1/cy8xKq069zPlETCvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EJo4yob7vOQavy6ktUop/3Taw42vy6pVTAmb2cuLio=;
 b=Ux2NEBd0SVdQZF96OSFMBkOXZp1kQlTwp1qwWP9XteoSDg7U8AxRN6G02YaJEO2iGFU/seUH1mzWH6wQ66KDy0AGX+R9EmKYH/GCj7CsP/xKkxPXnve9kJxRIhY0bV8H5y/qX3+5/IuGJ3rdXcW9YRghxYWQDSXgoi5seq298jRY3MadfcFuk9UnRoyelTNr1ojk6Yrvi8dxUpmKZWM/maGvjiiQ0wEsDZohI1Y99jp5t3whc7/BBitC9mQWNW914KA05bpqIZlsg7vQKT8Xgph6iTyidcyB24vlwmwWnUSEfocmbTD49Q+diWpRbb0BBSyUM5jIutXkuCDM/OlKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EJo4yob7vOQavy6ktUop/3Taw42vy6pVTAmb2cuLio=;
 b=hnTafXatDQIeMGa1RfqM3gNQbpNxhoBF/kr+lWU+0yskP55Dz0K0mUV/MzXF7SECo0MoiFePcWgvTJrWICP2/F/QySmegQzF3z1GMqP1micdxbSehgkthSmUYju3jJZUoAfBatd890eBnwK1GX0/5Pe3wKlx+8CpPq2DviJDrYY=
Received: from TYCPR01MB6637.jpnprd01.prod.outlook.com (2603:1096:400:af::9)
 by TYAPR01MB6217.jpnprd01.prod.outlook.com (2603:1096:402:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 00:10:26 +0000
Received: from TYCPR01MB6637.jpnprd01.prod.outlook.com
 ([fe80::2c85:38b9:eebe:b58b]) by TYCPR01MB6637.jpnprd01.prod.outlook.com
 ([fe80::2c85:38b9:eebe:b58b%5]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 00:10:26 +0000
From:   =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?= 
        <junichi.nomura@nec.com>
To:     Yang Shi <shy828301@gmail.com>, Shakeel Butt <shakeelb@google.com>
CC:     =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?= 
        <junichi.nomura@nec.com>, Tejun Heo <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "guro@fb.com" <guro@fb.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [REGRESSION v5.13-rc1] NULL dereference in do_shrink_slab()
Thread-Topic: [REGRESSION v5.13-rc1] NULL dereference in do_shrink_slab()
Thread-Index: AQHXRxxebYtRsUQjwE+Lz4ZOTK4uwarfyKOAgABBiQCAAIBZgA==
Date:   Thu, 13 May 2021 00:10:26 +0000
Message-ID: <701b3c80-b6f0-dcb3-7f3d-da6b74dfc1db@nec.com>
References: <921e53f3-4b13-aab8-4a9e-e83ff15371e4@nec.com>
 <CALvZod6J8Nk2Vv8eMo020F-jfKHii3Lu1KxOOaut4U88AH3gfw@mail.gmail.com>
 <CAHbLzkppo+cc1B=K4A5nRyso0UxdaRVe-OqBo7PGPXA-nLSGAg@mail.gmail.com>
In-Reply-To: <CAHbLzkppo+cc1B=K4A5nRyso0UxdaRVe-OqBo7PGPXA-nLSGAg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nec.com; dkim=none (message not signed)
 header.d=none;nec.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 891e68cd-9561-4267-959a-08d915a382db
x-ms-traffictypediagnostic: TYAPR01MB6217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB6217FA88878CAD069B8BB39A83519@TYAPR01MB6217.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yL+zEay/zOEChitJ9Os8/ghWo/HzMOflYnkqpAJfEBVw9GLTRs/iLYSPlspCZK+0faqoHiRbmF+ACfKbiEBHecQwGbVXUGD24pG3Ejoq+js8rxMDHLBk6NKdEmDfNuii+YYIXsBBzQVPsBslsedOPZxglS8F2Q4RfXM1FQVb5Tg/t2cNL98poJRfQxXG+9Zdef6MlZ0ufDfk6t9Wl5v0PEl4SMOjFA2sqXcpM+dqMCsf9LYXWTzRx67TXzOJ8GzzR/dZJy4dmMG6CyvuvWz6XVl/P3Dvou9/qY3mNMYYGeYy/ut24fKxC+DLI1AMQX1rryKXArsAHx4Kwib1tPuSG3Uv57WeCY+GqrElzDOXO2+IVZ4jZ0UXCLauNlx4VgwCK1sXTlYJNbY+EuPsK0gX0+I45SL6nXmjsudLOTIf39dVRaslYon/9btQTzUSuDWTCGEJfac1J3bt8ODpuT7kGt31zjqumvgq9Gtku8/gxXkp8VYZTS6yBk4jkAM3PnHIa+hZQ4NIB9zPmnnb2/l3OJr9hlcsCjl08UyOS86zUYkPMlba/B+vIHNajhHF/+xUSMb6zNIg08rn2eBDlZPIQ1feWvZZLJs0UQ04URNk9ofrr6u/VJsFtr1gMA/r39HCnCP/joZAyJH9PCS7n19pE8Wsk4z80hFbWfdyEmFpxMTleBnh1X+/p66ONAwd+d8oL7IPbez6qAYvzqA6oyNFoEhhgQI8CYfrWaKyFfF8pLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6637.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(4326008)(6486002)(66446008)(186003)(86362001)(8676002)(31686004)(31696002)(55236004)(26005)(5660300002)(6506007)(53546011)(64756008)(8936002)(38100700002)(6512007)(83380400001)(122000001)(316002)(966005)(36756003)(71200400001)(2616005)(7416002)(85182001)(66476007)(66556008)(110136005)(54906003)(478600001)(76116006)(66946007)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?SmpsMjU4Mkg1SnVmN2dNTWJsZ2lLNFN0NzRFRTJaVWdaYllncmxwUkd4?=
 =?iso-2022-jp?B?OTB5bjFmNUJtUzVPbm9aVnFoNFJYSENhbVg4eWpyN2EyRGJHUDNFSFdo?=
 =?iso-2022-jp?B?dXFieE1oZzV2K2R0My9XL1FqRi85d29TRmd4czV4QlBkbDNLWTJUNkd0?=
 =?iso-2022-jp?B?TXg2MXlrbnNFZTQ5YVFxNFg4cFdrLzllR2hLYzhvVzdGbnFSOVg5c0Vu?=
 =?iso-2022-jp?B?YnVKNWlnaGtIaHQ5M3U4TXNObTV1Zjdob1lMb0RNMytGdU14K0lXcW56?=
 =?iso-2022-jp?B?WG9nVnpMTVp1dXhnZlgwSHlzank0SkYwQSsxSWVOVzhhdGlVYmppOU5L?=
 =?iso-2022-jp?B?NW5SZFRqZndVUFh4aVI1QkNKajlRb0ZRNG91MzR5cFBXZVNZZFpTdy9l?=
 =?iso-2022-jp?B?K2dGcXB5M1hxcnFMVW1CcU5CZmxESVBPVmp1VnloUG9qR3lGVERPZTly?=
 =?iso-2022-jp?B?QXdXNnpHdHlkUmRYS3dWNVZzb251ZU1SK3MwNHZIL2pmR085T1BlTURi?=
 =?iso-2022-jp?B?bkRDdDN3T3JiTDltSXlBcXJ1aXdFV0hRWlRnakdFL01GNTkwR21PY2p3?=
 =?iso-2022-jp?B?UFJmUDAxbmFwemJWWW1lZURUVGJWMGNNK2JhSnRXREtCODllVjB6SVpP?=
 =?iso-2022-jp?B?bENvMUw1b3k5MGpZSjFqclg1Skt4SDY4TGEzOWFyd0VRQ2pzMlh4U2NB?=
 =?iso-2022-jp?B?NkFzb3QyNkc0cTdwcll3VmVyWStjVi9ndWlEa0tYT1FzcGRnOG9JU2d6?=
 =?iso-2022-jp?B?dGdJNUsrL3VMYmdTbklSYjFERi9oSHJpNVdJWEcwRlg2ZytxczR4UkN3?=
 =?iso-2022-jp?B?S3pjbjZscmJ1T3lpVUtlSTV2WGpnMzh3N080QnJzbVNWTnFYdlVKTWFU?=
 =?iso-2022-jp?B?MkNXRWx4REZXNE92RVZSbmZ0YXRTNFdndERLNTVZdmhaQWczNGhLemNZ?=
 =?iso-2022-jp?B?NEhBUzhrUVo3bXpLOEZNSWhPN3FNRHVZN0U4ekVMSld5NXdsL012KzVi?=
 =?iso-2022-jp?B?VmVtKytiSHdBaEgxMTd3ZFI4Y1lZemV0VHVpQllLQjBmY2x1Tytyc2JZ?=
 =?iso-2022-jp?B?ajFJNDNPVnVuM2tWNVpFbkpJd0ZlNlR0TFczcXFFOVM0QnVaYTJja00w?=
 =?iso-2022-jp?B?QjBQSjNPOG52WEdOb2dZTnM4WGtNK3pUeEY1aHhUWnVaK1k5SUFvai9D?=
 =?iso-2022-jp?B?cGIvVXZscHZQSUNEWGRoTSsxc2JKdUtBMkZFWmRHbXVWM3BBSVRFS0JM?=
 =?iso-2022-jp?B?R2ZmT0pkdkNLZ2Nla0ZVWVh5YnJsem8zdGV1Y1UzblJsYnZNUW0rRnZj?=
 =?iso-2022-jp?B?MEdycmVhZDBPUUExMG9OZjBMVXhyeDdpSFVUaElEdFg2Y1BDZ1d5cUNt?=
 =?iso-2022-jp?B?TVNUY3NwN2FoY05uQnVmYnBuZlEvMmE4M1hvUnd6Y05oSnhkZU0welBx?=
 =?iso-2022-jp?B?aU55ek1hSFR5UkV0YUUzd3hlWXBDWW5YTFpMaEE1Mkk3QlkvcjFBV2tR?=
 =?iso-2022-jp?B?dnoxUThkNnVPUE5SUFpHRG1yMlNaei93eGlmakxrbHV5TXdiNE1UY3Fw?=
 =?iso-2022-jp?B?bjhydUt0TlpMRVRzS2xqOHF0ZWd1d2Vybk1Ia3lsWlIzT0RpZE9sY2ZC?=
 =?iso-2022-jp?B?aGtoOTA0N1Joenk2RzVDWVQvV2kyK2FuNVp3MndxSGtBMG1ZbFpzTmVO?=
 =?iso-2022-jp?B?Z1RMajVhZExtdU9nMS9vODBIWEhSVjF6MDUwT1JhY3FHWlBqektrMnFY?=
 =?iso-2022-jp?B?ZzNiZGkzYWhjaXM4SjNURWVjU2sxOTZoU0RwbGR6dHZ6YkVieXFjREZa?=
 =?iso-2022-jp?B?c1hIWWhMeVJ4TjJMSXdDU2NabVpKUzNaS20xWHlQMk5DYmFreVpnUWJX?=
 =?iso-2022-jp?B?Ui9WTFhMcTBUejNxNHJDN3pIOThYUExzUFNQQTFVWmt0N2dBTW9adkJh?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <062F3A0F56852248A7EE78B12F8D25CD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6637.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891e68cd-9561-4267-959a-08d915a382db
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 00:10:26.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FePejJ31IUDOKJr6mOPBVq6rxtHIxCs9BR8PyKt98dQm85zTa8cWZGih4yMux1SzPaULr6wuxjp29w+51QWGew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/13 1:31, Yang Shi wrote:
> On Wed, May 12, 2021 at 5:36 AM Shakeel Butt <shakeelb@google.com> wrote:
>>
>> +Tejun Heo
>>
>> On Wed, May 12, 2021 at 3:48 AM NOMURA JUNICHI(=1B$BLnB<!!=3D_0l=1B(B)
>> <junichi.nomura@nec.com> wrote:
>>> With the commit 476b30a0949a, if a memcg-aware shrinker is registered b=
efore
>>> cgroup_init(), shrinker->nr_deferred is NULL.  However xchg_nr_deferred=
()
>>> tries to use it as memcg is turned off via "cgroup_disable=3Dmemory".
>>>
>>> Any thoughts?
>=20
> Thanks for the report.
>=20
>>
>> Is there a way to find the call chain of "memcg-aware shrinker is
>> registered before cgroup_init()"?
>=20
> Other than adding some printk in prealloc_memcg_shrinker() then
> checking out the output of dmesg I didn't think of a better way. Not
> sure if we have something like early trace.

This is the first registration of memcg-aware shrinker:

[    1.933693] Call Trace:
[    1.934694]  sget_fc+0x20d/0x2f0
[    1.935693]  ? compare_single+0x10/0x10
[    1.936693]  ? shmem_create+0x30/0x30
[    1.937693]  vfs_get_super+0x3e/0x100
[    1.938693]  get_tree_nodev+0x16/0x20
[    1.939693]  shmem_get_tree+0x15/0x20
[    1.940693]  vfs_get_tree+0x2a/0xc0
[    1.941693]  fc_mount+0x12/0x40
[    1.942693]  vfs_kern_mount.part.43+0x61/0xa0
[    1.943693]  kern_mount+0x24/0x40
[    1.944693]  shmem_init+0x5c/0xc8
[    1.945693]  mnt_init+0x12f/0x24a
[    1.946693]  ? __percpu_counter_init+0x8f/0xb0
[    1.947693]  vfs_caches_init+0xce/0xda
[    1.948693]  start_kernel+0x479/0x4e3
[    1.949693]  x86_64_start_reservations+0x24/0x26
[    1.950693]  x86_64_start_kernel+0x8a/0x8d
[    1.951693]  secondary_startup_64_no_verify+0xc2/0xcb

That is done after command line parsing but before cgroup_init.

>> Irrespective I think we can revert a3e72739b7a7e ("cgroup: fix too
>> early usage of static_branch_disable()") as 6041186a3258 ("init:
>> initialize jump labels before command line option parsing") has moved
>> the initialization of jump labels before command line parsing.
>=20
> Seems make sense to me. If some memcg aware shrinker is registered
> before cgroup_init(), the mem_cgroup_disabled() check in
> prealloc_memcg_shrinker() would return false negative. And I don't
> think any shrinker could be registered before parsing boot
> commandline.

Thank you.  Shakeel 's patch works for me:

   [PATCH] cgroup: disable controllers at parse time
   https://lore.kernel.org/linux-mm/20210512201946.2949351-1-shakeelb@googl=
e.com/

--=20
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.=
