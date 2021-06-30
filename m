Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CBB3B7D57
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhF3G2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:28:18 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:11783
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229933AbhF3G2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:28:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8sQQwkGJM3/EByRiuwPNaCNOhoBprttUSi89AD+8Czc5d1kWfemkqMdgHVBBBeLezSlZiT0Ekm7RjAF53fZ3xf9wI86ZDKufs8Ww8selWLUMadT3OxXCObLGdK7Nc1mqmK/cDYp2UaOgevpabkH7J/qKoD6e74CmhBpTgeRQvOnoWhXxyeP4eetdAHHpBTI84CSFC4LUa25aG+hg5PhFigqPgets/ocqVyo2kAfZg3solcaHgJQavZPCjI7IAV8L+zu5Y4XItv7/xYVAWwMHNOek0R0WKUYvHWKH2ebNFWTROr+6DfqA0peRCL7DhtnFO6k+qK7hjKZpkxOBzlJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVZ/UTVer35DlDv+6zn3fCOrsz01XWAjbB1hJi3Dsbg=;
 b=GDuHjKEjBOvvQMHprnnXpPHbFzNqzeNM1PfX3sPoJg+O1KL/5xxNT3qctyYG+/3Wy38qTmaMjb2EyKmn6P7glkLF+0xRQmXLByO8CUj8hFiJLDeRuYaOpXB4TP3xBZnK+RECcCY3gq+W/T6y2k3AEuG1kqslKJvzvchdQPUsVKE64JOBVoTtSCZXROAswSHDse9GxpvxyP/Uz4ImF3FE44sU7CMehG8ZaBzTbbNMHQtyy0APY0yEYoI5tUsjoxPO8ivhMvf0Jipg51qFGyEoThGRUVdk9xpKWNUpSzMCuJ6GuaB5/Y1rwBOxnCHRl9eIo5bl9mAPXa3PWIH2iAmCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens.onmicrosoft.com; s=selector1-siemens-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVZ/UTVer35DlDv+6zn3fCOrsz01XWAjbB1hJi3Dsbg=;
 b=JPHL4RuJ7JGD5DtR7oYFzlm2VpgSPAKcJgLudUnJqzlGyjLhishYh8cpHa2K9KMWi9G2M00bDyKIZVFtH+Wk5oOT/PbMp+jESnpfPTZAtMw82JZ8x1D6oszq/1CDFGAXVXAiHjxzlTIdL1Ruxu8YHiSbGcDLy3Sz2JKpN4LVTKU=
Received: from AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:125::20)
 by AM0PR10MB2113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 06:25:44 +0000
Received: from AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40f3:9d24:dd31:1488]) by AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40f3:9d24:dd31:1488%7]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 06:25:44 +0000
From:   "Zeh, Werner" <werner.zeh@siemens.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and
 time
Thread-Topic: [PATCH 1/1] x86/kernel/rtc: add sanity check for RTC date and
 time
Thread-Index: AQHXYQ31AXoAwWTUBE6ivSpoWZHRXqsi3/mAgAbU2gCAAnnIUA==
Date:   Wed, 30 Jun 2021 06:25:44 +0000
Message-ID: <AM0PR10MB2580E68ADF9D1AC6804DB2DF9F019@AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM>
References: <20210614110946.15587-1-werner.zeh@siemens.com>
 <20210624081507.15602-1-werner.zeh@siemens.com> <YNn6FqAfLwQ/Wwnu@piout.net>
