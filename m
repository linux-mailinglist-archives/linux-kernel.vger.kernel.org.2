Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9181840BF39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhIOFN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:13:56 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:42454 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236190AbhIOFNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:13:41 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F58cwC018483;
        Wed, 15 Sep 2021 05:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=z8k3DAF5zS0HdvZDaT/IXCa5F7DqDxFTF4S/yUwyoxo=;
 b=rI6zYvVvLLoF4jrfHrHfYGOjq/Gl/SxvQIVp3YIeTcJk/1Jkbuqa+wXWBHI+LSf88ZST
 sENb6Zuz6TiCczlc5kNmX8M36agTTnvbpPi4idKzKo4RWU4QIadvPTDCSZZDtLn61Wkd
 lkIYdRSE6aKrkyJgW1CLbqoecQ7ncguFEwkdnvmH3emLxnrEY61RQdsCiKIXwZ6Dcr+V
 aX5JkZGh6ybc0eUv3GAGsEDk8WmHvpSNSeb2LKH97JuS+aNSMZXUHumssBPhhuRE+m3J
 2wH3isAVmGK0QiHpkVI4h6lTR1KaVRjw6RKfxXlL8CZpqs5+cuHuOhVZDixxScADokjm GA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-0064b401.pphosted.com with ESMTP id 3b33a2g86j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 05:12:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbATnhdSrveJROGTuysqZrG/hKZf1SMr4MzMiWVvnxocr/4UC+YR66rmJ9DyI+6gkPwXi59uBbZk9iathWijpTsC4+f4uQYDRrswxuQHuf8NpRzrSbpa7JkEnCXs722pU0tA7gnZQjU5t+Ci5MaVnchQcihNWueGguGRXdyR17ye9bTCc3f1GBdyGcobGDQRnKkhshOSrV/NpyxKFxn2cOIZ9DJa9l73sl8yE+2aZvW3BIzvbI1Y1kwRgdUv48wsosYJzCoSYfnCu7FSq0y8fdatG/mFUJ0Xi8ztkl5/rDeW1rkIBgUgpwY/BPIMonI/N7vzPbDVQYC+R1hZgTvFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=z8k3DAF5zS0HdvZDaT/IXCa5F7DqDxFTF4S/yUwyoxo=;
 b=LwNq8SkqGxt4netWdcZaizEDMToNgw6a+re566TlMutzACFrDle0C7cheFFc4GtFxg6AyvitM2EScuBfxOwvJ8tgUpv19FiXaCOq7QXp+Jae4fgpzuKQErHSt8bj7puiy05mq6tOPxbjOcE8UJWJlKoXMW+dlu5Ctp/P49f73uNh5fv3SCMleKP/2hMEhz2Lu/uD8+dVD6uZVy3uFHluw3B/rlNFOH3QsKtXiEoIBaif1rl7tuHIwznhmP4W5d3q8u0Rt4yb5jpTcoSbMxjuKzYQsLSmHhKI1yYtTthbgasNcmINhrLp393NaOQ6qH9cuZFTxth/La1QHPkgnsntlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL1PR11MB5429.namprd11.prod.outlook.com (2603:10b6:208:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 05:12:14 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d%8]) with mapi id 15.20.4500.018; Wed, 15 Sep 2021
 05:12:14 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Hao Sun <sunhao.th@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: BUG: soft lockup in smp_call_function
