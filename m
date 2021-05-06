Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE437559A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhEFO0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:26:48 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:61622 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234002AbhEFO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:26:45 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146EOCQo004585
        for <linux-kernel@vger.kernel.org>; Thu, 6 May 2021 14:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=MtMa5tAeQXcl+et53roP/EZmPPmh+OFXhnzxOG2mRCo=;
 b=CGB+pjH3HcqRz4C6kCLZMfzERkffHA5dx+IdPY0isigijsYIFeC8Qi4k0UDhpS+LY3GI
 XkstS3vQqDOHwRQZoO54R6WA5XRIcGSN0JpRySjRRgsrDAM0dluKeMIT5dKitrh8/2mP
 uemr/mCVoIEPR4/qfF12HWDDbJnvGspMv/u8lbD84ywbp4AAr7pviv/XnKyFsj3cuyxa
 BzDj4Xxo08peZ8rzPYeQ3OL94jZKlDuxCfAUfFHpcwPemrY3mlVJEsuLD3VoXGITPCc6
 9Fj2drUfQ+Oap6G/h2/y6TrZ4N5vkZVdnvIP3cr8keeclQGBXK+ZNVGVCz8i4vewe0/g 8A== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 38cev8hrnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 14:25:47 +0000
Received: from G1W8107.americas.hpqcorp.net (g1w8107.austin.hp.com [16.193.72.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id BC19C99
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 14:25:45 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) by
 G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 6 May 2021 14:25:32 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.241.52.10) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 6 May 2021 14:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me96Hcz4kIWF0UVOQ82UyiwksP8ET7EehixT8Piwtwhxa776OtE1fPG3eNt8S5rAwiRFxrZMcKDMo2IDB17WRDPxGcc+MhAc9eP2PYbceE4Pe7UyyAziB3GElzTTVoVGKMGk8jnpb0Ni4g7+nyMfizvFWJNoI/21bsODf2b+0FUR5b34ojV4VGBkAxt0XeyB4CuE8u+as8A5jjMt4f9OmP7RoYfBzTUNJNMcED977JWiyRkQDmqaWj8JsKC5xT7y2bYYG8xqRfeoOGBn72eKa4QT9K9wpAR4bMbxBWX1e/XYq9PSkYJryFHow1WCAb2byc45e43i2wLqWrrQLxsBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhegwq64cBGr/Kho877TJropTQvuQbPDTtWtqgmi7fs=;
 b=UkGGTYNg/HgEAdB8r9MVAmuTrjRR4icaYNH2mkPUsfX2/ohMLbEgkDUSpIGCH5VvDSBg0AeutJPM8rnrrmHhR4DZTSXsX2AfFIrh5Nbl3ZOTI9xuJ50sb4ivlPxvsnNehPE5UoXb6BQyRWSjB7BFupN6NUYKeEFtMzs5zOIgN84GyLdNrjdwfiGfp6+a1vetUrGd7SKykNuiRtqqOOvztGhh+4ak6iZv6vlXvxugXKa1JvD4Nq/qf5y7ZdGrsQYA4fHNprXwTHpSs8k+kdC1jOOV73mVZygb3PwkqyEFpmYfaqSxL3Yg7kLSHQUmwAx7Vid82CIE+TalmhVgNl47jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760e::14) by DF4PR8401MB1211.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 6 May
 2021 14:25:31 +0000
