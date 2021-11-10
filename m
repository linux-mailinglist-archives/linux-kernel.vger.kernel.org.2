Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A7744C57E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhKJQ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:58:56 -0500
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:13088
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232040AbhKJQ6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:58:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCH7THyRJm4j1JhTJTZhI9BOW5B60FTKSQjQ4ZxZU0zP/Rr5F48vJoHdjS1a8VNtoJwiTpfLwJH2f3cNUHrFPzw4HzRynDPYUsdEmAG3CS2a4r9t4yoPa5LIGQ5cjoPFqOz1f6dDo+AW4QgyFji2k9nnh6I1ZLwW4ByGaFSh5/zwppUHo00kopGVXF59hIBYAYYh/cCMTDkkUR7mFMIoBvjD8RFcQIK7/yy4tyvB+EVRlacYy/cj6ds3jISkdf6DCVypF9WG+1sNIgIS5BqJRVHQJAk5vzAvVmDDAnWKKzwQnnpGLd6V15wTNedXLLzsUyJbOt71gY6nvrxkw8AqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW3apBa7p+VMp/nd7z2hvRvy36hcQZMqd5tujc42F8s=;
 b=PoZdvKPpiK4MUjpxcALm5hUxKKQdnGDq1z7yxpionLy9HikkmhAoHIQgMBL2TTqvSGbaSwzMWMEA2/Sl1mSzDLoT9rTHAUlpmfROdq+0g4+S93kmb+jyZTMhoChTc0n4INB/X+COzNq/ZueLSr1jj9l9HTW9bVBvTsb8hfkOqZDkj9Vf1+YXxiUtO39stU+b0uBKmEvM531msJFnau3sMAscB7QmTKINbP2cb5mD5uy20G73s98UDc9dLinmYvbAIQjGEtGt3sV6n7QjIWHSlWfA/iq8VWi2/P6mvALksWwIHLU/6Ynl/NP5s2rHXYFo2cFQfkJ1Nbft5+sH8hmEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW3apBa7p+VMp/nd7z2hvRvy36hcQZMqd5tujc42F8s=;
 b=ghq/DzejzqA34ppjQbRyynu8gfYYoMvqRiBJ+URndeWeVvQaZ8+Ss9uM6xO/fuLMOQ/AzlbM69M+RZYstFgLe2S7iHUe0/lZgkZYmFl7ln5CLwYkpLtrVGPvQAiG7Gjvk0J2OuaAmh64YmOGy+ESwJfeb76a1hLYD5laAR9yDK2g2Ki107eWnnlMSqfflTc8c7szXMSOoWrJl0PzKBLLr2LLyD+/IMl4Sm3UKo69eqpxKuN4NHmSmcTTEmIwwDLVGPgC6IOeYMVTty8o3QIOuLzjpWGRsaQOy+7VwpgbL08mOcKCvDfvV0szABNripUVMI1oOweMYE6hP4ykAd3ygw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 16:56:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 16:56:01 +0000
Date:   Wed, 10 Nov 2021 12:56:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
Message-ID: <20211110165600.GZ1740502@nvidia.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
 <20211110143859.GS1740502@nvidia.com>
 <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
 <YYv4Msg7zVLS3KE/@casper.infradead.org>
 <b9ea9c5b-2b7e-a6a9-f1b3-241c0882197c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ea9c5b-2b7e-a6a9-f1b3-241c0882197c@redhat.com>
