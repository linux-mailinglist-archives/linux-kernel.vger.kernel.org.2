Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F4F3768BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbhEGQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:28:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:26412 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238151AbhEGQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:28:16 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147GNtam014070;
        Fri, 7 May 2021 09:27:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=VpbkZqhgZ7nG/4f/KfKtMq7UX4aafs91hMtWtgeDVC4=;
 b=GnHBg7AJ2f5ldQqyotJlULlq9WMu0ggRTCFKtZMvur11qgkqpvygW3YK/mG+zbqGxifL
 /bklOfLY661gjiqm6XNfHDgAjaDvdISIR/rvNlfzoQuh80PDmm5+9dFY3sEXQBrcGzXE
 Tni0Zdw+lbMENu9m/YQt1KdwdNAVANEX6ftg2dEcVwAVZxt0BSv0sI23f/wXadBEHaTw
 J+/FZirTn1Q3cGlBM8m2MQfafgq1CK2DO3A8uEgNjR2JpzMDtHXrOO0je7kYmLScssmy
 wOGUyh7ibhPdEmqWGC9zsHqONJw2Cf+4FcA08wwgK9nsZLsKftEKf2QWxMqirXOhA++d Jw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0b-002c1b01.pphosted.com with ESMTP id 38csqksnum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 09:27:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAQqEVMTyYu/0krvyGA4A1/fOiEOwJ7N7LvkeJLbOAe5pCUnuk/CI24A84cyE98CKNVO4e0vcde+43bHMM5JNwwKA+5gi9gJrKaOBQXQAl4RzZM2+4KOHHaP7Dce/nQYEYXaJjyrpR1YruiqsiJvPt3M9W999NTXEq2Qrc/c2Qf7/Wq9aZm67ozVeYLWEKI+iwhyREiOgRIXiLjC+bi8ueX+JOOV1pNqPx/ZpGhfMyj2coEGx6yLRBI+fcO/pqJ5DK20c9r7vIfX3QkMt74XYptZa66SnADk3mbADCiieQAtMRXRdNe2TJhqwyXLww0uAkNhwKozYAoyBEWAZiPyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpbkZqhgZ7nG/4f/KfKtMq7UX4aafs91hMtWtgeDVC4=;
 b=EOuWEhgUoZvFlm1sKrzIBHQo/kpDCxYknS1oF+DDQD7XcYiBRRVhCWVlQP0r1+h4WeM42tJMTAcr+BqdJd6gpb/1TUzDAjy4DFheOG8er1w5bwg51d+5qYuXSz4KxuMi0/I0CLW4nObkYGtHUHXo7GarYcyL1zSYNN2PFIJYL0Ftk1KJfN6jq8JA9KXjIwUQt4dZupboeJq2njC+vMnIwTnAPB3iycaEMVcmsPsQbd0VIxD1UYNWICVTjWWFQCEF7HPxu/VUpIsJa5ZhoVasMAlsvOF7AzWIM8QMXoOK1BJ4cciVVoI41uttOO7UuSjwwWxFqMLNptE8sZDiodNBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by MN2PR02MB6176.namprd02.prod.outlook.com (2603:10b6:208:1bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 16:26:57 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::75cf:5b99:f963:cc07]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::75cf:5b99:f963:cc07%5]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 16:26:57 +0000
From:   Jon Kohler <jon@nutanix.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Jon Kohler <jon@nutanix.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anand K Mistry <amistry@google.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: wrap X86_FEATURE_RSB_CTXSW with ifdef
 CONFIG_RETPOLINE
Thread-Topic: [PATCH] x86/bugs: wrap X86_FEATURE_RSB_CTXSW with ifdef
 CONFIG_RETPOLINE
Thread-Index: AQHXQ1kgF/owkrgfB06Ny/ycZH9MzKrYLfqAgAAG6oA=
Date:   Fri, 7 May 2021 16:26:57 +0000
Message-ID: <E94CE2D1-4C5D-4C74-950F-0BE5F1C9C937@nutanix.com>
References: <20210507155308.97649-1-jon@nutanix.com>
 <cd3517fb-06c2-9188-1a03-3848db6aba3e@intel.com>
