Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8B3DE8C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhHCIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:47:44 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:41313
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234636AbhHCIrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:47:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebu/CRLSTEB96A6m6q26O+f6eNWdd/Z/SKRDSReGUPWld1AJLxH/Aq8OT1keFJ36OGBRE5NJBQyfmtgwEWJlaj8DZYY54dEV307lvds3SCaAIUFqwNXg+agUg6F+UA0SG9a18Hss8pEcn8wb1kf5n1+sCVgWhIqEHvSKAffVAfFnZVGu4OPLDQIJMATf5TQJonWtLuHo/aAma9ceguuwpNR1xb6D5Dk9OwVSQt1kVtLPYDfjXcsCnU2ktwGvTdwIaiytdHsPYRFIOhrIjIpg+ZrCJ/wWTqoicoLS1YgK0TbEJorRJf5qADBSQlMA8Fyt1cgRf0hSptc6jIgeeVzW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXBwYP7st40rGibKMa9B+wZxh/5OhfACV7msPtUoaPQ=;
 b=jN12gVvPfhE/6tkvt+dPE2vLzu8d0gu0pxkpi+yWuIuDrf5yL4R/7b/IYuS/g7Uu8NB2iEx7tuBttDrCT06DQ2Alu+GifEIYVYJp3Zh5kULVnsS2LsD45xLyRIenN7RH7rxG8oXLm/J5mUqD8+y2iSFkOvj6b5lmQre7tVdHbuSaGXw1532X3ZbefxCYovu/nG0GDSnxczJ94w2ZMCB0k+n+BzOW8vUXPh+CC3m+l8/u8qT0X+4boKVQtx1Cd0SQecf6OptYPov71MKMvpa8XomyOTghxVd69G2nZKAwkP7lKJ5B7uTxTscy2AlszA16iqaD1rnoThQWl8nwy4qY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXBwYP7st40rGibKMa9B+wZxh/5OhfACV7msPtUoaPQ=;
 b=V2WQgYnm8kbVGGYpA/ob/mtFmccO9hThk0ts8wAtXzBJrbLMjMgtFiiQfNWLddRWtpCnjJtJNhWuA7R+5QK8CfHR3kJbflZYTfFAMWxuVFTApj1jui7I70tyHS1mrIsfmlm7r7qMxUvJHLLYzBefto/l8WAtnUtfUPiSMRiwPaw=
Received: from BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20)
 by BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 3 Aug
 2021 08:47:24 +0000