Received: from DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dbc:4944:f017:d834]) by DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dbc:4944:f017:d834%9]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 14:25:31 +0000
From:   "Meyer, Kyle" <kyle.meyer@hpe.com>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] cpufreq: Excessive CPUFreq driver loading
Thread-Topic: [RFC] cpufreq: Excessive CPUFreq driver loading
Thread-Index: AQHXQoF9nK9JnggdOkGbcZj4RcL07g==
Date:   Thu, 6 May 2021 14:25:31 +0000
Message-ID: <DF4PR8401MB103590DB5A8656D6748B428E9B589@DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [24.183.125.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4223dd3f-4126-4f5d-337f-08d9109acdc7
x-ms-traffictypediagnostic: DF4PR8401MB1211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DF4PR8401MB121113EF2353CE53ED051D969B589@DF4PR8401MB1211.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cx9qJEotc0/p6ICKDZCEVbNnqqOtJH+Gti1eSUB4Xdj+ARq97gkSBPiXd8qz3/s0XMpUN0MYvvgIxd7DmajPLYSw1hWxtVTt9bYS3S8vflflvUH75y3UonbCEDwectdis5BAUbwzlpyAf4TIrp5A2ymHIvvhckqpBWQ2l9LWYxrxMZBfqgaCSGVYJFC3CH22SYby4PwOsRUt3E9HkN3cS+UXJTzuXqHhSQh//ZeZPe4lIskAPTcLB1SZr8SMKH+gB2hVfuslqd/ETzxSc+eFizl0Kn2vGMGBiXXdhDjm1gEruK5iP59C+lYoyORS8novHd1fQ+VZUgO+J1m7rTCnLO7M0//LNvP43M8frEYP9WrLUMgjLCx6sdzCm+1LptXc6EDNDdF9WAT8oiGFt2j6mUncf0/eWgtvUdazCB/jr5SEDvkjp9cQluuM1uZFJw1Xbc5NOIsi/0EO6WCCTtRri9GsnmgS4pBHUtwsbF/A0R21l4HGA8zOozYA0KU3xpTCf7dg3sfqRbs6AruQ3uowLc/PiVg73BpkKw6WyMtDnlxDBoEFBGJRx+Hxm9n64IDQtd7qOhItA2U9RfCEWmfOk18YJqOwY/suYie20JfT6Qy+31QFpHTDH6+/d1SrGWW98oaZc6D2AKGU03Yvq2DSWljjnmrfuYPk4z55VSmhkZAd+17EN/ejTw9oHuRqEuLLJGnEI8BxnFg+0EH40N/aVB8wFtfHSAOzyS1xBWMbF7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(396003)(39850400004)(86362001)(55016002)(66556008)(76116006)(52536014)(6506007)(9686003)(66946007)(91956017)(66476007)(66446008)(64756008)(26005)(8676002)(71200400001)(38100700002)(122000001)(8936002)(186003)(83380400001)(7696005)(316002)(966005)(6916009)(33656002)(2906002)(5660300002)(478600001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?GX1E8sdFDJCmNr7mnqfq3Zn07YC+2J8qYimZqigZx5M+dxaE6hiVSxnYl4?=
 =?iso-8859-1?Q?vBYFkWKg3w5c0EwZXo6E7310npjbE3529vH1tS3qeiPcJ0tuqZXb/dWsVE?=
 =?iso-8859-1?Q?Par1SSWmru8azuFFZEtw3Tjs6x3ge8nb4OjjZ0XBpzNhBwn8Jv/hbkrflr?=
 =?iso-8859-1?Q?fYXVbFdQfmTsJeqdzL9B0QJ21o517mvJilpiOZ/5ZgHX32j07EGYiXHzBb?=
 =?iso-8859-1?Q?t7r1weeCYUjNRPdhAK/sfZKXuWcyK0krSqlqiC4eXTNfSWwDr/g24vt1+A?=
 =?iso-8859-1?Q?iCw2CTMI1h7YXk4LtoErNcjqPG8bBQfCFmUyCzhpmwderu4CBKNfsMUGJh?=
 =?iso-8859-1?Q?SpLXinbBGZ+hE4zkHyOwZie5DiwrSzlb0k8snev38uyz9gBhL0m+u34GHG?=
 =?iso-8859-1?Q?rkUoeUQPdeO/6+8IKsqYFGFyrrHOm2BBXfRmCb9xhyABxVPluMKf0okuJq?=
 =?iso-8859-1?Q?JE+Uc6ulQlM+kcORmsdo0p6l60W9NEEcBnkdzKyqmyWhZTyXDnrM1CXfCW?=
 =?iso-8859-1?Q?PJqFjMWe0DUgZfK6rcy3c9N9CDo0IMdoFtZMSzQD7Vkt6X7vNqaFzuqION?=
 =?iso-8859-1?Q?GF8w1bsHT0AlADantWwdZen0OcfNE2YT4AbvJgBxGffqH+VsT8H3FZp7At?=
 =?iso-8859-1?Q?l7WTfYKkmS/YQmYdV4HbxmcRkSs5v5e49pB7mzRacfdsFY2ncPxv3UYoYT?=
 =?iso-8859-1?Q?we4ubDYs4ntZbhP4KwvbfOp3VUp1MguuG+XIersI4OyJ1BDwXioG20ACEL?=
 =?iso-8859-1?Q?YANTpv7xAGxbFb7DoVUrOzW/kepTIL3F8vGlziLefT3M8vAmMrV0AMpUOK?=
 =?iso-8859-1?Q?DzVV4evTq7ECy3g5XvdRBQLOY0EFEiPf2n7E4r7H7XDJ/LgYSQtFuJiGRS?=
 =?iso-8859-1?Q?J8BhJb1K6sPzH0jjPAbUQEq+FlGLlFOoJTBioVKJD2djZYz1dUP8dLKKwa?=
 =?iso-8859-1?Q?hDrTh25oG52cAf9Po9UHvicaHhIGhTQim31pQcJkODLreVzE8Q415yQdA6?=
 =?iso-8859-1?Q?9KicrhrVXzcFLGnygF7xoaa8IXRcYv62wftLj8vTv3zNYknzbCiyFcjBOZ?=
 =?iso-8859-1?Q?ln628gAdtIzftTVQNvH8A994Z+kQ4cNKdFwIi0gDt00E8Td5RUJ0Uxs+gq?=
 =?iso-8859-1?Q?iT2J6EgAfKdnyKteIhW8C7B8/xorB0y8KyBrjoAWoB9M4AA3nVR8VjxiHP?=
 =?iso-8859-1?Q?nKwqkE++YD80PjVxF08qB8zph4OFqE91N4eLD4A7NCtNnQkURkx6qLp79q?=
 =?iso-8859-1?Q?el8YwwAbqM90VFfK4J9ffwtX/55rmwn9meaZOkSJGd1jpKNrmUMqbYbhEp?=
 =?iso-8859-1?Q?/+m3KS55gi2IjaL5p6WFx1ONKQYEHxVH3A2ZwUmOeYdx2VPtjtMbbByHgC?=
 =?iso-8859-1?Q?SX5AaVx6Yk?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4223dd3f-4126-4f5d-337f-08d9109acdc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 14:25:31.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgNXFn5AM3ZhxoivyRqV6SVvS/yI4zo7ghLHoEJCGZMD7MeIyO0Broo+HTQyhhYukAPFq/w7NhIEw3TMoXuYhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1211
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: vcYvoqJ5F0lr2En1xBM4KzLHXNo--fVk
X-Proofpoint-ORIG-GUID: vcYvoqJ5F0lr2En1xBM4KzLHXNo--fVk
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Kyle Meyer=
