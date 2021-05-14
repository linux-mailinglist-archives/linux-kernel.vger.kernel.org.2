Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA11380B28
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhENOK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:10:57 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:10240 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234171AbhENOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:10:28 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EE0eHZ023088;
        Fri, 14 May 2021 14:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=D7637F4WKWWG93vgFfvEnt76vFOCAmiG7P1PTILbd4g=;
 b=AVmmPsuy6HFO8qvzji7n+WkUDhuXyAWODmBaluW9eIsQ2c1IMUIW94CPF71a47qz0ROI
 abIvydEhxFwfIcTJ3bteR12hhDOPTahXoc2gSrqcx6AcXuemq1e309U615BaQCIslOg2
 chI9GmmoulX/V4pN0DSYtP+EsuvGfbvS2lpA97t//AJRmeFiRP50anMdGYr0ymbbCZoZ
 h7VK9KyoYRgx2GTcBPF3A/EH4hUJ2sji6Y4ofz+wdxywebW0Mrr5QFt+ZS8E6JWvqzpN
 sKOK35iEf/huHmMnR+w0pBECc7B2IAzWftHKJcwu+P581RePClljqe+lA0qe5HBAjmcU jQ== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 38hmkx2ncp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 14:07:31 +0000
Received: from G9W8455.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id E85C48D;
        Fri, 14 May 2021 14:07:30 +0000 (UTC)
Received: from G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 14 May 2021 14:06:56 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W9120.americas.hpqcorp.net (16.210.21.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 14 May 2021 14:06:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFLvVVsPxRYTAaP63j1BC2JE4sk4WNxgp4zD0VB5q4ONqTy5qL2y61qnpBPdKN7peWclIDA1mmpE5FfgawDDM514+j8jQXNDUj44DyhW7ZfyhgD/PxJfSkQyHp2rc1nvVU19pDS4oxyS5a5O++UMRvhCREQRwnkxKnQfpXfWcpgtOivufgnrLpjB1r2lp/8RKJKF+CmB/wnuL+8QvZXpYuNjmfJjB2q+MqxDFP4J9mjIoVC7dkK3Kaik1VjDpV9S0JCYsvpm4sPwBcYyYw6+Z7fig9LlbDJP0ju4PW2MmsgqdGgt2LWQLZxvTSb5a2o9Blhxjzow6SrVljEfXK7jEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7637F4WKWWG93vgFfvEnt76vFOCAmiG7P1PTILbd4g=;
 b=XtgLEG822iSnPx+iAUubdPcgVeUcQEbyZt/d0/pbTpXqXxNxkyL/ljKkOgIUolUrJUOMBeMIN7CDlLVKLycgAxzi3nJMNDFjYzTwKaQpzcqUgQbUdNMz+i7VU/mo7in311JT8uTL/acSejYF+I/jveJMeMF4edNJIR6JmGeN46yPfMj7aX6pAOnDjqd4roWeUgxYatxSmbqANoC2hfS0zo2TbHaDxptxjiLdiyS33ihl+5erxHF0/UzLYdK72pz5+V+7cKJGW5yLKUD6Z7CmLwZe+p4PLmYcICsP3dk3URM3UA8SetQRPay9wctjDPf3cDg4jd5YhaJ/jfyJqRaz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB0592.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:770e::11) by TU4PR8401MB0591.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:770c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 14 May
 2021 14:06:54 +0000