Thread-Topic: BUG: soft lockup in smp_call_function
Thread-Index: AQHXqdVQ0gga3z+iAUSZKPTEkWTIhqukdI6K
Date:   Wed, 15 Sep 2021 05:12:14 +0000
Message-ID: <BL1PR11MB5478B519F5196C0F479C7859FFDB9@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <CACkBjsZa65=vqn_C+3wBRRPG6E_MC6j9KAJy9W+FYXo492Gy3Q@mail.gmail.com>
In-Reply-To: <CACkBjsZa65=vqn_C+3wBRRPG6E_MC6j9KAJy9W+FYXo492Gy3Q@mail.gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68152ff7-7bf4-4af2-fc1f-08d9780761a6
x-ms-traffictypediagnostic: BL1PR11MB5429:
x-microsoft-antispam-prvs: <BL1PR11MB5429DDEE47363C7738E7C3A5FFDB9@BL1PR11MB5429.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4Ng0uA1lkIshivgxBWAB01xKrR1GSu4UwwNDDyoN8vPaxuL8RpGqWC4i15XiYI2afhR6LdGLw9pHv1MMvUfgR42HnrCO0/wWu7DHV9nj8pHf+LKBY2tLNst/kNOeHOJ4+aDkhWsL7uOgiD7ph5eA9RbPfs4kKVSg8buiSSsur1nh/5CjaiGTIngDc0YqhmbRhpn68YHkvIN0H68SXVgxXK9r38zTeesk1Zm5/8OvlNzjfJYjvn/xDf7nVaLnKYtScMs/fdU9pfAX4Eoz6ucd/JW4ds2XhgM1onUfHfsPgYXMh3sX+9RjJJENs53UJRhxgOmBRdwIeyDbmBc1FIBMNQc3fHcZK/XXbS3Ujs9QDrovAEzuh+2rGeLCBXTXNxDKdiVkrZSPIj00WfSDhMxfb9xdHjyqMIyoOUcfo95NSnxf2XaoIMA7wqcs5xGALjbLeHPY/Su9a/GP2zND8QmYKO6/r7HR5vyduU77pbe+W3eMLL+YllZAF2WfPlS5GEjv2BYwKjEYWqcgAunkTxppDnCVMQc98FTB1F0BeI1b4RucM41rZ/mJwXELCmGYkKgobvrGDXxK3pFDlsxPkpbUkbks2efgDoQPE8eSFqckLzD/U2ezp4SollnV9s/bks1J+e4XIsJW3MN7pUQbkpzZKzF7SDlCPYaCndGRqyC6HwFZfDRtSpYFni7mWUfVWGzqi0d2nJ/fZjeK1REckY5aEP8xl0Ut4+NR1ZGQtecup7QFli+GMlWPUv9zGpxIpA9xRCFbEv48fo+AC4hpDru/NHN49YThvUo97W1EzRlgTsR3nZvSHc+WDpEO8dlcdAxgX25ueNp12/MM8+ObsdIsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39840400004)(376002)(396003)(38100700002)(26005)(66556008)(2906002)(86362001)(8936002)(66476007)(9686003)(8676002)(5660300002)(66946007)(186003)(64756008)(316002)(30864003)(55016002)(76116006)(53546011)(478600001)(966005)(7696005)(33656002)(110136005)(66446008)(122000001)(71200400001)(52536014)(6506007)(45080400002)(83380400001)(45954011)(38070700005)(91956017)(4326008)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dnbl4/mKILjcIcHua/9VLCXTGtd6OKxP3JVFZDujoGzVehU5Ek2NDulZaHLl?=
 =?us-ascii?Q?weXb+7cVjWmfnDFjDts9IC6bjGvIfKKBII1SViZF85XTNyVVjA90YafgFv5h?=
 =?us-ascii?Q?6P9VitiNVC5DsVz5P0288V/XVN+P2hNtm8vhf82VNUO6BTcQ7N6dzJ7YGF9t?=
 =?us-ascii?Q?ZUQnFzDLH4ZwPx190Ztu+Gvjpfe1PuKlzvOyC5PDqRWKJmFyAcjG2MMlLAb3?=
 =?us-ascii?Q?C6zm/oOgDiP74RxaZKWcM+xX0NlHxBmdBePDW+xZdPQoLBbbt24YmPCMTJfH?=
 =?us-ascii?Q?rYTmXuJF/2MNEgJ+UC+cKLGX0MhjUsNcbm3BXmQ46REM3CcnGxfJtezR7/9c?=
 =?us-ascii?Q?Sj7HnB+18mkHKhHZBt06o5nUQ/ZRVgPJHzdYdedNGV+ZnzNQvN98xVkCYJYa?=
 =?us-ascii?Q?b1sh/7eJXZGmU15Qi9i3r3zl5nmkQ0Rf3uzl1KLYTUJCsa9Y9zDgdicImDPT?=
 =?us-ascii?Q?6z0X1uEXIJeAqyqY8lCdnFX63h2xlssVtVz9BawgaZDhs/q6/hb6943V7CZG?=
 =?us-ascii?Q?97wjTgOEyOwKm5cDH4upD9ja0er0EbYVNVsBJAICaLtZS+AYejEyckUJvdWy?=
 =?us-ascii?Q?C/AlsURF+jnBlCGSb23YpV7eTA1bngSETM/9NHOrGJUdLJbFW5vbvwCwQbv9?=
 =?us-ascii?Q?aAcuG/BqA4w/aN4pgZjir0aBI4VevYRkGt0SedBUmK2kfJRDp1PIyQ4sxUFl?=
 =?us-ascii?Q?soxWRG2dkxFW90DTrmvi01AY4ERBDGyvesNtdhn9Hn+WORnulOZ6rZEAq9OS?=
 =?us-ascii?Q?TLE/VBxhI8qYQvnF/2hgBVXiUdZFXwUIy2muophl+G0qiw4dmvIQK6g7ISZB?=
 =?us-ascii?Q?ktKXp1NCRlxs30dwg5BSbjBV4yUje2NF8Z2k0lGkA7/PR0dn1Mg/RHxV1bn8?=
 =?us-ascii?Q?+VHC4aEV/ztc2A9Lwa593WbcrbVAAAzpBwOv78tZG38fedgD9zfF4Xm/bT99?=
 =?us-ascii?Q?KA7iOyBfJOJ3o7ojOcnG3mMwUOVW2hPZP4n6ICCiHCGSJ+ga5RwUABEmcyTP?=
 =?us-ascii?Q?u7I7kcEFy6SEJNJBIOG3ZeBhiAt43oDBnetCgtpajqeUtuTn/7cIJgwc3nAO?=
 =?us-ascii?Q?L/Z26vkOsIEBGPJkNwlx6P48al0UjJr5lB9y0ja82V+s5LtGP1MDs+BIFgHo?=
 =?us-ascii?Q?wsgXWmd6U9vHFdefO//zvUjcOcbYNj4OhB2VXsQ+beusjjWMuDHHQS6ielID?=
 =?us-ascii?Q?rv+UHkE8Ud7B/NwLRJXDu3muMmCjir560F6XnFUmkibCT4qp6JZFnfjA3l0m?=
 =?us-ascii?Q?rFMQBszYixYws6dthJ9Eiwda0K8J+IAVr0zxr6DJo6FUkwV1zOCFyygPyrZr?=
 =?us-ascii?Q?gVY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68152ff7-7bf4-4af2-fc1f-08d9780761a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 05:12:14.6535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWj4KiHouEWERohKKRaj3Lk52+5N8FlIXqNA2iKkDmV2UvjChDLxG21kBdfYZ7OiF6VcMlFLNAdLi0l5sHraPRDg39XYpsVp9C7SlgHLNrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5429
