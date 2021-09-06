Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0014014DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhIFB7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:59:04 -0400
Received: from mail-mw2nam12on2108.outbound.protection.outlook.com ([40.107.244.108]:49632
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233642AbhIFB64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:58:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7omeEhHEp53nPV3jW3tU2ISTj4pt7jQXxRKAmmgly2Ll2nsRdFrmiOcp1Y4zC5AmAHHNmHAtCwCOFp6eQp6V2WwXmDddYN3lmEHZbR4yU0DniXxO/JYfOsR/BbQN/MEEBL9Me+HyMKonaWnsu/T4yTrszMnwICnComIUzV5Um2wqoBSDoMTVXPbSsh5AQHinJK1ls7Uhd2lbfcu6HJIhx8nNXQAKPEYGFxx6gHS5AYRHg9fan2gG/rXmXjWqdbL3MfX1hw0LxlkPGVyq8qKgnDUrG4TVqpPu/7CoO7e1RvvVdM/z9MapgNcZJUdRh7d9sZklGvePSckdLceVNxA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Jqh+X4rotntuwUJDKlD9dodpbvpSczAhdVNXzaj7rDE=;
 b=IXBLKQ0t0XesO8U07LIYTN6DHJcGwAVMVj1nWlASinRmeniz3jmYLJvDu1HJni84dh78UMlD6GIiOFxUbcEobqtX6ZJrsvNi+PrIr61kMoIITpGSe5yTGg0267tHtIMfd9kAE2J+nSn+9UKqvUXT4O78bBZWujZDkS/yO20YJnVKAoTZeaQB8nxxLsIPpcbMqQsO0WEN+ZE74iKly9PZVOshcHE1vYhivQkjNKZrJwzvW7MiGxt7i/APQljKIYenhULZq5OlN48qQdPSKPh6HIyJyv+7mrObutca7uZbhxwxPteI+pGDMDpNltGl2BLGKB5VaZeUEZgDaP+Wp9/Wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqh+X4rotntuwUJDKlD9dodpbvpSczAhdVNXzaj7rDE=;
 b=WewLi1Mz09Y2snQNY/EqeKPBmeVc5QP7AYe1I9gSE756CkjLQNsDvQxXKEt5zPGqK/jt1Wsca03C2NQXZbTUIRIil+Fb8H5LqOUuIMOW3kXbAd6MlKauo7dX/x/Bq/3BHq9o5Ca1rotbstK2XKHDYtzMYSaxv6qbyhaY3FfN8uE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 CO2PR01MB2101.prod.exchangelabs.com (2603:10b6:102:a::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19; Mon, 6 Sep 2021 01:57:51 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56%3]) with mapi id 15.20.4478.022; Mon, 6 Sep 2021
 01:57:51 +0000
Date:   Mon, 6 Sep 2021 09:56:17 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YTXlwbjtAKBd5O4q@hsj>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org>
 <1630552995.2mupnzoqzs.astroid@bobo.none>
 <YTCktV3KF9PzIACU@casper.infradead.org>
 <1630652670.aplcvu6g23.astroid@bobo.none>
 <YTJxFgD0kKPs51dz@casper.infradead.org>
 <CAHk-=whCf1PAs7D0oGwVLfuJYxCcKeb3ApTF8E+PHGNJE7UW+w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whCf1PAs7D0oGwVLfuJYxCcKeb3ApTF8E+PHGNJE7UW+w@mail.gmail.com>