Received: from TU4PR8401MB0592.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f8f4:b509:72d9:5ea6]) by TU4PR8401MB0592.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f8f4:b509:72d9:5ea6%9]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 14:06:54 +0000
From:   "Meyer, Kyle" <kyle.meyer@hpe.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [RFC] cpufreq: Excessive CPUFreq driver loading
Thread-Topic: [RFC] cpufreq: Excessive CPUFreq driver loading
Thread-Index: AQHXQoF9nK9JnggdOkGbcZj4RcL07qrjDSmQ
Date:   Fri, 14 May 2021 14:06:54 +0000
Message-ID: <TU4PR8401MB05927B583A481A3F1823CD549B509@TU4PR8401MB0592.NAMPRD84.PROD.OUTLOOK.COM>
References: <DF4PR8401MB103590DB5A8656D6748B428E9B589@DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DF4PR8401MB103590DB5A8656D6748B428E9B589@DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [24.183.125.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1823693d-cfbe-44e4-83c3-08d916e18780
x-ms-traffictypediagnostic: TU4PR8401MB0591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TU4PR8401MB05917CEC42581593AFB4FAB29B509@TU4PR8401MB0591.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GC/pGg0nG9f0n7oUTWC1KeJ4njJ+F6vDQItDA9xzESRmNAjPbCWRvDXGysJkynEzsp/uGY+7x/rpi85NSQpdBLJOS7l/QpHU20zzhqR3AzE2Hds1lXOcGmm0TMt4bPiIK+qqSruDBVgPOFQJPzaz6RK1goTPqQSULIAcLBFSW/7h7szlJeT4hqFVvyaG+DpPJ06OoMoGPUAqECtnZAix6nB6w1kE4ONsnOQhOgdcTe/bMt6E7kOOKN0l/KRRYIu3vUCEMdP+W8AbnF2MvtE0n/BcNl4xfRzucZLJ9JR4pbEIVoRaZLYUa4Rs80I7zYNCi34dZUlobAWPxi7EpmUkNJjShVi8qUkmpkI9OXjftXfGeW7e0PuNCa+viPKsxGRNX7bY0prMJ+sUSqH++gXx/6m1R73PyFXpYKmqdfPx43M/ccZ1RiR1KtA4zB/da8qSlCPFnRj5iv0mLTr2niV8DeMeSSCazhkmZ2XIeBx6k1hDDNsVZN6PBkUPm8ZyUUDnxofL0PmtgGREdp/3KH6itKueTB6a2pG3KmrT3v7C/HiofAeQt/jJxocq6MUpUOT4z3JI3kiHIEVQXaYk0YmrEeqEWNGTrnvjR1EFXlCUP2k27S0QEzy6UppCfrYBF4tL8+0A79RXKj4wDbcJxR5VEkS/vry7OeoecqizUqb46/h3QVQYH34xTvJi+GD4EBcxB3AaLU2WGkL3TwcQ9d+khj/RC6NsO/B5FroeONaEuKw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB0592.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(396003)(366004)(83380400001)(8936002)(122000001)(4326008)(55016002)(66446008)(53546011)(6506007)(5660300002)(91956017)(66946007)(9686003)(52536014)(66476007)(66556008)(33656002)(966005)(64756008)(38100700002)(478600001)(76116006)(316002)(71200400001)(6916009)(54906003)(26005)(2906002)(186003)(86362001)(8676002)(7696005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H5G4tszZs3he7UsfvvvN7EixrklkO4xKUTwguOU9mLZo/oj+Tf210+Qi/Dxk?=
 =?us-ascii?Q?uFT59QwqmcGKJgCHuKxYU8a4LTyod0/w94VyeE0zZw0blC5wf3uUIUo73HgC?=
 =?us-ascii?Q?9uMty5neMptNOa43VEuPjSSvjjXdl+SXRW0p7e90GlGa+c571DereFRhACdX?=
 =?us-ascii?Q?XMJiO4omZBjKOSHFa6fxWPGhpXjxKZUK4OoHy1NroNcyFpeiivDuBBx5kgLJ?=
 =?us-ascii?Q?VBONqDRfo5+evyvUGMWT2OG/2syMTQ8mhaxwOpPax23YclHzFh1PvICtqwPn?=
 =?us-ascii?Q?/+ubnMPNl5iX7gQzLHS6b2zGq3aUKnN3k6AbHQty229CQ+LEfO2hCApxgD8n?=
 =?us-ascii?Q?KD2U/0hXd0AHDqvUmTgj/tqNL/MBqcdlo7VyBSM3AbxeW8S26hn/fgq5TILC?=
 =?us-ascii?Q?LezS06lZiLOv7iSaY+vXgiQR06OiTuEPzLVDUOmxp83/oa8/d3z4zw4GHknj?=
 =?us-ascii?Q?VQrzLk3K88uLo7FwEyP/H5sHQRkg0dC3uPIwbQZAA8SvPsMV8z2C3SVb6WKY?=
 =?us-ascii?Q?4ibN0XNVPLtq8gB5NwkNlJoeM1Zh4n4ccJahSrgubfwpXMaBo8X9VWIHYcxe?=
 =?us-ascii?Q?ZC7/o0i43fsfeYFZKPtaxniNC4e9nag75f0ACob1C0l9Sgs5yzzQR7JlPZGS?=
 =?us-ascii?Q?robVEk/7BuKjTijEMombcibSZwsMCiUWN5D11tF/9Vzw0zrF/96lpNt84jZe?=
 =?us-ascii?Q?E7/4BRUV008usdF2wrfdzeatdvLG4R5yu6//Hei+WBBTz4pm0Xj3vZoRIdaJ?=
 =?us-ascii?Q?u8fRh+sPo6y8pgmV3WNC3tIB95C5iV1wwmKD45HrM+RKXLpmp+2eU8nCyMws?=
 =?us-ascii?Q?mliMOf4GHqkK2WAhm03E0p/zf+7jVlptCCZxzw6YXU89+5dBZ6xhM+eamAdj?=
 =?us-ascii?Q?SH47UA+JrBQchK5gch31L+r9+wTXcj0UFojR4pVoq3pLHajmUnhT5n5Ybkw0?=
 =?us-ascii?Q?gpoBLsW+ftNDUV3AZ5ps/5J0XbQMkYu8lQdJuptMngudRZ15Ay2qMPbykLrc?=
 =?us-ascii?Q?rkp6cO7LVZLJexdz4fzeuJODjVDceDkA6XFy0GgQP4luY7Zl1VUBH1ihAif3?=
 =?us-ascii?Q?tye4gPteTpAdGHE8DAmfYTcv2xgnyrCnd2j/4PySjDkGXH5qKVf2fLHakRfY?=
 =?us-ascii?Q?x25A+bNpuZ3SW2tWNthbZ/xb0pLjwMHVBw/Q79NSOC7Z5vs6m8i60SKX6t9n?=
 =?us-ascii?Q?qvT857dNJPYdzdlp81z1dTcmCZU4AUx3zv/i7zakI2utHGSq8byz2z2dFgh+?=
 =?us-ascii?Q?5uIiU2NmwE9YW3ZaT2yYmP5R4d0UK8WqKXruKkq5vx9Bepg1qVFTXDMJN1G+?=
 =?us-ascii?Q?3e6G2Y2hg7qsXMrjxvNGqjd0?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB0592.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1823693d-cfbe-44e4-83c3-08d916e18780
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 14:06:54.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTuhFKP+Nj+r/kMTyHeDeTdWsutPdmlSw22BdraYZv1uc8VCxR8YaxYJIhSlsfZ07kYHolwC2sYfxoGrJZFtvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0591
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: XAuphFOSKvsZ5aaIGjFb90xVVT8uoBPU
X-Proofpoint-ORIG-GUID: XAuphFOSKvsZ5aaIGjFb90xVVT8uoBPU
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_06:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding maintainers to the CC list.

Thank you,
Kyle Meyer

________________________________________
From: Meyer, Kyle <kyle.meyer@hpe.com>
Sent: Thursday, May 6, 2021 9:25 AM
To: LKML
Subject: [RFC] cpufreq: Excessive CPUFreq driver loading

Hello,

acpi-cpufreq is mutually exclusive with intel_pstate, however, acpi-cpufreq=
 is
loaded multiple times during startup while intel_pstate is enabled.

This issue was reported to the systemd maintainers and they indicated that =
it
should be fixed in the kernel: https://github.com/systemd/systemd/issues/19=
439

During startup, the kernel triggers one uevent for each device as a result =
of
systemd-udev-trigger.service executing "udevadm trigger --type=3Dsubsystems
--action=3Dadd" and "udevadm trigger --type=3Ddevices --action=3Dadd". The =
service
exists to retrigger all devices as uevents sent by the kernel, before
systemd-udevd is running, would have been missed. When systemd-udevd receiv=
es a
uevent it matches its configured rules against the device. If a uevent's
ACTION=3D=3D"add", systemd-udevd will run "kmod load $env{MODALIAS}" from
80-drivers.rules. udev's builtin kmod will then attempt to load modules
matching the device's MODALIAS.

When systemd-udevd recieves an "add" uevent from
/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:XXX it runs "kmod load cpu:type:x=
86,
...,00E8,..." as "cpu:type:x86,...,00E8,..." is that devices MODALIAS.

When systemd-udevd recieves an "add" uevent from /devices/system/cpu/cpuXXX=
 it
runs "kmod load acpi:ACPI0007:" as "acpi:ACPI0007:" is that devices MODALIA=
S.

acpi-cpufreq is loaded as it matches both devices MODALIASes.
# modinfo acpi-cpufreq | grep alias
alias:          acpi
alias:          cpu:type:x86,ven*fam*mod*:feature:*00E8*
alias:          cpu:type:x86,ven*fam*mod*:feature:*0016*
alias:          acpi*:ACPI0007:*
alias:          acpi*:LNXCPU:*

On a system with 1536 logical CPUs, systemd-udevd attempts to load acpi-cpu=
freq
3072 times.

1536 * /devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:XXX
1536 * /devices/system/cpu/cpuXXX

The delay, caused by systemd-udevd attempting to load the driver, has a
significant impact on the startup time. It causes some devices to be
unavailable after reaching the root login prompt as it postpones the loadin=
g of
other drivers.

Each time that the driver is loaded it returns -EEXIST from acpi_cpufreq_in=
it.
static int __init acpi_cpufreq_init(void)
{
        int ret;

        if (acpi_disabled)
                return -ENODEV;

        /* don't keep reloading if cpufreq_driver exists */
        if (cpufreq_get_current_driver())
                return -EEXIST;
...

Changing the return value from -EEXIST to 0 when another driver exists prev=
ents
the driver from being loaded multiple times as kmod won't load a "live" mod=
ule.
Alternatively, blacklisting the driver (or disabling intel_pstate) prevents=
 the
issue as well. Below are the before and after startup times.

# systemd-analyze
Startup finished in 37.939s (kernel) + 10.909s (initrd) + 3min 55.004s (use=
rspace) =3D 4min 43.852s

# systemd-analyze
Startup finished in 38.307s (kernel) + 10.205s (initrd) + 38.312s (userspac=
e) =3D 1min 26.826s

Thank you,
Kyle Meyer
