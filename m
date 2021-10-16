Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93D42FFBD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 04:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbhJPCfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 22:35:18 -0400
Received: from mail-bl2gcc02lp2107.outbound.protection.outlook.com ([104.47.64.107]:60832
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232812AbhJPCfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 22:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ccci0MvnJeOYuXdqPpOZVibmRB+Is/XD3MmbVMgD5TvqPOsdX2QLffFmJk0p75qvCYLgxwNNRq/ydIQgMj9LmOpn1WWI71v7c/DSR/XVS5lEXCwx0bJYOJOUevWjVIUYLm6kWDn6sZdXVsOlNtNqQ8SNz0gk5ECnGUMh+Y99pvPN4ET7V2Z5u8nPWx3mAY2UtbEU5hKp0SPMUeTlnvpo70YGk6pllGJQ6SWVUTDnCVqRQ0fuYraK6Jx5DyBQxs2DNT+HlcYevLgiUNgDd8Qd9ULqhNOSssZUTpnKtjnO77tApH552qmvPP6wJPJPSOWckpYyXnw3YD8hWWKb4i1LVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqGBd1TXHCU9LtTzzZvInL6eWIGglPWo1sXfHET6HFc=;
 b=FxSMOmqru16hG2N+rOLJpFNvVWeB/QNrnon+i2AMReVFYPYCMYsHyXHwGUjQasvGS1/C9wtCeEwv/tktjHyrAt9/zK3hq1Eb6NT0IzsYTl+dNGIvDqLqyRHIJIDblOJw2w9fddYpfT5bCkxtO5kHfqZs+P2IuZPhtYgqF3v6G7uzTp6hK1vL+J/TsAKWkNT2aPPtdU+b7fU5nkuVJZXokDodbJne0abUWiCdEtKOiHQcB8jWDVP30v0sAzPRrQOPvxj+ET8bQOW3pk8oxUFYbbr5AkazqDz9a65/Ip1udq61DfoOMIotBSCRVnJS9w3mC6hZxGjvXtTXa2whQBcHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqGBd1TXHCU9LtTzzZvInL6eWIGglPWo1sXfHET6HFc=;
 b=iEupj3HIjDysFT7zoQheex60KqfEQB+vTk0HIuyVFFrSq1nCYeTcqqanDUYMOWMxQxWIu93OZf4f5qlDR+vszfPCwTQz3/T0z6PI/iM5cnowOE9V3KNoZEB05H9nBYq/HW1vxfWgLRWR/Y4ijzeMxw1ItBtTHzdKNWM/PMJWJFY=
Received: from SA1PR09MB7440.namprd09.prod.outlook.com (2603:10b6:806:183::14)
 by SA1PR09MB7758.namprd09.prod.outlook.com (2603:10b6:806:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Sat, 16 Oct
 2021 02:33:07 +0000
Received: from SA1PR09MB7440.namprd09.prod.outlook.com
 ([fe80::b0d6:a789:37f1:1995]) by SA1PR09MB7440.namprd09.prod.outlook.com
 ([fe80::b0d6:a789:37f1:1995%2]) with mapi id 15.20.4608.017; Sat, 16 Oct 2021
 02:33:07 +0000
From:   "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Thread-Topic: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Thread-Index: AQHXwevE+jBPDZzzYE22a/VOYXutsqvUo8mAgABD7D4=
Date:   Sat, 16 Oct 2021 02:33:07 +0000
Message-ID: <SA1PR09MB74400883EDB78A26DF16CD8CE7BA9@SA1PR09MB7440.namprd09.prod.outlook.com>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
 <20211015222719.GG1480361@roeck-us.net>
In-Reply-To: <20211015222719.GG1480361@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 44a9854b-548e-225c-270d-59295ce5cb02
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nasa.gov;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a482c787-e362-4cd3-e4a9-08d9904d49c2
x-ms-traffictypediagnostic: SA1PR09MB7758:
x-microsoft-antispam-prvs: <SA1PR09MB7758C6FA23CA057EA182A698E7BA9@SA1PR09MB7758.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ei+PL0GIuCh9tbvHcqO/bve/WuU0kfBA+BejbuRCmu0pyzSdYP50VyxpkDwOaw4KnLlRFLkvxIFCBGj5FjJW1IZRBGBB1SUGpw/YRB2+4Aee81FX6e98j/pFll/uUo7WU72NhCywaC4Aex+mOA69euqZ/VrkBl930rN9s4zHQ5jOLyQ5R9H7jcAIMfYmPIuOVIRZKeVo1W/x48QleMkWe13IW9PtJFajnKoWNObtmkx0FLPxVvAE/mTemq9SgmlINCKUrakVb9cN9UlPW2aU/d8y6KHmGRym9Swp4IY7Gs4u5NKUzulQ6tMhtXyi7TMRPy6fDyhzwKHgguhXD5iU6Cl4eqDPXqUcatAtztE5pmurpoId6uIVPU70wCUwTF9Gantj2V7V7UqAV6mXuAw1Rq2CEw8oLgjw7wqryTIvX/3bDlFj7bFxCzU5yHHM6QJDP+3Lvu1UywITlblf9xbtVaB4H4L1AZSux05r0apbyqdI4Wn58Fuwo9y/4CuZ+a1QP3qiv9yFp+FG8yjJh5CiGP52FEfnajAcDg5wqoLBpajAg7+SJCwIR17ScHtsVKz3LqVDm46NiAaWYN0R36Zzveigh8UClqYLAWKezx0PRGVdsD1CodJC5a3y4tG3bnqg0qPHNgE+0scPvLsl4Du1HBlsnfDkz/kR0tWcIEx+4gBKTGx9MycqQVwXyqVYu2pnRNJbFVcjKFdFiRclIsjQI0gHTITjj3XZM+4+RqsCSTiB96eZ04idn+AT/GF0cC6DZ1QhHCiLflt6vJ7Gc0/U/GwJqsQ3dF/QSmIjfB6M2Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7440.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(91956017)(53546011)(66476007)(66556008)(64756008)(66946007)(186003)(38070700005)(9686003)(76116006)(66446008)(83380400001)(52536014)(86362001)(55016002)(2906002)(54906003)(8936002)(7696005)(6916009)(4326008)(508600001)(5660300002)(122000001)(8676002)(45080400002)(33656002)(71200400001)(38100700002)(316002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5p5Hg7Y6i5oIDpmgwOwz1MNl5KGS092jbbInsk3hA7ke+Fhw+N6KwTrvMx?=
 =?iso-8859-1?Q?0j7f9yN8yk82djdjEp8k/sKUz3vHWanwH5qlyjtTEnc4lBgNvix8HRl1Y7?=
 =?iso-8859-1?Q?BxemIkd6ec5lfAvr4ByhilfHKVJ6VVdJmIqlZzHSWefY+PsOTLezK1CEzf?=
 =?iso-8859-1?Q?VW45fL/zgma75tNx22MHMvorKujUhDvQPfzJOZGyBrZt0RHDEpbF1+rtOn?=
 =?iso-8859-1?Q?ilIFfNrqe4um1cCBHizyS+1IJ5JIeLCzZcIYkc10F5yzcdLWTlysUsWney?=
 =?iso-8859-1?Q?6d+508otLKmsdnKktVS00hq+zZLhPOUr9RW2GMSzl/3x7CtrwCWLTUsUoQ?=
 =?iso-8859-1?Q?17Hd4/E6zUl074BlvES8UUSUf5EUwFJOQCFmNI5MtQd7wPQEgIS1AZx2HY?=
 =?iso-8859-1?Q?8Ru0kJ2exTSkhEEQJhBTMmM5RBnaj++2lyUQLFgGD75DqKmgqAX2Lcv7+Y?=
 =?iso-8859-1?Q?m9e8Vtxfy8K3KW+4Pc2o64wKQx+9dydCgHvJXIPwObUthyNm+iTuozc1ep?=
 =?iso-8859-1?Q?7zgvxVO5Iw768x09i8KuMy0xVJOWX4njBaoCpcocYh5TMxxmz1SGADXdmc?=
 =?iso-8859-1?Q?Br17zf3pmODpcRyVaqkYimfUzOS2kxFaJUxmNZhNX2WyxBg57iwQKsecgr?=
 =?iso-8859-1?Q?45UWLoKYRoS72m4uDW4R+EfuMD8RPq5SVe0BKT8FtO0z8SUk47hNcbulFy?=
 =?iso-8859-1?Q?wEGR6MiL7GMGxQWIzHCPHiJvgpaJvq9iJd4E12fEJ/CAYBRFW8OEcMDUoV?=
 =?iso-8859-1?Q?a4z20OwGu8A4uYiVrG2092NzGLzDRTmbZm0+KSANQ6brFBGv/OPAHQB9a1?=
 =?iso-8859-1?Q?KDgS+rAoT8Zjk7VsWTfwqDB4uAdNDlzOVqAMYsMihjoPnv+KWSulKgG9/d?=
 =?iso-8859-1?Q?IXfyfONbT/pwBCK/j0cHEfDElCdEHwHIZfaqy2RQvhJbqSlfm/Sng6vLJc?=
 =?iso-8859-1?Q?cvGSkK40E9V28EgcSg5u3RPilAsS6j11gYSONnLmG6unm6dcMwg66h8WNg?=
 =?iso-8859-1?Q?Iqu1A6glwjDpea//yjaYtQnuCx+O7K+Pa615dK/b9t8e3LsqcIv8r1WtZL?=
 =?iso-8859-1?Q?RrOCxP1pp9Sqz5R2ZKIEHyygI2RQg+0oIwdaMx0BtOgnkKP1ayP5peus1M?=
 =?iso-8859-1?Q?g5esLEvwN42pw/mEZj/4B+VCelXEN2kEyZOXVGv9KOWlnOdZidt+XnKQ6I?=
 =?iso-8859-1?Q?jGHn9qdurbZ2TdDOlCQWcFusqkjux+zyau5uHuSzsmI/LKr+tk/EEPmDWo?=
 =?iso-8859-1?Q?D0jAGkBDiMTc5YNG7xMVvkYIqGc/DmzxAfEP7ekGUS3seaaoFVb76qvITc?=
 =?iso-8859-1?Q?DUbJzm3LoYG9Xzd94pjCavNELVqQCQbvlG2MtuqNQ7Y10gUfhhigcdmGqK?=
 =?iso-8859-1?Q?nvYNnIAExK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7440.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a482c787-e362-4cd3-e4a9-08d9904d49c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2021 02:33:07.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB7758
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my target platform, I do not believe the i2c-tools are completely suppor=
ted, so i2c-dump is unable to provide me a register dump for the connected =
tmp461.=A0=0A=
=0A=
If you have any other suggested methods of achieving the i2c register dump,=
 I could try those as well.=0A=
=0A=
I see on a different email chain that you have already submitted a patch to=
 resolve this tmp461 issue.=0A=
=0A=
Thanks for looking into this issue!=0A=
David=0A=
=0A=
=0A=
From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@r=
oeck-us.net>=0A=
Sent: Friday, October 15, 2021 6:27 PM=0A=
To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hwmo=
n@vger.kernel.org <linux-hwmon@vger.kernel.org>=0A=
Subject: [EXTERNAL] Re: Potential issue with smb word operations for tmp461=
 device in tmp401 driver =0A=
=A0=0A=
Hi,=0A=
=0A=
On Fri, Oct 15, 2021 at 05:43:54PM +0000, Wilson, David T. (GSFC-5870) wrot=
e:=0A=
> Hi,=0A=
> =0A=
> I am reporting what I believe is a potential issue in the tmp401 driver f=
or the tmp461 device specifically. I am new to reporting issues, so I apolo=
gize in advance if I've provided insufficient information for an issue repo=
rt.=0A=
> =0A=
> The problem I'm encountering is that when I use the tmp401 linux driver t=
o read temperature values from the tmp461, all of the read temperature valu=
es end with 996 (e.g. 33996, 38996, etc...).=0A=
> =0A=
> Looking further into the tmp401 commit messages, I see that the driver wa=
s changed to use smb word operations instead of separate byte operations. A=
lthough the other supported devices (i.e. tmp432, etc...) are noted to supp=
ort 16-bit read operations in their respective datasheets, I see no indicat=
ions of 16-bit read support in the tmp461 datasheet, which is supported by =
my inquiry in the TI forums (https://gcc02.safelinks.protection.outlook.com=
/?url=3Dhttps%3A%2F%2Fe2e.ti.com%2Fsupport%2Fsensors-group%2Fsensors%2Ff%2F=
sensors-forum%2F1044935%2Ftmp461-linux-driver-support-and-16-bit-temperatur=
e-register-reads&amp;data=3D04%7C01%7Cdavid.wilson%40nasa.gov%7C1d874c8a8c8=
e471a2c1a08d9902af71b%7C7005d45845be48ae8140d43da96dd17b%7C0%7C0%7C63769933=
6485905564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DvwnJOlMAKMn752Vw%2F11KA96%2BP=
wnen22GvuT6fcitMt8%3D&amp;reserved=3D0).=0A=
> =0A=
> Reverting the driver to the commit before the smb word change, I am then =
able to read temperature values that do not end only with 996. As a result,=
 I believe that the tmp461 support may be partially broken by the switch to=
 smb word operations.=0A=
> =0A=
=0A=
Thanks a lot for the report. Can you send me a register dump for the tmp461=
 ?=0A=
=0A=
Thanks,=0A=
Guenter=