X-Proofpoint-GUID: kQ2zQuYwWf5YFrCRl2dzx8jIT2gCj9my
X-Proofpoint-ORIG-GUID: kQ2zQuYwWf5YFrCRl2dzx8jIT2gCj9my
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_10,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Sun=0A=
=0A=
It's like csd_lock cannot be acquired, causing the problem =0A=
Enable CONFIG_CSD_LOCK_WAIT_DEBUG for more information.=0A=
=0A=
Thanks=0A=
Qiang=0A=
=0A=
________________________________________=0A=
From: Hao Sun <sunhao.th@gmail.com>=0A=
Sent: Wednesday, 15 September 2021 09:59=0A=
To: linux-kernel@vger.kernel.org=0A=
Cc: mingo@kernel.org=0A=
Subject: BUG: soft lockup in smp_call_function=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
Hello,=0A=
=0A=
When using Healer to fuzz the latest Linux kernel, the following two=0A=
similar crashes was triggered.=0A=
=0A=
HEAD commit: 6880fa6c5660 Linux 5.15-rc1=0A=
git tree: upstream=0A=
console output:=0A=
https://drive.google.com/file/d/1W2g_mj5JPDXI5U7HibVepNdxMdChKS0_/view?usp=
=3Dsharing=0A=
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsU=
dWcgB/view?usp=3Dsharing=0A=
similar report: INFO: rcu detected stall in smp_call_function=0A=
=0A=
Sorry, I don't have a reproducer for this crash, hope the symbolized=0A=
report can help.=0A=
If you fix this issue, please add the following tag to the commit:=0A=
Reported-by: Hao Sun <sunhao.th@gmail.com>=0A=
=0A=
watchdog: BUG: soft lockup - CPU#1 stuck for 157s! [kworker/1:8:14241]=0A=
Modules linked in:=0A=
irq event stamp: 371624=0A=
hardirqs last  enabled at (371623): [<ffffffff84400c02>]=0A=
asm_sysvec_apic_timer_interrupt+0x12/0x20=0A=
arch/x86/include/asm/idtentry.h:638=0A=
hardirqs last disabled at (371624): [<ffffffff8424818a>]=0A=
sysvec_apic_timer_interrupt+0xa/0xc0 arch/x86/kernel/apic/apic.c:1097=0A=
softirqs last  enabled at (337636): [<ffffffff84600398>]=0A=
softirq_handle_end kernel/softirq.c:401 [inline]=0A=
softirqs last  enabled at (337636): [<ffffffff84600398>]=0A=
__do_softirq+0x398/0x561 kernel/softirq.c:587=0A=
softirqs last disabled at (337625): [<ffffffff81235b42>]=0A=
invoke_softirq kernel/softirq.c:432 [inline]=0A=
softirqs last disabled at (337625): [<ffffffff81235b42>]=0A=
__irq_exit_rcu kernel/softirq.c:636 [inline]=0A=
softirqs last disabled at (337625): [<ffffffff81235b42>]=0A=
irq_exit_rcu+0xe2/0x100 kernel/softirq.c:648=0A=
CPU: 1 PID: 14241 Comm: kworker/1:8 Not tainted 5.15.0-rc1 #16=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=0A=
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014=0A=
Workqueue: rcu_gp wait_rcu_exp_gp=0A=
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]=0A=
RIP: 0010:csd_lock kernel/smp.c:446 [inline]=0A=
RIP: 0010:smp_call_function_single+0x1a3/0x220 kernel/smp.c:745=0A=
Code: 48 c7 c3 80 a8 02 00 e8 cb b1 f1 02 89 c0 48 83 f8 07 77 6c 48=0A=
03 1c c5 80 98 62 85 8b 43 08 a8 01 74 0e e8 3f 9d 04 00 f3 90 <8b> 43=0A=
08 a8 01 75 f2 e8 31 9d 04 00 83 4b 08 01 48 89 de 44 89 e7=0A=
RSP: 0018:ffffc90001d4fd00 EFLAGS: 00000293=0A=
RAX: 0000000000000000 RBX: ffff88813dc2a880 RCX: 0000000000000000=0A=
RDX: ffff888112ac8000 RSI: ffffffff8132f4c1 RDI: ffffffff852d80e6=0A=
RBP: ffffc90001d4fd90 R08: 0000000000000001 R09: 0000000000000001=0A=
R10: ffffc90001d4fda8 R11: 0000000000000002 R12: 0000000000000002=0A=
R13: 0000000000000000 R14: ffffffff812ef7c0 R15: 0000000000000000=0A=
FS:  0000000000000000(0000) GS:ffff88813dc00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 000055a15807ccf0 CR3: 0000000025f6b000 CR4: 0000000000750ee0=0A=
PKRU: 55555554=0A=
Call Trace:=0A=
 sync_rcu_exp_select_node_cpus+0x27b/0x440 kernel/rcu/tree_exp.h:393=0A=
 sync_rcu_exp_select_cpus+0x238/0x5d0 kernel/rcu/tree_exp.h:441=0A=
 rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:615 [inline]=0A=
 wait_rcu_exp_gp+0xa/0x20 kernel/rcu/tree_exp.h:629=0A=
 process_one_work+0x359/0x850 kernel/workqueue.c:2297=0A=
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444=0A=
 kthread+0x178/0x1b0 kernel/kthread.c:319=0A=
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295=0A=
Sending NMI from CPU 1 to CPUs 0,2-3:=0A=
NMI backtrace for cpu 0=0A=
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-rc1 #16=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=0A=
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014=0A=
RIP: 0010:__lock_acquire+0x14f/0x1d60 kernel/locking/lockdep.c:4955=0A=
Code: 00 48 89 43 08 48 8b 04 24 48 89 43 18 41 8b b5 dc 09 00 00 65=0A=
8b 05 08 ed d5 7e 85 c0 0f 95 c2 31 c0 85 f6 44 89 fe 0f 95 c0 <83> e1=0A=
03 c1 e6 07 8d 14 50 0f b6 43 21 83 e2 03 c1 e2 05 83 e0 1f=0A=
RSP: 0018:ffffc90000003c40 EFLAGS: 00000002=0A=
RAX: 0000000000000001 RBX: ffffffff858b2d70 RCX: 0000000000000000=0A=
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88813dd1a3d8=0A=
RBP: 0000000000000057 R08: 0000000000000001 R09: 0000000000000001=0A=
R10: ffff88813dd1a3d8 R11: 0000000000000003 R12: 0000000000000001=0A=
R13: ffffffff858b2300 R14: ffffffff858b2cf8 R15: 0000000000000000=0A=
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 000055a1580bf6d7 CR3: 0000000025f6b000 CR4: 0000000000750ef0=0A=
PKRU: 55555554=0A=
Call Trace:=0A=
 <IRQ>=0A=
 lock_acquire+0x1f9/0x340 kernel/locking/lockdep.c:5625=0A=
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]=0A=
 _raw_spin_lock_irqsave+0x38/0x50 kernel/locking/spinlock.c:162=0A=
 lock_hrtimer_base+0x2f/0x70 kernel/time/hrtimer.c:173=0A=
 hrtimer_try_to_cancel+0x6d/0x270 kernel/time/hrtimer.c:1331=0A=
 hrtimer_cancel+0x12/0x30 kernel/time/hrtimer.c:1443=0A=
 __disable_vblank drivers/gpu/drm/drm_vblank.c:434 [inline]=0A=
 drm_vblank_disable_and_save+0xca/0x130 drivers/gpu/drm/drm_vblank.c:478=0A=
 vblank_disable_fn+0x83/0xa0 drivers/gpu/drm/drm_vblank.c:495=0A=
 call_timer_fn+0xcb/0x3f0 kernel/time/timer.c:1421=0A=
 expire_timers kernel/time/timer.c:1466 [inline]=0A=
 __run_timers kernel/time/timer.c:1734 [inline]=0A=
 run_timer_softirq+0x6bd/0x820 kernel/time/timer.c:1747=0A=
 __do_softirq+0xe9/0x561 kernel/softirq.c:558=0A=
 invoke_softirq kernel/softirq.c:432 [inline]=0A=
 __irq_exit_rcu kernel/softirq.c:636 [inline]=0A=
 irq_exit_rcu+0xe2/0x100 kernel/softirq.c:648=0A=
 sysvec_apic_timer_interrupt+0x9e/0xc0 arch/x86/kernel/apic/apic.c:1097=0A=
 </IRQ>=0A=
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:=
638=0A=
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:717=0A=
Code: 60 ce 25 84 75 09 48 83 c4 18 5b 5d 41 5c c3 e8 ab c4 fe ff cc=0A=
cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d ff 00 5c 00 fb f4 <c3> 0f=0A=
1f 40 00 65 48 8b 04 25 40 70 01 00 f0 80 48 02 20 48 8b 10=0A=
RSP: 0018:ffffffff85803e90 EFLAGS: 00000202=0A=
RAX: 00000000010c94ab RBX: 0000000000000000 RCX: 0000000000000000=0A=
RDX: 0000000000000000 RSI: ffffffff85524f3d RDI: ffffffff853cbec6=0A=
RBP: ffffffff860d9290 R08: 0000000000000001 R09: 0000000000000001=0A=
R10: ffffffff85803be8 R11: 0000000000000001 R12: 0000000000000000=0A=
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff858b2300=0A=
 default_idle_call+0x6a/0x260 kernel/sched/idle.c:112=0A=
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]=0A=
 do_idle+0x1e9/0x2b0 kernel/sched/idle.c:306=0A=
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403=0A=
 start_kernel+0x839/0x860 init/main.c:1141=0A=
 secondary_startup_64_no_verify+0xb0/0xbb=0A=
