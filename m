Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170F53F72CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbhHYKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:20:43 -0400
Received: from esa1.hc448-60.eu.iphmx.com ([207.54.67.163]:65257 "EHLO
        esa1.hc448-60.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235904AbhHYKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:20:41 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 06:20:40 EDT
X-IronPort-AV: E=Sophos;i="5.84,350,1620684000"; 
   d="scan'208";a="1664185"
Received: from mail-vi1eur04lp2055.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) ([104.47.14.55])
  by ob1.hc448-60.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 12:12:46 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYmbL8qM2HBfvmlfnQXNN7OC4UY/RuztY0knmbW0qQvNnplNprbpj2hbzl8GZtvxED73eEYcTwlmML/fRdHEoRKtqEw1l79hRbsqT0DKDRUsIllTPqcq68MkwQPf4nVsRBRIc2U3bJwGK6kF7mztBzdb6OI1vE/pS7yyN4FuAxT/YND4bE7SWFKDNwyw3STNwob7Lp7ugmntv7I3/E5Nlt/WPZRuTCCEMMcX0r3WctT3QXEQBMx2eetUqDJU4xsUM2F8jmxqV4u10Wmo/h5zn4vIV8BXZl09KPzpoF8kER0RvJIhf8d9LeGwn8yO4+k9B8CkOyFMhvVXCqllu5hNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjQH7SU7quwZt/DzJ9ImuWNrFs1YwhivJ9UX6J0OmUI=;
 b=VZAxyIQhD87nyjimLycfZXhmB6o7AMTxtzZr2mWuLIsvjbW40HBs0KMKcgPYolxXEmN9bXM+o4/QY3v5rL9lRYo0Z5RnZC1CgmpURJFPers+zsOuo/QPwqxaje4AQt8iFOYM+gEg1EQs2Y/J/DZ6Etpna3+ZSB81wJknE4MHMluXNwIf6prMhIkbItj18qOwgkzeC/J3zlOcguCkPtp5chhY/ziITzmw2nzsNWUTCqERlg5FGXXPUQX631K2J7so59eVlvqOtPcafFv8PwxpjqYYf2xA2DEhb64h7aQBIrfSdd4IgLLkrYm40qriVYKHvZZJK4tJ42P99KLYtRn1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensource.tttech-industrial.com; dmarc=pass action=none
 header.from=opensource.tttech-industrial.com; dkim=pass
 header.d=opensource.tttech-industrial.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tttech365.onmicrosoft.com; s=selector1-tttech365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjQH7SU7quwZt/DzJ9ImuWNrFs1YwhivJ9UX6J0OmUI=;
 b=SZmPbHvm2c5MRhYsTaLrtz4BcfbXrdW24nyGxKFHMQkH6BNXaUrT5P2KpYiw//h/DenyFAj5mRqK0m7BSUUDOwMjZdWhjc9Qxb1MZSTTHi1DbTv3kPlw3XWAeyx7LSXkth5HEByLjOKpDXjuNV5mTjrhlJuD9rMb72JGdU0AzA0=
