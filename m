Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02955311B2D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBFEyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:54:21 -0500
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:48448
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231148AbhBFD3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:29:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep6W6wYDdiFy7OD90JyEwipluQeSmHwKMpf/nSw1ldeISaQwNmJDthxlz3IkQ56c1smes5oY7Q71Sd1c59pq6n0q3nkjddwWGsaSAflI/otyrE0tskBHVJs0SHJdPZvgMBvT6lihJKCK5/UNPBs9o0sm4AqnelCkqO1oUiorAQVcLlbI/pjIqRBFF7KeA+Jl89PW0/5CeX11bhGKsFRcC0qFRhCuUfoHOKh3b9VZiVJsij2607G9iZp/OFvyf9MVkiEOC6ETGuJm+gUvHhFuMuNKmHYsKj5ijFrNHJPqssk8+VlvIYIJV36VLHY6GklxB5Wj+NMJ6Jd6FnCJhfYB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4uqpmutN7nK1rqC+f6pOcFrqnMAkj+OyoCF+A8pyzc=;
 b=m4HbFNmlGR6ra+fGlsLWLOEAP6rTXVpDFeZz84Tey2sLgyY0mAwYJJ2+JZNRZcQA2WHZ83sQnz1SzOKzM5RbdEmnM3YN2OLyAyV/gYJlDlZtl4x74LodnxqmxJxJ4bWGiDY1OlpbQDg3s46ukbRfZ6I3Wzhx2EWLIm1GJPCW4IzNffCJxGYxVHO8ji6Y04pKCMUWun6iLX6vaF8VSChh1EPrec1ZnBF6bzqnnrNbfNvAJMq7vfhqWTO7a8K+W4XaAQS2sJeTtGp4B3jdV41i9GJBqCmhbmuels5xyoNh9t+S3/CcDzYI06wl6OzHH03FD3JDBbtiGMvN5VBr6u9flQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4uqpmutN7nK1rqC+f6pOcFrqnMAkj+OyoCF+A8pyzc=;
 b=Eq3cBcUfG7eoJVU+eSI1oua5KPphvtJPmdL22gD8501h6s3Fj5FbEXLfQcJQiKZ46Aj1DTEzt8R02l4Gc9CBhz9/YITPWr+AAAX7VmbslLdC//zCJUyYhl57yFvWRE9r/TiqlmhLcDk2GB+3d8b8J2HsvV34hKa5qrtF1uDRmVA=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3255.namprd11.prod.outlook.com (2603:10b6:a03:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Sat, 6 Feb
 2021 01:50:49 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.026; Sat, 6 Feb 2021
 01:50:49 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzbot+2f6d683983e3905ad8d6@syzkaller.appspotmail.com" 
        <syzbot+2f6d683983e3905ad8d6@syzkaller.appspotmail.com>,
        "dbueso@suse.de" <dbueso@suse.de>
CC:     "oleg@redhat.com" <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB1cHJvYmVzOiBGaXgga2FzYW4gVUFGIHJlcG9ydGVk?=
 =?gb2312?Q?_by_syzbot?=