NMI backtrace for cpu 2=0A=
CPU: 2 PID: 9794 Comm: sshd Not tainted 5.15.0-rc1 #16=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=0A=
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014=0A=
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x60 kernel/kcov.c:197=0A=
Code: 65 48 8b 14 25 40 70 01 00 81 e1 00 01 00 00 a9 00 01 ff 00 74=0A=
0e 85 c9 74 35 8b 82 34 15 00 00 85 c0 74 2b 8b 82 10 15 00 00 <83> f8=0A=
02 75 20 48 8b 8a 18 15 00 00 8b 92 14 15 00 00 48 8b 01 48=0A=
RSP: 0018:ffffc900008cfa80 EFLAGS: 00000246=0A=
RAX: 0000000000000000 RBX: ffff88807dc318e0 RCX: 0000000000000000=0A=
RDX: ffff88800e9c4480 RSI: ffffffff8132ebc0 RDI: 00000000ffffffff=0A=
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001=0A=
R10: ffffc900008cfa30 R11: 0000000000000000 R12: ffff88807dd2a900=0A=
R13: ffff88807dd2a908 R14: ffffffff85a27620 R15: 0000000000000000=0A=
FS:  00007f831f8568c0(0000) GS:ffff88807dd00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007ffd76d1df1f CR3: 000000000fe3c000 CR4: 0000000000750ee0=0A=
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=0A=
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400=0A=
PKRU: 55555554=0A=
Call Trace:=0A=
 rep_nop arch/x86/include/asm/vdso/processor.h:13 [inline]=0A=
 cpu_relax arch/x86/include/asm/vdso/processor.h:18 [inline]=0A=
 csd_lock_wait kernel/smp.c:440 [inline]=0A=
 smp_call_function_many_cond+0x1d0/0x550 kernel/smp.c:969=0A=
 on_each_cpu_cond_mask+0x48/0x90 kernel/smp.c:1135=0A=
 __purge_vmap_area_lazy+0xd7/0xa40 mm/vmalloc.c:1683=0A=
 _vm_unmap_aliases+0x233/0x280 mm/vmalloc.c:2107=0A=
 change_page_attr_set_clr+0xb3/0x340 arch/x86/mm/pat/set_memory.c:1740=0A=
 change_page_attr_clear arch/x86/mm/pat/set_memory.c:1797 [inline]=0A=
 set_memory_ro+0x2b/0x40 arch/x86/mm/pat/set_memory.c:1943=0A=
 bpf_jit_binary_lock_ro include/linux/filter.h:890 [inline]=0A=
 bpf_int_jit_compile+0x65d/0x6b0 arch/x86/net/bpf_jit_comp.c:2338=0A=
 bpf_prog_select_runtime+0x173/0x1e0 kernel/bpf/core.c:1914=0A=
 bpf_migrate_filter net/core/filter.c:1295 [inline]=0A=
 bpf_prepare_filter+0x40d/0x5d0 net/core/filter.c:1343=0A=
 bpf_prog_create_from_user+0xcf/0x150 net/core/filter.c:1437=0A=
 seccomp_prepare_filter kernel/seccomp.c:666 [inline]=0A=
 seccomp_prepare_user_filter kernel/seccomp.c:703 [inline]=0A=
 seccomp_set_mode_filter kernel/seccomp.c:1824 [inline]=0A=
 do_seccomp+0x2ca/0xdb0 kernel/seccomp.c:1944=0A=
 prctl_set_seccomp+0x2f/0x60 kernel/seccomp.c:1997=0A=
 __do_sys_prctl kernel/sys.c:2346 [inline]=0A=
 __se_sys_prctl kernel/sys.c:2264 [inline]=0A=
 __x64_sys_prctl+0xd4/0x770 kernel/sys.c:2264=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