Received: from AM6PR01MB5416.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:28::32) by AS8PR01MB7256.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:252::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 10:12:43 +0000
Received: from AM6PR01MB5416.eurprd01.prod.exchangelabs.com
 ([fe80::7485:c3f:cc22:b358]) by AM6PR01MB5416.eurprd01.prod.exchangelabs.com
 ([fe80::7485:c3f:cc22:b358%6]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 10:12:43 +0000
From:   OPENSOURCE Lukas Hannen 
        <lukas.hannen@opensource.tttech-industrial.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "EMC: linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Subject: [PATCH] changed timespec64_to_ns to avoid underrun
Thread-Topic: Subject: [PATCH] changed timespec64_to_ns to avoid underrun
Thread-Index: AdeZmZxwvho0Ru4vTiKBH4bSKRLpGg==
Date:   Wed, 25 Aug 2021 10:12:43 +0000
Message-ID: <AM6PR01MB541637BD6F336B8FFB72AF80EEC69@AM6PR01MB5416.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_ActionId=b3ba5569-2951-4f51-a9a9-db6578c5774b;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_ContentBits=0;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_Enabled=true;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_Method=Standard;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_Name=Internal;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_SetDate=2021-08-25T10:09:48Z;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=opensource.tttech-industrial.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff21d65b-4dd2-4c78-ca8f-08d967b0e0d6
x-ms-traffictypediagnostic: AS8PR01MB7256:
x-ld-processed: 5638dc0c-ffa2-418f-8078-70f739ff781f,ExtAddr
x-microsoft-antispam-prvs: <AS8PR01MB7256C846529F5D9CAD03D85EEEC69@AS8PR01MB7256.eurprd01.prod.exchangelabs.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JW6mmTBIH7o2czkYP7i7p47a+bH/t6YaYhvObEkNTAxh0r+bM2mjbL7n5jlWNFlLyt0pG1ZqZsRbkTbWHpnx1b/RhFKGyeLfvwGiDnQtG0AQIZxhV8nz7lQANzn02t+QazKbYedXqbMfewg/u1jTWVLomieIe/j5PjcxKM//kop8Mfo10+/P2tqhmHoDur82zZ8Z0vuVZoEL6piEo9YiKtlnpw08HRwzkm5l4mXf5jZ48/dgLD48eUyrs/1OmcM0p1SfXAmHCZtaWzAptIjRjk//+0SVQIqTDFC4Cq5OmFSZS2pd6i0h53ovwB+Vek5grf73iwRTzKjL8r2aqO2Opz1Gs9Vw2U0j/PiHb45zWohtOEAYafzCL5LKvDQ2Qj53RHmCqPHcKJoDLe3ojW7FPykCMb7tlmaF/0ngSwaqGHJNSUcoKe/kP0xtMFkIqjcBQ+oKwnrwxZsxtd5Jw0nFuTqFIK9J1bZwwhlMh2Lo0FggrjUnR8Zyz9RSV25nIqg19gcNjM+dhFgWQWm/s01A/9petzh4pT+17kkNk7nlYWF8CjiUGqGa//bcwAR5+RYZCsa2VwRN3+tJknc8gv1zp9xRH+n6n6bpLYzQkNdjIt3Rhdmmv9N7igLEQbopjOBxywnybsOcVWO2ZNss97q9G/eweaCrWTmN3aWEePp41bVJXUCXvSIXKmieJWODZm7Lk7n/H4t27+rRj7J4JdL6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR01MB5416.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39840400004)(83380400001)(66556008)(5660300002)(71200400001)(64756008)(9686003)(66446008)(478600001)(55016002)(6506007)(38070700005)(66476007)(86362001)(66946007)(186003)(52536014)(26005)(33656002)(76116006)(316002)(2906002)(110136005)(8936002)(122000001)(7696005)(8676002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7bvPvfH4vuxpwgt0P939TDnYCcIHyuNpTt6sgqFcMRgkoqcCPVqvyVVQGm4o?=
 =?us-ascii?Q?K7/of3Xj5spvrpqdsszcvypFGkUlwob8JK9TisPcSx64uiGBsHe3PVO3ZPeE?=
 =?us-ascii?Q?VsDzW8sd8PqwQEipA1uTO0jq4KkMLkKsRNVid3S0aSPKKMt24x6EzkD6f12C?=
 =?us-ascii?Q?YPVD2/tBpmRocxOR4cOUGeGtTsBiyay8bBfz5qVs7sq5+ak8+0G2sskv1BjB?=
 =?us-ascii?Q?4dP5ga323DFdEzAT97PbjV6/m8NPQXA8+IXoZ8wWVx8mQFfxZgUJbtjqpB+Z?=
 =?us-ascii?Q?ZuC8zE44EglH25jADZftXio8Cb6f8wDt/+qLHPPJMAz6Rf0SNYg0/70D+von?=
 =?us-ascii?Q?+HyxRYfDptF//aob8e1LSFQKi21gsvPpGXpcU71o8K5TQ+KofHKgglG/yBoj?=
 =?us-ascii?Q?r7AY8R22H3n8Lu0V9c1wQ02wOTBBkDORmr0qvAL+MPU2DAaoNMHYLBgrAmg8?=
 =?us-ascii?Q?BSi5KNWTjfGdPC2WfaiRV3CsNjzvEmsME3M6aLGx/7CgUiiNk+xCVpDNNW5Q?=
 =?us-ascii?Q?sHa8RKdUITrKJxnMABwcKGru9eBObTFsAfkqsjBiru2Wp7hiH7antFuAWZL0?=
 =?us-ascii?Q?FDq5b8+TcvObFxA3rTbZirLP0tgzpdvqRtNjbQ4G15lhDPFREOxNmvtfNV0B?=
 =?us-ascii?Q?1mDPUOJZMPBR4kLhseJJrrE+F7t2tOANYyzFmF9U9cUGOvqwq1aVZr8BiiPn?=
 =?us-ascii?Q?bhOCbk/jPinxQ+yBBarpChlIpSfHkXZOm0Ezi6WJFZnfv7mUKRP9kmY8mIn4?=
 =?us-ascii?Q?Xncc7d0aiF2E/IpAZ9fFg2PRFue8YMBUH8I3qUa04V9j8sL+4l76+4PpU8W5?=
 =?us-ascii?Q?yqqaY5ELEQa2w01YrecPJIGvSHioYLQQe3TvIZFNE5i/Rtg0pzWU9fjETPez?=
 =?us-ascii?Q?nDFvbrIAFg7ynEDHYHCMnvn9/nls8kOfP1NFg+oEesiDxDPNqPv16CeBxdFy?=
 =?us-ascii?Q?4uxFIfcvuvPmtzj6oYDhNJEX9lGQCf2K0SEJPRFlkQIGmegSHDcZoyhOpA7W?=
 =?us-ascii?Q?VxS+u26G8HkZy8bG4ztuzkQdJiueympZAO5NJKabz5IgfPQTdZCYObBmfwLE?=
 =?us-ascii?Q?GWPG5Bh9YOMZ+BgTOfICnnRWvhfN2eUuSNYSS5256QUJ1IokIJmoigo4bW8T?=
 =?us-ascii?Q?yiFDaVToxN7FUkTFDlyhixbnyPh/32EE7gqmCjF/6ZhZnJdxyPZdQ6VvCKDo?=
 =?us-ascii?Q?U/o/GfKmQPQ8Gvf53QQ+iovK7AkI19DETThSfJeDn3G9C/KRn7JzM1c9O28?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: opensource.tttech-industrial.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR01MB5416.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff21d65b-4dd2-4c78-ca8f-08d967b0e0d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 10:12:43.1904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5638dc0c-ffa2-418f-8078-70f739ff781f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NUj5i/ox9sQnpnWubh2FS2Hx6gAeAR1povl1dxWh04FyFSXOgqXw2t3lA1PLw/h7EisR20Huy39UT7eA8RptOGyxd1SqO3e92Ct4/nKrP+cBt2zP24R1LVMqi/sREPP0xhy9Gy7J09sWOKJe0ekdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB7256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a small oversight in timespec64_to_ns() that has
resulted in negative seconds being erroneously clamped to KTIME_MAX
due to a cast to unsigned long long (which expands to the 2's complement
of a negative long long, even if the architecture does not implement
negative numbers using 2's complement)

This is especially relevant in the PTP context, since the ptp_clock_info
struct (from include/linux/ptp_clock_kernel.h) specifies

        int (*adjtime)(struct ptp_clock_info *ptp, s64 delta);
        int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts)=
;

which is exactly the kind of timespec64 / nanoseconds mix in combination
with negative values ( ns adjust times ) that can easily lead to calling
timespec64_to_ns with a negative ts->tv_sec, which would in turn lead to
instability of the ptp clock.

Fixes: cb47755725da ("time: Prevent undefined behaviour in timespec64_to_ns=
()")'
Signed-off-by: Lukas Hannen <lukas.hannen@opensource.tttech-industrial.com>

---
The Patch should apply cleanly to all the branches that the original
commit cb47755725da ("time: Prevent undefined behaviour in timespec64_to_ns=
()")'
was backported to.

include/linux/time64.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 5117cb5b56561..81b9686a20799 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -21,15 +21,17 @@ struct itimerspec64 {
 };

 /* Located here for timespec[64]_valid_strict */
 #define TIME64_MAX                     ((s64)~((u64)1 << 63))
 #define TIME64_MIN                     (-TIME64_MAX - 1)

 #define KTIME_MAX                      ((s64)~((u64)1 << 63))
+#define KTIME_MIN                      (-KTIME_MAX - 1)
 #define KTIME_SEC_MAX                  (KTIME_MAX / NSEC_PER_SEC)
+#define KTIME_SEC_MIN                  (KTIME_MIN / NSEC_PER_SEC)

 /*
  * Limits for settimeofday():
  *
  * To prevent setting the time close to the wraparound point time setting
  * is limited so a reasonable uptime can be accomodated. Uptime of 30 year=
s
  * should be really sufficient, which means the cutoff is 2232. At that
@@ -120,18 +122,21 @@ static inline bool timespec64_valid_settod(const stru=
ct timespec64 *ts)
  * @ts:                pointer to the timespec64 variable to be converted
  *
  * Returns the scalar nanosecond representation of the timespec64
  * parameter.
  */
 static inline s64 timespec64_to_ns(const struct timespec64 *ts)
 {
-       /* Prevent multiplication overflow */
-       if ((unsigned long long)ts->tv_sec >=3D KTIME_SEC_MAX)
+       /* Prevent multiplication overflow / underflow */
+       if (ts->tv_sec >=3D KTIME_SEC_MAX)
                return KTIME_MAX;

+       if (ts->tv_sec <=3D KTIME_SEC_MIN)
+               return KTIME_MIN;
+
        return ((s64) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
 }

 /**
  * ns_to_timespec64 - Convert nanoseconds to timespec64
  * @nsec:      the nanoseconds value to be converted
  *
--
2.31.1


Internal
