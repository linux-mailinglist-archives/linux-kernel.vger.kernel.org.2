Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FCA319FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhBLNji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:39:38 -0500
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:28999
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230336AbhBLNjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:39:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctHXI3on9Dffu4VbW32PrhTUyahtup0hIfl3LFiLsXhiLj/hHk7P21xGJYgDp5Ce/2WPqc4d36xY7p3nla2gLdF9yLNFRzdg+45Dxa2ALch9+gt319Uz1UxIKo+U4VcU7dcgWcjPLDU6GkRpHdsZv8eyagoTyyqVcJ1iOt6P2V4cQfBWxSmUkndzWLtG8/EVVEbFdz32mGB0+Wx4q5XlmdJ/3h5trIiGGTqbVs+ugrm/rJj1Yr3JYnDIYYrwRk1XcZo0CLd28cLzAoxN4N+J3J8jMcjkJu9A555oSZBNg+uo9K1UYH4GKg84/Jw8PmnGxfVFIOkYmKI5ZsKYrfsTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFA5ttsy5pD6JsNKvWI8HVy/TN3o6C0B5hk/TJUdfXM=;
 b=MjCK02m0njOVqzG0/DZSVn+WR9r6iO//U36fAW2GPsdlXz2Mh8DVsn5ZDXYv3Y5pJpJD0QYGocI1GTWCXP7TdG98tcQKjFLyxHfLiqmwW5PqsTZxGQb28UlsjM8UrWv8pmCmllg/05YVQdtZpgHi0SrnflksXwlQYG0HLZCYI+rmkcVUjZyYlXlsWK5o4GiOUQZHhG2w9xHkxVcwpqPGvtTjykuwklc1CEdObWhRYQPXcg+SvqpkYoul7oljU8xxHkxhnG1QnERHl8vmk92/zUizGW5rib3i6eXuBxe0HXZ4HETRGWPu9q1cfa/G8iDYnB1BZjv1eLx931Wuc6dDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFA5ttsy5pD6JsNKvWI8HVy/TN3o6C0B5hk/TJUdfXM=;
 b=i+/ampxQ69MIGU7YRikdR3qDfpky3YYwDOKu8pvXV8Gm5irs9zkP7VaUlsJH31bmbuJAhI8QUMdO1a2abQOp7oueESaYcmyJvh9ZO/BpBJY1HNbruDkprv8+J3aUd9uN3hoIkpkJHYCR2GqBIfqCU+m0KVj1lbH7uDDoQUGdOM4=
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 12 Feb
 2021 13:38:23 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::4cc3:4690:b257:8c51]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::4cc3:4690:b257:8c51%6]) with mapi id 15.20.3846.034; Fri, 12 Feb 2021
 13:38:23 +0000
From:   "Beckius, Mikael" <mikael.beckius@windriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Sv: [PATCH] hrtimer: Interrupt storm on clock_settime
Thread-Topic: [PATCH] hrtimer: Interrupt storm on clock_settime
Thread-Index: AQHW+9X7XBZLk3jbIESBUTkLlSY7p6pUjrzQ
Date:   Fri, 12 Feb 2021 13:38:23 +0000
Message-ID: <PH0PR11MB4904A4830FED08F91CA97C04928B9@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20210128140208.30264-1-mikael.beckius@windriver.com>
 <87r1lu8qmx.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87r1lu8qmx.fsf@nanos.tec.linutronix.de>