Thread-Topic: [PATCH] uprobes: Fix kasan UAF reported by syzbot
Thread-Index: AQHW+URAC/bVX6aMT0qizOjNHSMAQ6pKYPGN
Date:   Sat, 6 Feb 2021 01:50:49 +0000
Message-ID: <BYAPR11MB263201A79E051B259F9D0812FFB19@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210202093535.19822-1-qiang.zhang@windriver.com>
In-Reply-To: <20210202093535.19822-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [106.39.150.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06789a7d-48de-4a82-1616-08d8ca41a0e9
x-ms-traffictypediagnostic: BYAPR11MB3255:
x-microsoft-antispam-prvs: <BYAPR11MB3255A505D1F47457DAAA775EFFB19@BYAPR11MB3255.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWctUJqYQySrm/Drgr1lKGh7nwpykNMzJEwu+jdTDy9hMkMyVb5n+ABd0m7mMybOnUlvnPkHGJqALBaSLrg69fnyePCY0Jd+vEIcRLxBpDXMF1MLfvc84mzWM7R3C2psDDiG/ZITpiutKme3tRRjD04dR+Rf92UQRW36nCa4RbunX0gBx4euvN1Znnx3JiPJcfTfI3uCFlxOwzRlqdaopBz+yHF/KDF3HOKrfRNyNZsOC4WOKyTC8XjlRED4lIZksX9YBidQQF+ta8EPXIp9bU1YHR+jWQTPf5KSs9h/BzwQCEragmLCVG7IGYlKZIa47n4479grSBz1nAJdVy1ZO+Aupjbey3/WWnqAnfb9/6TwDe0jx8+ayVMiEmQWtR6WXqo5+3JU+MEaHhaIqDAAyPZoWEuSWFNarSFpqJOqdGKruGM+jDG1UDBk+xsdmsGHGvKW0Fv5u742WzP5d+2pQH3mBgLAdwOJc8B0BQaUUtBfhLioKqFJeuFfxSseSEQtx/AyGF5vc93YLR0tuQ9odg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39830400003)(136003)(9686003)(316002)(55016002)(110136005)(66946007)(54906003)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(224303003)(2906002)(5660300002)(26005)(8936002)(6506007)(86362001)(52536014)(83380400001)(71200400001)(478600001)(33656002)(7696005)(4326008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?OXNxOVVPM0lFWFQyRytqWTU1ZDJVbU5aMkFPOVpkbmxmTFpIZzNsVWkzM1kx?=
 =?gb2312?B?TzNyQnhMdVR4UHRnenNlYmRUODhaL2MxWVRnQ2VPUDNOZ1oreEVtUDluMW9L?=
 =?gb2312?B?ZkFuWjErSUl6MGZYMmZ0eFFvNmdCWGZ0WDFTeE5OU3JCbVEzV1JUVUZNOXhY?=
 =?gb2312?B?ajUzU1N6c2lzV2plWXN4ejRFU2ZDK3daejd5NlNMT3d5Zjl6Y3RuR0dWWGM0?=
 =?gb2312?B?NGdBdzZVcjRFR1ZQSkxWVi8yaFpzaVkyaHh6VnUxOFVqUXAza2tyaHlvZnI5?=
 =?gb2312?B?NDdsNnZncUdIQmw1aWxuTXozdXBJR1F1UmxqTXcyU0JBSk50emZ1R1hiKzZF?=
 =?gb2312?B?cW02dDJTK0dwT1FCalBiR0F1UVV0ZytDL3dqS1ZqMmU3V2xNVHVHZTM3bjJl?=
 =?gb2312?B?dlJvQUR5YnJuYVJ4NG9VdzBYbDduUG4yWkJuTnpFTXhOMnZBMEdvbmVDeHda?=
 =?gb2312?B?UVJGRTRnbmpFK0VrYy9YVjZhY1I5bmZjT0hCNytKTktqck43d0EybTdzSCti?=
 =?gb2312?B?b2NEVlphU3phRjVkYk92d1YyT001bk1RMDRBeG1VekdNaDIxT2t5dmV4YmQx?=
 =?gb2312?B?WXUwSExqZWIvRDEyeFdXNHVYSmc2UktndG13QWpMVWtWcmlQUVZtUEEyYjlk?=
 =?gb2312?B?RFIwOHplaXpRcFVPT2FiTnY3TGJKUjYwM3FPY1lwaTNZL2ZuRVk3RXh6NitY?=
 =?gb2312?B?TnlhTFZNdHd0dWs5Z202MkJTMmx2L1FBcE9Ub3pCOGNHNmh6SUV0dUtyVVdB?=
 =?gb2312?B?bG5JR0QwK0RjZ3ZKdFNheXZWVndUWWhBS3ZyOTY4MVp2TXd1YmdsRlMvcjZG?=
 =?gb2312?B?T0ZHR2VRaEEzTG5vSUZVc083UEgwMk82c0N0anJ3b29aZ1NNdGFMSzFiQUlQ?=
 =?gb2312?B?Mm5PUy9DZ2d3TG5WUlhRcWlhZkhmaVJoRWVvcmxlL1RSaWJoNHhBS3FZbXdI?=
 =?gb2312?B?a3hZU0R1OHU0Q3lCUkkyOE5YdTdsR0ppYWJSMGFYcStzdzhrTHBnaHNyZGsz?=
 =?gb2312?B?NjBla3VMZTRNaHg5NCtEcWMvNzU4aGx1TEJTRmdyZ1Jrd013dXdQNXVnN3Ix?=
 =?gb2312?B?V2V4MWhaa2Jjakk2QVBMb0dFYldBN0o4Q21MNldIYnlnbDFuZEFOaG9MV0ZY?=
 =?gb2312?B?SmJhaG04RFpFRVdWTTV2ZnVSZ09STURhTkxacEFMZWt4NXB2bHppYm9RMWpa?=
 =?gb2312?B?dVkzWjFhOGJRQ3lsOVNaTWR0ZEZXaFhhRFFFQ3VEQUdmejdzN3BZQ0gvS1RW?=
 =?gb2312?B?blhTTUtRWU1IT0pnMitoR2NweGpBZWltc3g3UUVuWU5hN3dRTTNGYTVSZXkz?=
 =?gb2312?B?OFUxN00zMFlSOW9VUmZuajFSakVZeDl5cll2Tnd0dEJobGkwS2xndGl5b0Jw?=
 =?gb2312?B?TXh3Wi93dUU0bmNwa0pZSzJvZGN1RXAwdkFKQnFESVJHaDhONG1SbThEcXpy?=
 =?gb2312?B?NE4wMUtLQ3ZLZDlRQWZVUUlNdjllVkE5eUZCUHZEYTc0NTRsTjRKRW9tVkIy?=
 =?gb2312?B?QUhlVjVXVWpkZU9TTFFud0JBR3JzMFdiZjNBUUhKNm92L2EwMmJaeFVhTjFN?=
 =?gb2312?B?Qm9hOTlGK21wL2JrVHczc0l6b09aemFldDVuTVVnTTEyYWo0NGhZRUl1V1o1?=
 =?gb2312?B?eXI0aHlicFFYQ0srZGJRNUVpKzl6SXBkQWNBeE1ERDBqcHNRZHl4RXh5aFdU?=
 =?gb2312?B?bnlzYUJCb3ovNm1PcGpRNzc3Z3RXTlJoaFAvb0h0UEcwNGZsVVg2SEpsUllB?=
 =?gb2312?Q?dxsyo49kHJQXNgAAC0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06789a7d-48de-4a82-1616-08d8ca41a0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2021 01:50:49.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4F9c0OIcyvg0nleHuh+VpEdlua//Y/ALYnoAG7OHKJiXH0zp7zovCJw+Jv7ZhX/nVfrIGd1rSas5/MI4gqpU41B+yhKJKCSARSpALq3brOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3255
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gcGV0ZXJ6DQogVGhpcyAoInJidHJlZSwgdXByb2JlczogVXNlIHJidHJlZSBoZWxwZXJz
Iiltb2RpZmljYXRpb24gbWlzc2VzIHRoZSBpbmNyZWFzZSBpbiB0aGUgcmVmZXJlbmNlIGNvdW50
ICwgc3l6Ym90ICBoYXZlIGJlZW4gcmVwb3J0aW5nIHJlY2VudGx5IC4NClRoYW5rcw0KUWlhbmcN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBaaGFu
ZywgUWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+DQq3osvNyrG85DogMjAyMcTqMtTC
MsjVIDE3OjE3DQrK1bz+yMs6IHBldGVyekBpbmZyYWRlYWQub3JnOyBtaW5nb0ByZWRoYXQuY29t
OyBzeXpib3QrMmY2ZDY4Mzk4M2UzOTA1YWQ4ZDZAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0K
s63LzTogb2xlZ0ByZWRoYXQuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98zi
OiBbUEFUQ0hdIHVwcm9iZXM6IEZpeCBrYXNhbiBVQUYgcmVwb3J0ZWQgYnkgc3l6Ym90DQoNCkZy
b206IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4NCg0KQ2FsbCBUcmFjZToNCiBf
X2R1bXBfc3RhY2sgW2lubGluZV0NCiBkdW1wX3N0YWNrKzB4MTA3LzB4MTYzDQogcHJpbnRfYWRk
cmVzc19kZXNjcmlwdGlvbi5jb25zdHByb3AuMC5jb2xkKzB4NWIvMHgyZjgNCiBfX2thc2FuX3Jl
cG9ydCBbaW5saW5lXQ0KIGthc2FuX3JlcG9ydC5jb2xkKzB4N2MvMHhkOA0KIHVwcm9iZV9jbXAg
W2lubGluZV0NCiBfX3Vwcm9iZV9jbXAgW2lubGluZV0NCiByYl9maW5kX2FkZCBbaW5saW5lXQ0K
IF9faW5zZXJ0X3Vwcm9iZSBbaW5saW5lXQ0KIGluc2VydF91cHJvYmUgW2lubGluZV0NCiBhbGxv
Y191cHJvYmUgW2lubGluZV0NCiBfX3Vwcm9iZV9yZWdpc3RlcisweDcwZi8weDg1MA0KIC4uLi4u
Li4uLi4NCiBfX2RvX3N5c19wZXJmX2V2ZW50X29wZW4rMHg2NDcvMHgyZTYwDQogZG9fc3lzY2Fs
bF82NCsweDJkLzB4NzANCiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5
DQoNCkFsbG9jYXRlZCBieSB0YXNrIDEyNzEwOg0KIGt6YWxsb2MgW2lubGluZV0NCiBhbGxvY191
cHJvYmUgW2lubGluZV0NCiBfX3Vwcm9iZV9yZWdpc3RlcisweDE5Yy8weDg1MA0KIHRyYWNlX3Vw
cm9iZV9lbmFibGUgW2lubGluZV0NCiB0cmFjZV91cHJvYmVfcmVnaXN0ZXIrMHg0NDMvMHg4ODAN
CiAuLi4uLi4uLi4uLg0KIF9fZG9fc3lzX3BlcmZfZXZlbnRfb3BlbisweDY0Ny8weDJlNjANCiBk
b19zeXNjYWxsXzY0KzB4MmQvMHg3MA0KIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDQ0LzB4YTkNCg0KRnJlZWQgYnkgdGFzayAxMjcxMDoNCiBrZnJlZSsweGU1LzB4N2IwDQogcHV0
X3Vwcm9iZSBbaW5saW5lXQ0KIHB1dF91cHJvYmUrMHgxM2IvMHgxOTANCiB1cHJvYmVfYXBwbHkr
MHhmYy8weDEzMA0KIHVwcm9iZV9wZXJmX29wZW4gW2lubGluZV0NCiB0cmFjZV91cHJvYmVfcmVn
aXN0ZXIrMHg1YzkvMHg4ODANCiAuLi4uLi4uLi4uLg0KIF9fZG9fc3lzX3BlcmZfZXZlbnRfb3Bl
bisweDY0Ny8weDJlNjANCiBkb19zeXNjYWxsXzY0KzB4MmQvMHg3MA0KIGVudHJ5X1NZU0NBTExf
NjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCg0KIGZpeCB0aGUgY291bnQgb2YgcmVmZXJlbmNl
cyBsb3N0IGluIF9fZmluZF91cHJvYmUgZnVuY3Rpb24NCg0KRml4ZXM6IGM2YmM5YmQwNmRmZiAo
InJidHJlZSwgdXByb2JlczogVXNlIHJidHJlZSBoZWxwZXJzIikNClJlcG9ydGVkLWJ5OiBzeXpi
b3QrMTE4MmZmYjIwNjNjNWQwODdhMzhAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KU2lnbmVk
LW9mZi1ieTogWnFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPg0KLS0tDQoga2VybmVs
L2V2ZW50cy91cHJvYmVzLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9rZXJuZWwvZXZlbnRzL3Vwcm9iZXMuYyBi
L2tlcm5lbC9ldmVudHMvdXByb2Jlcy5jDQppbmRleCA3ZTE1YjJlZmRkODcuLjZhZGRjOTc4MDMx
OSAxMDA2NDQNCi0tLSBhL2tlcm5lbC9ldmVudHMvdXByb2Jlcy5jDQorKysgYi9rZXJuZWwvZXZl
bnRzL3Vwcm9iZXMuYw0KQEAgLTY2MSw3ICs2NjEsNyBAQCBzdGF0aWMgc3RydWN0IHVwcm9iZSAq
X19maW5kX3Vwcm9iZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3Qgb2Zmc2V0KQ0KICAgICAg
ICBzdHJ1Y3QgcmJfbm9kZSAqbm9kZSA9IHJiX2ZpbmQoJmtleSwgJnVwcm9iZXNfdHJlZSwgX191
cHJvYmVfY21wX2tleSk7DQoNCiAgICAgICAgaWYgKG5vZGUpDQotICAgICAgICAgICAgICAgcmV0
dXJuIF9fbm9kZV8yX3Vwcm9iZShub2RlKTsNCisgICAgICAgICAgICAgICByZXR1cm4gZ2V0X3Vw
cm9iZShfX25vZGVfMl91cHJvYmUobm9kZSkpOw0KDQogICAgICAgIHJldHVybiBOVUxMOw0KIH0N
Ci0tDQoyLjE3LjENCg0K
