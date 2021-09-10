Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3255C406D35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhIJN6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:58:33 -0400
Received: from esa3.hc448-60.eu.iphmx.com ([207.54.77.17]:64783 "EHLO
        esa3.hc448-60.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231963AbhIJN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:58:31 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Sep 2021 09:58:30 EDT
X-IronPort-AV: E=Sophos;i="5.85,283,1624312800"; 
   d="scan'208";a="1668002"
Received: from mail-he1eur01lp2056.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.56])
  by ob1.hc448-60.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 15:50:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTlUvKxmMqNsQFxf+f7zkXrUm3AX5ouiobcbzHvX4HtKqBa58YlK8HTiVO+BqBRbsAvEwJ4NKBKfA2Ghf76IyKgoHPI1tuFom51UX9uEDrSzsTLSBInbK1swgIkIdTJW3287qBs/lD4SyxuakOlPlTSU6dmR9fJQ1q8onweMMLWwDihW8cTdyJwsLYxcHztojFMkJdJqNgwlNY3bjeL+uQb+sLVT/VzIx62FHLl6FkN8+ogo+onsPBfgKrgZ9+evHeKLxvpB6yMp97JZGWeI9qlRh/AMc8p7Cm4j9EZy7P0wkwY0E4cFLPTlpAOpb7gVlHJK+cIrfu/XOlmVvpqzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qGvHCePDcucczGc7QONXnuCqAC8FdXrSX79r6qiCZek=;
 b=b0QoHhroL56ZJoEXX+F72MzrHc4ga7OR+erxJIThacf2gKm3uElu7bwE/RH10Wo2kXFMUnN6BwBpu25d9iODWNmp5paNnRKt4CV5N7v8lhFgI2GX/360yABoP1cMn0qrnBh4fz4/pP3LSiAxqD+csihtBLdKC7aO+DI7RLgUAtjYdfNOEE+GNN63KjOjA2Lc7PBVOJ6gvPzziuWIKGXSy6gTGJt2UparlKDxE6LxDlpw/xZJ/tCbFGUooeg7bcfMobATXDkjmutIjLUwM44+FlAboUxQVjSUaIQQEw1czVHtyvbWzYpbLA5HnDqhgfsZicDaTwhlWBqXabk54iOxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensource.tttech-industrial.com; dmarc=pass action=none
 header.from=opensource.tttech-industrial.com; dkim=pass
 header.d=opensource.tttech-industrial.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tttech365.onmicrosoft.com; s=selector1-tttech365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGvHCePDcucczGc7QONXnuCqAC8FdXrSX79r6qiCZek=;
 b=CcpdclXrYx30R1yPJq118lpjD284UUF2D79XKb8OP1dxIuU1YfGEJxdhxZwHE2HSrFEjNOQHqBSC66FOaWnXINUj1lsxserozq/Kx4heBl5Fm36Vak92YM3VmGTvd1cB422jWUFx/A4vqbHyYU10Q+6GLcnLzo9PGJO5AuPLoQs=
Received: from AM0PR01MB5410.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:115::22) by AM0PR01MB3761.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 10 Sep
 2021 13:50:07 +0000
