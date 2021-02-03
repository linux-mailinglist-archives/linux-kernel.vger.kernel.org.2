Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84530D1CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhBCCux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:50:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28510 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhBCCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:50:50 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1132cexG007630;
        Tue, 2 Feb 2021 18:49:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZVZhdGTbcY6r9IKoVXjkvRPp4llVXV5ECUVQEwLwWCk=;
 b=YRjVB14rbY+A2vKwCiYXanNGEodROTebwYVj93Rq0Q+0ucwUCZdAb52lXpBJil5KiLZn
 DxfS4i8tpK57HiXUplJRuDjEemoMccFxzHii0qe2LZnY6PBo/GXM/s/Nhav9YEO4AVH4
 DiI3USSgruEFRmDRWnAfEUf20Fd/4miL45w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36fcs5t2gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Feb 2021 18:49:58 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Feb 2021 18:49:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4zPxX0Q4VieUyPjJSqxzkMCcToUT9fzJSJY3Im0JVeip2qovMeOVKLNjnmjiGxZxBA5BBgO0KDD7TVUonELtUMQ/jzEiziXw7uljK1ObB7+L12UkZTJvwh4SyNUY4ZxU2P2v+KLbL+BLppZhtRXa5yxlXIQIfv0DyjSg/94vt6yFyMt0l8qjBdp1i7rbp3CmmbFFCNJAWOEgO7bum+ZNtMK1OIVTUxjLWP7WE8i7UjKCSfQSnYJ5JpJIOc2LQngTLlPIa13X2vYzzHBXpxBQBdH8kzVkz3PNL0Ts6iQxbnRTF5v7X1Q3hxAODxON6Y5ih/EKoKsp0efTDBNddkzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WAXRIr6kjDNrDMEFmgrFfA9DsIuvf6sS/hbPyRKpHM=;
 b=FL4eVAQsAEgfahmXGQGk4iH/8OAXw3G5KnoUkkfU2oHZOfRmGNjxvIlHYGR9gr4i4uwMdoi3I9hSze/l44eDPmZOUxIIHQOmc8YzErEtOGcasjvghNqSjzR3c1RvZ70eI5xxdWLs2XsRdwoNxzC8k7dlNHuBq2etRy2IqvIWX6BiLztAI3bgWIpUFzGW5eIWoMAKRRWxM/bfIpb/w99aSpnVJ1pzLqKTTOW4Wkxl5b9t/C1VwsbkHJCsPbpKYEzzOfLnjsXsTaWVDylXcMCszvnnJsw6SGFuBwsiRdL3mvCzBKo8gTOB5VnT1I6DCW9q9LOTogtQ/DJJPXMLId278g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WAXRIr6kjDNrDMEFmgrFfA9DsIuvf6sS/hbPyRKpHM=;
 b=ZRfB5fAC6jcs9Yz0g6uX9jq3TOFuemRSku5p7Ou2injnF6myhXvEAJF9Jlw+dsUTnuzzZJ6J5hfYvObxllN0quJnTWlvjj2mOdkUvmFC+GnBz8ggPcHmu3iEE/2dlJ9Ed5A9DpGBcP3pxt9Tox3SKtOJe8bic/9hD4in/rmgwks=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2632.namprd15.prod.outlook.com (2603:10b6:a03:152::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 3 Feb
 2021 02:49:56 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 02:49:55 +0000
Date:   Tue, 2 Feb 2021 18:49:51 -0800
From:   Roman Gushchin <guro@fb.com>
To:     "Xing, Zhengjun" <zhengjun.xing@intel.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>
Subject: Re: [LKP] Re: [mm] 10befea91b: hackbench.throughput -62.4% regression
Message-ID: <20210203024951.GA1837780@carbon.DHCP.thefacebook.com>
References: <20210114025151.GA22932@xsang-OptiPlex-9020>
 <20210114031839.GA415540@carbon.dhcp.thefacebook.com>
 <59b6fda7-509a-0afb-112d-46c1e73c589b@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <59b6fda7-509a-0afb-112d-46c1e73c589b@intel.com>
X-Originating-IP: [2620:10d:c090:400::5:65c1]
X-ClientProxiedBy: CO2PR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:104:3::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:65c1) by CO2PR06CA0059.namprd06.prod.outlook.com (2603:10b6:104:3::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 02:49:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 859b53a7-42ec-4b40-6ed2-08d8c7ee6365
X-MS-TrafficTypeDiagnostic: BYAPR15MB2632:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26328ADA53CC590504EACC8BBEB49@BYAPR15MB2632.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTsDSI/1jvKFh/TRML52bu4FvXY/FRdX3DFpFz9FENxIav6rZHhkQeXvh234mQy7hufjQfw/gBEtdqqmp4XS9aQU3XVDrnbT08oMdUCMU9eyyC9bWVtyscV9IIDE4gTcjhMWDAAn4kPYG12V2zOX4L3QI1z6bg5Py+zP8DClGtnDG0ph57WcaHOzsHKRXMeC4m6INmsmrhE/zRiEwFWQ7bXdbSa0MdlFWJRCKmYmKdGHR2ApplLlQnqobNswZ+VDk47RTh3CKYoNRt83n/5vdeuMPKiapaFvNZUhxizUbgr1iZvtsfWIvjIbJCpwLnINy9GSW3RKIB9kaE6XvwDtf9y2pZXFbgpqG765FFD2m+uFpqsJ90i66S1vpYQ+vQC6Tezqff4BcIztoeP5dr3qjCgJi/v3WcANDiKAk7BZjRDDL++2GM5vI93DkXKPeKdkzRPFar7jE46E7N3upM/L3un6llcJqXgP8ZXHqKoJTwEpnaTApDq8H7Ebp4a9Rlu7YNCyGfDHNBRh6T3hdgxJXEEBh4gvqcnlAQnvGhO8ra8xN8xoI0V6Qmvlm0HRVQh/+DIEgv4yJa2XmKVUOPwDpJGFL83mNCDpSVKg9u6LsYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(396003)(376002)(366004)(53546011)(4326008)(33656002)(7416002)(5660300002)(52116002)(966005)(478600001)(186003)(1076003)(16526019)(6916009)(66476007)(7696005)(55016002)(6666004)(8676002)(66946007)(66556008)(316002)(83380400001)(9686003)(86362001)(4744005)(6506007)(54906003)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?ISvqJBV3KKMyh3I6eBpaqdl8+DK2YgmytdmyGjyspJo8wlDfgIISE7xB3N?=
 =?iso-8859-1?Q?zzLYonFxsu8SAgF/71XL42zTLdjdpAaV+E5F3X+hMejWelINjDFo02uoxr?=
 =?iso-8859-1?Q?9tqnmUkf6JUKsCZ9xx0BLexm8Z04y7gIsAT/xSt30GmqwYQBUolUhNxCzV?=
 =?iso-8859-1?Q?W6NHSrT2nP7XnAzGIk1zwh1kykX4Vofx8PSIeG7wF/NEk6rtBVeKp5TY5k?=
 =?iso-8859-1?Q?k1i4lY5JPwX7FXVErS1lol36PQOV3zRGv33ZxNbcUYSWY/x01U5dg5l05/?=
 =?iso-8859-1?Q?33pGOiGUdxMcFcT24bNjIiYehe9jKrt+9Ow0hXadAqn3C6olbJwTMAvafa?=
 =?iso-8859-1?Q?LkuxmrBwNlCFuUOAPsR0JoJhxATqrnOgd3O4D/FEWYctY6cwy1/e3pBKmi?=
 =?iso-8859-1?Q?dbdgOtDXaygjK608vXGwy9Th/6HvvT8NauPm3rcigWvhng6k39mkKTEu+k?=
 =?iso-8859-1?Q?qgqDuwS6aJp3ToNjkuP3F0omgGIELwaOl7l0IOy9tFofr5JBuGg34F6THY?=
 =?iso-8859-1?Q?hytjvRWm0tDMwSS+2pnJON4E11U4nDsmDV3ul7uZFhHo9+QKCpnszplxd3?=
 =?iso-8859-1?Q?huxXrz/8U3PggBzQHHmTTmGE7BvrwiAhfcMRk1j6gFhGT9EsED2acBf8/u?=
 =?iso-8859-1?Q?Y8x2/3JS00w5izWZSIBCtfvLK0Y4cO/V9yzpgAl5yKkUxVPHOndMwU0pUA?=
 =?iso-8859-1?Q?O7r00g+QYr1HCznH7eGThde+liKvj/r7Hltc0O1/juTNcNeBFw9d/VDnnw?=
 =?iso-8859-1?Q?NND6MMagdKpptUHncXbsKHwDx/83JpiAxPaO+X3b6Emqt/it0vxCjSC/9G?=
 =?iso-8859-1?Q?oERW3MeyAl9QQc3mpFh1kQkcuZYzU15wjo/ujE2uQWGYv3xdw3PPIwuDVd?=
 =?iso-8859-1?Q?9+EfLPXKHFXX6FRatc+lwoEZi9l5eWOTQonFL71pFK9V1OHCa5zHsvZzDt?=
 =?iso-8859-1?Q?xK03wVVgb/4/GbD7KXkPugDxXlUHiq52dllH1UnFF1e3hDMZK5RC3U0aHZ?=
 =?iso-8859-1?Q?1RDhUH4ur2Y06qRVN+h2/Go3s+isGOwuf4TkVgn5SmxmvNTtX2Bq0KPvuw?=
 =?iso-8859-1?Q?b308T/1BjTgm7kv04yQ/tCUWq0qQGLoaVfRcZr2sf5pOlvF3fsqxmL8wth?=
 =?iso-8859-1?Q?ckXErB0B/PMu2ZXEqPJ9oQ7NJOCyU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 859b53a7-42ec-4b40-6ed2-08d8c7ee6365
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 02:49:55.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS98v7F212FcBMus2kxlFn/3vMDSFieS5elliECnDitK1aHi+iRU6QLoOMV67Exc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2632
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=803 suspectscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 04:18:27PM +0800, Xing, Zhengjun wrote:
> 
> 
> On 1/14/2021 11:18 AM, Roman Gushchin wrote:
> > On Thu, Jan 14, 2021 at 10:51:51AM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -62.4% regression of hackbench.throughput due to commit:
> > Hi!
> > 
> > Commit "mm: memcg/slab: optimize objcg stock draining" (currently only in the mm tree,
> > so no stable hash) should improve the hackbench regression.
> The commit has been merged into Linux mainline :
>  3de7d4f25a7438f09fef4e71ef111f1805cd8e7c ("mm: memcg/slab: optimize objcg
> stock draining")
> I test the regression still existed.

Hm, so in your setup it's about the same with and without this commit?

It's strange because I've received a letter stating a 45.2% improvement recently:
https://lkml.org/lkml/2021/1/27/83

Thanks!
