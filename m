Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDD443D8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhJ1B4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:56:31 -0400
Received: from mail-bl2gcc02lp2102.outbound.protection.outlook.com ([104.47.64.102]:28641
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229534AbhJ1B4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:56:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OilR5Q6zcinRex42XK38vu5zhSvCybwp3FtWsJf4cy5xm5CVBKrFdL/kzia8jhxeddf1QloFKENrxZg7jx0obn5LiR8dKJiiLyi99lsAal4NMNqObW/9JmDuX8iVzoUjmy1EagBIowzLIpdQfi7qjcP/CtUcAyOCYSgcufoVHGoXdYdjEzV4pdPdY+5NGRbX0/RNg4YO2pDn29iXa+w5qD6N6fsbW+SBecCcgiBUc3pN1TTKH362LbRYiS7MqF4R73Ps1vjBnX1aPVfTXcUzJnMoIi/oHAOk7SxINC/lAxda6ZzPKVJR5KywCLS+/r4CGgu0Qys8CiLy5r8i3Us5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnD4csDvdVL+X7Qh7ECdCWhdeu7lW8x4Gd3dcz+MAqA=;
 b=jQ/lAjyypxQR0pKvf0emZIYed+Jj+T3Ssrw/m2a5WkvVbR1l33UfZHRFVyn0+AGzclG8HHYtzV4B2b4WBnHN7xu8RCzcBwKxyU1vv2oIUEiGCwOEvkmS8cVCFP/8JVommSihEPfx+OpNmCIV9sutY0tQdPxbsEF9yl+gGaP2ETgmhmznHfU+hna+blAukvx9zeqGyLk1/nWgAFKbbU7GNSaeFtpD66PfXdeF0Uf+RAyEXIzoNhJ6D4kf7NOqoc0j15GVFMN1P+uOdjLOxpz/9aA9v+8mjDfEwWdEWo4/8e/WQz0/wxJyS96HlWtzJ8KmDsMg/ERFVMjCjSx40Dm10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnD4csDvdVL+X7Qh7ECdCWhdeu7lW8x4Gd3dcz+MAqA=;
 b=SMoWZQbGlOCbzGOfdoNDKy5CXRqoxOdiXmHk/nGJ1yPw2Z6x5I/1jYnftKI+m/58WZKanP6NtFZf0MMzFfHFY3wrybk6p3SYzjmz9W4ONNb3XOzR83dLmoOeOY9GkZ6vMCUR2rzcV7ukl0ohVU7zZu8FLw6OLEJtZdFHAmMPCvI=
Received: from SA1PR09MB7440.namprd09.prod.outlook.com (2603:10b6:806:183::14)
 by SA1PR09MB7694.namprd09.prod.outlook.com (2603:10b6:806:177::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 01:54:02 +0000
Received: from SA1PR09MB7440.namprd09.prod.outlook.com
 ([fe80::44b:e648:2d1:3471]) by SA1PR09MB7440.namprd09.prod.outlook.com
 ([fe80::44b:e648:2d1:3471%7]) with mapi id 15.20.4649.014; Thu, 28 Oct 2021
 01:54:01 +0000
From:   "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Thread-Topic: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Thread-Index: AQHXwevE+jBPDZzzYE22a/VOYXutsqvZx2uAgAAKYFOAAJKegIAA+/8jgAGwgICACqaJgA==
Date:   Thu, 28 Oct 2021 01:54:01 +0000
Message-ID: <SA1PR09MB74400C313FFCCEAE32A4C565E7869@SA1PR09MB7440.namprd09.prod.outlook.com>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
 <7f334e4c-0e71-2005-854f-c2d4e068ef85@roeck-us.net>
 <SA1PR09MB74408633E36AE3C97B4D2CA7E7BD9@SA1PR09MB7440.namprd09.prod.outlook.com>
 <3923f61f-031c-f293-dfbd-8db7efbce2cb@roeck-us.net>
 <SA1PR09MB7440DE6CE6882186ECDE3401E7BE9@SA1PR09MB7440.namprd09.prod.outlook.com>
 <8485a422-31b2-6d9f-516c-29d60fd13490@roeck-us.net>
In-Reply-To: <8485a422-31b2-6d9f-516c-29d60fd13490@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6a4fab40-c6dd-9c74-124a-903b18b47fe5
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nasa.gov;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef153d41-bb35-4058-047e-08d999b5d0ac
x-ms-traffictypediagnostic: SA1PR09MB7694:
x-microsoft-antispam-prvs: <SA1PR09MB7694CD03D57A9C0C92D7112DE7869@SA1PR09MB7694.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qiNa/34vE4vnsWJ3vgk99YqKtjU57gRmjEeJn1YmnnQ6Oyx8wMY0K6gP+gfu9Z9/hpEvMvICXWM/6+NbmAnso/ccZ+kO0FynLeOHzBYocX7h5M4/GEcf0+bVrHUq8B+Qw2VrL+agG8aDV/T81nUkz6RthLkzggD1V7GjJ7tr1JCWqSKjKV0dhCItAkHMZgItKCLt9cKEjyN4kEM4Ic7GQkKcUm7vnR9aMHmGdueYrIE1M0kLXSHxKZ00kc1xLolf4YRIn8aDFn5RcVepsl1q3Oi4R+R3jJWjPfY9dtjAwLKVI3j5yUnotuYJcJgRQQ9xVLecAAW05V6pPaiwf16BX6phgqH+i/EMwZZQm5ppeDlDA6/K1GYzgRmdQSxwMg1gmULVciwHR4fip7LWjG9FK8JNw1dacRSxxHLnOb13SzEt/wYxxjIGZLCCm7xHV8EIAb+kO1sb/lrG4FrMOr+/tiVEpkVf6P1JHbZE9KRSvzAwJKavGGL4Osuj1hVApAaxEosJv3jWRDt92IItPk1PZLliNyWzQ4qYob8CoR3nimOnRRg8B+K51Q+RmcZk6KW/2GB6MQ4UszUBk3stXLZOub0nnBJb9DGXJuxZ/CoU55ndwdvdlaMDPNzS1mbRCb3BiMWmih0IIdpxHZwCOCW+n/pK95PfPQBq1FC6N/TH9qnsynb1vtAVqrdKVIRaGWGA/74hiOu8woqjPo7kfxE7X+7TsV12DGGjy6n7JIMMJIYDy6JByqd+MgWjjCbclJZqhoNrGMrfhQ7uQBrtYjUigQ+bgHQ8cIncseZG/fUCs/M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7440.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(86362001)(5660300002)(33656002)(8676002)(7696005)(4326008)(316002)(2906002)(6916009)(76116006)(91956017)(66476007)(45080400002)(6506007)(186003)(38070700005)(66946007)(64756008)(66556008)(55016002)(122000001)(54906003)(66446008)(38100700002)(53546011)(9686003)(71200400001)(8936002)(83380400001)(52536014)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rj5o9JFng060zwtf55XjFCIkjHPl/zp4xP9vwC7w/dQqO1WRhk3VYG8WbE?=
 =?iso-8859-1?Q?aUuzFxFgfIMJv/PCXnLf8R1PIpPBHzEAQ9qkZRvvVLGbItekFwoLU+7p/d?=
 =?iso-8859-1?Q?E6u3oXwzis1WP1cveao6VumdQJ4saj8WO9tpIbjqCqvJtZ0+15FvRhcUJL?=
 =?iso-8859-1?Q?hh6moEBb5xEpeUfHVcLGooclIIcLx5rHuXLPbkGqzAIrkV1VuMf+C4I304?=
 =?iso-8859-1?Q?t27ZShDkDHav8Vseb3IVoTqRm35J5ebVBdXblEwidoZvIF0ZqXSSfaUrJx?=
 =?iso-8859-1?Q?Q0x6IJRHyvv6cCFzuICkx4T1DjHaF7zjUu/cAK6ABuS/jt77vxUKdIxwOg?=
 =?iso-8859-1?Q?A7suCVq6M+1t5lTvI0f6+gbl9dMWDwF6QvYdETaR/l/YLQaADN6ZHHAAQo?=
 =?iso-8859-1?Q?tom1BivGmfXU4N2mDrn4IV+Bk5NhUIUguwxupRSNM4oksY1dXDjs4n/whx?=
 =?iso-8859-1?Q?taZL0gHQqHn2kOqDhodj0oGQNNqoWG9mFkMuA+KjyTjKIkU2adHPzXGWh5?=
 =?iso-8859-1?Q?X8P4DyCi9CHifUT4PRPieQn7kl+3OClUhdgzVdcO/pCRKpQE1cSg3Rmt+P?=
 =?iso-8859-1?Q?7oy1WLIlLDu6rNrVDKFmO1MZUGMfOtbbvGzZ5Q+6WwPSTd0fGXU8yMjZvn?=
 =?iso-8859-1?Q?+6Jo6OD+IUkNWk/815MjT2scjvMbNhQ3Nug48UEtTK31b0VAx6lHI/7MAh?=
 =?iso-8859-1?Q?+KYxtzsLSh2VVT1y/RA3ltyq2nwhMvjTX69meF/lr7MDitKPCKO/D3F3SF?=
 =?iso-8859-1?Q?lPtqeiNHLGQ51HyRnvSv7GUqDaZoHNJdhyIBY/m5cHrr2jsEpMiBIxfyhj?=
 =?iso-8859-1?Q?9XsyIMh22nmBV/mpX6pxe1FnazBbNci2/K6+qwPOOmiJLalTnoxf5OpoAl?=
 =?iso-8859-1?Q?CAN9JNVadnbQC8gjw9NcJfp0DOU32gKyAc0WyxoZx4Dvlm/A5LzG3+1Q5G?=
 =?iso-8859-1?Q?uou7J3YOR6FzYpwIloJydEJ5UiaP8PdcMgEbDLZ95ff9s7EH5myB8fDOdO?=
 =?iso-8859-1?Q?d0pgprXalrqdWpwYXvR6lM4yGNVRpDKxqjepPpvmRGIor8MZkfAUJoQ3d0?=
 =?iso-8859-1?Q?mVZ5taWoB+NQ02WlYuFQOTFrmQxIlJwVOeFRC8GLmLTh8RLVdI4nJin4U6?=
 =?iso-8859-1?Q?enyDMyt6vKk57uj+rDbpcIVMvgaM0rKlUDyWrXjVOk3swmWLwlPFpkdM6U?=
 =?iso-8859-1?Q?l4xmTsS50mj30Q6rheAIJcZKB2hVrVDlMOVYeX5yhyDNhpBsLxzrfr+Di/?=
 =?iso-8859-1?Q?6jila/YQT5chK0ewjWqBwnwpoaikdwGB0+uTrz8r+eTLjLKwCH5b3dTFr5?=
 =?iso-8859-1?Q?z85EqpsaWTP6TS5Qa3PfOriZTT4n/qKH7WrgWx8PDBYXfwg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7440.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef153d41-bb35-4058-047e-08d999b5d0ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 01:54:01.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB7694
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,=0A=
=0A=
Like last time, I updated several files in my platform's v5.4 files and app=
lied your three patches. =0A=
From what I can tell, I'm having no problems with the tmp461's basic suppor=
t in the modified lm90 driver.=0A=
=0A=
Thanks again for looking into this,=0A=
David=0A=
=0A=
=0A=
From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@r=
oeck-us.net>=0A=
Sent: Thursday, October 21, 2021 3:07 AM=0A=
To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hwmo=
n@vger.kernel.org <linux-hwmon@vger.kernel.org>=0A=
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for tm=
p461 device in tmp401 driver =0A=
=A0=0A=
Hi David,=0A=
=0A=
On 10/20/21 10:37 PM, Wilson, David T. (GSFC-5870) wrote:=0A=
> Guenter,=0A=
> =0A=
> I updated several files and applied the lm90.c and tmp401.c patches. It s=
hould be noted that my target platform only supports v5.4, so=0A=
> I had to update additional files (i.e. hwmon.c/.h) in order to successful=
ly compile and apply the patch to lm90.c, which could suggest=0A=
> that some of my findings may have been due to poor updating of files.=0A=
> =0A=
> In regards to testing, I got temp1_input and temp2_input values that look=
 good from a glance and that steadily increased after booting=0A=
> my target platform. There were three areas of possible concern.=0A=
> 1. The lm90.c patch includes=A0 "+#define TMP461_REG_DFC 0x23". If this d=
efine is referring to the address of the digital filter control,=0A=
>=A0=A0=A0=A0=A0 then the value should be 0x24, since 0x23 is the n-Factor =
Correction register=0A=
=0A=
Good catch. That is a bug. Thanks a lot for noticing.=0A=
=0A=
> 2. The values I recorded had a resolution of 0.125 deg resolution (e.g., =
30625, 25250, etc...). However, the datasheet for the tmp461=0A=
>=A0=A0=A0=A0=A0 notes that the resolution is 0.0625 deg for local and remo=
te channels, so I was wondering if that would also be supported in lm90.c=
=0A=
=0A=
You are correct, the lm90 driver assumes a 0.125 deg resolution. I'll see w=
hat I can do about that.=0A=
=0A=
> 3. For temp1_min and temp2_min, I used "cat temp1_min" to get the value -=
128000. Assuming that is -128.0 deg, I don't believe the=0A=
>=A0=A0=A0=A0=A0 tmp461 should be returning a value underneath -64 deg base=
d on the temp data format if I'm understanding the datasheet correctly.=0A=
> =0A=
=0A=
It is odd, but the tmp461 datasheet does list a default value of 0x80 for t=
he low limit registers.=0A=
In 2-complement format, that does translate to -128 degrees C. That doesn't=
 really make much sense,=0A=
but it is what the chip reports, and I hesitate to change that.=0A=
=0A=
Thanks,=0A=
Guenter=0A=
=0A=
> Thanks,=0A=
> David=0A=
> =0A=
> From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux=
@roeck-us.net>=0A=
> Sent: Tuesday, October 19, 2021 10:18 AM=0A=
> To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>=0A=
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hw=
mon@vger.kernel.org <linux-hwmon@vger.kernel.org>=0A=
> Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for =
tmp461 device in tmp401 driver=0A=
>=A0=A0 =0A=
> David,=0A=
> =0A=
> On 10/18/21 10:42 PM, Wilson, David T. (GSFC-5870) wrote:=0A=
>> Guenter,=0A=
>>=0A=
>> I've tried testing the patch by checking out the most recent commit's ve=
rsion for tmp401.c and applying the patch. However, the temperature values =
seem to be to low <1000 for each read.=0A=
>>=0A=
>> If I'm understanding the driver code correctly, I believe there's two pl=
aces of interest that might explain the low values=0A=
>> 1. In tmp401_update_device_reg16, the final assignment to data->temp[j][=
i] overrides the patch's assignment to data->temp[j][i] in the tmp461 branc=
h=0A=
>> 2. In SENSOR_DEVICE_ATTR_2_RW, the temp2_offset is at (6, 1), but the ne=
wly added LSB array does not contain the LSB address at (6, 1)=0A=
>>=0A=
> Thanks a lot for the information.=0A=
> =0A=
>> Regarding your most recent email, I will try the lm90 by changing the dr=
iver tree entry to "ti,tmp451" and I'll let you know if that works for me.=
=0A=
>>=0A=
> I just sent two patches, one to remove tmp461 support from the tmp401 dri=
ver, and one to add=0A=
> tmp461 support to the lm90 driver. Turns out tmp461 is almost identical t=
o tmp451, which was=0A=
> already supported by the lm90 driver. Adding support for tmp461 to the lm=
90 driver makes=0A=
> much more sense than trying to fix the tmp401 driver.=0A=
> =0A=
> I module tested the lm90 driver for both tmp451 and tmp461 (I was able to=
 find=0A=
> register dumps for both chips), so I am reasonably sure that it works.=0A=
> =0A=
> Thanks,=0A=
> Guenter=0A=
> =0A=
>> Thanks,=0A=
>> David=0A=
>>=0A=
>> From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linu=
x@roeck-us.net>=0A=
>> Sent: Tuesday, October 19, 2021 12:56 AM=0A=
>> To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>=0A=
>> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-h=
wmon@vger.kernel.org <linux-hwmon@vger.kernel.org>=0A=
>> Subject: [EXTERNAL] Re: Potential issue with smb word operations for tmp=
461 device in tmp401 driver=0A=
>>=A0=A0=A0=A0 =0A=
>> David,=0A=
>>=0A=
>> On 10/15/21 10:43 AM, Wilson, David T. (GSFC-5870) wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> I am reporting what I believe is a potential issue in the tmp401 driver=
 for the tmp461 device specifically. I am new to reporting issues, so I apo=
logize in advance if I've provided insufficient information for an issue re=
port.=0A=
>>>=0A=
>>> The problem I'm encountering is that when I use the tmp401 linux driver=
 to read temperature values from the tmp461, all of the read temperature va=
lues end with 996 (e.g. 33996, 38996, etc...).=0A=
>>>=0A=
>>> Looking further into the tmp401 commit messages, I see that the driver =
was changed to use smb word operations instead of separate byte operations.=
 Although the other supported devices (i.e. tmp432, etc...) are noted to su=
pport 16-bit read operations in their respective datasheets, I see no indic=
ations of 16-bit read support in the tmp461 datasheet, which is supported b=
y my inquiry in the TI forums (https://gcc02.safelinks.protection.outlook.c=
om/?url=3Dhttps%3A%2F%2Fe2e.ti.com%2Fsupport%2Fsensors-group%2Fsensors%2Ff%=
2Fsensors-forum%2F1044935%2Ftmp461-linux-driver-support-and-16-bit-temperat=
ure-register-reads&amp;data=3D04%7C01%7Cdavid.wilson%40nasa.gov%7C2e3728d5f=
2e74810482108d994618683%7C7005d45845be48ae8140d43da96dd17b%7C0%7C0%7C637703=
968869859896%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D3n9QPCDAzD0Qoy16KVtTzVNAe42=
KBgFdGbZr3naFWko%3D&amp;reserved=3D0).=0A=
>>>=0A=
>>> Reverting the driver to the commit before the smb word change, I am the=
n able to read temperature values that do not end only with 996. As a resul=
t, I believe that the tmp461 support may be partially broken by the switch =
to smb word operations.=0A=
>>>=0A=
>>=0A=
>> can you try to instantiate the lm90 driver (instead of the tmp401 driver=
)=0A=
>> and let me know if it works for you ? If your system uses devicetree,=0A=
>> you might have to select "ti,tmp451" instead of "ti,tmp461".=0A=
>>=0A=
>> Thanks,=0A=
>> Guenter=0A=
>>=0A=