Accept-Language: sv-SE, en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [94.254.65.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad38bad2-dd8b-45be-964a-08d8cf5b7836
x-ms-traffictypediagnostic: PH0PR11MB4999:
x-microsoft-antispam-prvs: <PH0PR11MB4999C8541C7EAE1096EECB87928B9@PH0PR11MB4999.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmsTIw51WYUaZzY0MJMWlRqv88CW+ztyP9LQQ4BoTBVB6uX9ehgnv862xdsaCvyuCWiJ4KpciKT0qb+xRRs/oEsxwkswur34OJUQUdnLt4ttFRqWi823gl9auQLtC1fV2O/wJgwoqmVJrSl3//rDlD2T6BdOKgpCIoh16AunPmI6b5EyuLkkiQWDjnNk4sujSjwx5D1Xc/4P5KcugPMZM3GOiRhQZ16+RPCYXc1x8esLV7QpQ5scRisYQEunX+1Vx4bT6/Im7DH3GvsnMawvkCi66Hrg5Mmm3DIBjyodO5EiB/W19HXVCMHp/c7vm9HkpbB2k5LPYyELtH+VNsUj9KyQ2upkwCIVjRyS9pi2gvst2lxVo0NuU0EcS/0o7/Cr6fi40TgCqPSu++ZuJCdrO4/XAe/zWxbsdCvw4sxHYNvyVqdMkCOL+WSIXCB72yJTTJHWjpcdT8NjDmwClE72J0qvxuUSJeOazv5TrYDMLiEnFkrNfOvsxMVjKIz1VmsuQAhhaQX4keGAi+ylr7dalw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(376002)(366004)(346002)(9686003)(55016002)(7696005)(26005)(6506007)(8936002)(66446008)(110136005)(66476007)(64756008)(71200400001)(186003)(52536014)(2906002)(86362001)(83380400001)(8676002)(33656002)(4326008)(66556008)(66946007)(478600001)(316002)(76116006)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kYdgL5h4B7r3Tl7LQalBRr8QtwKEkt0YDMIHxiRrI8gnZshoHw/tsbrxE8fp?=
 =?us-ascii?Q?nSgRK6gCs+0ld2FghL19pvykJWnolm5/mm5ZRC1UkdFstd67870PDAPMPX7V?=
 =?us-ascii?Q?VGRx/ezCH2AsAJY3uRvmTwPfyvLsbCkoWc6+tmfq3jEcCgvEP48/TKceGPrf?=
 =?us-ascii?Q?HsGeh/ZYoVwaxWakWAEM1fs92354BRdpJkTGixPiIOoUf3eDMLH9zD+CA5xK?=
 =?us-ascii?Q?7ghgHKPDY//p43edctolibZuySFYziPi3wgKzBHm0H8mxJicQoW8llJtx+1r?=
 =?us-ascii?Q?EQgJtus0maWpWnu2UK+Lh13/4VlONOB9dM9+oKROtj8rIpcVqgg9WIJaBsyJ?=
 =?us-ascii?Q?DDTS6bFoOXq28wEjr80D/pdgTsrJlS2MCg31JroUXL2c00dH7e9/q5GNvCqv?=
 =?us-ascii?Q?sCoTY+Dy61cUOj80aP33a6OLy+kz94ayYJZCJgvWt7xhUiBv2+O3w25Y1cB/?=
 =?us-ascii?Q?WW3Uq/7I3+BvcLBTUZVX5JI8sqwgC4agFAUlx2P1BdONd18BlGMEfDDrfYuI?=
 =?us-ascii?Q?A5puKpQJhucU7M0WhrMlqxMBuI0cF+lbgd8spY8BX53+da9dzHxZXpBvAB+R?=
 =?us-ascii?Q?fF5sd0POI989VVcG0R7ts5b3IHUaOebOYWbXVz0fMzAaSoNelzTf7Fh4FSzf?=
 =?us-ascii?Q?Fjk9uG3lTs1AJ0umdkTLiUdlIMlGo/lacJ+ShROMriqVPoXKJkBbUPMbeSWi?=
 =?us-ascii?Q?9ZG5nChRTYC8tckQzw5/ZAM4DL4Wrr55t6iTQ1yO2jxVA8e8zUxpLLAQ1LyA?=
 =?us-ascii?Q?o6SjLkoHdu3wFa4D3rAXQetXMNUQUtdgQDpDrDeDLldjt/7jOnq5KaMKJB8R?=
 =?us-ascii?Q?Hdtj1U8+jK4176b4dNUNBolUANjfOlbd9OIkIOgJoOoNFCRFiMxcaEobfnll?=
 =?us-ascii?Q?gKwc+NchV7qiT9+jpDh/XwmBSvTT1s0DQ6YMqqLwPONQC3KQdmauzeVzzEMI?=
 =?us-ascii?Q?Se3kP6MEmfr2h6RvW/J4WtUobp/UfCnW07uqiwjh18QkoAjs+38N9haSgAmV?=
 =?us-ascii?Q?9CAqQovyWA77Ee7Y3vgzqiANuBhPmvEk7ZRCbyjY0XlBW9u7B6BoorV0MCW/?=
 =?us-ascii?Q?J/SEDlNCq4ahvCFigqmIYAj3ySsp8zscdSQ6P4q69F7fJnHFxj3dQSl2YN/t?=
 =?us-ascii?Q?3MF7YFvGX9AZZUBpqE1xeXuuIblVB6vnzVthqB/drZ4vGbTV9gWp63SF9/OU?=
 =?us-ascii?Q?lnoiv3iz4dwnDfPLiBM7TP1lkNPPolDL+vXbKlo/1qIUzL/bMafFwyRphH+L?=
 =?us-ascii?Q?bg9bd58hMyBoZsrW5BY/3Q1SfukHjhMlfmHRi9GdsPIryJ5zThK9W+n7xD2j?=
 =?us-ascii?Q?VO7s2aSsivIb0oHFwIRB5Bvr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad38bad2-dd8b-45be-964a-08d8cf5b7836
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 13:38:23.7726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhu+hab/QSqM3e5+PcUGikaYk8005KDzNvpGM3oVpl8jxwz4Fv0e2hVRaVJ4W31zRrBPulGIQ1Yz+z7XRA9mAgfKUcMaCj8A5y5II48Y8wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the update and sorry for the late reply. After long-term testing=
 of the patch, storm detection improved, it turns out that a similar proble=
m can occur if hrtimer_interrupt runs during clock_settime. In this case it=
 seems the offset can get updated and later read using hrtimer_update_base =
in hrtimer_interrupt before softirq_expires_next gets updated. As soon as s=
oftirq_expires_next gets updated by hrtimer_force_reprogram the storm ends.=
 To fix this I made the below changes.

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -529,8 +529,10 @@ static ktime_t __hrtimer_next_event_base(struct hrtime=
r_cpu_base *cpu_base,
 			if (exclude)
 				continue;
=20
-			if (timer->is_soft)
+			if (timer->is_soft) {
 				cpu_base->softirq_next_timer =3D timer;
+				cpu_base->softirq_expires_next =3D expires;
+			}
 			else
 				cpu_base->next_timer =3D timer;
 		}
@@ -633,19 +635,6 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_b=
ase, int skip_equal)
 	 */
 	expires_next =3D __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
=20
-	if (cpu_base->next_timer && cpu_base->next_timer->is_soft) {
-		/*
-		 * When the softirq is activated, hrtimer has to be
-		 * programmed with the first hard hrtimer because soft
-		 * timer interrupt could occur too late.
-		 */
-		if (cpu_base->softirq_activated)
-			expires_next =3D __hrtimer_get_next_event(cpu_base,
-								HRTIMER_ACTIVE_HARD);
-		else
-			cpu_base->softirq_expires_next =3D expires_next;
-	}
-
 	if (skip_equal && expires_next =3D=3D cpu_base->expires_next)
 		return;
=20
--

This is similar to hrtimer_reprogram. I also removed the cpu_base->softirq_=
activated case since as far as I can tell expires_next must be hard if cpu_=
base->softirq_activated is true. I might be missing something as I don't ha=
ve whole picture of the hrtimer subsystem but at least no interrupt storms =
are detected during clock_settime with latest changes.

Micke