RIP: 0033:0x7f831d9cd54a=0A=
Code: 48 8b 0d 51 f9 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f=0A=
84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 9d 00 00 00 0f 05 <48> 3d=0A=
01 f0 ff ff 73 01 c3 48 8b 0d 1e f9 2a 00 f7 d8 64 89 01 48=0A=
RSP: 002b:00007ffd76d1c428 EFLAGS: 00000246 ORIG_RAX: 000000000000009d=0A=
RAX: ffffffffffffffda RBX: 00005597d3a36f20 RCX: 00007f831d9cd54a=0A=
RDX: 00005597d32bdf50 RSI: 0000000000000002 RDI: 0000000000000016=0A=
RBP: 00005597d3a35d40 R08: 0000000000000000 R09: 0000000000000005=0A=
R10: 00007f831d9cd54a R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 0000000000000028 R14: 0000000000000000 R15: 00007ffd76d1c870=0A=
NMI backtrace for cpu 3=0A=
CPU: 3 PID: 9782 Comm: syz-executor Not tainted 5.15.0-rc1 #16=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=0A=
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014=0A=
RIP: 0010:kvm_wait+0x4a/0x70 arch/x86/kernel/kvm.c:893=0A=
Code: 5d c3 89 f3 48 89 fd 9c 58 fa f6 c4 02 75 30 0f b6 45 00 38 c3=0A=
74 16 e8 94 82 25 00 fb 5b 5d c3 eb 07 0f 00 2d 95 c1 6d 03 f4 <5b> 5d=0A=
c3 e8 7e 82 25 00 eb 07 0f 00 2d 83 c1 6d 03 fb f4 eb c0 e8=0A=
RSP: 0000:ffffc90000768e00 EFLAGS: 00000046=0A=
RAX: 0000000000000003 RBX: ffff888100998338 RCX: 0000000000000008=0A=
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff888100998338=0A=
RBP: ffff88813dd2a600 R08: 0000000000000000 R09: 0000000000000001=0A=
R10: ffffc90000768d20 R11: 0000000000000002 R12: 0000000000000001=0A=
R13: 0000000000000100 R14: 0000000000000000 R15: 0000000000100000=0A=
FS:  00007f849523b700(0000) GS:ffff88813dd00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 0000000020400010 CR3: 0000000025f6b000 CR4: 0000000000750ee0=0A=
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=0A=
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400=0A=
PKRU: 55555554=0A=
Call Trace:=0A=
 <IRQ>=0A=
 pv_wait arch/x86/include/asm/paravirt.h:597 [inline]=0A=
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]=0A=
 __pv_queued_spin_lock_slowpath+0x262/0x330 kernel/locking/qspinlock.c:508=