Received: from AM0PR01MB5410.eurprd01.prod.exchangelabs.com
 ([fe80::807e:987c:688c:62be]) by AM0PR01MB5410.eurprd01.prod.exchangelabs.com
 ([fe80::807e:987c:688c:62be%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 13:50:07 +0000
From:   OPENSOURCE Lukas Hannen 
        <lukas.hannen@opensource.tttech-industrial.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "EMC: linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH] time: changed timespec64_to_ns to avoid underrun
Thread-Topic: [RESEND PATCH] time: changed timespec64_to_ns to avoid underrun
Thread-Index: AdemSfFfOqTnASerSE+/zqTNEdMoJw==
Date:   Fri, 10 Sep 2021 13:50:07 +0000
Message-ID: <AM0PR01MB54100B19D6ED5FDE764FA516EED69@AM0PR01MB5410.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_ActionId=1b0d6886-b97d-41cd-9bb5-7ea256a6559b;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_ContentBits=0;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_Enabled=true;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_Method=Standard;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_Name=Internal;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_SetDate=2021-09-10T13:39:47Z;MSIP_Label_875f25e9-4961-49b9-93b5-e6cb7bcff2b8_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=opensource.tttech-industrial.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a856e2-f587-4bb1-c98a-08d97461e67d
x-ms-traffictypediagnostic: AM0PR01MB3761:
x-ld-processed: 5638dc0c-ffa2-418f-8078-70f739ff781f,ExtAddr
x-microsoft-antispam-prvs: <AM0PR01MB376125A562262B95460F760EEED69@AM0PR01MB3761.eurprd01.prod.exchangelabs.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PdoTRkUjrVBB2TedtwfLfPfpuF7UTqyE9foRRpcJLytQi0L7SG32ILtD1T/LWu0uz2+R/Df1AVl3TcdtcfKWyPhvlT/MFe0TyqhK0sLdNQqB5jEgsExr4yOjWY60NpnNxDqSlgzdqkj1/zS89B9dar+30hDOKSncHGvAmm4cXBThNwWe9uqsvyWdkUwrjfedC/pn8g6OkoCdwiCTsDCznQcSbl1lbgK60EsjwFcMXtSyQDx8PRtbuGV/2ejsqJQTtB3lg6oxGMjbSycJhB0El0tDtnqCW5S13NMAguLVTLES1PLvaCy6zWrCcDGz30IU9epNMC7wTKVCrfhB5svZYLimZjWtcZdqE99BpiNNS1fcqyI1AB6J7sl6+5BXOWMCT61Rn/TDL1R/soVFEL0PSllOh3qTccDBtL2iBFrTxlzlUz/P65f8gvx0bQfl2XP5FMoD1BqVfZBWQ24yV5offWDAZL8xhKcUQjAzbYX74VnrOL5y1jRvjyLidY9MHvXRIXO+BQZuMYF4erSGdzu8R00jiOg6v9wpgH0xGvuQLSNVuHIZi2pw0G9HeW9hkicXxRtgJIIcrTNyLutGI3bwcWsQsuPgjNirvjQuVa0jb1Vh/X1rjjtuLjhwPFJtHMopZvDNIjH93mdvcCHJQHSMEH1BQq83jYY/1o0p/3mm2QXKhHv13tw/ByNPmKU+3LQGsVoYLjx8spzees5t73uc0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR01MB5410.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39850400004)(86362001)(316002)(6506007)(2906002)(33656002)(7696005)(38070700005)(52536014)(66446008)(64756008)(66946007)(8936002)(55016002)(66556008)(66476007)(71200400001)(76116006)(9686003)(38100700002)(478600001)(5660300002)(186003)(83380400001)(122000001)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mWLOYCEPOvpbQHl7uXTlh+yggzi7do3quIzuyiwn+BqcPsHzpptlEvaNToIi?=
 =?us-ascii?Q?fuaI3wUnGSnINeW+4mch/5BXUs2WG+qQUndF2oYPR3Q76lrtNzYfYUYTZIZM?=
 =?us-ascii?Q?Y/2ZPmodoWqfblMLS3za4x5PHAqgU3OHzhRXNSLHO9cgmT7FWlLTnk7Set7I?=
 =?us-ascii?Q?f7w4QY6SSS7XGeDhaXu/3OBxdYQJIs2/dwUlgptsKHKJqsSDZHQoOHYMvcCo?=
 =?us-ascii?Q?4yaaxo99H3uOY81wjvGCNojQA37j283SxK3l1VRAl9LdW9IfjlWbbeNiA9hK?=
 =?us-ascii?Q?Nw6ebyEbvzdACEDn2saulZq1rRao5E/DPdGEFwZxXSOFnwtXgeHdvZmwsJ7c?=
 =?us-ascii?Q?gn28ZNVSEgYpF1YD6xTcOQm8bGwagY2JxJXZgNnSkVHgrMnJhdEvIk2cZ0jT?=
 =?us-ascii?Q?hSHth5wdWFHTl7GuIjfsROpFiKQQcAZRIWNtWh8YyqTdHPnJRSu1CyPFcfrR?=
 =?us-ascii?Q?YtPoG7PrL0UwS+1KOh2FnSeyRniUvHuMGQVASrEu6j98kWSWCcu6qIg/oYPT?=
 =?us-ascii?Q?lYRWaAUCRvumj1fUBJpKK0pn7Bwne+GKCjPt0cu8s+pHZiyviV3eBC9FiMwg?=
 =?us-ascii?Q?tVpuWMdSzgVeq2RoiqmyswORylVzhfwn8N8Svv4BZyl+HMwjOVZ22yE2Opmi?=
 =?us-ascii?Q?kzaO2nqC3NEO9pjlhTq515CAiC2ei0fCtSz3l4pdxlNN1dZT4KJ8bc+0NoOW?=
 =?us-ascii?Q?kjwo1TjBuXwJOMWMdhbqV4/HqIts0PwT0jIUbppTQqRnLDEvLVqcHotXmPtk?=
 =?us-ascii?Q?93aQTy8iUGPfb1k6+wmd+Q6RSM+P0eN0MrxHiTfLaXPCYJXWOOXi7tqnl2nv?=
 =?us-ascii?Q?vJ7lqySRrsQfBfs1AP20gsHjS1H/72kr7SFfdsDBtgPPrvj3lFitb4X7a0jf?=
 =?us-ascii?Q?bQpRbURrgKs0/e2Sq6blMkM5rSQgnvREmOm7hVau+wqlo4YFmwtSUTKO1yJk?=
 =?us-ascii?Q?5Ja4YnYRfaG733r3MYkyFoBLW4XD73qGMOU29AuF8VZFcfNb7Yx1QB4BdOkc?=
 =?us-ascii?Q?YyG1A6oNSCToLY2xzsNJiaLjGPJ718gTboxtNe9tpzKhrNPG+y6ty3MuT5dD?=
 =?us-ascii?Q?wm6buDUM9LDab8h6vLdBjQSFxlnbZYYeeEFT5bB6muUVfO5xD0YUaFQ7H0qM?=
 =?us-ascii?Q?re36qVZx4+MlPNfVWo/gqOOa+P6cIgdglwIjsr5zG90MOeclTbWyrGsjDKEb?=
 =?us-ascii?Q?CZYLQMfs6tCvBiuKsiuqVYkXAqbI6E37l43/K/eEDc7jI9ZFrGVA7GMhSCcq?=
 =?us-ascii?Q?k5peNj5VFAnve2j/9sEy2ZO0QSCAThJO84gHmHqUImjl9FTLRimeOI3xpAc+?=
 =?us-ascii?Q?zUEvWBfEN+46ireF+7QQ4IRuFHdiR2NaW2+yRvs7CWrDIUA3MUYNJ0LSBrUR?=
 =?us-ascii?Q?AH+JGgxnjqd1iSNhOhBd/GVBiR7Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: opensource.tttech-industrial.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR01MB5410.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a856e2-f587-4bb1-c98a-08d97461e67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 13:50:07.4760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5638dc0c-ffa2-418f-8078-70f739ff781f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AC3w/ToH7vJ1PEjKmImJ0dygmA+SjLTTw+VNG3+rsxDgcE6nGzbZMjubx2Y3MwHE4r52rBcetMoM85izzPKnToH0ocfpReb8bWcceUpjIzn6lK829uxS10ktBhT8nxCj1NxS2B+vMbOG9RzwcrNRlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB3761
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a small oversight in timespec64_to_ns() that has resulted
in negative seconds being erroneously clamped to KTIME_MAX due to a cast
to unsigned long long (which expands to the 2's complement of a negative
long long, even if the architecture does not implement negative numbers
using 2's complement)

This is especially relevant in the PTP context, since the ptp_clock_info st=
ruct
(from include/linux/ptp_clock_kernel.h) specifies

        int (*adjtime)(struct ptp_clock_info *ptp, s64 delta);
        int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts)=
;

which is exactly the kind of timespec64 / nanoseconds mix in combination wi=
th
negative values ( ns adjust times ) that can easily lead to calling timespe=
c64_to_ns
with a negative ts->tv_sec, which would in turn lead to instability of the =
ptp clock.

Fixes: cb47755725da ("time: Prevent undefined behaviour in timespec64_to_ns=
()")'
Signed-off-by: Lukas Hannen <lukas.hannen@opensource.tttech-industrial.com>

---
The Patch should apply cleanly to all the branches that the original commit
cb47755725da ("time: Prevent undefined behaviour in timespec64_to_ns()")'
was backported to.

include/linux/time64.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 5117cb5b56561..81b9686a20799 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -21,15 +21,17 @@ struct itimerspec64 {  };

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
 static inline s64 timespec64_to_ns(const struct timespec64 *ts)  {
-       /* Prevent multiplication overflow */
-       if ((unsigned long long)ts->tv_sec >=3D KTIME_SEC_MAX)
+       /* Prevent multiplication overflow / underflow */
+       if (ts->tv_sec >=3D KTIME_SEC_MAX)
                return KTIME_MAX;

+       if (ts->tv_sec <=3D KTIME_SEC_MIN)
+               return KTIME_MIN;
+
        return ((s64) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;  }

 /**
  * ns_to_timespec64 - Convert nanoseconds to timespec64
  * @nsec:      the nanoseconds value to be converted
  *
--
2.31.1

Best Regards,

Lukas Hannen


Internal