In-Reply-To: <YNn6FqAfLwQ/Wwnu@piout.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-06-30T06:25:42Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=e5894fcf-29a0-4927-9175-0db842b63029;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=siemens.com;
x-originating-ip: [195.145.170.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d0a461e-4e14-4257-9afa-08d93b8fe44e
x-ms-traffictypediagnostic: AM0PR10MB2113:
x-microsoft-antispam-prvs: <AM0PR10MB211338FE925DE906F178D6469F019@AM0PR10MB2113.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 266cAv55RvMmrj+zv7zU2b/5wZg0CY6lHvygWURF5Z2Y0PeoHBkpmjBEXjhZDQiOj8ueqliTdeXURSF40SXML+KklKikhgvy8MLWhWm/yLubfGRsQbVqoi7i/zVx0JtFHPv3+TVLoZ+yUcfLaAz2xN9Wfs9bzvgZ7nKbIDX99T88qazVHk3vS8dIJCxsoewLosypRckdEdvcOyBAf2h9D23ifgE3VoWJVYSm2jlY4yS3prvX5Ge7aqAo+010n+KLEAhZuuV4I+9QcADMISn4INlo9gvMiLv1qztkqJEI3eXOBqiSV2rd/8StgsUPKtPmLVIHWUaSLMmF0WMsLLT8OdDsYRtyou0gboTTue5isTYKgB4jaXrBVE7jjJYO53a60aUl2z1IrMfnNvBjyLkayZaTtRYtbCSs9FzLjiIjjiruTStL7JjuPMEY4Wr6eo4aRImCc/ks1x0f7awmu5a0n++PPgXbDLOvz9iFsaqAKTjwtOru4XOhKi5k+3nR+ZVuAFzb+kTMkckZngckQdsGBCH42NpRNLJHMRPZFvTjvI1FC6GIWLg41fFzghzHylxAbG/MEaiKzWKYot48W+mRvTS0RvSU9ZsC2t4Cc4Byt7ilXEnXIW1f6Rfq3niKRC+2owIKDg87wi/HY8m+7AssaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(122000001)(9686003)(55016002)(86362001)(38100700002)(2906002)(6506007)(7696005)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(26005)(71200400001)(4326008)(52536014)(6916009)(83380400001)(8936002)(186003)(8676002)(5660300002)(54906003)(316002)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eSdjuW1A3Zrf0cJDsO1+a+4YkH2QzLEZ4PPqSJZII+ZzedVs9+m0P4f7dlA0?=
 =?us-ascii?Q?6wo5B3AY9/LLPKAcY4kYseRUmHQlUZdID7k0oXCIB+J6WBYil6hS5iqj4zQn?=
 =?us-ascii?Q?HAYchjMoQOWNCjXu+n8iBW8Y1VpYyi/8DSj4SfO7K6jy2PoXhVJ3PMlz4WdT?=
 =?us-ascii?Q?gm/YDyw1XM+O7kBx8ugL3zl8F5tF2jx64dt8S+qb6lMs86SgdyKJzvocee/7?=
 =?us-ascii?Q?7W0Y4wgceM2ubngaXG6VWs9hpIhMBum8Gbwclphrf9SirMdO04sQZHCfHY4m?=
 =?us-ascii?Q?0p4R9mxcUU6JwCgOaOngYDKbQDCd0MTk1sjIG/Ik7Ln5GtGBgnoNNVBzAwHe?=
 =?us-ascii?Q?IRk9GMcDHDFXen6oAahn3V7PcOOIQMhgkI8aDqL3qbhws5MStMbNAL+6PeLk?=
 =?us-ascii?Q?nLQabAFnXrnVEOJ+wFtReo+al6dDzKCWkjmIsDc4J1IQzupP29HRwOQvmU2b?=
 =?us-ascii?Q?3Rhrxm1XB58RX2HRY9wbk8kuRjazcuXvgWV1K8qY7SmxCNhDNVq8KOYNGgFV?=
 =?us-ascii?Q?VaGCWl7200BmMcpOxKa4v3VnVQuEc9XF8eTr9URPMGOcLg4AgKlsOwC21Z7F?=
 =?us-ascii?Q?xIEoGH7mw2Cz/CH51VNIhBv7KIc2nCUmAMCZHG2StsGVAkp/bWHoD9qEeWgd?=
 =?us-ascii?Q?o5MBkOcRCTbipzDz/JiwtCpNcrABiv9285Li8cZcJnXoulD3mV9I+TymKZR5?=
 =?us-ascii?Q?YNJim9idYZTRX5kfjLhn7kKZEDRk55qPURekZZbedw5RP67+QjAxzw+dxu7C?=
 =?us-ascii?Q?NdFPKsniE73qViK1wW6eTRZIPCxxo4yHmRSI6eTEht8icGKBqst6ypTpGNRb?=
 =?us-ascii?Q?ugxYdvgZcEnjkKuax02mq3RQqJQg9MANlZ+EK7tcNn2hIjoc0EmHwbb4e2/E?=
 =?us-ascii?Q?x6Gvp6vwhDfX6oRczGClHNBzlozSYvCthlxm9T9/zExrwyNQeSvSArkdK+aS?=
 =?us-ascii?Q?u8TGpK8ZAP8jD0R9KrUZYDJqD9JpBFrCSfUBGBdx/G67cwTawqlpTBKAOeK6?=
 =?us-ascii?Q?OqpiBGdUX2GUbnk9oAaqDVqyyUnBglIUQAW7co+XDt+PFVUaej+LSJF0Z3cc?=
 =?us-ascii?Q?wx+2zY+BnhO+eWKqbWtHSYOpQh4mLa3B1mAbipzZy83l/PEyAozp2PtZacMU?=
 =?us-ascii?Q?avHSPGv1dZlUnu//Tb99trqpcjb9XXAoWSH5KILeqdogw9VOZsaH9MlWBAbP?=
 =?us-ascii?Q?2x626tfHEAt02NE7PLzUJ0ngaHz8S5dTv/iBAZxJbfQut19iuzcJKE72tUdH?=
 =?us-ascii?Q?+rLMBPX0K68/04ukIczV49u1EZEAKJ2JT5bS4ZuQFo49OHgj6LbMM/Pt2T7T?=
 =?us-ascii?Q?ioRsWoMqtGceRhBKGm9oyVIc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2580.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0a461e-4e14-4257-9afa-08d93b8fe44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 06:25:44.5335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6bbCdUo3/1+WnHl/Wc5x1EAfaS187wquof9KLy8g8WF2t00O0U6RMoIl+3CL56yhXi8cF83fCnGuXWWxizOWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre

> Hello,
>=20
> On 24/06/2021 10:15:07+0200, Werner Zeh wrote:
> > The timekeeper is synchronized with the CMOS RTC when it is initialized=
.
> > If the RTC buffering is bad (not buffered at all, empty battery) the
> > RTC registers can contain random data. In order to avoid date and time
> > being completely rubbish check the sanity of the registers before
> > calling mktime64. If the values are not valid, set tv_sec to 0 so that
> > at least the starting time is valid.
> >
> > Signed-off-by: Werner Zeh <werner.zeh@siemens.com>
> > ---
> > [resent due to wrong lkml address]
> > [added RTC maintainers to the recipients] This change introduces the
> > same validity check that is already done in drivers/rtc/interface.c.
> > If it is not done here, the timekeeper can be set up wrongly in the
> > first run and won't be corrected once the RTC driver is started
> > because the validity check in the RTC driver drops the time and date
> > due to invalid entries.
> >
> >  arch/x86/kernel/rtc.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c index
> > 586f718b8e95..f4af7b18c6c0 100644
> > --- a/arch/x86/kernel/rtc.c
> > +++ b/arch/x86/kernel/rtc.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/export.h>
> >  #include <linux/pnp.h>
> >  #include <linux/of.h>
> > +#include <linux/rtc.h>
> >
> >  #include <asm/vsyscall.h>
> >  #include <asm/x86_init.h>
> > @@ -64,6 +65,7 @@ void mach_get_cmos_time(struct timespec64 *now)
> {
> >  	unsigned int status, year, mon, day, hour, min, sec, century =3D 0;
> >  	unsigned long flags;
> > +	struct rtc_time tm =3D {0};
> >
> >  	/*
> >  	 * If pm_trace abused the RTC as storage, set the timespec to 0, @@
> > -118,7 +120,15 @@ void mach_get_cmos_time(struct timespec64 *now)
> >  	} else
> >  		year +=3D CMOS_YEARS_OFFS;
> >
> > -	now->tv_sec =3D mktime64(year, mon, day, hour, min, sec);
> > +	tm.tm_sec =3D sec;
> > +	tm.tm_min =3D min;
> > +	tm.tm_hour =3D hour;
> > +	tm.tm_mday =3D day;
> > +	tm.tm_mon =3D mon;
> > +	tm.tm_year =3D year;
> > +	now->tv_sec =3D 0;
> > +	if (rtc_valid_tm(&tm) =3D=3D 0)
>=20
> Doesn't that make the x86 architecture depend on CONFIG_RTC_LIB?
>=20
CONFIG_RTC_LIB is already default enabled for x86, see arch/x86/Kconfig.
Do you have any other dependencies in mind I have overseen?

Werner