=0A=
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:585 [inline]=
=0A=
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]=0A=
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]=0A=
 do_raw_spin_lock+0xb6/0xc0 kernel/locking/spinlock_debug.c:115=0A=
 spin_lock include/linux/spinlock.h:363 [inline]=0A=
 drm_handle_vblank+0x86/0x530 drivers/gpu/drm/drm_vblank.c:1951=0A=
 vkms_vblank_simulate+0x5a/0x190 drivers/gpu/drm/vkms/vkms_crtc.c:29=0A=
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]=0A=
 __hrtimer_run_queues+0xb8/0x610 kernel/time/hrtimer.c:1749=0A=
 hrtimer_interrupt+0xfe/0x280 kernel/time/hrtimer.c:1811=0A=
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]=0A=
 __sysvec_apic_timer_interrupt+0x9c/0x2c0 arch/x86/kernel/apic/apic.c:1103=
=0A=
 sysvec_apic_timer_interrupt+0x99/0xc0 arch/x86/kernel/apic/apic.c:1097=0A=
 </IRQ>=0A=
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:=
638=0A=
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inlin=
e]=0A=
RIP: 0010:_raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202=0A=
Code: 0f 1f 44 00 00 53 48 8b 74 24 08 48 89 fb 48 83 c7 18 e8 be ce=0A=
05 fd 48 89 df e8 f6 06 06 fd e8 e1 19 14 fd fb bf 01 00 00 00 <e8> 76=0A=
9c 01 fd 65 8b 05 df 93 db 7b 85 c0 74 02 5b c3 e8 9b 4c da=0A=
RSP: 0000:ffffc90001503e18 EFLAGS: 00000202=0A=
RAX: 00000000000b619e RBX: ffff88813dd18240 RCX: 0000000000000100=0A=
RDX: 0000000000000000 RSI: ffffffff85524f3d RDI: 0000000000000001=0A=
RBP: ffffc90001503e50 R08: 0000000000000001 R09: 0000000000000001=0A=
R10: ffffc90001503e28 R11: 0000000000000001 R12: ffff88810d86c9c0=0A=
R13: ffffc90001503e50 R14: ffffffff839a5e10 R15: ffffffff860d9290=0A=
 expire_timers kernel/time/timer.c:1465 [inline]=0A=
 __run_timers kernel/time/timer.c:1734 [inline]=0A=
 run_timer_softirq+0x6ae/0x820 kernel/time/timer.c:1747=0A=
 __do_softirq+0xe9/0x561 kernel/softirq.c:558=0A=
 invoke_softirq kernel/softirq.c:432 [inline]=0A=
 __irq_exit_rcu kernel/softirq.c:636 [inline]=0A=
 irq_exit_rcu+0xe2/0x100 kernel/softirq.c:648=0A=
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1097=0A=
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:=
638=0A=
RIP: 0033:0x418dcf=0A=
Code: 1f 84 00 00 00 00 00 0f 1f 40 00 64 8b 04 25 08 03 00 00 41 89=0A=
c3 41 83 cb 02 41 39 c3 74 17 f0 64 44 0f b1 1c 25 08 03 00 00 <75> e7=0A=
41 83 e3 bb 41 83 fb 0a 74 01 c3 48 83 ec 08 64 48 c7 04 25=0A=
RSP: 002b:00007f849523a9b8 EFLAGS: 00000246=0A=
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000=0A=
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003=0A=
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000=0A=
R13: 0000000000000000 R14: 0000000000000003 R15: 00000000204413a0=0A=
----------------=0A=
Code disassembly (best guess):=0A=
   0: 48 c7 c3 80 a8 02 00 mov    $0x2a880,%rbx=0A=
   7: e8 cb b1 f1 02        callq  0x2f1b1d7=0A=
   c: 89 c0                mov    %eax,%eax=0A=
   e: 48 83 f8 07          cmp    $0x7,%rax=0A=
  12: 77 6c                ja     0x80=0A=
  14: 48 03 1c c5 80 98 62 add    -0x7a9d6780(,%rax,8),%rbx=0A=
  1b: 85=0A=
  1c: 8b 43 08              mov    0x8(%rbx),%eax=0A=
  1f: a8 01                test   $0x1,%al=0A=
  21: 74 0e                je     0x31=0A=
  23: e8 3f 9d 04 00        callq  0x49d67=0A=
  28: f3 90                pause=0A=