In-Reply-To: <cd3517fb-06c2-9188-1a03-3848db6aba3e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [2601:19b:c501:64d0:a9a2:6149:85cc:8a4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0db950b7-a61a-4500-b674-08d91174ef20
x-ms-traffictypediagnostic: MN2PR02MB6176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB61765AEE06DE783320B03D77AF579@MN2PR02MB6176.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kQy9mR5/FB5LHTyKkIfP2kzX6LeB0CFJg0TTVgGOybTuTjyvP2rWpgL7uueHDhz8GVlIGEGmviFPW4uRGYAPkUxfbpT2hePSYdOQdFM0ipU3eRq54AgxUK6EF+GLYjCgJBo0GsC+JsuHMpRK5exC3j5fxGsM4bEaIYyqr4OovuKEj8t5d+5OqCq8+eP1ZS5qp/give3gcxmLDG7JoT3MHBkWOQDCNjhc8pp7dB3vQabEIakmcIHWn4OWtFOSchAL5GUZTNXAbqOC87gNrltf7nbISZ8QYRoxF+wOV7akQm3krP6fRbqJs2QPtjUsYqjfWUL1AO2vt5yTVxOtmnxKmuV5jmNyOoame1Y22aBZG8g4YwkrTCAZ+UPDX+4yfvcWJjjNTpdodcXMtnt6yKNC2SrwHrxoPTYNePqTFg8bVBPotMvRv0MW3118ZaUeeJE7ZIZNtxEp/j7X63igXG8M6S3KHyg4SGlN4pOS2xoA8A8ls6dVDKZ8TO42CZ1zng2di0SNeyX7GEND0IQPaCNtHwm6EsCwz4wXu2594XoCnG2sRuLas0mMieSNwrctWDJHr+pVsGZj5BA1qNMckxC7Vq35L9xKg6n/60zwghIGX46FPAE7oz2e6c22BqMEeP4xI/nCl2BinjxLFg3Q/SkOLjg0aV1ukvLJ1DVjn0vpx7k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4579.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(39850400004)(346002)(64756008)(2616005)(8936002)(8676002)(4326008)(76116006)(54906003)(91956017)(53546011)(66946007)(86362001)(36756003)(7416002)(66556008)(66476007)(6506007)(6916009)(6512007)(478600001)(122000001)(38100700002)(6486002)(33656002)(66446008)(83380400001)(186003)(2906002)(316002)(5660300002)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XfpkbZbiMMcTS+J0UUxL62YrhtjoLhzpbIeClT8cQ58C0HpIw1L0qosCqoAX?=
 =?us-ascii?Q?CyNlVvRVODTPlpNDXa6CiY8+DEYocxTpvHwbqfXRE3PjuLnmilL9alklOF1/?=
 =?us-ascii?Q?LPZjDkY18nLfY3RGOlRdhAD6ApESDVVkyqAv35x6J/LePJhzJQg2frXKiBUO?=
 =?us-ascii?Q?JNlx/3AbDv0SSGlQMf2qu/2Tw9S/8LS1ojgN2eOoWztWap2uK1W/i8zYQmUp?=
 =?us-ascii?Q?JXZQkSFwY9T5EOHWDv0tWcBwYWvfnQmN2g171jmipEHpOUI/KzDY2e4COqai?=
 =?us-ascii?Q?xu2Qpqgi4OxUA8+fAi46Ry67NPHL+ALrf0rfTqWrDHiiKKx58y2j9kJM0xW3?=
 =?us-ascii?Q?374rkGVbkI42YNXC4xHyYYyk0XbjxWXJe7X1SQ8QoZmt2biGUJWmvso/ag+n?=
 =?us-ascii?Q?gE1wF//x3whh6H/TXHrxY+0t5dgqGk1asADFyRmcHIjQUk7p0TeVdes3PMy2?=
 =?us-ascii?Q?Qrx/tNT0+F+BJbvhscGRHvcgZPnAUIPs2VmSr4k3qlCKVJ8F0gV3jR4871bU?=
 =?us-ascii?Q?xhlf7/v6vovl9Ybi7AJ7liMiBqIo6ykb2JZlyvDM7rqk6hOcnguZTdJySpM0?=
 =?us-ascii?Q?WxHDbmEX4yZlsx1IDpzxgFhap7pO7+UqQyaqmT12WVDFFpdc956ged7BhhhD?=
 =?us-ascii?Q?r0+dCXgqH5uIrCVMKXyH8zQebFN2O1WrtBVjpEtkQslKuencO4v6cOJg5QKD?=
 =?us-ascii?Q?wlaRROY+Ui1EZMNCqWMnEsjy3t5mcgnp2Nrlnj35VAmPDBKmOezrzXt4XQlE?=
 =?us-ascii?Q?0UvxmQ3eOJl4bohYYV9fo8rGkjsZT9hxHUq9+J6GIm76FT4sv6VjRy+Z+qXu?=
 =?us-ascii?Q?qudyG6jfYru/hP4xtqtlwI+gTh89D3aBN3+3eMht9ycbKFg+/Ri18E08WjeA?=
 =?us-ascii?Q?FaoAs9evqQdJ4TDxkduzF+Q9V3ae8OCwqfy9BJKUspoodYWCus5Snu48Bqu9?=
 =?us-ascii?Q?YAJVdmMTs5MUQwQBji7YKqaJp1R8TGWd/BiebhBT6DEr8jcjTdN2RlTCeVGZ?=
 =?us-ascii?Q?HOQ7sK81OLYT+XY3bFodOjqX3oTTwKRtdJjs+y3DUkl/jKkRUw6n7k9+ooxE?=
 =?us-ascii?Q?KKPh8mnRSObi/pr17pZJqUwg8xhaGcwt5OA31rs/xPc7IUg1cvGZ1r8F1JAQ?=
 =?us-ascii?Q?1YAkBF2A7t4Ah/QYKbHx0eKlcNLdJE4xIEHHp4vW5IDlx9mQV0MQBA10BAVD?=
 =?us-ascii?Q?2C52KVt/cMCuoMg0HG1T50rqsUBbRQclb7cf0HnVyLZBpmM2GwRPFKs3HriR?=
 =?us-ascii?Q?22zhmbXk6v87LVmnvYWc4bEyEaQ8NDGbUOJOnY3CqXsZaU1UHsNOBOSBJlht?=
 =?us-ascii?Q?2F1+miRysIeI0SmmJj3mLfVeWVQAvZa/PiTuVnePqVpnGmVtNI965zfRjWnf?=
 =?us-ascii?Q?jovcadJFfmlCXXVK+wAQCNVbu+jG?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D6346EF487C484D920E24AFD17A8764@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db950b7-a61a-4500-b674-08d91174ef20
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 16:26:57.4233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHUOAQ2ngno3iiETRmXoVX8VpqbH4k6+Jca9lV+urkT/Oh/IJSZ2zG/BJC+oikzETEmB0eU+/DnVLHCTyQ8eNbOPvr314GlBy+6O0cb7KQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6176
X-Proofpoint-GUID: rZT6GXSkhDg2fneEkJQydeOLz15c6tnB
X-Proofpoint-ORIG-GUID: rZT6GXSkhDg2fneEkJQydeOLz15c6tnB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_06:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 7, 2021, at 12:02 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 5/7/21 8:53 AM, Jon Kohler wrote:
>> The only place X86_FEATURE_RSB_CTXSW is currently in use is in
>> arch/x86/entry/entry_{32|64}.S, where its use is wrapped with
>> ifdef CONFIG_RETPOLINE. If someone uses a system with
>> X86_FEATURE_IBRS_ENHANCED and compiles without CONFIG_RETPOLINE
>> but still has spectre v2 set to auto, the kernel log will
>> print that eIBRS is enabled and that RSB stuffing is enabled;
>> however, that stuffing would never occur.
>>=20
>> To make this behavior more clear, wrap the enablement of
>> X86_FEATURE_RSB_CTXSW and the resulting log message with ifdef
>> CONFIG_RETPOLINE, such that it is compiled out along with the
>> actions it controls.
>>=20
>> This way seems more correct at first glance as this was the way
>> the code was originally written in fdf82a7856b; however, when
>> enhanced IBRS was added, there was a goto added under
>> SPECTRE_V2_CMD_AUTO which bypasses going through retpoline_auto,
>> where X86_FEATURE_RETPOLINE is set.
>>=20
>> The other option would be to remove the CONFIG_RETPOLINE from
>> the code in entry_{32|64}.S, such that it would always be
>> compiled no matter what, such that these two areas match.
>=20
> This kinda dances around the real issue: Does RSB stuffing have
> mitigation value on enhanced IBRS systems?
>=20
> If yes, then we should make the RSB stuffing code in entry*.S available
> separately from CONFIG_RETPOLINE.
>=20
> If no, is it because eIBRS systems are not vulnerable, or because RSB
> stuffing has no mitigation value?
>=20
> Either way, I'm not sure the approach in this patch is the one we want.

Thanks, Dave, for the prompt response and thats a great question.=20

The way the existing documentation reads in bugs.c, all Sklake+
processors are affected by this, so I'd lean towards "yes" to
your question; however, would love the authorative view from Intel
guru's on this, as RSB stuffing is a bit expensive, would be lovely
to drop it on eIBRS systems! :)

In running down the idea for this patch, I did look at Intel's=20
"Affected Processors: Transient Execution Attacks & Related Security
Issues by CPU" guide, interestingly enough the CVE for spectre RSB
(v5 / 2018-15572) isn't listed, so I had to depend on what was written
in the various previous commits around this topic.

Anyhow, happy to take up a different approach depending on what the
powers that be at Intel say to needing RSB stuffing on eIBRS. In
addition to the chatter here, I'll see if I can poke around more on
my own as well.

Thanks again,
Jon