X-ClientProxiedBy: CH0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:610:cd::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:610:cd::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 16:56:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mkqtE-0086N0-7Q; Wed, 10 Nov 2021 12:56:00 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4db6539-dc13-40cc-2740-08d9a46af9c6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5336D334DBCD7FB059F94EBBC2939@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Shfq2KVza3Z0JRSMBrf/srrvSgIuWS/qY/aHRrHyvPaO1l9/GYDc0tl0ktr5zKxzjbf6tINJo3Cgh7gpPocMiZpDyBPIfSYShAz68y/l34PL0jskQhmHOTRSu0+yNrpVwkRhZEUz1DQFH+nYQ9RDezmJ3qA/gexI2q40YAZXq80QqUyZddQLtOkRytVHXTN2JBOwb1NVfJNOBjzKCpR8WxHJPaQDo2B7YmUf/Hu/RcUZq6SJPHVjSWMkCVM+EcIMa2BAzrtb7HPUvDgvBh89TVZWKaROumLeHs99PlMW3IQ+/ZvOOMnaxsZhbqjtVJCBukjocLgeaVBaDyXoin6pvKtPhJI4vgWyUznqTkWEKrzSz8AMRqI/Ul8RCx4HAqrg6WElJaxBJhmc5mdsgqxzc6KNBZTPFH2rOVsUeICKtzrq7QXELsFdmaBR2Z5/1O7k6y8d0U9jPZPBv9/9Q7dREDNOuXsiQ8w1jzpSilEQMN5dnSvs8WOMNWwI90ZGtPpEn9wwKXkOCF+IBatNvaTXD9TVGXfAZcjV7iAfmOdiT1bfWySyfk8kphmxCydArBsfa9cGNJVn7EJIkliDyRarixGEP75WyDpOm0+02ACFj3UHj0xQVVXJuPVu3IPCmMZGDQpF8Bca4TH6ZZCCXMGyww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(1076003)(66574015)(426003)(9786002)(53546011)(8676002)(54906003)(8936002)(38100700002)(316002)(26005)(508600001)(186003)(2616005)(6916009)(4326008)(9746002)(33656002)(2906002)(66946007)(83380400001)(5660300002)(36756003)(86362001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJADxArENwv0jMf2f1vva8FBtlAX/z5LcQ8vs1a+GEk7Y2IcWzqNq9W3f/3y?=
 =?us-ascii?Q?cHkzC3BfY33sJvuDpC98wwpjIE46lp/Ukc6J8rJrePW3bnNrThjxeTwzspa7?=
 =?us-ascii?Q?9KJhsCgnLXDC0lfszbvQV/FhP/444FNJIGl2ZAhWU7PMf56KEVCjnVurRw3l?=
 =?us-ascii?Q?f5Z1Z1a1m/Vw4fmcuheDDIk9Iaw0UMoBCAifDxe4G75BSp/ytmzhPYWfWmAg?=
 =?us-ascii?Q?Iv8ExxJVLDHUqnVrNjFlE9T+OIgnifZiJBd1Pn02IXxffVWNje9P5VUxgM7r?=
 =?us-ascii?Q?s9yTjCJFmlfhRieI3CFUwbMHlK+pvcj0qEha/UI9ZSlgj6m2EirSCgX69FRK?=
 =?us-ascii?Q?+W0D9e6k9KZma4u2i90EC713JaMaMXvXd7Ws1K5cg/Uhl+Htszb519+JrkbI?=
 =?us-ascii?Q?3y7YBtpIjAnWp9e/+DnaRwH2xhrx19C8tyvqzNBtdUwERjcKLng7zt2D3jGo?=
 =?us-ascii?Q?zKkXaLfPS6k5zi85uYRnWUtNOc9MNc9YtMpBe/6uGk0GdWpvP6KyYHPUxVbt?=
 =?us-ascii?Q?9hkvG+/yXyGGur3BXxGG1GGxTId32JmMaDxeefU/8R81ejANYIErdAPqGtUs?=
 =?us-ascii?Q?w4x6GsVdxsLHWXU/Dpx0gR2T3iqLl01up2HxUfc2bprWEbDjXwy9+Ihn6hPx?=
 =?us-ascii?Q?qsxjwB2M13I71khGDGzx2puYZePD7OzJwU3WhEZo/H+WEIp2MMAthpg+vvNL?=
 =?us-ascii?Q?7ubgVyhNf+wdSAw0or660Iv2/T8lVYJ8yC/3d0t44oM/RmCPXbpadJcMgY4V?=
 =?us-ascii?Q?7cRrKy3Roau58IK7iUwKvv9n0dYAEvR20OMyGkq70jAZhX49qCpJwfVIsuK1?=
 =?us-ascii?Q?oNcEoxx4JU/qih27Yet6Z9t8iX4dBrvI4Qa8qjIReEH/4s7fPM+EHJnMqKsU?=
 =?us-ascii?Q?HrQ7qwOkBlPZU10qOr7A0sOnuHt0ozTCcKg1OvWrNw5Ye3gL0a1+cG9rod8E?=
 =?us-ascii?Q?3ip7tsRUU4thLxv3soZQxfXi+KyF9lUVeXA+hnIhVL9sj7zGnUMiXbMB0CWD?=
 =?us-ascii?Q?35tLfJrnEioeMMFDdPXiaLjmjVKjt3BMmNXJQ7oGjix2UV7O8gPkQ3W6BwpY?=
 =?us-ascii?Q?KD4isx2i/rYY96skmUzwPTblogz4vDyQIcZO/aitEPcVhO4xX4iTOVI0Nybn?=
 =?us-ascii?Q?es0605jQBkg9wFAYK3XRsE6osBXXUhMGulbzUo2ige9AdLKilfHwmWlXymbL?=
 =?us-ascii?Q?lHV0k0Ns30IzTkC8PxPn4a2aUd2i/8mR5opPHXkN9xNxiSUYC8R0Wr1UPPk5?=
 =?us-ascii?Q?cuAdWZc0GCX+yj9l6j+tmjox2+lbQvat14qCq/8W4036sCeBp8PzJYaZ+Z4x?=
 =?us-ascii?Q?lBokQV28RwzRLnuF8FBjr1TcalEn0tba+U9G4mgxk3sCdQIeyhA4f3GELRiz?=
 =?us-ascii?Q?XWufIQOIOKpQwpc9Geq3glrcL3cabfIjmCDvIHCVsHDax7TFhG8w6U7tB9kI?=
 =?us-ascii?Q?tEs1FhpojbYb9sALotOXn3p+MP2uvcxOuXCYkse/ViGS5jbY2FTeRgRZ88zn?=
 =?us-ascii?Q?cQsJHdPJKEQuOK751SrDfPQ/Qn01HkAkXDQZ63y+ky49SPVTUA3+fAkcmItR?=
 =?us-ascii?Q?YgpXN4BSFlLSGv5NLhA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4db6539-dc13-40cc-2740-08d9a46af9c6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 16:56:01.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FAscxE8OwSgamSoWhS5FkssD1MTljDIirihIchFf0P5T3yheRTftU04TOLmxmq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 05:53:57PM +0100, David Hildenbrand wrote:
> On 10.11.21 17:49, Matthew Wilcox wrote:
> > On Wed, Nov 10, 2021 at 04:37:14PM +0100, David Hildenbrand wrote:
> >>> I'd suggest to make this new lock a special rwsem which allows either
> >>> concurrent read access OR concurrent PTL access, but not both. This
> >>
> >> I looked into such a lock recently in similar context and something like
> >> that does not exist yet (and fairness will be challenging). You either
> >> have a single reader or multiple writer. I'd be interested if someone
> >> knows of something like that.
> > 
> > We've talked about having such a lock before for filesystems which want
> > to permit either many direct-IO accesses or many buffered-IO accesses, but
> > want to exclude a mixture of direct-IO and buffered-IO.  The name we came
> > up with for such a lock was the red-blue lock.  Either Team Red has the
> > lock, or Team Blue has the lock (or it's free).  Indicate free with velue
> > zero, Team Red with positive numbers and Team Blue with negative numbers.
> > If we need to indicate an opposing team is waiting for the semaphore,
> > we can use a high bit (1 << 30) to indicate no new team members can
> > acquire the lock.  Not sure whether anybody ever coded it up.
> 
> Interesting, thanks for sharing!
> 
> My excessive google search didn't reveal anything back then (~3 months
> ago) -- only questions on popular coding websites asking essentially for
> the same thing without any helpful replies. But maybe I used the wrong
> keywords (e.g., "multiple reader, multiple writer", I certainly didn't
> search for "red-blue lock", but I do like the name :) ).
> 
> Fairness might still be the biggest issue, but I am certainly no locking
> expert.

Fairness could use the same basic logic as the write prefered to read
in the rwsem.

The atomic implementation would be with atomic_dec_unless_positive()
and atomic_inc_unless_negative(), without fairness it looks
straightfoward.

Jason
