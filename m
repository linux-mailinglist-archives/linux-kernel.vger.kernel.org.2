Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD54932CA2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhCDBsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:48:04 -0500
Received: from mail-eopbgr770049.outbound.protection.outlook.com ([40.107.77.49]:28910
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232805AbhCDBsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUCdNMlL74hnsG3OF/337Am3DjT5OmzMOj3zmFAia4uvZVpax/gkzLulivq+XvPn3NiY02l7oZ3xaEtZHQC8FuvpWoca94ml8gZ7Cm0WetTRHefzjlVIU88rK1cRwJIoSnQ5fH6msY62ksqhAfPN9troAC7HqHvKPb2Aip8pPUGwPuMt66h5vM9QS0wLU/a/oOoe2w0mjJNiSQ9b+Mq+w7OmFUb67lwI4joiXKPEJ4UuGn6pPTMcW7f066Ftu8en8OH+bB2KtlwQCOHQefb3FpQXxP7A/D6vDN/grU9SywGTQ9o+Npr6STx/pWASb8IeeCWOOL6x+Lhjc52vateprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EgeDcsRCJ/Np8edFfKIbwOPiu/3fYQiMkO0jjU29eI=;
 b=UzZpRvWjZlA7q9qE6UTfwndHTmndNZTzTozExrYgUuze65lYj2dKGenmAzKEnNCc57x1XsrGxn8SbjFsZ2hXZRuCYJlIT6bPTOJkzSjQYELN1t6cKkqC8xlX3tbp4dloQ99oRJeO4DfZ1VB2rLb3XzfBBnMQ1RazYwkO+3zCotEQQ38w6JnyBLyOghBlNiGzRbxnpEekgjbZlpbGxl5dCrZveM00wHVgTbDXkasNihSaBNQjC7o9y78wPnv4kfC/ASomcMW3zsKwArvislrdRNGTxrySh/oiFASMw1+bWwZBVjjegRz1igJhSngJtparcEqzOlpUCaafXNt3EigSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EgeDcsRCJ/Np8edFfKIbwOPiu/3fYQiMkO0jjU29eI=;
 b=YDsdM2LYWpnTZKLPYvRtPdzJQwnpT3RbQTCOJOzlwl/W2AYOXJOlBiHGvDh5jggtSjjNY/RhqJ8HDCMfm2ot1BShXobvqaczF04q1VaXe04F7P/OjVjL+/M7UFtXEnM4RNjxxtrQibdGLC8qWnUZJdzk8H/TbRKL41WnXsF6L6A=
Received: from PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Thu, 4 Mar
 2021 01:47:20 +0000
Received: from PH0PR11MB5175.namprd11.prod.outlook.com
 ([fe80::8c9c:1dc9:353:8eba]) by PH0PR11MB5175.namprd11.prod.outlook.com
 ([fe80::8c9c:1dc9:353:8eba%7]) with mapi id 15.20.3890.030; Thu, 4 Mar 2021
 01:47:20 +0000
From:   "Liu, Yongxin" <Yongxin.Liu@windriver.com>
To:     "vaibhavgupta40@gmail.com" <vaibhavgupta40@gmail.com>,
        "andrewx.bowers@intel.com" <andrewx.bowers@intel.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: ixgbe: disabling already-disabled device
Thread-Topic: ixgbe: disabling already-disabled device
Thread-Index: AdcP85JsQajz+UmXRjWk+/KVlWjmHg==
Date:   Thu, 4 Mar 2021 01:47:20 +0000
Message-ID: <PH0PR11MB517500D906CDFA9CC09DFCCDE5979@PH0PR11MB5175.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63f34c7c-c1f3-4a2f-c1b9-08d8deaf7302
x-ms-traffictypediagnostic: PH0PR11MB4821:
x-microsoft-antispam-prvs: <PH0PR11MB4821FB85EF95335D67F2B8EAE5979@PH0PR11MB4821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:245;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZIIjqNpY5Dg6F81slrbI6+W6YA1nez/FZPPlXR6Ib0abdGEFougImKuIbX/2ptN8awuTRSzxZ/1eQc5rqqe99922XKeoHK+SVQ0SaeACg1hsSuOa/sWjhm+K2NUWVoJK8dcgGjO2O2i/mrY+gg11AqQLb2IpovVkDV9g1ABzsvuVa45RuL1UjeKuVhLiIKB9njoFEijB+Oq8YAkVk+YSMLHd3rejCjBypHvEQGif15mOK+ACNvQBLfOaLsNRLkb6qnmVGf/qEkMLdz3XRD/LP1ExBcd6x7q0HhklFOa+hhdD5/eqxQdb+Fj8FoTPf3PevWtql4sKSuPFLebUltSXHQ/KVIgeLR78KhhR86xJVPGPHn2dlKzL/emnXzGHUhEv8mHKgkge/ibZUmVYKdORPUeeW/nnfZn/E7OuWXrdrRiYDkhlljpmxdsHSmz2qQY3tEZuE0putpPMIoEVX/F4mdiKz3OrexLgc69nuuMx50dwummJjwC7d04ipP1kEM39Lt/1uZOBEAV4lqkyX4euAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5175.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39850400004)(136003)(376002)(83380400001)(9686003)(2906002)(55016002)(8676002)(86362001)(5660300002)(8936002)(4326008)(110136005)(33656002)(71200400001)(186003)(76116006)(64756008)(66556008)(316002)(66476007)(66946007)(66446008)(52536014)(478600001)(7696005)(6506007)(45080400002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Giyj1JvTf6hmqnnIt4HMX+STzZ7jtv54LcGTPCBitpzwqf5R7rROCcO9abdS?=
 =?us-ascii?Q?rKPkOIQaEssJtcW+Fh2Lc7tXnFDB9wyFYYuoRI4JkH/jwIv/c9+vwMMCQcuW?=
 =?us-ascii?Q?qSQwslIWNMcClVKaLECG3iaRLAJsdblSfbXh6mduQ90I8Hjg6ycq0M2JwUKb?=
 =?us-ascii?Q?xvxfGVIlszx0wrTA/CaUXvrtfeGQpeoapQkgMxMAurZ4zFMMLRPEseuZ+PTk?=
 =?us-ascii?Q?F4QH8In8izMfsstBSz045YtLZCrMsD1Kj+hwfp0yc+uCpRKU4DvX98dW6dOV?=
 =?us-ascii?Q?21VPn7jgWb3x/Jp1V1sxxVw3XIUzj4sRKhsHpC7Dt/0kk/xbM/NZk66qmvVE?=
 =?us-ascii?Q?vKNTXT9NdrHn5c/9SJ4zTuCgg9LxF1ypfaHauYUkkKtAmHQSglrnz9rmTfrt?=
 =?us-ascii?Q?6R4uyeAi3FXTTH4z8m9AS4HmdSZivCUpLZJXtilggNjgjlPDoLNAs6ov4TKN?=
 =?us-ascii?Q?ddXCrj/sq8dS/gC5YMH6H9pQzLtVr707aCUIjwZgSqFT1ho+nV9a/KZ9e6T+?=
 =?us-ascii?Q?T5u33WMoz6O7xjSjJd0ngwM8W/y0II8+1+t5gBv2p8fZQiYww05j2UU2+Ctt?=
 =?us-ascii?Q?d/uOpETgnoUa+TqnOhT5Hf4hWzD14CubXCEHdsPNv/dIzIygSBvpkBRHPdyq?=
 =?us-ascii?Q?XuhwD2vPUURRvbmVJXKcZzf/U1RKzel3ZuxYzg6dYwRuDWQs/S3LjaSr35sV?=
 =?us-ascii?Q?dkt8k19jUZpKOESc7RTiU5nySxR9yx5gStGHfA+WbZdjtftJhDJdOLS6HZx0?=
 =?us-ascii?Q?9IIiLUaiTpGeG54fVf1Ac0rG9gBvvWH7VhQZ2yrzuMKfVPd+4X+xO5Sgu3Sp?=
 =?us-ascii?Q?XTrXeJ5egse3jmOEzRMAEjI8+8TXYNWtCCgxudj0aiG46CHDHi6uHd6Xwhnk?=
 =?us-ascii?Q?oUObR9yzjEFF6FEnSR/0dv5TCLeaHoM2J+Inzijlwgb/FrYQ3fBqCosc7aIK?=
 =?us-ascii?Q?F7zaoRdXk0tBfjTdZjnBbe7pPZCvt89qEpLXyGC4RREhx4xU2BOBmzCtBGDi?=
 =?us-ascii?Q?/qPZowiGORpSIkljaaQdUK7FVaIJDW3WELYR4rGrM7WWZgvlf1HofVoc5E2G?=
 =?us-ascii?Q?3KxwuVZ5Y32oq+2f+H9EfSdygOwSxSIOXR55nDJd/THhkn2R9jcAJyJ1nh+H?=
 =?us-ascii?Q?2deJylmqjWC6Ix4dQWQM1NhWNkGVit3JdITNUorXlDTV9jmeHWlVyaljnd7U?=
 =?us-ascii?Q?IT2rBzDnUscZ7aE2QlEWkIT71Vzncw4cOeyUu9cVMDvrYkCJhakRiQq8om5o?=
 =?us-ascii?Q?FYZaAxUcRWSbBgpgCMq18ub+6k8P5FL8Cp2rkcH0Ml0trX5rvei8JxkPZmdL?=
 =?us-ascii?Q?/yU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5175.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f34c7c-c1f3-4a2f-c1b9-08d8deaf7302
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 01:47:20.2053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kgwph7y+RfICc6y9/JKjj/l7w8uYe7tocLCJwSRBELsTzWV4Rgqk/COqQU9lFOo9DSykQIUqIer3yrEXZhrBNySMZFG9fDGUTea+4I/s2c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am seeing the following call trace on the second run of "rtcwake -m mem -=
s 20".
After reverting commit 6f82b2558735 ("ixgbe: use generic power management")=
, the call trace disappeared.

It seems "pci_disable_device()" is used in "__ixgbe_shutdown()", however "p=
ci_enable_device_mem()" was removed in "ixgbe_resume()".
Does this cause mismatch of disable and enable?=20

Could you help to check? Thanks.

Here is the log.

root@intel-x86-64:~# echo s2idle >  /sys/power/mem_sleep   =20
root@intel-x86-64:~# cat /sys/power/mem_sleep           =20
[s2idle] deep

root@intel-x86-64:~# rtcwake -m mem -s 20
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Wed Mar  3 05:37:01 2021
PM: suspend entry (s2idle)
Filesystems sync: 0.000 seconds
Freezing user space processes ... (elapsed 0.002 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
serial 00:03: disabled
sd 2:0:0:0: [sda] Synchronizing SCSI cache
sd 2:0:0:0: [sda] Stopping disk
power_meter ACPI000D:00: Found ACPI power meter.
serial 00:02: activated
serial 00:03: activated
hpet: Lost 5087 RTC interrupts
sd 2:0:0:0: [sda] Starting disk
ice 0000:ca:00.0: VSI rebuilt. VSI index 0, type ICE_VSI_PF
ice 0000:ca:00.0: VSI rebuilt. VSI index 383, type ICE_VSI_CTRL
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata7: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
ata9: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
ata5: SATA link down (SStatus 0 SControl 300)
ata10: SATA link down (SStatus 0 SControl 300)
ata3.00: configured for UDMA/133
ata3.00: Enabling discard_zeroes_data
ice 0000:ca:00.1: VSI rebuilt. VSI index 0, type ICE_VSI_PF
ixgbe 0000:17:00.0: Multiqueue Enabled: Rx Queue count =3D 63, Tx Queue cou=
nt =3D 63 XDP Queue count =3D 0
ice 0000:ca:00.1: VSI rebuilt. VSI index 383, type ICE_VSI_CTRL
ixgbe 0000:17:00.1: Multiqueue Enabled: Rx Queue count =3D 63, Tx Queue cou=
nt =3D 63 XDP Queue count =3D 0
OOM killer enabled.
Restarting tasks ... done.
PM: suspend exit
igb 0000:01:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow=
 Control: RX
root@intel-x86-64:~# ixgbe 0000:17:00.0 eth1: NIC Link is Up 10 Gbps, Flow =
Control: None
ixgbe 0000:17:00.1 eth2: NIC Link is Up 10 Gbps, Flow Control: None

root@intel-x86-64:~# rtcwake -m mem -s 20
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Wed Mar  3 05:37:37 2021
PM: suspend entry (s2idle)
Filesystems sync: 0.000 seconds
Freezing user space processes ... (elapsed 0.002 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
serial 00:03: disabled
sd 2:0:0:0: [sda] Synchronizing SCSI cache
sd 2:0:0:0: [sda] Stopping disk
------------[ cut here ]------------
ixgbe 0000:17:00.1: disabling already-disabled device
WARNING: CPU: 60 PID: 1138 at /buildarea3/yliu15/WindRiver/kernel_upstream/=
linux/drivers/pci/pci.c:2147 pci_disable_device+0x9c/0xc0
Modules linked in: intel_rapl_msr intel_rapl_common i10nm_edac nfit libnvdi=
mm input_leds led_class ice x86_pkg_temp_thermal iTCO_wdt intel_powerclamp =
intel_pmc_bxt qat_c62x crct10dif_pclmul iTCO_vendor_support intel_qat crct1=
0dif_common coretemp watchdog aesni_intel isst_if_mmio crypto_simd i2c_i801=
 cryptd isst_if_mbox_pci dh_generic isst_if_common lpc_ich i2c_smbus wmi ac=
pi_power_meter acpi_pad sch_fq_codel openvswitch nsh nf_conncount nf_nat nf=
_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse configfs
CPU: 60 PID: 1138 Comm: kworker/u193:17 Not tainted 5.12.0-rc1 #2

Workqueue: events_unbound async_run_entry_fn
RIP: 0010:pci_disable_device+0x9c/0xc0
Code: c6 05 d5 93 37 01 01 4d 85 e4 74 36 48 8d bb c0 00 00 00 e8 26 f0 16 =
00 4c 89 e2 48 c7 c7 e8 90 42 ac 48 89 c6 e8 c4 53 9d ff <0f> 0b eb 82 48 8=
9 df e8 d8 fe ff ff 80 a3 e1 07 00 00 df 5b 41 5c
RSP: 0018:ff6d49e649a13d10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ff4a345a47899000 RCX: 0000000000000001
RDX: 0000000080000001 RSI: ffffffffac3cda3c RDI: 00000000ffffffff
RBP: ff6d49e649a13d20 R08: 0000000000000000 R09: 0000000000000001
R10: ff6d49e6468f7d98 R11: ff6d49e649a13ac0 R12: ff4a345a476be850
R13: 0000000000000000 R14: ff4a345a47899000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ff4a345f1ff00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005600c6bf5010 CR3: 000000088480a002 CR4: 0000000000771ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 __ixgbe_shutdown+0x10a/0x1e0
 ixgbe_suspend+0x32/0x70
 pci_pm_suspend+0x87/0x160
 ? pci_pm_freeze+0xd0/0xd0
 dpm_run_callback+0x42/0x170
 __device_suspend+0x114/0x460
 async_suspend+0x1f/0xa0
 async_run_entry_fn+0x3c/0xf0
 process_one_work+0x1dd/0x410
 worker_thread+0x34/0x3f0
 ? cancel_delayed_work+0x90/0x90
 kthread+0x14c/0x170
 ? kthread_park+0x90/0x90
 ret_from_fork+0x1f/0x30
---[ end trace b6646a12cd8b3fb4 ]---
power_meter ACPI000D:00: Found ACPI power meter.
sd 2:0:0:0: [sda] Starting disk
serial 00:02: activated
serial 00:03: activated
ice 0000:ca:00.0: VSI rebuilt. VSI index 0, type ICE_VSI_PF
ice 0000:ca:00.0: VSI rebuilt. VSI index 383, type ICE_VSI_CTRL
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata9: SATA link down (SStatus 0 SControl 300)
ata5: SATA link down (SStatus 0 SControl 300)
ata7: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
ata10: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata3.00: configured for UDMA/133
ata3.00: Enabling discard_zeroes_data
ice 0000:ca:00.1: VSI rebuilt. VSI index 0, type ICE_VSI_PF
ixgbe 0000:17:00.1: Multiqueue Enabled: Rx Queue count =3D 63, Tx Queue cou=
nt =3D 63 XDP Queue count =3D 0
ice 0000:ca:00.1: VSI rebuilt. VSI index 383, type ICE_VSI_CTRL
ixgbe 0000:17:00.0: Multiqueue Enabled: Rx Queue count =3D 63, Tx Queue cou=
nt =3D 63 XDP Queue count =3D 0
OOM killer enabled.
Restarting tasks ... done.
PM: suspend exit
root@intel-x86-64:~# igb 0000:01:00.0 eth0: igb: eth0 NIC Link is Up 1000 M=
bps Full Duplex, Flow Control: RX
ixgbe 0000:17:00.1 eth2: NIC Link is Up 10 Gbps, Flow Control: None
IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
ixgbe 0000:17:00.0 eth1: NIC Link is Up 10 Gbps, Flow Control: None
IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready

-- Yongxin
