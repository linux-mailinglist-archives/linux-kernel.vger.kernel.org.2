Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47AE345075
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhCVUIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:08:16 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:62656
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230479AbhCVUHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:07:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKWVaIg2UnxJQUN5V8Wv+XEx8ZXj9CIAR3kFNe8N2oge3xNWC5iOb8fWhjbsUckKeT2FvWEPLYa77j87UT/7tVMoeTwrdq4JVtymqXuP0y6wy98LS19qiE5Luxpw2Pxstw1IWlgE/0D/GMMdtIAnQSI1nkbrHCnGuzZBN6Lll/+8Hqp1K237BxwGFNETGu8AFJe3v11/aK98R4Y4pYJdpW6Bis0I+Gx2Ie/sdnq+Hnrx6pohFvdYgiYue92ON4czShOf3WqRe34xCwDn0oSDFvQ1xMKOk/iUgPLYyxbUYFigQA7WqRpi7dLMeDfSx23riLAR+I4acGRTKozbjnC6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKXJhiaAvXQNW8Hh9HWq2aiTSMjnM2dhqGNg0B/7di8=;
 b=AZkZXn9iNYYwDG3YC6fZ134wfogFuY7uDrgxPcP5F0nUrnHEOyvq+67SFETd5cZCBbA8lLGz1msz5GE1jHuum6izOdUSho0pF5ijMSAFtnPlvPrbLQaRyxUuvciXxhAVghWST6eM3kkGI8P5xoUDLRfbzCfYofDcmJNbzifTSBogzcpYo1vEcqilHHyjtO5DdEFCusn6NbkIoebCIQrPLWvZQmKamsQ7a0KE+f4iZSE/zxfW12nLqTTutnSMiwQ48oObefzMBUeDzUmLJRo1yvOpBz/y4QwTJrGeAh/kaGa01VWGu7DTZWEEQazN40T6s+YsqZPszhBKpn283kF8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKXJhiaAvXQNW8Hh9HWq2aiTSMjnM2dhqGNg0B/7di8=;
 b=UbqAywfWN/py5y3f1TRe8UwezswkLIC8od0AGoNyNM6axY99JPE9Lsoyx6zGQCeudMyKcbn/60mQn7pvNMB4vJpJIphMJ/bwwEX4Tc3UtbvMzWWpFoHBcklpMhPR9Vu36JNq+d35ki5FtfXLyDemsrHbS+99hnYrE7XcmN9kmXs=
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 (2603:10b6:910:45::21) by CY4PR10MB1398.namprd10.prod.outlook.com
 (2603:10b6:903:30::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 20:07:37 +0000
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::fcfe:f4e4:1d73:6d79]) by CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::fcfe:f4e4:1d73:6d79%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 20:07:37 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     Zhe Li <lizhe67@huawei.com>, "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
        "xukunkun1@huawei.com" <xukunkun1@huawei.com>,
        "zhongjubin@huawei.com" <zhongjubin@huawei.com>,
        "chenjie6@huawei.com" <chenjie6@huawei.com>