* 2a: 8b 43 08              mov    0x8(%rbx),%eax <-- trapping instruction=
=0A=
  2d: a8 01                test   $0x1,%al=0A=
  2f: 75 f2                jne    0x23=0A=
  31: e8 31 9d 04 00        callq  0x49d67=0A=
  36: 83 4b 08 01          orl    $0x1,0x8(%rbx)=0A=
  3a: 48 89 de              mov    %rbx,%rsi=0A=
  3d: 44 89 e7              mov    %r12d,%edi=0A=
=0A=
=0A=
=3D=3D=3D=3D=3D INFO: rcu detected stall in smp_call_function=0A=
=0A=
rcu: INFO: rcu_preempt self-detected stall on CPU=0A=
rcu: 0-....: (3203 ticks this GP) idle=3D417/1/0x4000000000000000=0A=
softirq=3D25875/25875 fqs=3D485=0A=
(t=3D10500 jiffies g=3D37621 q=3D38)=0A=
rcu: rcu_preempt kthread starved for 486 jiffies! g37621 f0x0=0A=
RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D3=0A=
rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now=0A=
expected behavior.=0A=
rcu: RCU grace-period kthread stack dump:=0A=
task:rcu_preempt     state:R  running task     stack:13832 pid:   16=0A=
ppid:     2 flags:0x00004000=0A=
Call Trace:=0A=
 context_switch kernel/sched/core.c:4940 [inline]=0A=
 __schedule+0x323/0xae0 kernel/sched/core.c:6287=0A=
 schedule+0x36/0xe0 kernel/sched/core.c:6366=0A=
 schedule_timeout+0x2cb/0x430 kernel/time/timer.c:1881=0A=
 rcu_gp_fqs_loop+0x2f7/0x3e0 kernel/rcu/tree.c:1957=0A=
 rcu_gp_kthread+0xd0/0x160 kernel/rcu/tree.c:2130=0A=
 kthread+0x178/0x1b0 kernel/kthread.c:319=0A=
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295=0A=
rcu: Stack dump where RCU GP kthread last ran:=0A=
Sending NMI from CPU 0 to CPUs 3:=0A=
NMI backtrace for cpu 3=0A=
CPU: 3 PID: 14220 Comm: kworker/3:10 Not tainted 5.15.0-rc1 #16=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=0A=
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014=0A=
Workqueue: rcu_gp wait_rcu_exp_gp=0A=
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]=0A=
RIP: 0010:csd_lock kernel/smp.c:446 [inline]=0A=
RIP: 0010:smp_call_function_single+0x1a6/0x220 kernel/smp.c:745=0A=
Code: 80 a8 02 00 e8 cb b1 f1 02 89 c0 48 83 f8 07 77 6c 48 03 1c c5=0A=
80 98 62 85 8b 43 08 a8 01 74 0e e8 3f 9d 04 00 f3 90 8b 43 08 <a8> 01=0A=
75 f2 e8 31 9d 04 00 83 4b 08 01 48 89 de 44 89 e7 4c 89 73=0A=
RSP: 0018:ffffc90005793d00 EFLAGS: 00000293=0A=
RAX: 0000000000000001 RBX: ffff88813dd2a880 RCX: 0000000000000000=0A=
RDX: ffff888103ddc480 RSI: ffffffff8132f4c1 RDI: ffffffff852d80e6=0A=
RBP: ffffc90005793d90 R08: 0000000000000001 R09: 0000000000000001=0A=
R10: ffffc90005793da8 R11: 0000000000000000 R12: 0000000000000002=0A=
R13: 0000000000000000 R14: ffffffff812ef7c0 R15: 0000000000000000=0A=
FS:  0000000000000000(0000) GS:ffff88813dd00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 000055b72e9c2cd8 CR3: 000000000dedc000 CR4: 0000000000750ee0=0A=
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=0A=
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400=0A=
PKRU: 55555554=0A=
Call Trace:=0A=
 sync_rcu_exp_select_node_cpus+0x27b/0x440 kernel/rcu/tree_exp.h:393=0A=
 sync_rcu_exp_select_cpus+0x238/0x5d0 kernel/rcu/tree_exp.h:441=0A=
 rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:615 [inline]=0A=
 wait_rcu_exp_gp+0xa/0x20 kernel/rcu/tree_exp.h:629=0A=
 process_one_work+0x359/0x850 kernel/workqueue.c:2297=0A=
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444=0A=
 kthread+0x178/0x1b0 kernel/kthread.c:319=0A=
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295=0A=
NMI backtrace for cpu 0=0A=
CPU: 0 PID: 9 Comm: kworker/u9:0 Not tainted 5.15.0-rc1 #16=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=0A=
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014=0A=
Workqueue: events_unbound toggle_allocation_gate=0A=
Call Trace:=0A=
 <IRQ>=0A=
 __dump_stack lib/dump_stack.c:88 [inline]=0A=
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106=0A=
 nmi_cpu_backtrace+0x1e9/0x210 lib/nmi_backtrace.c:105=0A=
 nmi_trigger_cpumask_backtrace+0x120/0x180 lib/nmi_backtrace.c:62=0A=
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]=0A=
 rcu_dump_cpu_stacks+0x125/0x17b kernel/rcu/tree_stall.h:343=0A=
 print_cpu_stall kernel/rcu/tree_stall.h:627 [inline]=0A=
 check_cpu_stall kernel/rcu/tree_stall.h:711 [inline]=0A=
 rcu_pending kernel/rcu/tree.c:3880 [inline]=0A=
 rcu_sched_clock_irq+0xc20/0x1360 kernel/rcu/tree.c:2599=0A=
 update_process_times+0xac/0x100 kernel/time/timer.c:1785=0A=
 tick_sched_handle.isra.20+0x27/0x70 kernel/time/tick-sched.c:226=0A=
 tick_sched_timer+0x8a/0xb0 kernel/time/tick-sched.c:1421=0A=
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]=0A=
 __hrtimer_run_queues+0x23e/0x610 kernel/time/hrtimer.c:1749=0A=
 hrtimer_interrupt+0xfe/0x280 kernel/time/hrtimer.c:1811=0A=
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]=0A=
 __sysvec_apic_timer_interrupt+0x9c/0x2c0 arch/x86/kernel/apic/apic.c:1103=
