Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65933FE77B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhIBCPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:15:31 -0400
Received: from mail-mw2nam12on2117.outbound.protection.outlook.com ([40.107.244.117]:50253
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235353AbhIBCPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:15:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7+Umktx2oYr8IQePCGmlXhcuXQyPBLxZS1+QiqteZtcZQ2haEO8eAPHxH8qASR9wrHPy9coh1h/Nru/mml1006z6cN5Tnd0xiwKj9dBY//PwJyOTWIhB0dLL4WL9fI0HaNAiwwbijIXM2E2BWv72ev1ZX91jyAZ6GtF7wM5DaMArI9Fy5fVVWs9lsAR5rJlHJrPyxh+J0i11afuxSTYIx+0D53KIZQp1aB0Qa/jgEqXkqcb1Y2iEq1Yf+TIXG5VU7vMaCw3hFxI0Au7IgFQRpkuTSo9VGvS/WbklUPXgwslutesQlyvyfPWqfG2bLbPE6F5h5pwXtW07mviacTUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hLhWUAFhaf0EwHJrcBDi11D3URXDUHruFBSY7oPirRQ=;
 b=HEJyzWzZanM8buXUKopedFNYDzog00WSzmSmKzrRDzOnO9YgVKxLHrJP8sDNlS1n/XvjP01b06YPC8OUwTV3J5HWTb2iDFXNk+61APzZy/MYAyogyugPlTpTZBPWsC8aVU6MC3aGYecYka6698e+FqaKl2edggWdXWqNqeM0pdbAUypIcTv8orybjp59j3C+KpfwczRRQDkp2pKBKoyw4RHjmcKJpt6BfEOt/MO8c0OyNAge32b/8WDjGKVZvo36rbC0RoviDi0SdwgNrPROwSctMPd4/i5EiVZFtM4KrH3uBmtBWKqDcMnTn5wjpOOrlNp5apGK1ZVIPjZXEUZYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLhWUAFhaf0EwHJrcBDi11D3URXDUHruFBSY7oPirRQ=;
 b=ge8ohw3mbPuLIOjki36NdZnLbNUO8mOL2XwlW6XW0HoYE+uNwlwhUDmJk6WBBtr2uTIndAIAWUUduEvUYGjeg0ytQb6LR4DVxqE5M1/8i6ODYoKchZCv7yQw1WVwwGquzsgGUB3wxKRDE+fXepDlG9832eHcwINg3Oseip+IUpY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MW4PR01MB6177.prod.exchangelabs.com (2603:10b6:303:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17; Thu, 2 Sep 2021 02:14:26 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56%3]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 02:14:26 +0000
Date:   Thu, 2 Sep 2021 10:12:54 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YTCjpr5IotYW5naG@hsj>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS8HpUz9FUcFWt0V@zeniv-ca.linux.org.uk>
 <CAHk-=wiwAC8L7UsRsd-sHNS8ZETbrTB0EELvYV1qMOUo86R7kg@mail.gmail.com>
 <CAHk-=wjAPEs3HRGswJ-AE1R048j2MBsBtMfg3GOsaFykHoeKsg@mail.gmail.com>
 <CAGsJ_4yLrGv2izZ2z4QWnBbDOhEjHygHDFBthfFqW0XEkMP-ag@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yLrGv2izZ2z4QWnBbDOhEjHygHDFBthfFqW0XEkMP-ag@mail.gmail.com>
X-ClientProxiedBy: CH2PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:610:4c::33) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
Received: from hsj (180.167.209.74) by CH2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:610:4c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 02:14:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84f2b03-238c-4b71-9c7a-08d96db76362
X-MS-TrafficTypeDiagnostic: MW4PR01MB6177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB6177D23FCC32D8C03F6ED730EDCE9@MW4PR01MB6177.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWyyf56BcnSZ/DkrDJlH5xQvPETctmsjjcoSFXAhVBQncqi4WC7RORJMqRIWRxCSCnR6SvjZT315rab2e5PdwGHgV/O7cu0QyQE2EGBZIB17+mLicaNr0BXc9lt23FJCg9/pjJDysYI8gSp5S3e0nYYs5lBeT3zp5K6fBPnoNxAhK9QFdx6dSMeVTEuDS9f/KbNniy0qgm7EcVK0YwxMbu2TmAXjjCEzDfasZyWm79cseZHY6YXuFMlInh09v1qyL6K5OqcWDvap3h7UPM9649TzE5fzEnuCt5FNAHwmGvTEZ+IKyV+NYL6FfF13CdFADnNFH6ycI+BhOKGTeZIXWB/rC7mZnYxuHuQmCIHPJY5YfqsaAX1fSk2ggwF8CkcGP40mMlvnZqOHWOaASTeGg4g3gRy/JvRbLtFk44QLoHg4DGrjQRdE0+zvp8rKUXqstTdoU42pAGWXOo2bxosdf9l4mJYbZoRyS3EdVX9M3rt/3ScJOyNuq/B1ZZFaBalAdVfk9YSqTtirN4bAfvTECXcAodc0c4z9+k8svH3o88L5eypasJWHWm4Q890UDr/oCFEMATdDXZwXy1wDF7H5Ij9DLzFdcEwBL0Xv31rmg3LHGUjaR2gAFg+E9Et32GI93Bxk/O7CsWVHIvc35fSoFO8Pkj+MHUd8KLm+yLs9MLOjz+d762Akl3veX6wNyWERmYXKTtEeGZzVwA6XZrrv4wdbl+H0XgpmFueGNEO5ZQFBcDkrOWxtK5j4GOM8Zi6UkSr+nytUvFJ7tZxDsz6huZwSQoR2eCIiqVE4PGg2XO151WuZ0FmuuuR0b0OmZS1s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(2906002)(8936002)(956004)(4326008)(6666004)(5660300002)(9686003)(9576002)(107886003)(83380400001)(55016002)(8676002)(54906003)(38350700002)(38100700002)(6916009)(316002)(33716001)(508600001)(966005)(86362001)(66556008)(66476007)(66946007)(26005)(186003)(6496006)(52116002)(15398625002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qo+9bA2AKDVQWBesdTNrflFIxBh1GCdsDcJihCyBVyvCwd3A6oBAGbf0CqVY?=
 =?us-ascii?Q?UgqpQwww/K0/vUKyLNFA/wZhW8Q9JexUfezILMZJFIy5m7SFpVQsEpqSgUSZ?=
 =?us-ascii?Q?rt4l7tV9KaEfJLPuV83wKxDF+aEeUHEBhlwVzQ0IZ7OmqR0J19kaQi0XJu4m?=
 =?us-ascii?Q?2KRwPcWbWHeHOcoN6rh6cBQ947Sn4Ab7WAyRAZX6wFdRCNgtsNlDwsZokOFQ?=
 =?us-ascii?Q?mSeeQBOTGRvTGSnzAFjo54Cy+/VXBWDBWXJAsrihP9X1m70yeHsCGI8VPybC?=
 =?us-ascii?Q?nK+EmyClK+CcHwf7Hy0WawqyR+4xCOMUKNcP33CymPYqJ6Ojz9uPJ95qrPVQ?=
 =?us-ascii?Q?vhFcUtCeDdA3+Nc4xMkdB+LpMxdxjn20JrvYxmQNujoemXIXm7uyXpoYUqWi?=
 =?us-ascii?Q?L4KrBeQcefpOskjt576LrRS4rebHodAG8hw6skHrfrNqko+iAsKoNg+6KS66?=
 =?us-ascii?Q?onuC4V253MB2qfpJiQB55uHODap6KgV1s7aef11t2LTOk3UfYQP9L3C4mSVc?=
 =?us-ascii?Q?cIa25STTCoBbdOW3VS6wmffN7wGSweiXBNHekYDvMLlUITu7qeyi4EqVNiWS?=
 =?us-ascii?Q?/+MID1YktiE9csW7NR4b5D4DjdzGRMe04pUbKcufyPRgfadyp9a7pUJ0sggx?=
 =?us-ascii?Q?xe95/sGPfGHUhlpFj5kU55pptNHCfy6PPvaAo6tjzICbdQ36JD2vG/+ELk3X?=
 =?us-ascii?Q?n84vcaTXMEf5Yg+0pabqp4wxo2WJuUeAZYA3HwKZcsDqwjFOY0vBH7HjnoSJ?=
 =?us-ascii?Q?YETnjDWwU39yQ4DdqW5nKok8a6RO+C616qkHuBHFLYTCv3wzsxqgp0cIZF3n?=
 =?us-ascii?Q?HiRVAEctvJy5g1bREDUK4hdrU9svwjOxkBhsFadyBh8bCSlNLIPXfc1xRHTR?=
 =?us-ascii?Q?OKIgygne3TTcvBMLqFJdxdHExUj4KY7h7FKllEJ+2LlxsoxExqS+iWyBvgd7?=
 =?us-ascii?Q?RfOrdWtbk0VwQAnTE6hlwUdxIbLjZnOHQo/ARqnjMeNQ9fS+7HPpohpd0kZc?=
 =?us-ascii?Q?wJwwaGgtpp89jTynBSwtO6YmNHRVs3gfT9d84fVd/snrS9TeO2dKW7MABdGz?=
 =?us-ascii?Q?qrr8YQSHesoYURLd2FF/Lp7/QyvGMyLtawe3ObgXPrH/LJXsMmDHrRHduONg?=
 =?us-ascii?Q?1Pnxsoo/0n3/eJHwoOVQG2wmcbPUnjr7d9Hb3dIuIHxlhLYjej6n0cXiYB24?=
 =?us-ascii?Q?ziQx+dtX1tvcichwHvDhOLr+/BRNT5vLv108tN+Z38Qj3kpBCcIT96oxvpDm?=
 =?us-ascii?Q?2T3K+/VWDxCwCPFJVd6qt0ycQOdL9z4u3nrHEU1ZvdOkgvASN6TZsAnkdG03?=
 =?us-ascii?Q?kAdZ2TE+qFN7NuPfBsZfMRyP?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84f2b03-238c-4b71-9c7a-08d96db76362
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 02:14:26.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDOI7d6Jq5PB4XPiDEi2b9IrbhIZaZQJ62LMbxjvxE87JjyFSJuB/CMQLvnQVg65JqnGQWTpjRfjqkaanz670IRHKoD5FXNtW2ytyxeDdjjBS6c5xSF7POsCoK7dxsDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 10:56:20AM +1200, Barry Song wrote:
> Not quite sure how it will benefit X86 and ARM64 though it seems concurrent-rt
> has some solution and benchmark data in RedHawk Linux[2].
> 
> [1] http://www.nacad.ufrj.br/online/sgi/007-5646-002/sgi_html/ch05.html
> [2] https://www.concurrent-rt.com/wp-content/uploads/2016/11/kernel-page-replication.pdf
Thanks for sharing this.

Thanks
Huang Shijie