Received: from BN9PR12MB5384.namprd12.prod.outlook.com
 ([fe80::69d4:43bb:10a6:6349]) by BN9PR12MB5384.namprd12.prod.outlook.com
 ([fe80::69d4:43bb:10a6:6349%6]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 08:47:24 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched/debug: print column titles of
 show_state_filter()[V2]
Thread-Topic: [PATCH] sched/debug: print column titles of
 show_state_filter()[V2]
Thread-Index: AQHXeGApwcMMUKvQ2UeYt2AcIPdlB6thl0RA
Date:   Tue, 3 Aug 2021 08:47:24 +0000
Message-ID: <BN9PR12MB53844B3412546087B8C80AFBF2F09@BN9PR12MB5384.namprd12.prod.outlook.com>
References: <20210714032705.79726-1-shirish.s@amd.com>
In-Reply-To: <20210714032705.79726-1-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-03T08:47:20Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ca840ee9-aa4e-454a-8273-f3b2cc808c58;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 041395e6-e6f8-4816-9b7e-08d9565b5098
x-ms-traffictypediagnostic: BN9PR12MB5129:
x-microsoft-antispam-prvs: <BN9PR12MB5129F3DD04B26CB4E1F1097DF2F09@BN9PR12MB5129.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:274;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZEYtuSKVk7TWQp0ivKY8IDg5kz/z25hes4KlQa5mIdYZrgoV1SaClEOnJDtJfR30QZ6WOTYTrC0aKLSSdvcJ/vSfwYAf8f3+FgdlxeXsQHAJ6Yvt0BR8f92+IW+T4/0Z3moxWuvJdz5//7VH2o+RlPC9eAd5Vbc7d2snSVeD/UjLgwtXsxmV2xnyCB+lacdd529hztlwSK0EuPzbHLR1raVSMpj4K/NMmuNWQ3Mcdgiz7IgT+t/hwN9nUOg+NrktQzlp3AQXSck218//8te57thP8FAN9qQgYmwwYS4xiwIA+j+pLMnOrfucDq72x1klB4ty0iSHmWtC60x1IhZCGFn6bvSxgaBug1isXB+aKEzI3B7y7RF3FvHem2STttSePERLvulth2usDsht3FQOAoHy8130NYZQawh1aHzup5jDTD+ugb6L1Ee951ngKoG40vN7NmFenFEa+JmFdXHv3Grp5da1xXQR6M/FeGyPqAqhihgS+4hiR0QZ0BSBMwAIzy3jfnNLAykOQoCSqTe/Ouocm6uLAMrdNzYsVf11EJrJM1Awz2Lv5nL17TITfiKoVQ4zvcycGHdpAE/dAYCcIcA4JhlFwHeH7K5W6HJTfW0YohWfWs63T3k/FMX40zZkAHsHdEWJNUXjqSktnFex/HEogoM1dqt8lO43FSh42MyN7TiDQvkE/2KJACgD5LRXF0gHRxMJdofqHCIaXa+TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5384.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(5660300002)(38070700005)(53546011)(38100700002)(76116006)(26005)(7696005)(71200400001)(2906002)(6506007)(186003)(83380400001)(110136005)(33656002)(7416002)(66556008)(66946007)(55236004)(4326008)(66446008)(8936002)(66476007)(86362001)(8676002)(478600001)(316002)(122000001)(64756008)(9686003)(52536014)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x46ovSYGB/ItGuqngb5fUojQhhtbg3fgPNDHHxt/eezuXej8WULkaZ5HcuoA?=
 =?us-ascii?Q?hteSLQyTC3cZiSp9E6QrRhqkKdItibFRgfhCmDwvcz4T4C9F4rx+eDxtADtD?=
 =?us-ascii?Q?lCoYnaY9R8UCMi8nUSyZrpmriYvlUuxTYdennMvZ6wddTEcIwjAJWR6qMLSx?=
 =?us-ascii?Q?m2HTacjzXbQ6dryAwzQ5OXAhqaljGS2cOt6RVaUfaY8qJH7ml9ETm/h31qVp?=
 =?us-ascii?Q?CuS7ZHyLrONlIpVvSnbJkTsV5bwDq0LN9SECdfHO9vSpa7JxfeFORig5DjJE?=
 =?us-ascii?Q?QOiUEScWp87y3iYQhY9TZ6d03t4LqAyVSlG+8aa1RGZNSv8AiNm3BqP+twOf?=
 =?us-ascii?Q?ah4HzGj/0mJO4D5xamzhnA/bbvqitLJ/cBlW1mwgjzow2n5PsORdJ9jYOfcn?=
 =?us-ascii?Q?Qfh8KvrwuQ7B6QPHLm6qvh3DVN7Abl4hbpy/njSyaJl6JhAS/Dn4VKBWq+py?=
 =?us-ascii?Q?NKp1cneSn/FZfx9rzzYs2VGEhvt6oRIhKtaJshj5NRDYwNRapfiAlNCCbv0Z?=
 =?us-ascii?Q?3ZvrPMMY8rxeOPIaGPowdcsqUFPL8s1jILsYP5JRz10dA0F9QVdw8LHM1g57?=
 =?us-ascii?Q?+1/YqfjADXOu0sVBUYUf8JUmtqcaB6S/MMn+mPpUwhuyb+c++VTfuzKJ9fmD?=
 =?us-ascii?Q?HZOhxZPKEBASKmsd+vV+TU632IKj9bwzHZo9gk0CYFbjbmO16D9XnAFiFaK4?=
 =?us-ascii?Q?Mrp60sHFfSwLl7O+xhe1vjZS0JF0H0H0/8JE/c1T5QbpeCtfL/rPdOOwiBl/?=
 =?us-ascii?Q?4Cx5PjK2vepHgLKkf1a2n4naRsdoupo4+mM9T1XPr1nbXfMRdeuTJCrLTqk9?=
 =?us-ascii?Q?nB75Sok96ltimBXD9GIovUtU0AIB3tiglARyQIoFffgBmziajkul/aUoZSma?=
 =?us-ascii?Q?ABY/g0ygW0g2AgVNUHd5iDzCl49MaQILDhEDUc95TxBMI99ht8P1aS8jeQRI?=
 =?us-ascii?Q?ByHPUEgNywvX3DY8YyWYR1lHTNmGX0xF7t+64t8Dhv+TZGFrD4Nc62+hPiwz?=
 =?us-ascii?Q?tTA5UZfmIaP5q4v3v8SAB4nF3GY3ut7tnsCuruih3OzA20Wck0rsYiO4+C05?=
 =?us-ascii?Q?nDsLYFu7hg54s/pgHTCro14180L1xDZnXjwLHpqmszxnN1z0mem0Ee+Cga09?=
 =?us-ascii?Q?TAbAFBkbE2dLcrIAatObLsHnjLUuGtfsX5DqOcvVfYerpt59tdiY4ttBKN4e?=
 =?us-ascii?Q?aM7iMvtBZ5qKlHtCdt4uMWQ22Nv8ES6fbmE+19ZOiYKoJiuYoyx9tyKCb7ni?=
 =?us-ascii?Q?duGRyvfsi+n3eSmmX/A8cH69EhmNzNNprM9xsUeEwRJFtr2DYaIId7VUqPRt?=
 =?us-ascii?Q?GNthauSrtjW/Vj7kVwSXYU8+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5384.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041395e6-e6f8-4816-9b7e-08d9565b5098
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 08:47:24.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qqSNvcAm4CchDF9u7HrCVBkSp9MMSj9UbUUNo+lTJSM9QVH/9WihrYSmKU0G+o6ehK+Ez6xjTzSjrGsgQT2PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

Can we get this patch merged ?
Any thoughts?


Regards,
Shirish S

-----Original Message-----
From: S, Shirish <Shirish.S@amd.com>=20
Sent: Wednesday, July 14, 2021 8:57 AM
To: Ingo Molnar <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; =
Juri Lelli <juri.lelli@redhat.com>; Vincent Guittot <vincent.guittot@linaro=
.org>; Dietmar Eggemann <dietmar.eggemann@arm.com>; Steven Rostedt <rostedt=
@goodmis.org>; Ben Segall <bsegall@google.com>; Mel Gorman <mgorman@suse.de=
>; Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: linux-kernel@vger.kernel.org; S, Shirish <Shirish.S@amd.com>
Subject: [PATCH] sched/debug: print column titles of show_state_filter()[V2=
]

This addition in the debug output shall improve readablitly..
Its not intuitive for users that the pid printed in last column is of paren=
t process.

v2: Dropped #ifdef logic

Signed-off-by: Shirish S <shirish.s@amd.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c index 2d9ff40f4661..=
22cee4c0f4b1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8194,6 +8194,9 @@ void show_state_filter(unsigned int state_filter)  {
 	struct task_struct *g, *p;
=20
+	pr_info("  task%*s", BITS_PER_LONG =3D=3D 32 ? 38 : 46,
+		"PC stack   pid father\n");
+
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		/*
--
2.17.1