=0A=
 sysvec_apic_timer_interrupt+0x99/0xc0 arch/x86/kernel/apic/apic.c:1097=0A=
 </IRQ>=0A=
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:=
638=0A=
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]=0A=
RIP: 0010:smp_call_function_many_cond+0x1d2/0x550 kernel/smp.c:969=0A=
Code: a6 04 00 4c 63 fd 49 8b 1c 24 49 83 ff 07 0f 87 31 03 00 00 4a=0A=
03 1c fd 80 98 62 85 8b 43 08 a8 01 74 0e e8 40 a6 04 00 f3 90 <8b> 43=0A=
08 a8 01 75 f2 e8 32 a6 04 00 eb ad 48 83 c4 40 5b 5d 41 5c=0A=
RSP: 0018:ffffc9000067bc80 EFLAGS: 00000293=0A=
RAX: 0000000000000000 RBX: ffff88807dd2f9c0 RCX: 0000000000000000=0A=
RDX: ffff88800985c480 RSI: ffffffff8132ebc0 RDI: 0000000000000001=0A=
RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000001=0A=
R10: ffffc9000067bc28 R11: 0000000000000000 R12: ffff88807dc2a900=0A=
R13: ffff88807dc2a908 R14: ffffffff85a27620 R15: 0000000000000002=0A=
 on_each_cpu_cond_mask+0x48/0x90 kernel/smp.c:1135=0A=
 on_each_cpu include/linux/smp.h:71 [inline]=0A=
 text_poke_sync arch/x86/kernel/alternative.c:929 [inline]=0A=
 text_poke_bp_batch+0xb6/0x2c0 arch/x86/kernel/alternative.c:1114=0A=
 text_poke_flush arch/x86/kernel/alternative.c:1268 [inline]=0A=
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1275=0A=
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146=
=0A=
 jump_label_update+0xbc/0x190 kernel/jump_label.c:830=0A=
 static_key_enable_cpuslocked+0x77/0xb0 kernel/jump_label.c:177=0A=
 static_key_enable+0x16/0x20 kernel/jump_label.c:190=0A=
 toggle_allocation_gate+0x71/0x240 mm/kfence/core.c:626=0A=
 process_one_work+0x359/0x850 kernel/workqueue.c:2297=0A=
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444=0A=
 kthread+0x178/0x1b0 kernel/kthread.c:319=0A=
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295=0A=
Sending NMI from CPU 0 to CPUs 2:=0A=
----------------=0A=
Code disassembly (best guess), 2 bytes skipped:=0A=
   0: 02 00                add    (%rax),%al=0A=
   2: e8 cb b1 f1 02        callq  0x2f1b1d2=0A=
   7: 89 c0                mov    %eax,%eax=0A=
   9: 48 83 f8 07          cmp    $0x7,%rax=0A=
   d: 77 6c                ja     0x7b=0A=
   f: 48 03 1c c5 80 98 62 add    -0x7a9d6780(,%rax,8),%rbx=0A=
  16: 85=0A=
  17: 8b 43 08              mov    0x8(%rbx),%eax=0A=
  1a: a8 01                test   $0x1,%al=0A=
  1c: 74 0e                je     0x2c=0A=
  1e: e8 3f 9d 04 00        callq  0x49d62=0A=
  23: f3 90                pause=0A=
  25: 8b 43 08              mov    0x8(%rbx),%eax=0A=
* 28: a8 01                test   $0x1,%al <-- trapping instruction=0A=
  2a: 75 f2                jne    0x1e=0A=
  2c: e8 31 9d 04 00        callq  0x49d62=0A=
  31: 83 4b 08 01          orl    $0x1,0x8(%rbx)=0A=
  35: 48 89 de              mov    %rbx,%rsi=0A=
  38: 44 89 e7              mov    %r12d,%edi=0A=
  3b: 4c                    rex.WR=0A=
  3c: 89                    .byte 0x89=0A=
  3d: 73                    .byte 0x73=0A=