X-ClientProxiedBy: CH2PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:610:58::31) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
Received: from hsj (180.167.209.74) by CH2PR20CA0021.namprd20.prod.outlook.com (2603:10b6:610:58::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 01:57:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30b63b3d-90c1-4ae9-44f8-08d970d9bb64
X-MS-TrafficTypeDiagnostic: CO2PR01MB2101:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO2PR01MB21011E4CB6674C93A8A3B243EDD29@CO2PR01MB2101.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjxYLFmu59n8CWsZJCK5fqyJpj4+rjx05mo9pibkiviw/R1PJTZwDO5J0bIP2sm/1GeZ2gaXjSEajs9xWIlpxe31BX1ZZ0vE5A+h117kQb35tAf/yOYoHRFkSr01HqBt/7q8WyggoBPB4aZ270oYXN9doSTLHNFEj68ba7vXArGbYESrSNGU2UM/JkKAHPsKu3xujlshQcWq0FLqsVLBUEMU0Cbd9ZKGBH1rxQsbfUoHtoMcolY/O5qFg/3hx3lVNNAucB3eoYQNTVP5ZITbyBWQ49/vW6Hib6JoiP8wEiTgXh7z6jRaSyOm9PQxgsvt9CtEPqtnWIamVQU8O6eTBadjas8L9TjqxU2lQmWFrmEB6cyr1cyLxoaZvhNA8cuLaKri/Vb4LpRk+4HtbyZOjFeGI5Nt1zbtfTfzibet6GqMai/dtNPFWTwsYG4NjyUqGGDOcjU3DukYvlOSPuPXuxjTcu/lr217VMSdRi/F20SM4gQCoHqR7zEOjUvq/4vi4Tx2Fvck681cqZlyGIixksjWrqlQpFRYq5mPYUiAkhVmJIt0cLlF5l9pekP01/oiqWyhcq5phaae5a+dCAm6rcVxbA0kR6vBHkF+tq8uFmNfN426mKB9IgSqBfJf326BWX1UIIf5XYSyxBDbKcCDng9LfeqDn0bVvb5L6PWcrtpqNSfVK3YxM+FGIEaiVFxP/eXN3D/ndAXpHx8IpWjRKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(136003)(396003)(366004)(376002)(346002)(38100700002)(38350700002)(6916009)(54906003)(26005)(55016002)(6666004)(9686003)(66946007)(9576002)(478600001)(66556008)(66476007)(8936002)(4326008)(33716001)(186003)(52116002)(6496006)(2906002)(5660300002)(316002)(53546011)(8676002)(956004)(83380400001)(86362001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sK3kITPLubJRQHoorTn44oEiujxFgeEyG7X2cbSFO61+JXljbswSWrNpEJdP?=
 =?us-ascii?Q?TAuOK4K31cGfwyotBdyhXanE3aqnXmsxu0JBKj4kMBW0cmteANNSXzEgSksz?=
 =?us-ascii?Q?QP/4K0TO4pN3+zkj2B4MUweucn7nuj7R4LP94cO67Cb02P9XCiPZZqDhZnbn?=
 =?us-ascii?Q?U4p7iiy1ol8LDxLpb9xy9eGbRagXiU9hilDuTHY1lm1jqcrqyvqEJNCbMyaC?=
 =?us-ascii?Q?QOI1nh0HKtsWyBLRoJvCfYr+szOamMBnYA/kJ4ctV+jxM+wr/ZUMcCm5pPjl?=
 =?us-ascii?Q?fO+WJdGSF60aRQ/qxxqMHz58VDsIDw8afQkDJNhGSzjRpeJzceG+c4D5dFIz?=
 =?us-ascii?Q?ZMsG7zZbaLSFsKtv9rllk7UNuenvrPIhUT9BTn4r6i3RijUhmCjTJDzwoKVJ?=
 =?us-ascii?Q?Fu4jHT2d7tYQhPSpp5ViY8+hxa99w8llevy1n5K3xlkQoydhwAgkhFeGspBv?=
 =?us-ascii?Q?iCevJvDOt3Ku8GiC7vwKmf0DIy8+0m+Uw8pyoz1ztov7mdJb6/+Wc8jaNGE3?=
 =?us-ascii?Q?Mq6sfUxxpZHuIrTmzQ5JMBgOO4Fr5eHsB2ue9jfC6707Suiw5szg5IO/DJrH?=
 =?us-ascii?Q?oOiM39cORqsukziQq91OafJ3XKgNbnUh7IYNlSC/P7sdnkrfavBYgmuNyHj0?=
 =?us-ascii?Q?KV/OtKtvrw/f5/sSi0dQOuRhF+mUKCq2kKTWiX3gyaOvcpZNs2CjvWHyml0H?=
 =?us-ascii?Q?YmRQ/wt2hb3fmaH2Fha2epicTlBxoecMRDjy0NxXBpCnvPSQjmtWMsmbqbBJ?=
 =?us-ascii?Q?EoutjswkzaXN7ykTfe5TdBXb88fNxpbx5Kl5askDr1KLG5kLDUHwWf1Sl39V?=
 =?us-ascii?Q?HPYzDfVEsFGB4dBbxxtsbczoT81A1sHoG5MzXr5qX53FegE6a6ZdzzDzgbTu?=
 =?us-ascii?Q?A4WkcFERQQ5Fsk7l+d0tJVDOvQ/Y6BDPpFkpAxMuf/b991EIbctS5hp3mCcf?=
 =?us-ascii?Q?+GqB7pkyDhaLs570JTTqfxQEZ4YcLmXmDwalFoKs4m5h3fL1r5OJS/tfGbbT?=
 =?us-ascii?Q?8hp++RKHgbTu8BU7J2/guNs38nWq6Cf508IVluWh08Q1Vqri+YbYbHLIB0HD?=
 =?us-ascii?Q?2UEyem3sqU5dO1mjhkGHT2Z1TY6Uifd+uRLfFvzkaUU0tCgzfuEynFPS8hyI?=
 =?us-ascii?Q?x8nlAtIcGR0L/ZJDeQltCxoD6hk+AyRZxZuImtoGR+Eo+0CucXnL8PQfd5UN?=
 =?us-ascii?Q?HRrnHfFmphcdWXwarEACdwf75We1kabkCxs/MrBKxBkD5xHDhrRLnL+Pi2ja?=
 =?us-ascii?Q?B2VGgKdkS/CK4QPVFbAkmXj1TafxxLwAg2K27Q5gH0dvVfRoro8IXL8eJa3Q?=
 =?us-ascii?Q?CEl1F3NGRnH7+1UfeTMAXusQ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b63b3d-90c1-4ae9-44f8-08d970d9bb64
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 01:57:50.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxNkjpjonAZtt9JW/1sbMii9Kt45qQUGb1h0tNRt0Bkaj4s65PjxCqurRvGVL+awKjOugzPurO5hiKq1Gz4TtpwFgEwDyR6YlGiIc/Z7ViytSgfFBGFDbHmD08XTzWPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
On Fri, Sep 03, 2021 at 12:08:03PM -0700, Linus Torvalds wrote:
> On Fri, Sep 3, 2021 at 12:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Was there a reason you chose to do it that way instead of having per-node
> > i_mapping pointers?
> 
> You can't have per-node i_mapping pointers without huge coherence issues.
> 
> If you don't care about coherence, that's fine - but that has to be a
> user-space decision (ie "I will just replicate this file").
> 
> You can't just have the kernel decide "I'll map this set of pages on
> this node, and that other ser of pages on that other node", in case
> there's MAP_SHARED things going on.
> 
> Anyway, I think very fundamentally this is one of those things where
> 99.9% of all people don't care, and DO NOT WANT the complexity.
> 
> And the 0.1% that _does_ care really could and should do this in user
> space, because they know they care.
> 
> Asking the kernel to do complex things in critical core functions for
> something that is very very rare and irrelevant to most people, and
> that can and should just be done in user space for the people who care
> is the wrong approach.
> 
> Because the question here really should be "is this truly important,
> and does this need kernel help because user space simply cannot do it
> itself".
> 
> And the answer is a fairly simple "no".
Okay.

Thanks for confirming this.

Thanks
Huang Shijie