Subject: Re: [PATCH] jffs2: fix kasan slab-out-of-bounds problem
Thread-Topic: [PATCH] jffs2: fix kasan slab-out-of-bounds problem
Thread-Index: AQHXG6TtC8xnwV9O+02ylI57ffrSdKqQdg+D
Date:   Mon, 22 Mar 2021 20:07:37 +0000
Message-ID: <CY4PR1001MB2389E99ECB5B04A65BE35E22F4659@CY4PR1001MB2389.namprd10.prod.outlook.com>
References: <20210318030657.22840-1-lizhe67@huawei.com>
In-Reply-To: <20210318030657.22840-1-lizhe67@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=infinera.com;
x-originating-ip: [178.174.231.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e640d3bb-50c6-4c30-2844-08d8ed6e23b2
x-ms-traffictypediagnostic: CY4PR10MB1398:
x-microsoft-antispam-prvs: <CY4PR10MB139884BA2C47C95530079748F4659@CY4PR10MB1398.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kElvTonxKE+2mU9tTutchHKQwsG9AxRKgCuJkjmvvDjC5Az6lsasvQHstHcHCLFTzWThCIvOzN+Q+k+Td8pRF4p+9ehz4J3qYthjEDiQ0wzdWT/voguEYWVnih4dGrlNubU18XtFb0yPgrC+cdX/Bw8RyrWrCMe3qU7E70SKlyFIZIkc/juHpytFXnFsL7+5/7IEHBfazegbwh1aEO72ipE7XlyUIDi+VXRJbZ2qAFFoctv/j+GdUIwSRHjkah7SEh1kRQMnqGSrfE/mqnxcYSoc7SW5heErrwhim9ccgTnlUwvh2EIDMw74yE+MJ8Kb1+XKP9wuOkVZkZEUvzKZM1z4d2JHkWQZbZrFrCPr4UxPpAclR4mwJqszA6GzbEzSVSsUyDz87SaQRX0XxLBNWeD8HRfORepJtKfc0k2m0eWC9fq1I6Gf2Hm5vd8nHXFndqBdWNtYt87pH9ZpiS714rqZqfpzCeRzp1nuCZUO7w++/Sw4GnHovhOHR3DsLh1kFUYspawZp05zSUavd3be7DU1+w+75UXY6+L79yU+C4q/EwHY97dyvORoE1BRDgPil9SvfZ3OSviZG2ca4xMLyn7vKpSnnmyIeZcsgAa+mna4QFxXrh7bg5iFkSgA5pmhWVpdI/c+CWE9wo3fqN+cUiMhHpTQd8haR1NKv4bPW7vsGZzUbxQP1xYp+PHdb+wyJRtE530nZAZhm0vkgBkV0lYvRDT5iJ/pMFYAeIC9l9/iu9CPGvcYnr5TA0Rgw+9S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(110136005)(186003)(9686003)(52536014)(5660300002)(86362001)(7696005)(966005)(54906003)(316002)(53546011)(45080400002)(6506007)(76116006)(66476007)(478600001)(26005)(55016002)(91956017)(8936002)(66946007)(66556008)(64756008)(66446008)(33656002)(83380400001)(4326008)(8676002)(2906002)(38100700001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?GabfbNWLr3WsvGghYU/R2RGBryJbCdYFcu35PyF/wuPs7fwj9BZLTQr4Ub?=
 =?iso-8859-1?Q?aijRxOQjZjP4/Thri8+EWRe9FMAzWGtITOCYMu4wbzm/+UeBxUMdFnqaYO?=
 =?iso-8859-1?Q?YQodGAaAqkq+CY2oquyFm1XSXokyvNe9L5wcdJIETAU+i2O3XP6QKpPmmQ?=
 =?iso-8859-1?Q?zwKJ92hOu/9tn0Do/xfbWP8lXLiuIrt+w0XFbrSnbJxFp7Y6O4zs6HMB+O?=
 =?iso-8859-1?Q?tmKNlFpvu03gkQCmQmKcJv8iJOBzvkv8ESircN4lqchwYSLXb214cnIwfH?=
 =?iso-8859-1?Q?y4UesW2JuQQwF5Tdx20QzY2gxeuQFQEXeiDeKPLvqcYqlnhOP5PDFdORaM?=
 =?iso-8859-1?Q?aUv117bXwLWdH6A2G9hFGsQPQBn2NeCjEa/q4028kKfLB6lZm35gd6yZw5?=
 =?iso-8859-1?Q?5SMlj7MRNSs0rQlJjEHST1begSQfys9LNGJkSwqYy8q4HRuRHv8AW13jI3?=
 =?iso-8859-1?Q?FtimUsB2HOnSnlH6p0fXl+RQ8rUjhkNgLZ+AVePVe1aRGrijT+3O9d3t2c?=
 =?iso-8859-1?Q?3yXvc69rEXmOZ0i82FhiO6ZQ9+m/0rxzXzX+FE+1ulaWHqxO8Fn6s5Mjrg?=
 =?iso-8859-1?Q?wo9BkVbcpsFO6BShWeMUDg52mBnPT9KSFoO8bIphkJhzWUZWD+VMQcJsgN?=
 =?iso-8859-1?Q?HU4EQdaQXkkQnZS7qup8n+2l8I7767s9uQRtganKFSwtkzhUM+wGdHrGDU?=
 =?iso-8859-1?Q?GjPnoim8pXjhYxCFXjEHorSHl1MiWziC8lGhOWKLamgHWayvCz9o4h9Gjz?=
 =?iso-8859-1?Q?VSa3FbI3DaC9XwzyX5NAnlmBqOtCPwYih/LimWylBrArSX1Ukad9azkqOi?=
 =?iso-8859-1?Q?inVh/ptaNEmJPVa3/lP9EUusbaKemgYaNz6fD3Brw/CY8MSYbMVN7WmPKQ?=
 =?iso-8859-1?Q?LQW/NKj5We7cfN6r7eEvvqqD+Y5yd5TsbmoWfaViHwdY5KWC5N0PxYyFAE?=
 =?iso-8859-1?Q?2WKPYgQDQKj53yf785wb/cvaou+Gf439TWxQBiIQsx0EMpK/QakL8dvneV?=
 =?iso-8859-1?Q?4BX/OHQTFEZT+5eq7MeYc442UDvO1VJpDHnWtPEG2mIQx2cseLLHK0GxfT?=
 =?iso-8859-1?Q?tMfRtKRyyVjsMBv0ctQ+4g1iqGfnrOdIuP6bBPDCpJPb0oBKEpNTEyFsTh?=
 =?iso-8859-1?Q?nKC8FuEWEo1VWc+B9ZUhEHLxigBsvgbYERRSnUkqwm1/j8cOEFICNITQde?=
 =?iso-8859-1?Q?CLDfA8yWdPIutClPyO9SaIRBXOBTS1BidsVmUicczG5UAGrU7gpDRFDV8n?=
 =?iso-8859-1?Q?U8o9jkUIU1Kexpxotw500Kl37nF1pV6EysXmCybbKGuFSS5BE9snydwOXP?=
 =?iso-8859-1?Q?ze9NKNz+FugM8AtaKDcUcHActvIPk37ZpivWxes/OttB60HCJ1zanRICDq?=
 =?iso-8859-1?Q?1/ScMB5tU1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e640d3bb-50c6-4c30-2844-08d8ed6e23b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 20:07:37.2267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r280XigVAZDxPnBgFjzBy0c0+cTvNYJ8K+rfbXkwKJFVPzkk7D2HJb2W3n9Cmy7rSofCyvc3r+7CCjtAxAdT5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewe-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>=0A=
=0A=
It would be interesting to known how you managed to create such a dir entry=
 as that is a bug too.=0A=
________________________________________=0A=
From: linux-mtd <linux-mtd-bounces@lists.infradead.org> on behalf of Zhe Li=
 <lizhe67@huawei.com>=0A=
Sent: 18 March 2021 04:06=0A=
To: richard@nod.at; dwmw2@infradead.org; linux-mtd@lists.infradead.org; lin=
ux-kernel@vger.kernel.org=0A=
Cc: lizhe67@huawei.com; wangfangpeng1@huawei.com; xukunkun1@huawei.com; zho=
ngjubin@huawei.com; chenjie6@huawei.com=0A=
Subject: [PATCH] jffs2: fix kasan slab-out-of-bounds problem=0A=
=0A=
From: lizhe <lizhe67@huawei.com>=0A=
=0A=
KASAN report a slab-out-of-bounds problem. The logs are listed below.=0A=
It is because in function jffs2_scan_dirent_node, we alloc "checkedlen+1"=
=0A=
bytes for fd->name and we check crc with length rd->nsize. If checkedlen=0A=
is less than rd->nsize, it will cause the slab-out-of-bounds problem.=0A=
=0A=
jffs2: Dirent at *** has zeroes in name. Truncating to %d char=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: slab-out-of-bounds in crc32_le+0x1ce/0x260 at addr ffff8800842c=
f2d1=0A=
Read of size 1 by task test_JFFS2/915=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=0A=
BUG kmalloc-64 (Tainted: G    B      O   ): kasan: bad access detected=0A=
---------------------------------------------------------------------------=
--=0A=
INFO: Allocated in jffs2_alloc_full_dirent+0x2a/0x40 age=3D0 cpu=3D1 pid=3D=
915=0A=
        ___slab_alloc+0x580/0x5f0=0A=
        __slab_alloc.isra.24+0x4e/0x64=0A=
        __kmalloc+0x170/0x300=0A=
        jffs2_alloc_full_dirent+0x2a/0x40=0A=
        jffs2_scan_eraseblock+0x1ca4/0x3b64=0A=
        jffs2_scan_medium+0x285/0xfe0=0A=
        jffs2_do_mount_fs+0x5fb/0x1bbc=0A=
        jffs2_do_fill_super+0x245/0x6f0=0A=
        jffs2_fill_super+0x287/0x2e0=0A=
        mount_mtd_aux.isra.0+0x9a/0x144=0A=
        mount_mtd+0x222/0x2f0=0A=
        jffs2_mount+0x41/0x60=0A=
        mount_fs+0x63/0x230=0A=
        vfs_kern_mount.part.6+0x6c/0x1f4=0A=
        do_mount+0xae8/0x1940=0A=
        SyS_mount+0x105/0x1d0=0A=
INFO: Freed in jffs2_free_full_dirent+0x22/0x40 age=3D27 cpu=3D1 pid=3D915=
=0A=
        __slab_free+0x372/0x4e4=0A=
        kfree+0x1d4/0x20c=0A=
        jffs2_free_full_dirent+0x22/0x40=0A=
        jffs2_build_remove_unlinked_inode+0x17a/0x1e4=0A=
        jffs2_do_mount_fs+0x1646/0x1bbc=0A=
        jffs2_do_fill_super+0x245/0x6f0=0A=
        jffs2_fill_super+0x287/0x2e0=0A=
        mount_mtd_aux.isra.0+0x9a/0x144=0A=
        mount_mtd+0x222/0x2f0=0A=
        jffs2_mount+0x41/0x60=0A=
        mount_fs+0x63/0x230=0A=
        vfs_kern_mount.part.6+0x6c/0x1f4=0A=
        do_mount+0xae8/0x1940=0A=
        SyS_mount+0x105/0x1d0=0A=
        entry_SYSCALL_64_fastpath+0x1e/0x97=0A=
Call Trace:=0A=
 [<ffffffff815befef>] dump_stack+0x59/0x7e=0A=
 [<ffffffff812d1d65>] print_trailer+0x125/0x1b0=0A=
 [<ffffffff812d82c8>] object_err+0x34/0x40=0A=
 [<ffffffff812dadef>] kasan_report.part.1+0x21f/0x534=0A=
 [<ffffffff81132401>] ? vprintk+0x2d/0x40=0A=
 [<ffffffff815f1ee2>] ? crc32_le+0x1ce/0x260=0A=
 [<ffffffff812db41a>] kasan_report+0x26/0x30=0A=
 [<ffffffff812d9fc1>] __asan_load1+0x3d/0x50=0A=
 [<ffffffff815f1ee2>] crc32_le+0x1ce/0x260=0A=
 [<ffffffff814764ae>] ? jffs2_alloc_full_dirent+0x2a/0x40=0A=
 [<ffffffff81485cec>] jffs2_scan_eraseblock+0x1d0c/0x3b64=0A=
 [<ffffffff81488813>] ? jffs2_scan_medium+0xccf/0xfe0=0A=
 [<ffffffff81483fe0>] ? jffs2_scan_make_ino_cache+0x14c/0x14c=0A=
 [<ffffffff812da3e9>] ? kasan_unpoison_shadow+0x35/0x50=0A=
 [<ffffffff812da3e9>] ? kasan_unpoison_shadow+0x35/0x50=0A=
 [<ffffffff812da462>] ? kasan_kmalloc+0x5e/0x70=0A=
 [<ffffffff812d5d90>] ? kmem_cache_alloc_trace+0x10c/0x2cc=0A=
 [<ffffffff818169fb>] ? mtd_point+0xf7/0x130=0A=
 [<ffffffff81487dc9>] jffs2_scan_medium+0x285/0xfe0=0A=
 [<ffffffff81487b44>] ? jffs2_scan_eraseblock+0x3b64/0x3b64=0A=
 [<ffffffff812da3e9>] ? kasan_unpoison_shadow+0x35/0x50=0A=
 [<ffffffff812da3e9>] ? kasan_unpoison_shadow+0x35/0x50=0A=
 [<ffffffff812da462>] ? kasan_kmalloc+0x5e/0x70=0A=
 [<ffffffff812d57df>] ? __kmalloc+0x12b/0x300=0A=
 [<ffffffff812da462>] ? kasan_kmalloc+0x5e/0x70=0A=
 [<ffffffff814a2753>] ? jffs2_sum_init+0x9f/0x240=0A=
 [<ffffffff8148b2ff>] jffs2_do_mount_fs+0x5fb/0x1bbc=0A=
 [<ffffffff8148ad04>] ? jffs2_del_noinode_dirent+0x640/0x640=0A=
 [<ffffffff812da462>] ? kasan_kmalloc+0x5e/0x70=0A=
 [<ffffffff81127c5b>] ? __init_rwsem+0x97/0xac=0A=
 [<ffffffff81492349>] jffs2_do_fill_super+0x245/0x6f0=0A=
 [<ffffffff81493c5b>] jffs2_fill_super+0x287/0x2e0=0A=
 [<ffffffff814939d4>] ? jffs2_parse_options+0x594/0x594=0A=
 [<ffffffff81819bea>] mount_mtd_aux.isra.0+0x9a/0x144=0A=
 [<ffffffff81819eb6>] mount_mtd+0x222/0x2f0=0A=
 [<ffffffff814939d4>] ? jffs2_parse_options+0x594/0x594=0A=
 [<ffffffff81819c94>] ? mount_mtd_aux.isra.0+0x144/0x144=0A=
 [<ffffffff81258757>] ? free_pages+0x13/0x1c=0A=
 [<ffffffff814fa0ac>] ? selinux_sb_copy_data+0x278/0x2e0=0A=
 [<ffffffff81492b35>] jffs2_mount+0x41/0x60=0A=
 [<ffffffff81302fb7>] mount_fs+0x63/0x230=0A=
 [<ffffffff8133755f>] ? alloc_vfsmnt+0x32f/0x3b0=0A=
 [<ffffffff81337f2c>] vfs_kern_mount.part.6+0x6c/0x1f4=0A=
 [<ffffffff8133ceec>] do_mount+0xae8/0x1940=0A=
 [<ffffffff811b94e0>] ? audit_filter_rules.constprop.6+0x1d10/0x1d10=0A=
 [<ffffffff8133c404>] ? copy_mount_string+0x40/0x40=0A=
 [<ffffffff812cbf78>] ? alloc_pages_current+0xa4/0x1bc=0A=
 [<ffffffff81253a89>] ? __get_free_pages+0x25/0x50=0A=
 [<ffffffff81338993>] ? copy_mount_options.part.17+0x183/0x264=0A=
 [<ffffffff8133e3a9>] SyS_mount+0x105/0x1d0=0A=
 [<ffffffff8133e2a4>] ? copy_mnt_ns+0x560/0x560=0A=
 [<ffffffff810e8391>] ? msa_space_switch_handler+0x13d/0x190=0A=
 [<ffffffff81be184a>] entry_SYSCALL_64_fastpath+0x1e/0x97=0A=
 [<ffffffff810e9274>] ? msa_space_switch+0xb0/0xe0=0A=
Memory state around the buggy address:=0A=
 ffff8800842cf180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
 ffff8800842cf200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
>ffff8800842cf280: fc fc fc fc fc fc 00 00 00 00 01 fc fc fc fc fc=0A=
                                                 ^=0A=
 ffff8800842cf300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
 ffff8800842cf380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Reported-by: Kunkun Xu <xukunkun1@huawei.com>=0A=
Signed-off-by: lizhe <lizhe67@huawei.com>=0A=
---=0A=
 fs/jffs2/scan.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c=0A=
index db72a9d..b676056 100644=0A=
--- a/fs/jffs2/scan.c=0A=
+++ b/fs/jffs2/scan.c=0A=
@@ -1079,7 +1079,7 @@ static int jffs2_scan_dirent_node(struct jffs2_sb_inf=
o *c, struct jffs2_eraseblo=0A=
        memcpy(&fd->name, rd->name, checkedlen);=0A=
        fd->name[checkedlen] =3D 0;=0A=
=0A=
-       crc =3D crc32(0, fd->name, rd->nsize);=0A=
+       crc =3D crc32(0, fd->name, checkedlen);=0A=
        if (crc !=3D je32_to_cpu(rd->name_crc)) {=0A=
                pr_notice("%s(): Name CRC failed on node at 0x%08x: Read 0x=
%08x, calculated 0x%08x\n",=0A=
                          __func__, ofs, je32_to_cpu(rd->name_crc), crc);=
=0A=
--=0A=
2.7.4=0A=
=0A=
=0A=
______________________________________________________=0A=
Linux MTD discussion mailing list=0A=
https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.in=
fradead.org%2Fmailman%2Flistinfo%2Flinux-mtd%2F&amp;data=3D04%7C01%7Cjoakim=
.tjernlund%40infinera.com%7C7ec1d950724f4995dc9c08d8e9bc0e35%7C285643de5f5b=
4b03a1530ae2dc8aaf77%7C1%7C1%7C637516341206870320%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am=
p;sdata=3DV0RwumJqxPlGWG6qBjSfu%2FDk5lon3vjB23S2h4w0DDg%3D&amp;reserved=3D0=
=0A=
