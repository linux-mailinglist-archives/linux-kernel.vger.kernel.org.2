Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852E63B1CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFWOwS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Jun 2021 10:52:18 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:36173 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:52:17 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2054.outbound.protection.outlook.com [104.47.21.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-29JNa8_QPWqgaEpYmnGsFA-1;
 Wed, 23 Jun 2021 16:49:58 +0200
X-MC-Unique: 29JNa8_QPWqgaEpYmnGsFA-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB3732.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 14:49:57 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 14:49:57 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Safe return of kobject_get_path with NULL
Thread-Topic: [PATCH] kobject: Safe return of kobject_get_path with NULL
Thread-Index: AQHXaD5guylz4e+fzky/qfcToJhYzKshrPLr
Date:   Wed, 23 Jun 2021 14:49:57 +0000
Message-ID: <CWXP265MB2680FAA36A50E96193037B4DC4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680094534A5559B0A904B76C4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680094534A5559B0A904B76C4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c990c3c1-b59c-49cb-529a-08d936562b47
x-ms-traffictypediagnostic: CWLP265MB3732:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP265MB373262BC8FEB0C0919CB57A4C4089@CWLP265MB3732.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:182
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: ZHcws9xZF9j/wt6gx4ndpnJHZGga37fGbhHI4mnxqy1rhmaCyyJKrdT/I6qxnqoxW/aAFJG4LVpIsa9yzQ+crB+1jbff0byeO4SJge0GkcVY1rh8mTVrVXCCwwAFvloRF/mcLkcZ5Lvf7cDTy1qn8GzhaJTXPYAx4i8aylXLhA0g7SvQIQYrFTlc5T4krQ8O/fjtXBo1aW9kXza0Xoruqcqv43o7nbOLyFzEsLYv+SvblwaoF7GPDplSr1l1EqgbqBSUhg7qiqCOioiCKB3KKScLVRcMyiPgg+9h2V7TotzpfMiOZtDZyOHyY4JpRQYc3ntTHa9CFySrjt4yKpPJq0HlHLYoM0AHUwoUDu2ugi+PUXDAPEhoiPHsu5YlWdh6UpkzyFrLy65cuynSvyaT4GOQLdrPI0NyqpGssr+9hboDAxG3Eb1AMjsq1YDY96zsOY098b6SfFjiPZl/6wTTqTQcZQ3Klq3vqLOq2HdxlSrNFtTx9qywSLnHiED2BepAcamsU+gmI6tsR24CzGVXUE6+LG4RuMv1rG22VhrWL+zaZmlcCpdFQSERVBjbjSjqKmV4VuNwisAOkwjN+H1N4i4dHXC1StnxBpYR4BwR3O+IfcN1xx9b/DKgxV32RtXBU2FUn4uphBnR0ht6O2JOhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39830400003)(45080400002)(71200400001)(91956017)(52536014)(8676002)(8936002)(66946007)(2906002)(5660300002)(66476007)(64756008)(66446008)(66556008)(33656002)(9686003)(6506007)(316002)(478600001)(76116006)(26005)(55016002)(83380400001)(110136005)(86362001)(186003)(38100700002)(4326008)(2940100002)(122000001)(7696005);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cooUJuWyQnmDQl52K2I0zGg01Mc2pQJN5xDctaRRXs+a5TYd/PwegHh3jH?=
 =?iso-8859-1?Q?uZW7ZeDbj0NGVbG6or80AVZoh6UkcrXp1W0KUnXGtixksD0gsgs6cHCYxl?=
 =?iso-8859-1?Q?XynR9RwQKRL+q+POT+mfgaj3YRyUD0zRl2GDH6EXcMt80xt3ateYBiOILJ?=
 =?iso-8859-1?Q?a2J5g3U2VDXN/WDj1kc9iyBhK1BnobyRQOR/EsWO5LPO41vrtCaffaxz/Y?=
 =?iso-8859-1?Q?Dj5Xq/pcJf2wyG2XDGlR1t/aPTYQvJvU6D6ZyEzMmdE4HVWuER3sbiWkRz?=
 =?iso-8859-1?Q?8IE4rJRGUOufEeK3z4jBZ0UA84pDku7IMwyla8GAIy5rMlmNgEq94netDn?=
 =?iso-8859-1?Q?OqPW2AV0KOXEosgrPMw+Soyti1yUo9yb7a0pJJHQAnt+cs/lOJj92AMMMj?=
 =?iso-8859-1?Q?mCQ6548lIFHXp+WtTg5edIwU2YJH44PmBKrshvaAM+hSjrx4ZTXDStpr/s?=
 =?iso-8859-1?Q?DTF0QP+JZHrAVr5gOvLO2mu0SwbtMTkCVkScnlqRFOEW5DMRCOK/qWze7n?=
 =?iso-8859-1?Q?9p7L3RrGnC9QXYxzZ8FudTDEaSUPdxhuF4GmYrKd3cmjtNf3M7I8Gl+eBy?=
 =?iso-8859-1?Q?zWHAjVVGNmrqDkm+Hi2HtLtFfGmGUvPjmUXBmi+nGN1PMQ9jO1l5VPu1Z9?=
 =?iso-8859-1?Q?1stueb552951H/cAVi9MGjuY40/9VP1py/uEzZUxT6DLHwyRLI6ofulXLj?=
 =?iso-8859-1?Q?xdCibDNUF6gV69DPybXr90ToqHnZFm4VoTQ6Esid8qeG6ItFXPvT+0pIi+?=
 =?iso-8859-1?Q?AhZOwXvKj8YirMYmRKHesgcWWbjdpJANddnUpVj+NTlDIr9NShfWjI7FJ8?=
 =?iso-8859-1?Q?oD/bkGZd4C/tmRlQFQEbGfgXM8yHJE46ryF+a7V8qoMIiPXC3uPxUEoEHy?=
 =?iso-8859-1?Q?KFun3hfqWc/YR1ebqfOXdicAKXfWghYX9HvJv3pnLY5aBRdonPiPmN0pYL?=
 =?iso-8859-1?Q?xNdKKQ+wOxzXCQYM4ZkuBeIwIOkV95sHlpcvbUWc4oDY3WG9KP1i+OBKWN?=
 =?iso-8859-1?Q?kJApSYc4C69cbcioDfXnsReqbRhz3U/LXyIBvXcPNc9KoKyXhUQv+MKya0?=
 =?iso-8859-1?Q?KcP3TP/y69mcJSlg3Mw0G+YCQz9baLWvz1GFfkWCiqi1sZlsv1T+E7Ezk2?=
 =?iso-8859-1?Q?Eg0wuxGLDRER5O7tgoyZeMqRbNP8RGIF5W2FhDliR+Eu6yD7geRnb+gET3?=
 =?iso-8859-1?Q?8Ma0Zp2U2pUZNTtkvkaY7L/PiWsN1+Z0Z1rCqlpJiUSFHbgbyYhYSuzwpb?=
 =?iso-8859-1?Q?PzIbMrUhpNDsUpkuWrya8OHnzr07nWDUXo8P8Ci5kwO9gA+HB67bhRRuK5?=
 =?iso-8859-1?Q?GoTdPhRO1lGlTThrHusLrQyLFiqvuE0nrKZitdommm4Tl8c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c990c3c1-b59c-49cb-529a-08d936562b47
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 14:49:57.0180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4i+T5FGdjx+awpCrm+0rkzCD1iziHiKNmCSY6Uk2XMXHQC6ibp0i+buczoWEZ0Lar8nhn9GXJ6FUE2z1C+ZjDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3732
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE5A68 smtp.mailfrom=cloehle@hyperstone.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prevents two Oopses I've encountered.
(Sorry for the older kernel)

