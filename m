Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74769435A67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 07:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhJUFji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 01:39:38 -0400
Received: from mail-dm3gcc02lp2104.outbound.protection.outlook.com ([104.47.65.104]:12097
        "EHLO GCC02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230050AbhJUFjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 01:39:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn0QKMPuG8OLc+8JNPRL2g6XeStZ5Uwfax1wpbLYbHtGtkiGylbpqyyc8ZpmyDryszpZOUOheLIJ9IEw5XK8kQKTmNUAeJnfA/wbhZoTKHSC6qbyTeP/fGpYrdFSJPEiz7FWg4OdtX4KdvcCzGAeAGmt229Iadkgjmwg6M5f/QtKqKTL5bb1vH+3A2GhyMSxGdIwOSHMDsDIo2sihRsKmrzJAovMdBHnaAxMzWgJz8vAnH6fIarn5VkV951U0kKIGuw/bCj1wI46CEVZNIenyP/gtsb1bTea9N8LfrXsmZDMLKW0WH+MVgDLHSuB5RWzsn2uQWJXagzQpQaIH7Ed3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwmdnEXvJl9VREYtBsUsrlWbPdh7ShXnDG64oLSxAE8=;
 b=Uej+eixa8sOFjm5j+HL5SSdzELW8O1nE0rq6P12cDByZEkfXSNstJh3Q0VNxtxEtXJyQL/ClLRJACuMJ3ZRoDdDrIYogyOpLvsA5EPt6FCx8QjFjdhIvo8Jc7FEiL7L1CQVRoDFa0YPonpLQBVlUrPBZXJE+Z+K2u8R5OrSfCePmCCbBzR/CfP4DeuiungFukVmAvC2pH1DwVgLTNauXiFryLaSxYyZtf2LmTE1qtSChRiE1kZwN+6hM/OZ3TtDERdfCnBVG8FVMMKqgS3O8urCBn1AykmZAenZf+tHwgIWXDGiCYiyrQ6UVevCNNXkjKzYZ/rbgiDTGwxo4w/9fSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwmdnEXvJl9VREYtBsUsrlWbPdh7ShXnDG64oLSxAE8=;
 b=WkmmbnlUGWYvCygEzGkXvIDK/82LRDJn3nA0jzSnrLNBzNzJphm8XFYlEwTJ9g4LO81YldsRHIBcT3Y3G1LnUA4raVEVjJWujv3H5WrNY0WgegSBce8jJASjEirftWCxKyPLLYc+B5h99/dS8a0ICNSc7jRPXhhgM/04hwEq3zk=
Received: from BY3PR09MB7425.namprd09.prod.outlook.com (2603:10b6:a03:348::5)
 by BY3PR09MB8196.namprd09.prod.outlook.com (2603:10b6:a03:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 05:37:18 +0000
Received: from BY3PR09MB7425.namprd09.prod.outlook.com
 ([fe80::a502:156d:6eab:8015]) by BY3PR09MB7425.namprd09.prod.outlook.com
 ([fe80::a502:156d:6eab:8015%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 05:37:18 +0000
From:   "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Thread-Topic: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Thread-Index: AQHXwevE+jBPDZzzYE22a/VOYXutsqvZx2uAgAAKYFOAAJKegIAA+/8j
Date:   Thu, 21 Oct 2021 05:37:18 +0000
Message-ID: <SA1PR09MB7440DE6CE6882186ECDE3401E7BE9@SA1PR09MB7440.namprd09.prod.outlook.com>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
 <7f334e4c-0e71-2005-854f-c2d4e068ef85@roeck-us.net>
 <SA1PR09MB74408633E36AE3C97B4D2CA7E7BD9@SA1PR09MB7440.namprd09.prod.outlook.com>
 <3923f61f-031c-f293-dfbd-8db7efbce2cb@roeck-us.net>
In-Reply-To: <3923f61f-031c-f293-dfbd-8db7efbce2cb@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 94adefa7-1abc-d096-fd0c-62bc9ac024e3
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nasa.gov;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67defc0b-44c0-45fc-bdd5-08d99454d8cf
x-ms-traffictypediagnostic: BY3PR09MB8196:
x-microsoft-antispam-prvs: <BY3PR09MB81969A3D4ED29E17367CFAF5E7BF9@BY3PR09MB8196.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FyN8OkuKge2BWM1CluqGO95uCdVNjgIhkaVgC89YEceX3qKqFXZ4gSf1C1ocvEmrr0vqIivPrLhHpHPIA722ZZAOp/9J/oibTbyLCy9HHnaCbiOW2pwq+Y1ai/oqHBDb4IL7yv8S+rukDIqitfOkWgn7y3GdcLSjoFkCvo997pql0LU4RV14q0ZBicdutGTn6h5ZqHaBU7kTSB55VgGbmD987xBBSlk93OP0x0ZePRhAjZOQ79Km1iI+PfrBrJGEVgGgFkoqbjjXroEO9tACy161pAJm8hhDlBAsT0rr4sOdggjWuOzAzrnNbArD2IfgBCEU4Lju9HIbVcIlgKHVqKPYUMplOM+azFCvoT3YHqGH+Jmqw4Xs8nff7oQKn/46jUnP6y7kO875geN4yQwPyYhkxlYe9M/54Lw3usN8lFThXUd1k7hF7R4Rlj6f+MuZ8In/2HITI/wX8cNCc/2bwrM79E3IA0r+/abWG8iVxX8MLdFcZWcCeX16MDlPlpo7UqZ7Z8JHrAJ9f5a/pTHeyKL+2DHCxttSYqKkQEpTDTcMwjKlHH1YrWhoXLf/wxFu5wShnm3leXBX+mX82x+Bi6zPT0iwAlVHokUH3pRwInrxT5DibkBVEWHSUPc0U+qKB5YTUuFE6j2a8GjPCq6YS4R9wbFbI4lEzw5fLT/ppUMNO1wSvTKuyPYszrTuU+XOz9znA6fGx4id7vr/pzbdZjgclPpQZTu2ySYL/UNytvkFH7yWcS8kqjr7iFktJQEtF5RGDgzkd0fCinSZ/eVC54mUc/tUIowu+Z8gssExloI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR09MB7425.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66946007)(66476007)(52536014)(316002)(71200400001)(33656002)(6512007)(4326008)(8936002)(83380400001)(66446008)(9686003)(54906003)(91956017)(64756008)(66556008)(76116006)(86362001)(508600001)(6916009)(5660300002)(45080400002)(38070700005)(122000001)(8676002)(6506007)(6486002)(53546011)(26005)(186003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ubJCZodGuYHgxp5SGTddYVVp8JveanWd8fjRiqwtrOkrVucBT7QcVDACGZ?=
 =?iso-8859-1?Q?jxa9IVnsk7AI1RCAcTIXr9DkZ6kZwSNfMznt/ScB2u7ta6NKiIYkozTlQ0?=
 =?iso-8859-1?Q?Gs7GgAkSrvoqYXsaEAim9gFXpkC2twZZ4xyZiGBoDYCf+RPszsHm/nlEtd?=
 =?iso-8859-1?Q?mdgCIryAKcM7LuyKwvYHMbASYKVVspB00qs7J27UAO3tvrQcuGI/IBNeFO?=
 =?iso-8859-1?Q?iNqyOGscr+mNDgjWAzMZZ6cqt7ShGmJSPPIRNXLlKo2Zq4RU7yYyXo0J3I?=
 =?iso-8859-1?Q?35V736o1JDob1iKiRYu7H3H95/NvJSQ4yUS8kUqLb6JlpK99Ug0FA9r0QO?=
 =?iso-8859-1?Q?Sodw7Q2/H/h07K0yRqxm9sQGkHnwVSIT6FOR+qWl+bgAF9+iCvC4IkY+n/?=
 =?iso-8859-1?Q?duwBidMZF1fXzU3FFsEfFfdYZ5Ff/GOjTGNRs/kP8LPtt5Xim5FQ0t4DCL?=
 =?iso-8859-1?Q?pEs4QPpvZg0gOG8UkkQ3Cu97ZhO1Jii72nPTwFGq7EnwbuU3SCn+aM3OxH?=
 =?iso-8859-1?Q?TomuvCow6JjvVleagDnA8wSt/T/aeRzTiNpsbd/ub1T7eW/viL2LFyfRg4?=
 =?iso-8859-1?Q?cUxPWvG7NKxQWnx3v48/5lhopuWUaxpevRYu7uu16eOu/1ZZI7GAsMTh1I?=
 =?iso-8859-1?Q?qLsAxiayzWB+BjXWt2x8BWmDN+IXZ5Hhp6eFxGjo5dyKjKVR7X8cpZ6FgQ?=
 =?iso-8859-1?Q?rcXudsyKK+UMnvFe12QseDf9VygauiPtIAhCfWpCl8duT3GZH9EDvkpxZB?=
 =?iso-8859-1?Q?7HBu2qfegnkiTaY4JTTxT+fuBH32O02s3U0C109WDrAYF9kxlPe1aQPyZ7?=
 =?iso-8859-1?Q?GqdMibspbVSF2p5GsYPUZ63/38hpFQBW3jcd7hnOvoB0AGQVtArKab3BkF?=
 =?iso-8859-1?Q?Bcwz7H4YhSLrzZYFFAxuoeVMeofS6I94KesikK0XvZZjx9wzbk1hxxeUyJ?=
 =?iso-8859-1?Q?Gso6+hFjKV24HHw123btMSaDnzu6hRpGWLWpT04B9cVMMmrXSuPdQbFBxP?=
 =?iso-8859-1?Q?H0cvrBmqmUffoKYjpdhU88RTJRcCeD8GOd673n30qQOQTd5KpzuvmsXV1x?=
 =?iso-8859-1?Q?tNJrCYSDVN4q77e53jqGgu19ry7N7LGZ+WouIo6IUeUImgjSG7vPmPIcJp?=
 =?iso-8859-1?Q?Whh+mLAFpW34+IeqComf9wnVTiuyKWj+0B016qDvbwlHsq0W1vPnteuU8D?=
 =?iso-8859-1?Q?Ob6ZQ2nEZ3gi2aoHvXDD+hTLjiG+U6KWW89Tohg3ac6FgokCp6D48AIdhg?=
 =?iso-8859-1?Q?t4ZRO4TiZgfh5oGveJmz3LbcfafcoLxmw83/tMH3Pvlz2EKDVZA7rfXGMY?=
 =?iso-8859-1?Q?xBIU9ItXCwrn4hh0OBDwvcqowcHkTh9JNAGLX998Z37PkGM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR09MB7425.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67defc0b-44c0-45fc-bdd5-08d99454d8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 05:37:18.3500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-CrossTenant-userprincipalname: dwilso25@ndc.nasa.gov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR09MB8196
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter,=0A=
=0A=
I updated several files and applied the lm90.c and tmp401.c patches. It sho=
uld be noted that my target platform only supports v5.4, so =0A=
I had to update additional files (i.e. hwmon.c/.h) in order to successfully=
 compile and apply the patch to lm90.c, which could suggest=0A=
that some of my findings may have been due to poor updating of files.=0A=
=0A=
In regards to testing, I got temp1_input and temp2_input values that look g=
ood from a glance and that steadily increased after booting=0A=
my target platform. There were three areas of possible concern.=0A=
1. The lm90.c patch includes  "+#define TMP461_REG_DFC 0x23". If this defin=
e is referring to the address of the digital filter control, =0A=
    then the value should be 0x24, since 0x23 is the n-Factor Correction re=
gister=0A=
2. The values I recorded had a resolution of 0.125 deg resolution (e.g., 30=
625, 25250, etc...). However, the datasheet for the tmp461=0A=
    notes that the resolution is 0.0625 deg for local and remote channels, =
so I was wondering if that would also be supported in lm90.c=0A=
3. For temp1_min and temp2_min, I used "cat temp1_min" to get the value -12=
8000. Assuming that is -128.0 deg, I don't believe the=0A=
    tmp461 should be returning a value underneath -64 deg based on the temp=
 data format if I'm understanding the datasheet correctly.=0A=
=0A=
Thanks,=0A=
David=0A=
=0A=
From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@r=
oeck-us.net>=0A=
Sent: Tuesday, October 19, 2021 10:18 AM=0A=
To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hwmo=
n@vger.kernel.org <linux-hwmon@vger.kernel.org>=0A=
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for tm=
p461 device in tmp401 driver =0A=
=A0=0A=
David,=0A=
=0A=
On 10/18/21 10:42 PM, Wilson, David T. (GSFC-5870) wrote:=0A=
> Guenter,=0A=
> =0A=
> I've tried testing the patch by checking out the most recent commit's ver=
sion for tmp401.c and applying the patch. However, the temperature values s=
eem to be to low <1000 for each read.=0A=
> =0A=
> If I'm understanding the driver code correctly, I believe there's two pla=
ces of interest that might explain the low values=0A=
> 1. In tmp401_update_device_reg16, the final assignment to data->temp[j][i=
] overrides the patch's assignment to data->temp[j][i] in the tmp461 branch=
=0A=
> 2. In SENSOR_DEVICE_ATTR_2_RW, the temp2_offset is at (6, 1), but the new=
ly added LSB array does not contain the LSB address at (6, 1)=0A=
> =0A=
Thanks a lot for the information.=0A=
=0A=
> Regarding your most recent email, I will try the lm90 by changing the dri=
ver tree entry to "ti,tmp451" and I'll let you know if that works for me.=
=0A=
> =0A=
I just sent two patches, one to remove tmp461 support from the tmp401 drive=
r, and one to add=0A=
tmp461 support to the lm90 driver. Turns out tmp461 is almost identical to =
tmp451, which was=0A=
already supported by the lm90 driver. Adding support for tmp461 to the lm90=
 driver makes=0A=
much more sense than trying to fix the tmp401 driver.=0A=
=0A=
I module tested the lm90 driver for both tmp451 and tmp461 (I was able to f=
ind=0A=
register dumps for both chips), so I am reasonably sure that it works.=0A=
=0A=
Thanks,=0A=
Guenter=0A=
=0A=
> Thanks,=0A=
> David=0A=
> =0A=
> From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux=
@roeck-us.net>=0A=
> Sent: Tuesday, October 19, 2021 12:56 AM=0A=
> To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>=0A=
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hw=
mon@vger.kernel.org <linux-hwmon@vger.kernel.org>=0A=
> Subject: [EXTERNAL] Re: Potential issue with smb word operations for tmp4=
61 device in tmp401 driver=0A=
>=A0=A0 =0A=
> David,=0A=
> =0A=
> On 10/15/21 10:43 AM, Wilson, David T. (GSFC-5870) wrote:=0A=
>> Hi,=0A=
>>=0A=
>> I am reporting what I believe is a potential issue in the tmp401 driver =
for the tmp461 device specifically. I am new to reporting issues, so I apol=
ogize in advance if I've provided insufficient information for an issue rep=
ort.=0A=
>>=0A=
>> The problem I'm encountering is that when I use the tmp401 linux driver =
to read temperature values from the tmp461, all of the read temperature val=
ues end with 996 (e.g. 33996, 38996, etc...).=0A=
>>=0A=
>> Looking further into the tmp401 commit messages, I see that the driver w=
as changed to use smb word operations instead of separate byte operations. =
Although the other supported devices (i.e. tmp432, etc...) are noted to sup=
port 16-bit read operations in their respective datasheets, I see no indica=
tions of 16-bit read support in the tmp461 datasheet, which is supported by=
 my inquiry in the TI forums (https://gcc02.safelinks.protection.outlook.co=
m/?url=3Dhttps%3A%2F%2Fe2e.ti.com%2Fsupport%2Fsensors-group%2Fsensors%2Ff%2=
Fsensors-forum%2F1044935%2Ftmp461-linux-driver-support-and-16-bit-temperatu=
re-register-reads&amp;data=3D04%7C01%7Cdavid.wilson%40nasa.gov%7Ce801cf6c7a=
c146b0e90908d9930b4794%7C7005d45845be48ae8140d43da96dd17b%7C0%7C0%7C6377024=
98923858681%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ=
BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DgGK9KbA0TWUJ4r3We%2BG9f5LOY7=
m%2BM5FkYuxhnEZFifY%3D&amp;reserved=3D0).=0A=
>>=0A=
>> Reverting the driver to the commit before the smb word change, I am then=
 able to read temperature values that do not end only with 996. As a result=
, I believe that the tmp461 support may be partially broken by the switch t=
o smb word operations.=0A=
>>=0A=
> =0A=
> can you try to instantiate the lm90 driver (instead of the tmp401 driver)=
=0A=
> and let me know if it works for you ? If your system uses devicetree,=0A=
> you might have to select "ti,tmp451" instead of "ti,tmp461".=0A=
> =0A=
> Thanks,=0A=
> Guenter=0A=
> =0A=
