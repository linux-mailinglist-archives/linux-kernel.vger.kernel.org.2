Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9AB373EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhEEPhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 11:37:41 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:26348 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233483AbhEEPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 11:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620229002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wGx/Sr59UsooH/Ef/uqSZ0p0qWv43FJ1EfWc2udMDU=;
        b=bIA7PReYUl0DMgrxtrMEmLCpru/UT8uhPJZoedil8FkQpl5bu0i/nAfGD6TqXCkH3w6XO1
        7j0pgv398d55aXEMYtDnwVGPrS27dQ6MvqFgVR+GWsItPJSjtCLU6+Vtk3W49CPJypLK32
        R3A3EsYyFjTEfRFKfM1NHqNvk37wuqI=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-36-6wOzTaRhPIqHq4pw6aG09Q-1; Wed, 05 May 2021 17:36:41 +0200
X-MC-Unique: 6wOzTaRhPIqHq4pw6aG09Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMsqZse8ccd3g5COzJd/noEYfCB99YLAVJA+e8OQ1iL2mm//LmBX4e+t6muxGj5JwslrUmH/mLRZnNMcRo9NtS+bmcXZbWk/pV5RTUhHmWvQOs/RBUKl9ZFO60SX7JZgM/9oMu3zTEL1GyyyKjpXMDsyKy1GVW3+o7tqrfR8kBPWefXB+EHWAkoi26L+x+Vsy3nZf2k01CHKIpdtCeB/MUd8zpDAeIVLwtIjk6hLeXwl93i0M5JbbMfC4pwhdsbHj3SEjk9xyWWs++24MV9snr7Et2I9JbTJDbuRx3VEm+13nQ8/iznKoYWjGpHFsEZG1wmq+qeFRAoUb55cPblScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0CwasagLNXAXHo6a0a75bNG8CnRTHAUwxJBgdhNEe4=;
 b=Y04UvazSR8jpPG9NvWR6I2u6T/MSg6NHI2d4QDwmvSgEISu5hQR4B3hi0rp5iAsOLIRtshGiIj2XU244YJOzw7IgS82b7FXBPcq5S6+4JOs2shw4sDtr9TfE5TIqzAp4bdPQsO8Uf/U8GrqSA5qCcWwMVnd0cm9YxSRkngK8v2DoEPBdlLB8d9mPwh1yEGmPaGgIP7Ak7JuRecCqQjzOR5cqc1BuvVMJ8XqrQ3f3h4z9ktHf1XmDI0vYRg6R/9BpgP16RNB/tGAGTiI6IK4PEQCyoSnX/9sEXEiFggOb6+Q4tB7FfkPt3RZ1Z0t6cD5xgCjhOAnScTmiiggOm83DkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Wed, 5 May
 2021 15:36:40 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d%6]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 15:36:39 +0000
To:     Davidlohr Bueso <dbueso@suse.de>
CC:     linux-kernel@vger.kernel.org,
        Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210504155534.17270-1-varad.gautam@suse.com>
 <4959eb8d8c14b00113370ae86dc7c9f5@suse.de>
 <fe1b29a0-af09-e270-de52-09bacac35d86@suse.com>
 <6fbcb0fa502e7574f87213fc29877ed8@suse.de>
From:   Varad Gautam <varad.gautam@suse.com>
Subject: Re: [PATCH] ipc/mqueue: Avoid relying on a stack reference past its
 expiry
