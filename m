Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F1310214
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhBEBGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:06:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232591AbhBEBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:05:59 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11513JHo011826;
        Thu, 4 Feb 2021 17:05:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/nDmz4m+k7DWVi57e6phZzWvl1nuR/D1lVyayNPRQys=;
 b=iRDaRgwtLGfF7oVe8O13qUOsFB0TEO2XMjCPNmUM4IA1UQhQqP/6n+NDgpXUhXaczyLC
 iFJv9G1W7qAqT17PROteNaITsrT5uHk1/MNrvfGncYovsS5+Lv+dkQHLxddJiOc6h2D3
 fbwaNGQX4stB7wWvHaz9n8iO9T675L1n6oY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36f3ej9upa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Feb 2021 17:05:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 17:05:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHLEEXIIdVSbEFV7JXl4BY4Ob0tZfqvC5exwifAvydL9x05EdNaItO9Tw3g5qThFfJFdFoYn+Kf238yAQ/rQqCo6QbcESMlfrqwieieNdppQB/Pqk8gNe3tqwg/oFS6d7bwst7+Ng/F89UGnicYlxkSyUkcTUPttwhS6V8aIuhiaLplpTlrJWZydRKBImIpTtL58T99atfqam1u5jDvf/R9xoRxNkeoFB5PR2GnK5PAsMr4UF/dA00lDoRSHRhDk0Qrw8aIx9Mjmp6V0vyDwWY8iyplxKDPhTo3t21sX/u7bIwbLh151yScAxS5moeQwsQl9lTnE693XTLsl99gblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp6mdsTJOPVzD0oSjGKdHjYAme2teb7EjL2GA9d4MXA=;
 b=kRSRFPWmJ6wHGcSwt+Zyg84BJsBPQMufY22CBZHwW3HtQmQYu0jSZxT96GbjT7KKpo9D4mCN3GKZTvPtHukweJyO9xgmB98nNO9X1rU89sYxCd34wMoejaU0FsLl8wkaMk4ouU93Ww1U5MvdQ1OlzazlNXZ+c0+iBeMxfOHTjWm5by0FtjIGVl16SSTu67Y8cXhxVAllGRhVvEUxUJzPWGnHQuRxZH0IG4cRhlH3Q1pNvcBYCstS1iMCfb+pV8o46QIjoF5bdvfaUnjy23lKBQI6zHlhsIL5szm6Q1SXLwr2Gzt450v4lWcxCDKDo6C/imOxvq7nO5Dxr6fluu/0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp6mdsTJOPVzD0oSjGKdHjYAme2teb7EjL2GA9d4MXA=;
 b=TmRVpX6jynWKaBPE5AZB2lGzSsSpoqs4S64ESCms/yyOcvjn4+LmWmZ1pEAqx8d9s7Kl3+atEPgwzED7JtRlkoQNvHufBuUnxY/SLr5FQKd5pgFVTxGmjIDbqHUYKo3f0vQh5YV99OEzBV+nPs7N8nxkaWDqAyUmvJu+5NvUBg4=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2392.namprd15.prod.outlook.com (2603:10b6:a02:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 5 Feb
 2021 01:05:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Fri, 5 Feb 2021
 01:05:03 +0000
Date:   Thu, 4 Feb 2021 17:04:57 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>
Subject: Re: [LKP] Re: [mm] 10befea91b: hackbench.throughput -62.4% regression
Message-ID: <20210205010457.GB2053809@carbon.dhcp.thefacebook.com>
References: <20210114025151.GA22932@xsang-OptiPlex-9020>
 <20210114031839.GA415540@carbon.dhcp.thefacebook.com>
 <59b6fda7-509a-0afb-112d-46c1e73c589b@intel.com>
 <20210203024951.GA1837780@carbon.DHCP.thefacebook.com>
 <8ce56447-b416-4750-eeb3-0d5bb92e007d@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8ce56447-b416-4750-eeb3-0d5bb92e007d@linux.intel.com>
X-Originating-IP: [2620:10d:c090:400::5:b62b]
X-ClientProxiedBy: MWHPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:300:4b::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b62b) by MWHPR02CA0014.namprd02.prod.outlook.com (2603:10b6:300:4b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Fri, 5 Feb 2021 01:05:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d49454-796a-4d23-08fa-08d8c9721157
X-MS-TrafficTypeDiagnostic: BYAPR15MB2392:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2392B615B4E7AED34A1C6A1FBEB29@BYAPR15MB2392.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0o9B+j/bj6t3Qemxg2QSVZOIAJSjKuZZ/HIW5n38Sf/zrObp8JDDUQAXw6++rYJmwc+h8N8r8H1dibxV9f2cdeXxv0eIYOmDjd+7nFopNcUYMLGsZ7LEt1Ko5ndXxV0DcuHcDDkTSESzi8Z8p3d88YMzPYuahrpO/VddZOOT+8ACmLEnkGJzwBVenLHGhg7WSH2tExDGYKaKPySAwD0OzR/7aOwsLd3tCCIJgtweJj7dPzN6WtJWqL/epoVEoKEKaO+GK6Tb/ggw0olSS7a8cvK86vlXmdNit75QBRHcAaF7a36amyOY9klWjJqtQHgjQanfWo8umbAwuxwHyVpILsdRXxRDe56QS7VVDT55ZTStdmeKW4PizQxUN5+ahsMcum6m5HJ/pcjDleGe0vqLpEpUL2IB+wh4NfHdUpSklZVD5txAT5xSFWecB3J5wJyrDK67Gmct03zcARvqsAiqJi6jBtG/+UyuOWe2rG+snCwCtjsPqLBlX2cejQLY1gp7+/EiNQZgOipQ3YxX2ZMKN6Vq7bAzRCeVD6pOB99edjNlxzKDxvNhc9ea63ly0uQ5apYF3VvpHyp3UabOW4CJ2ItLOgC9On3Ov4xBffoatJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(86362001)(2906002)(966005)(8676002)(1076003)(6666004)(16526019)(7696005)(52116002)(5660300002)(66476007)(66946007)(66556008)(186003)(55016002)(9686003)(54906003)(316002)(53546011)(33656002)(6916009)(6506007)(8936002)(4326008)(83380400001)(478600001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?7BzgGfIOGRnK6HbjvfuDqMWf6OK7ZHPaE7+dzDEXj86yCQWx01xLn/SiCi?=
 =?iso-8859-1?Q?ZBajn2N9VJR4q3ua6oYQMb6Ckm6lesg2QP2zQk2OTJ+Mcj6NY+bgYyvZED?=
 =?iso-8859-1?Q?0ElRf5vUtb40PxAVdfKDEzKZJ5fiBVZoKVkdKKgvvggdxS0agu+AiJKvbo?=
 =?iso-8859-1?Q?Fut5DgBhix8o4QU8m//2yyL3WG+t3VXiMW0GWNYmMmt2KfjmfaH7ASdjmY?=
 =?iso-8859-1?Q?8EtyrtHjg70QPkoQx+06f7I2jFXAx3J0HB/BDWE5j66A3jpugThXoCeX7e?=
 =?iso-8859-1?Q?oU7kIiYN5SiT3fQbSmU2TYLmD1nw0eCNqs1EAfguk7tB8JHLPy56r/lrYL?=
 =?iso-8859-1?Q?iHyRmC19d2mBUoyrkuZ/H5K59NfR7Jqv5cjN2zf4uPTED+ToIZeCa1HYLC?=
 =?iso-8859-1?Q?Lju2oTquw5vSK1IXaocmh+YWoTSqyiIRAuwBF4mRceXzoALtv0tX/a+2KM?=
 =?iso-8859-1?Q?zqhg/zd+R9AprpRtcvEXgh8xu/jgHEu48hS1ElPBIWfTvU8VGl7w1Fgsuf?=
 =?iso-8859-1?Q?tv3Z02iYPXTJI1iNQnHK0y5rd4WgygYkjlLosNUSZzAJsGLtaX7K9Ay/rm?=
 =?iso-8859-1?Q?zSyzGRdqUXbXASZLtSOlhSetYY6OsW/c9W4GtoUni5HU7/BYs/6LsfepYE?=
 =?iso-8859-1?Q?RaRA0SQD6PUjQYcZvNUq0HEFICui4PBlhbH3bjnkiqlAAThz2yJTteO6pk?=
 =?iso-8859-1?Q?mo4+werXH56b5/5wXLvFNITXbxzKMULhnpnU0XD4LTceRmpwo1RWp5NqvN?=
 =?iso-8859-1?Q?YcdCu+wV7frJC7xHeS6RKVGDoA5VXcBlcHsThQVmO4X8mqPjPdDh91bR3q?=
 =?iso-8859-1?Q?XTIvrB1bIQNBSWW+xgx9ALO7ajihhaxkxKPGLeueS208I3ewLz1ik03bdt?=
 =?iso-8859-1?Q?23t3VJHpaklQWXnZMYw9GpS2IIPMGqmJQOSDE0XQGWaWPxMTPIrowSV61G?=
 =?iso-8859-1?Q?3oAPobvJ2SHwaaZ3OF4nxrW4blKBo7vuYWgqbzFXYUHXx0dalEtinehQbQ?=
 =?iso-8859-1?Q?DC7w3CXzcCY/SHJOvcqIUcloxxl/E06Fs0rBlZTVe6vDJOo+PFG9O0YEAF?=
 =?iso-8859-1?Q?T49gFP4z3GOwxD7XBrjCW3sePZq63w7sYnkaBOZuHdRh8BUy5grGThdHTm?=
 =?iso-8859-1?Q?xL5bnLteDLyBXJkgFzymL3M9/sP6SeetgpT7RcEI7YnWKyYWmuJwbDVzxl?=
 =?iso-8859-1?Q?Tzszo4+pGriAOckR2WPFa5CKZP4sZ5fqOYNkZUT5EnlA/Sx9p9UjsTzV8/?=
 =?iso-8859-1?Q?kwkdoLUDhz0VdaLxzbBqzDG5HDDjZF6LusxkH817EA/XW/cPNZKkEDoJ3/?=
 =?iso-8859-1?Q?tiLwqY/i2p8PZQQI2NQE/Sb5QQLLDfjB+Nnn8LuyAo0yaqWl2Vbig9W75O?=
 =?iso-8859-1?Q?X49EIXc+rIEfUtM1a/hf8h6e/QzqmV1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d49454-796a-4d23-08fa-08d8c9721157
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 01:05:03.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3WW4naVyiAHDpBTPfGrR9di9zvR/NeRBmsQ8Wzb3KczpkNxRlbG98dDBozTOioh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2392
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 mlxlogscore=846
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 01:19:47PM +0800, Xing Zhengjun wrote:
> 
> 
> On 2/3/2021 10:49 AM, Roman Gushchin wrote:
> > On Tue, Feb 02, 2021 at 04:18:27PM +0800, Xing, Zhengjun wrote:
> > > On 1/14/2021 11:18 AM, Roman Gushchin wrote:
> > > > On Thu, Jan 14, 2021 at 10:51:51AM +0800, kernel test robot wrote:
> > > > > Greeting,
> > > > > 
> > > > > FYI, we noticed a -62.4% regression of hackbench.throughput due to commit:
> > > > Hi!
> > > > 
> > > > Commit "mm: memcg/slab: optimize objcg stock draining" (currently only in the mm tree,
> > > > so no stable hash) should improve the hackbench regression.
> > > The commit has been merged into Linux mainline :
> > >   3de7d4f25a7438f09fef4e71ef111f1805cd8e7c ("mm: memcg/slab: optimize objcg
> > > stock draining")
> > > I test the regression still existed.
> > Hm, so in your setup it's about the same with and without this commit?
> > 
> > It's strange because I've received a letter stating a 45.2% improvement recently:
> > https://lkml.org/lkml/2021/1/27/83
> 
> They are different test cases, 45.2% improvement test case run in "thread" mode, -62.4% regression test case run in "process" mode.

Thank you for the clarification!

> From 286e04b8ed7a0427 to 3de7d4f25a7438f09fef4e71ef1 there are two regressions for process mode :
> 1) 286e04b8ed7a0427 to 10befea91b61c4e2c2d1df06a2e  (-62.4% regression)
> 2) 10befea91b61c4e2c2d1df06a2e to d3921cb8be29ce5668c64e23ffd (-22.3% regression)
> 
> 3de7d4f25a7438f09fef4e71ef111f1805cd8e7c only fix the regression 2) , so the value of "hackbench.throughput" for 3de7d4f25a7438f09fef4e71ef1(71824) and 10befea91b61c4e2c2d1df06a2e (72220) is very closed.

Ok, it seems that 1) is caused by switching to per-object accounting/stats of slab memory.
I don't now anything about 2). There are 38326 commits in between. Do you know which commits
are causing it?
I believe that 3de7d4f25a74 partially fixes regression 1).

I'll take a look what we can do here.

Some regression could be unavoidable: we're doing more precise accounting, but it requires
more work. As a compensation we're getting major benefits like saving over 40% of
the slab memory and having less fragmentation.

But hopefully we can make it smaller.

Thanks!