[ 4650.202534] general protection fault: 0000 [#1] PREEMPT SMP
[ 4650.202554] Modules linked in: serio_raw atkbd libps2 aesni_intel aes_x86_64 crypto_simd glue_helper ahci libahci i8042 fam15h_power hwmon_vid k10temp scsi_mon ftdi_sio usbserial exfat ext4 crc16 mbcache jbd2 fscrypto sg fuse nls_iso8859_1 nls_cp437 vfat fat nfsv3 nfs_acl nfsv4 dns_resolver nfs lockd grace sunrpc fscache e1000e ptp pps_core i915 intel_gtt usbmon button serio ehci_pci ehci_hcd r8169 mii xhci_pci xhci_hcd libcrc32c crc32c_generic crc32c_intel crc32_pclmul radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm agpgart ata_piix pata_acpi ata_generic libata uas usb_storage sd_mod scsi_mod isofs loop overlay ip_tables x_tables sch_fq_codel tpm_tis tpm_tis_core tpm lpc_ich ie31200_edac mei_me mei shpchp parport_pc battery fan thermal i2c_i801 intel_rapl_perf
[ 4650.202746]  intel_cstate ghash_clmulni_intel cryptd crct10dif_pclmul ppdev parport mousedev input_leds iTCO_wdt iTCO_vendor_support kvm irqbypass evdev mac_hid eeepc_wmi asus_wmi sparse_keymap wmi led_class video coretemp intel_powerclamp x86_pkg_temp_thermal intel_rapl cfg80211 rfkill hid_generic usbhid hid usbcore usb_common
[ 4650.202824] CPU: 0 PID: 20750 Comm: python3 Not tainted 4.13.5-1hyLinux #22
[ 4650.202840] Hardware name: ASUS All Series/Z97-P, BIOS 2905 12/04/2015
[ 4650.202855] task: ffff88020f61cb00 task.stack: ffffc90002814000
[ 4650.202873] RIP: 0010:kobject_get_path+0x30/0xf0
[ 4650.202883] RSP: 0018:ffffc900028179e0 EFLAGS: 00010206
[ 4650.202896] RAX: 0000000000000005 RBX: 000000000000000b RCX: 0000000000000000
[ 4650.202912] RDX: 0000000000001000 RSI: 00000000014000c0 RDI: 0000000000000005
[ 4650.202928] RBP: ffffc90002817a08 R08: ffff880217002c00 R09: ffff88020d66b000
[ 4650.202945] R10: ffffea0008537b00 R11: 0000000000000001 R12: 372e63313a30303a
[ 4650.202961] R13: ffff88020d650080 R14: 00000000014000c0 R15: ffff880216352120
[ 4650.202977] FS:  00007f5119e3a640(0000) GS:ffff88021fa00000(0000) knlGS:0000000000000000
[ 4650.202996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4650.203009] CR2: 000055a91ad5d130 CR3: 0000000210c09000 CR4: 00000000001406f0
[ 4650.203026] Call Trace:
[ 4650.203035]  kobject_uevent_env+0xcf/0x4e0
[ 4650.203047]  disk_check_events+0xe3/0x140
[ 4650.203057]  disk_clear_events+0x77/0x110
[ 4650.203070]  check_disk_change+0x27/0x70
[ 4650.203082]  sd_open+0x75/0x190 [sd_mod]
[ 4650.203092]  __blkdev_get+0x348/0x430
[ 4650.203102]  ? __follow_mount_rcu.isra.30+0x68/0xe0
[ 4650.203115]  blkdev_get+0x127/0x340
[ 4650.203125]  blkdev_open+0x79/0x90
[ 4650.203135]  do_dentry_open+0x1bc/0x2e0
[ 4650.203146]  ? bd_acquire+0xd0/0xd0
[ 4650.203156]  vfs_open+0x4e/0x80
[ 4650.203164]  path_openat+0x51e/0x13a0
[ 4650.203174]  ? mntput_no_expire+0x2c/0x1a0
[ 4650.203184]  ? mntput+0x24/0x40
[ 4650.203194]  do_filp_open+0x9b/0x110
[ 4650.203204]  ? __check_object_size+0xb1/0x190
[ 4650.203215]  ? __alloc_fd+0xb2/0x160
[ 4650.203225]  do_sys_open+0x1ba/0x250
[ 4650.203233]  ? do_sys_open+0x1ba/0x250
[ 4650.203243]  SyS_openat+0x14/0x20
[ 4650.203253]  entry_SYSCALL_64_fastpath+0x1a/0xa5
[ 4650.203265] RIP: 0033:0x7f511eb0efe4
[ 4650.203274] RSP: 002b:00007f5119e37830 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[ 4650.203292] RAX: ffffffffffffffda RBX: 00007f5104006b40 RCX: 00007f511eb0efe4
[ 4650.203308] RDX: 0000000000080000 RSI: 00007f511b9a0650 RDI: 00000000ffffff9c
[ 4650.203324] RBP: 00007f511a70a298 R08: 0000000000000000 R09: 000000000000007c
[ 4650.203340] R10: 0000000000000000 R11: 0000000000000293 R12: 0000556257edd1b0
[ 4650.204199] R13: 00007f511d446ab2 R14: ffffffffffffffff R15: 0000000000000000
[ 4650.205027] Code: 57 41 56 41 89 f6 41 55 49 89 fd 41 54 49 89 fc 53 bb 01 00 00 00 eb 13 e8 9e 8a 00 00 4d 8b 64 24 18 8d 5c 03 01 4d 85 e4 74 1a <49> 8b 3c 24 48 85 ff 75 e4 45 31 e4 5b 4c 89 e0 41 5c 41 5d 41 
[ 4650.206990] RIP: kobject_get_path+0x30/0xf0 RSP: ffffc900028179e0



[273327.641637] general protection fault: 0000 [#1] PREEMPT SMP
[273327.641656] Modules linked in: serio_raw atkbd libps2 aesni_intel aes_x86_64 crypto_simd glue_helper ahci libahci i8042 fam15h_power hwmon_vid k10temp scsi_mon ftdi_sio usbserial exfat ext4 crc16 mbcache jbd2 fscrypto sg fuse nls_iso8859_1 nls_cp437 vfat fat nfsv3 nfs_acl nfsv4 dns_resolver nfs lockd grace sunrpc fscache e1000e ptp pps_core i915 intel_gtt usbmon button serio ehci_pci ehci_hcd r8169 mii xhci_pci xhci_hcd libcrc32c crc32c_generic crc32c_intel crc32_pclmul radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm agpgart ata_piix pata_acpi ata_generic libata uas usb_storage sd_mod scsi_mod isofs loop overlay ip_tables x_tables sch_fq_codel tpm_tis tpm_tis_core tpm lpc_ich ie31200_edac mei_me mei shpchp parport_pc battery fan thermal i2c_i801 intel_rapl_perf
[273327.641856]  intel_cstate ghash_clmulni_intel cryptd crct10dif_pclmul ppdev parport mousedev input_leds iTCO_wdt iTCO_vendor_support kvm irqbypass evdev mac_hid eeepc_wmi asus_wmi sparse_keymap wmi led_class video coretemp intel_powerclamp x86_pkg_temp_thermal intel_rapl cfg80211 rfkill hid_generic usbhid hid usbcore usb_common
[273327.641931] CPU: 3 PID: 1636823 Comm: python3 Not tainted 4.13.5-1hyLinux #22
[273327.641947] Hardware name: ASUS All Series/Z97-P, BIOS 2905 12/04/2015
[273327.641962] task: ffff88020bc15a00 task.stack: ffffc9000399c000
[273327.641979] RIP: 0010:kobject_get_path+0x30/0xf0
[273327.641990] RSP: 0018:ffffc9000399f9e0 EFLAGS: 00010206
[273327.642002] RAX: 0000000000000005 RBX: 000000000000000b RCX: 0000000000000000
[273327.642019] RDX: 0000000000001000 RSI: 00000000014000c0 RDI: 0000000000000005
[273327.642035] RBP: ffffc9000399fa08 R08: ffff880217002c00 R09: ffff8802115cd000
[273327.642050] R10: ffffea00084b7b00 R11: 0000000000000001 R12: 372e63313a30303a
[273327.642067] R13: ffff88020f8ea080 R14: 00000000014000c0 R15: ffff880216352000
[273327.642083] FS:  00007f6fb4be0640(0000) GS:ffff88021fb80000(0000) knlGS:0000000000000000
[273327.642101] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[273327.642114] CR2: 00007f2762bb3d80 CR3: 0000000214fab000 CR4: 00000000001406e0
[273327.642130] Call Trace:
[273327.642139]  kobject_uevent_env+0xcf/0x4e0
[273327.642151]  disk_check_events+0xe3/0x140
[273327.642161]  disk_clear_events+0x77/0x110
[273327.642174]  check_disk_change+0x27/0x70
[273327.642185]  sd_open+0x75/0x190 [sd_mod]
[273327.642195]  __blkdev_get+0x348/0x430
[273327.642206]  ? __follow_mount_rcu.isra.30+0x68/0xe0
[273327.642218]  blkdev_get+0x127/0x340
[273327.642228]  blkdev_open+0x79/0x90
[273327.642249]  do_dentry_open+0x1bc/0x2e0
[273327.642259]  ? bd_acquire+0xd0/0xd0
[273327.642269]  vfs_open+0x4e/0x80
[273327.642279]  path_openat+0x51e/0x13a0
[273327.642289]  ? mntput_no_expire+0x2c/0x1a0
[273327.642299]  ? mntput+0x24/0x40
[273327.642310]  do_filp_open+0x9b/0x110
[273327.642321]  ? __check_object_size+0xb1/0x190
[273327.642332]  ? __alloc_fd+0xb2/0x160
[273327.642342]  do_sys_open+0x1ba/0x250
[273327.642352]  ? do_sys_open+0x1ba/0x250
[273327.642371]  SyS_openat+0x14/0x20
[273327.642392]  entry_SYSCALL_64_fastpath+0x1a/0xa5
[273327.642403] RIP: 0033:0x7f6fb9a30fe4
[273327.642412] RSP: 002b:00007f6fb4bdd830 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[273327.642430] RAX: ffffffffffffffda RBX: 00007f6fa400a840 RCX: 00007f6fb9a30fe4
[273327.642447] RDX: 0000000000080000 RSI: 00007f6fb6f5da10 RDI: 00000000ffffff9c
[273327.642463] RBP: 00007f6fb846c928 R08: 0000000000000000 R09: 000000000000007c
[273327.642480] R10: 0000000000000000 R11: 0000000000000293 R12: 0000562253e6be10
[273327.643330] R13: 00007f6fb8efbb62 R14: ffffffffffffffff R15: 0000000000000000
[273327.644179] Code: 57 41 56 41 89 f6 41 55 49 89 fd 41 54 49 89 fc 53 bb 01 00 00 00 eb 13 e8 9e 8a 00 00 4d 8b 64 24 18 8d 5c 03 01 4d 85 e4 74 1a <49> 8b 3c 24 48 85 ff 75 e4 45 31 e4 5b 4c 89 e0 41 5c 41 5d 41 
[273327.645958] RIP: kobject_get_path+0x30/0xf0 RSP: ffffc9000399f9e0
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