Message-ID: <5abf8348-b1fc-fecb-d130-6d45b84ee081@suse.com>
Date:   Wed, 5 May 2021 17:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <6fbcb0fa502e7574f87213fc29877ed8@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [95.90.93.216]
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.77.67] (95.90.93.216) by FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.10 via Frontend Transport; Wed, 5 May 2021 15:36:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1986541-2577-4b3f-d5a2-08d90fdb9394
X-MS-TrafficTypeDiagnostic: AM9PR04MB7618:
X-Microsoft-Antispam-PRVS: <AM9PR04MB7618DB12A9F7707551F36C06E0599@AM9PR04MB7618.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eq2ea7npgJs+wotgbrmP10ONX6p15qFeokLyJAR75QvfUZ1eQv83OyHo9YPkU6+RXwQnrdmpFuBOqll08q0sa+qZVIJ8HB89+iCeEUZZu0C4+N3+ky2sPyUMlDMoXa4W8F7qevi/scseFhhvgPQ3BNCGpYX7uuZKmkXifd8spu++H/0/Rys3EvrFaXPSfhOQK8aEhkdryd6EHsPNtYhcjqsS36aWEnAPuVi6tXybS82kJFUrYkrdf4UGBRJCHDrBwupfgkLzLH7maKY+r5Tfual0F2+A0b49suS3QU3IUPNZoXHBywh1ll5qLlHqvQqpTVuQI4aeg47uACv3jgqad1YrSx86VnxcO3iopHUn+s+GY93Mt9BOT7/2ReSr769tg4QPQIcHLO7aV8ifRZXh8rKwXCO7VHFL7YYumLlomxkI+v9VrwuK9Uijt+fxbERjSLdg8tkz/TltPCQtz37p5MJMrh1k7hKffUp4aQHKWGcvR+9p1SjPG5yGJDfsTOfl/+NaiHCVIJTg8+gatzkve9Q1bKHL7tdq6USZ9ym5/jmXp8wwRCzLu4EbEdhgUK+ZP22RW6hhkJZosT9UJclmmh6tLD4xB45zUhSEatk8Mrygc6Eg1nP204428CHpAhs6KsrcacNMvWdmOmwwKYqIwF+Via1TsJJnrOv0gu07zvyp7VXP0yAFq2RT8lZnx/rp9e055+qN5syn9rG3kixZTcayBUvX7Rt/JTgildO8qPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5650.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(136003)(346002)(52116002)(16576012)(86362001)(31696002)(5660300002)(6916009)(2906002)(4326008)(54906003)(16526019)(53546011)(6486002)(8936002)(31686004)(83380400001)(26005)(316002)(66946007)(478600001)(66476007)(66556008)(186003)(44832011)(2616005)(956004)(36756003)(38350700002)(38100700002)(8676002)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?62hdLpqI+8n7Oi0RBC95XGI8cx9EPD5PQFr0mu/Yk40DEoolJdc04/NnLD+S?=
 =?us-ascii?Q?KKihgCkjYpQpUfPtXQCq+QifMpOY+CQxIwybmEszhaHG8Ib2pwqEc3pZT00V?=
 =?us-ascii?Q?SWEoZkT/fRj2pfGa9FNUbUfcVudKvF+Y/3ZlyT4QDWa5GUy+rQkZSbWOkx2X?=
 =?us-ascii?Q?znToXgwXVvCTt+JMTMXdVE8egDdPLZfE6slvV+AZ1TqGNcfH5Bhod61tX6Us?=
 =?us-ascii?Q?fmvFKyu6Qs0410d1I9mmioKB/W2VyphkRLKpQdKAEXGn3AiGAXxAoTaALVgT?=
 =?us-ascii?Q?fe82g1j4hPW9X8gnwfF05eR8KXIWnf6EQ65YH8Ee7BJkgHALPgaGvbt+hj0r?=
 =?us-ascii?Q?fhC4GAh1aHzPvvaZInMQEE6zotAATp0KBneJOvW/5gBIkvdmVZMlowSPddC5?=
 =?us-ascii?Q?3LUPnQnjTR362OW2qzXD2Q8Vhf3sjyJcZJ6WpNSZbJvP3p08H4+LfCqjXk6B?=
 =?us-ascii?Q?eBRP55Luu+Jwy/33M671THNMDA4scnD02VlPfE2dh1FpRfuCarWHe0soalJC?=
 =?us-ascii?Q?mHgH194kg511AhSMevm4m1hIKvUA836p7hdT8F/RkUM7KrqmKHgAskuEjmZQ?=
 =?us-ascii?Q?Pz0JJc0ZkGauPSDPZLktV+HO0hHKEqrHwxsWqRlvTFcNoz1dzgh9o7bj2wQO?=
 =?us-ascii?Q?YWEnlvmYbvVCKkA9HI3ofRJS90lZFOAqnhTdVPTXowVsBkH8WRmHNTAlePLs?=
 =?us-ascii?Q?qwozrfubeBsUQo9aJ8tB+H8Z/TO6GwfEQCYCEESz6bW/pNdzp7OvY0xbK5xZ?=
 =?us-ascii?Q?MsMPyGTSH7oBC9YT/4DXJFn7UDpQ4UpRIHA1+Mzaf18vS9z2HbH/ZYLBUwze?=
 =?us-ascii?Q?3PjBT5GnWUvEebVsRGkROpnfkNu8VrgdayGh/L/+72LD8aaMVLH+YiZ7TtkF?=
 =?us-ascii?Q?PKCd0qZf5cHUtcz5JrwdQL06k8i2cUhy9/mUQyiMNBTZI2/T96Bsx5+vgFua?=
 =?us-ascii?Q?r60SowWQf/m7Vs0Z6IU0HGNCUT7Q+ms3wBmKyL9ipSGdJnA7p70z38XjDzOH?=
 =?us-ascii?Q?gey4PGbxPqA696VDxJL5z+JtriTc5NemtITDHYyCXXqxBkFXpJkBvcUmGZxs?=
 =?us-ascii?Q?Qm0cqaJiaJhHW+W/XYvxxwVYvIxzqdfAiI7s7UZbaQeWD5LIW5sNy9J23UdP?=
 =?us-ascii?Q?O1dzdVXop55zuEqfH2LhswysKkZo14UNs3R1zPH8eV5g46OGu+0MdNDJSFyP?=
 =?us-ascii?Q?nqRYodT52XZAeqj3LQdnFVME3jEnB9o0KUkFbvJh/J8O03hu/xnn9YIasRpP?=
 =?us-ascii?Q?EzhCZqurWoEm1JDbvUyvq4m0zm/vpS+0Jj6/a/4GhR5RxIAuKyir4v9SU9+v?=
 =?us-ascii?Q?/Dcbseqxwefyjm6WNqCtPobo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1986541-2577-4b3f-d5a2-08d90fdb9394
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 15:36:39.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MaRpTeJMouKeKcWb6CjHkELQiHlDPsY4nLvf9masGCt6xBZOBnNWqXK+/2mVtLHgIf6zRVsaD8kfiNy7K/9qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 5:11 PM, Davidlohr Bueso wrote:
> On 2021-05-05 00:49, Varad Gautam wrote:
>> The race here really is about the lifetime of __pipelined_op's `this`
>> argument only
>> being guaranteed for some duration of the call (ie, until someone sets
>> ->state =3D STATE_READY). It is not about when wake_q addition happens,
>> as long as it is
>> being fed a valid task_struct.
>=20
> Again, it's all about ensuring that the READY_STATE is set last, the bloc=
ked
> task has no business returning in the first place, making both races (exi=
t and
> the one reported here) similar by ending up using bogus memory.
>=20
> ...
>=20
>> I considered that initially, but given that the race isn't connected
>> with wakeup, I
>> preferred the current approach which makes this fact explicit by showing=
 what's
>> valid/invalid during __pipelined_op.
>=20
> I understand your point, but this is why I updated the ordering comments.=
 Furthermore
> there is no reason to decouple the task's refcount with the wake_q_add op=
eration, it
> just makes the code weird and harder to follow.
>=20

Different tastes I guess - I'd avoid an additional case to account for in t=
he
MQ_BARRIER comment block and have the __pipelined_op code describe itself,
which avoids some back and forth while reading.

If you're still unconvinced, I'll send out a v2 w/ wake_q_add called before
smp_store_release.

Thanks,
Varad

> Thanks,
> Davidlohr
>=20

--=20
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=C3=BCrnberg
Germany

HRB 36809, AG N=C3=BCrnberg
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer

