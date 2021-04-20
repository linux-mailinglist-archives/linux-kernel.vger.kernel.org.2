Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7853366183
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhDTVXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:23:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42646 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233896AbhDTVXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:23:44 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13KLIfZ2026732;
        Tue, 20 Apr 2021 14:23:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YhzHs1rNvoZ1SdNM8kpaSIqZ5briovzT1eA53Rxx0GM=;
 b=F1jQ/snnp5L/WK6HqJFA9PLkiRpDOT2YuA3U3chRoz2w1ysy8M/VVvx0HdnIFn6E/A6v
 sni1/5LIZrMF9LJ+8S5f1dIzczfoYPI9QakDy7f7N7omiyl8bVXGrB5FM1beiciXZR4A
 KaG4Q3rwD50KZCsEP5ke5AuIuWzC0QEIwqc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 38191g991b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Apr 2021 14:23:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Apr 2021 14:23:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7O4H08LgkxEO0f0rgOh8hjD31Puj7WovYS+NDuyF+6b3DML45K+tRzmYopfuzK5A2OQPnKEzQULLBHwoVLhQA/3Nc89qrS77aEwqLuNd/myH/J5A/qirLH73fHbHMVAJNqEALDVvvjScoMHtvtcHIfzPPtwR4YFBS4ZxphJHQIFQ+0hOVCeEAKQ+w3yW/dbrQdqy+Nv6CF2aIr0DXgTfJ0ySY4p+wv6qMSi9dF6TUziM1XFsmYxWSIkpAUKG/KCpGvp+Y3hXUSCgBwvOsE23n375Ag46BF84nyPIj1Ux/hPKC4ORcd4WmpXGBvijCuqWHsd66+WfnWMoUbrFRr6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhzHs1rNvoZ1SdNM8kpaSIqZ5briovzT1eA53Rxx0GM=;
 b=g2lczvM+sPR6gH3Laysrj0VfSSwPngMvQMbYPRzja7m9lUpkkd58CGgNUgThyjTIPTBV2+/rA4aINOm/z13KPdr4pmSWzu7lfIYL+6fNTAcZMFlQtGtqGwCFWmqUha4DkokMkSUqCqqdsGolUh6tfIAcg5QMnnqdR/NXm25PimoE3FnwX+zZPsjFPDP6pRaf7f+X6sLilAkl+rE5PWDrca88EX3nuK9dvIcxoWTTV1qjynto0wjyL5Chf3kj9l0jIhBt62ML1wVBmaYePxGAbUFd1YGh7HoNtrlivYM67y8JzsXKu6O82rV/NvTedAVUm9VsTz4xUkYV3PFJzkFuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4647.namprd15.prod.outlook.com (2603:10b6:a03:37c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 21:23:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 21:23:07 +0000
Date:   Tue, 20 Apr 2021 14:23:03 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] percpu: use reclaim threshold instead of running for
 every page
Message-ID: <YH9GN/EbGE5yf+CO@carbon.dhcp.thefacebook.com>
References: <20210419225047.3415425-1-dennis@kernel.org>
 <20210419225047.3415425-5-dennis@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210419225047.3415425-5-dennis@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:3ae2]
X-ClientProxiedBy: MWHPR11CA0033.namprd11.prod.outlook.com
 (2603:10b6:300:115::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3ae2) by MWHPR11CA0033.namprd11.prod.outlook.com (2603:10b6:300:115::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 20 Apr 2021 21:23:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f22a65f-eb0f-46bc-337c-08d904427d8e
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4647:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4647905F7B2EB311E0AF2B17BE489@SJ0PR15MB4647.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e85WMYKvke4d2AnIvNmYRKbk2Qae6FnStcj2izmOWDtoFYlLtyzd1I0ahTxGb2qT4ZGCCmVYfXc6xw7bshKJH7OHfbCNp0cVcGxmsvRfFHvLnqJ8wYjqbKZQ8sCjg3VpdwBznaQtwEOn0flowKx27hU043Y5pUGlu+/jE6H7h/TY6JSQ4bGk9mwGdN4AZusFMebFOpxXp+uF3+huuiLg8dQrAS4V2WEoNZNQMKQW7XD/DW0r1Ipj1kZ94NJTksLLf9xqOMu0JIaj+OJlD7TTlQcEXyC2IZGnumz0R4VzGpVNe3xh0LadDyq4SWVFeFH/zYuV8RkwHZ4+JYytm963Dw44JGc12eGDqKFcTpjVY2GapOGYjYuqiNvHNlA+vEJYEGDkJdJmFUB+DtPj7sEEiUfmbpezYtATW0LH70T4Y9BM6GhiEjr6A0touNF3jfCcja80lD7QDTHeaAjgaWqA1qXFfNUltKm3gioaeXSIfU5XuSu2V1URncaQzs+ljlhLXegz7G0JegVTMLkPldIQ1ap0LWI7SEL/rrwfWKwWJUzOhb/fAZrIAOkfw6m2bmRuBliJnsxKmtzKb6NmCpZTv2OupgNZuXIyAdZasQytg5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(66556008)(9686003)(4744005)(8936002)(66946007)(52116002)(8676002)(6916009)(6666004)(66476007)(86362001)(7696005)(38100700002)(316002)(4326008)(2906002)(16526019)(186003)(6506007)(54906003)(478600001)(55016002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?06vSF4UR1r2yoft/IHskNhljT9aMtbwNid9KrC/9IJI1CpZ0aD7mTGIoJ/Wj?=
 =?us-ascii?Q?XuaXJHLP8X0RpcpYDFJ97oLo9Pg0iQJEINkd8nTyjosB51Msd3Ny7cSxkKJn?=
 =?us-ascii?Q?tqf+SDzjnoG8GuvYAMmcusU34QKjin5Rj5x9pg6mWyLC/Sd2FL0JO7UrCsyX?=
 =?us-ascii?Q?LPL7ET7kKADkJ+uie/qeKgcj+o/9/RHGhCxkpzlpGYeqmukZBNbCVE4QX0t1?=
 =?us-ascii?Q?XVuerbSWVNttn76ELODV+C8dfu3OuwQLj8bM+FgTBCbuE8WwdIcbfHTfOP/M?=
 =?us-ascii?Q?FVKmWe1/MwTfAix8pesnKsFbiL3L3zSeQ7THz4rw+zXRmiReDsXdCRQmqU9M?=
 =?us-ascii?Q?97jVT5zJmBu6vXp3NMPVS1X/L1nPmbuxyW2EynC1USyJsLd9QsDnCRmNa3b9?=
 =?us-ascii?Q?8Yo7GAPB1EC//qz93aYo27undcRO+U1adpY/ekMdSdXiV1L4WnJn0L7IBc7b?=
 =?us-ascii?Q?8YZGU2zDCHj8ri26NDw+jpPsWxs8w3cEdPzvws5W1xvsMVoWckzA3w+tSWPs?=
 =?us-ascii?Q?EtWmJqtaBEanAsGy3v3VoonRTihPc9Pl7iP6dhlz2vYBwnw9DM1GeSYOdtBo?=
 =?us-ascii?Q?mvM1PFx7AePr3dV2TcgvMILA7Kb/WWCsU03b+BrvQeV2cUCZSUMrWNlZ0BjM?=
 =?us-ascii?Q?RaKjPafWYAAehVKoaLf3OZhuKqOeAzimE1SQ/P6/KiQr3BoeTRl8RGXNP+XT?=
 =?us-ascii?Q?P1fzrwYJVSv/A5FVcKAY52gfXgp3VDauly3AxzIQGBdd2w26ATQDJXVWAzch?=
 =?us-ascii?Q?TObEJDqYSi/gTEq8tqOL4tH1SVrTErd9Ndn0K/ka4eKVML2knf+7qGOZwo63?=
 =?us-ascii?Q?tGmZQVb2ww+gYcUOUa1VUU70wETc6Ih+lexlIRQ0h5fDmatd5azg4uStaMeI?=
 =?us-ascii?Q?zBSum0XBmT9xNo6bgrarHnOV3pgYcBPN1nsxhtAF7RBq0VquXWKEMLwhcoFn?=
 =?us-ascii?Q?7U4gljZR++JaaJDzxO0zeY3irQ9YB2m2+f8rAE5cw1hSOaPPqlKKicN/wl0O?=
 =?us-ascii?Q?jAYuvzRtY9j/k7HEzqQR+muqqZ5iD1OpN/8CHDyuV59wrr8RgoYLZXxyKRjy?=
 =?us-ascii?Q?BdzPnBAfbEiEJMyI7pxey41hJcBYVbDUSNl4EeryD7CjXihIFluqDsI0hyE6?=
 =?us-ascii?Q?mXU6XXsaCpAI0VdQe8DuCpixeBObuJw+yFKLAyXYeUrQv+EMDehtyZw9Kggy?=
 =?us-ascii?Q?pBqar+EBV25N0QiGtPVM+cwfsNDLL/yT/EybTzqzzmpq+5p6uRbp8uK3tw+D?=
 =?us-ascii?Q?2AtTKKQejV3gHZ5c8n9GCou7cLXKLR6PZVgEQf0de8/fqzY3q8PAiVVJ09iw?=
 =?us-ascii?Q?rkUijmLiR2is9HUcrrLBmJHGw8zjOPCP2PSndnRd5wZdDA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f22a65f-eb0f-46bc-337c-08d904427d8e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 21:23:07.2528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnHvKBTzFxdWs2To8enqymPnPTa0R4tc1XvtekzYHYF3gu5/9rXJCK+218o38eft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4647
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _Sgu8OfqvlxFFjHuCHvWxKg37o7ZaBvf
X-Proofpoint-ORIG-GUID: _Sgu8OfqvlxFFjHuCHvWxKg37o7ZaBvf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_11:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=974 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 10:50:47PM +0000, Dennis Zhou wrote:
> The last patch implements reclaim by adding 2 additional lists where a
> chunk's lifecycle is:
>   active_slot -> to_depopulate_slot -> sidelined_slot
> 
> This worked great because we're able to nicely converge paths into
> isolation. However, it's a bit aggressive to run for every free page.
> Let's accumulate a few free pages before we do this. To do this, the new
> lifecycle is:
>   active_slot -> sidelined_slot -> to_depopulate_slot -> sidelined_slot
> 
> The transition from sidelined_slot -> to_depopulate_slot occurs on a
> threshold instead of before where it directly went to the
> to_depopulate_slot. pcpu_nr_isolated_empty_pop_pages[] is introduced to
> aid with this.
> 
> Suggested-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks, Dennis!
