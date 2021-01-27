Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E589305595
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhA0IYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:24:18 -0500
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:63904
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232278AbhA0IVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:21:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikd4bZuUXCu4h55c0E+uhRySzO0N8jKTJoLxRZDjcPIrurOGc8cLocd51RH7Tklx+YnuDult/TkD1MOqyBwB32LZNwWMRkZ1NRFAr0ad9V9Tu6p+eCOeYw7+VwtqnexxIfwc7wgGcNDpsqRBQaOUNXolNBe0BLsOag50d8CJP6lYdujd6uslbO37j78vnItOGFKVEosdsNM99k5gWDdHzfVzUkCSSOHzy77avE9+WsNLH54wEmuk1Lb3Vy9eCC/R7zmobtgACbbyf48uweEr9rh7zcsboeAK3ngYV8SYkRr6YgtQVyJaYizknkDlhJu9dFPQILBZREWQsNws0H1wvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOo+bCiV2vQB9ghymHO/8837c3VYAhqznIHdMl9VO5M=;
 b=AVhfi7rTeoFSqfE0hNai6wrCYW9zzOWvZpP9MNuXZNkgHb2lbRRnILTrG1nvzGHvo8P9FzXtCbjXcR/8ctU+Ur0WAJYQFr7bzWrCd0DmzjE9yozNsmENClq3TdKTg8vxPnErnGhZ2K+nwoVIAMHL6QRSSbm/je7wj12jSGMw6WdXxCa8+J1dVwnLr2RjCEqPao81K78Z+6r/vKRffY8Lepu0GD9jiTGT3du74ElUEqHQScEy3QZEwiPBLwRSdpHNYUhh5mrtvq2lxKPnuRNPIID5s9o1PlxdYSx9VMAzQMFFEoh9VAtmJtdPOBBfthJv7tGW4HuuAmz2vRHv6xCucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOo+bCiV2vQB9ghymHO/8837c3VYAhqznIHdMl9VO5M=;
 b=FffkSSNVt2sJO1JRQcCQNAqnNqSACtmfXli+TlQCMVPb+GEb2GFjbzNBfJrIYiLagP81U8nhicRgYIQlaGvsBDlNJLRY+XjRTfstjhpA6/NSzcQZ5bsOJIoUN70noXyRHwMNpC9ff9RK3be/bG750kLSoYGQfn3YDmumgCxmR8Q=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB1339.namprd11.prod.outlook.com (2603:10b6:3:d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Wed, 27 Jan 2021 08:20:50 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%5]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 08:20:50 +0000
Date:   Wed, 27 Jan 2021 03:20:47 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of
 bitmap
Message-ID: <20210127082046.GF23530@windriver.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-7-paul.gortmaker@windriver.com>
 <YBCLmrCSwBRkTAhT@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBCLmrCSwBRkTAhT@smile.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::37) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 08:20:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8957c78-2789-424f-e865-08d8c29c74a2
X-MS-TrafficTypeDiagnostic: DM5PR11MB1339:
X-Microsoft-Antispam-PRVS: <DM5PR11MB1339870014BF6A6030DF8C5683BB9@DM5PR11MB1339.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bl/31eXHs7frlomtqhOg9EtcQ4Nr6JUwp65ll9Pq01D7uV/+LKTy9LNMhwlFkvArkfHvyb/LxTfyXf5Has/XGdC4/+esDlBxuJiKdzNYw9apisija8TnShupbk5z6QMrGWCQ9XHTbtyR7lSYs31R9IajsbTU4h4tH1j3gZnfwIt4c2M/YPpGBEadgWJ72dBLW3f1zQqCo7ZxkH5Agp6XETsj1O4BuRaijyyEV+tqviTidCRg6PPoTfOEtDOqhwD202WRN7eCRDvVvFBBl2fgtVHC17IgJe5vBAMp3nKiME5GMftOZGyBMYcJNy/6nhYvhLAuIl7umsyO1uz0e2O3JJxj2+KfDjqIk40r6wj/NhhOn5IeRQFneXl1G/rPqWtFUnBHFUSCkj0ef97nSMwRwF3Q9ZCA1J/x2V6VjhVuj1r467XqGvpK9143mi5hJSyPANz30VJqIUObcl7w+tiyZETQXgd7RHngtpyvbVntFFWjWI5bTheFTYSTb2/GPg9XS3QZJlryWxMInJQB22Rpn8zMdSzIFJOpwi7/CtU2VtGk7Qg9oWhGdWZ4NcEAzVqsrqO50qCCMEn7pAq1RJE/IfhDZIDYJ/66VtEqXq6SoQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(366004)(396003)(346002)(478600001)(66556008)(86362001)(7416002)(6916009)(316002)(66476007)(966005)(66946007)(55016002)(8886007)(5660300002)(33656002)(2906002)(52116002)(7696005)(16526019)(36756003)(1076003)(2616005)(4326008)(956004)(186003)(8936002)(26005)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ye+xYa8iCZmBaAeuPOEXn2IlhcHfexLTeFaYK9FRUZ/CiPDdE8CgvXfwtBki?=
 =?us-ascii?Q?Vw5QuLM001ouksPa7wSnqK0uYEefW7e93yPYM60pfmiNfnW4fZStke6Z+7b8?=
 =?us-ascii?Q?5zpMiu1kNWRCiAi+yCAb6g1XAUjn1vDB3azSdEcAzb0sYhmlIeYw/g3kts0m?=
 =?us-ascii?Q?I/So4mAyHUSctbg2ZP3o4meF/M6EKA0daK3cLL5UI+BzmgkMny2foFq4RhYZ?=
 =?us-ascii?Q?9HI+q8y7UjRcOqdpct7of/As/hbsjOubf4/W6i8fORP4lne8TOCxxv2e3Vqg?=
 =?us-ascii?Q?1u5bGwvJ7DdZRdNTJoLU8ZUobZB5NQX7jd4LmfGkk26rGMJFc66qlQoMXTxq?=
 =?us-ascii?Q?EsUoXsIboEtrooogKCtzpjdPNl2GfvXFOFloJon5uGpZ9kJFFSxJDf9VAvBV?=
 =?us-ascii?Q?sh+9nxhJ2E0U9vxvSuwC4e3M/ICAzhRYIc02pwMDTM2gVaw3HaNkYH35GWYb?=
 =?us-ascii?Q?Ar4BkD3St6/EN0cMUFjpeVyWIFGdfpCzJypyl8M8hwZSWVnplmwRbJH3FLyp?=
 =?us-ascii?Q?YtIpZyTVOSvVDJffUjtYGJNO47sgTsQM7yYHYJe0eTrC89oXTWSBc0hQUYGR?=
 =?us-ascii?Q?Mm7wU5iGOSD/nJy0oTQQqTmYxcOWcvIgeGd4AfYMotYQr3NHvla4Zn36QQmJ?=
 =?us-ascii?Q?iW5wMacxZsF69OUL/n5+krXzyPK9XU0MK8sj99sW45nqZavYJAlFEypOLfpC?=
 =?us-ascii?Q?QVf5VgGtHC5CuFRZeaBbYnASb7fUp+RG0L8PfVfiTA4Jl/TYylhxETF004dy?=
 =?us-ascii?Q?FUZsPdlgblX7ixXHjlZ+6EjjdndKGG2w65DDVddTnHqUNjYPemhKS0+wKw+r?=
 =?us-ascii?Q?oNT2Xc8hfJduD0TgXNrPKFe0nf3HUvWzXllbPpk7kGib5bDLVlQrOGzWonhs?=
 =?us-ascii?Q?QBwg6T8G+gqge4TEDyZDvA/zkpKhdy8sbLBlip232NlU3gDFAc70mCGcBZaE?=
 =?us-ascii?Q?J6hQAMoHdf/d6IKggVCx65rmMnMfyKLFqIpg3qzWnKaR0TVsIYvOhrzylY7x?=
 =?us-ascii?Q?rioO4aQm6kFAtMBSyt6Vgq9S/9lkv7SzQ/eJBV1om7U7GEHSqFXSxhb1q6Yh?=
 =?us-ascii?Q?KCKMHA91?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8957c78-2789-424f-e865-08d8c29c74a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 08:20:50.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPp09MEpTlUYUn3h7Hol3olDzDYkuvKvNGiDDBKTpS0Iqggp/Y2QyVM4tP+ewtwQUC7i1c4dQrBAntHabAToIbn7BlDHuNFH3bbTTphTD78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1339
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap] On 26/01/2021 (Tue 23:37) Andy Shevchenko wrote:

> On Tue, Jan 26, 2021 at 12:11:39PM -0500, Paul Gortmaker wrote:
> > While this is done for all bitmaps, the original use case in mind was
> > for CPU masks and cpulist_parse() as described below.
> > 
> > It seems that a common configuration is to use the 1st couple cores for
> > housekeeping tasks.  This tends to leave the remaining ones to form a
> > pool of similarly configured cores to take on the real workload of
> > interest to the user.
> > 
> > So on machine A - with 32 cores, it could be 0-3 for "system" and then
> > 4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
> > setting up the worker pool of CPUs.
> > 
> > But then newer machine B is added, and it has 48 cores, and so while
> > the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.
> > 
> > Multiple deployment becomes easier when we can just simply replace 31
> > and 47 with "N" and let the system substitute in the actual number at
> > boot; a number that it knows better than we do.
> 
> I would accept lower 'n' as well.
> 
> ...
> 
> > -static const char *bitmap_getnum(const char *str, unsigned int *num)
> > +static const char *__bitmap_getnum(const char *str, unsigned int nbits,
> > +				    unsigned int *num)
> >  {
> >  	unsigned long long n;
> >  	unsigned int len;
> >  
> > +	if (str[0] == 'N') {
> > +		*num = nbits - 1;
> > +		return str + 1;
> > +	}
> 
> But locating it here makes possible to enter a priori invalid input, like N for
> start of the region.

Actually, no.  N can be valid input for start of the region - or for any
field in the region.  I was originally thinking like you -- that N
was only valid as the end of the region, but Yury made a compelling
argument that N should be treated exactly as any other number is.

Skip down to where Yury says:
     So, when I do echo N-N > cpuset.cpus, I want it to work as
     if I do echo 15-15 > cpuset.cpus.

  https://lore.kernel.org/lkml/20210126171811.GC23530@windriver.com/

You weren't Cc'd at that point as I'd not added any self-test changes
to the series yet - so you didn't probably see that discussion.

This is why you'll see "N-N:N/N" added as a self-test that works.  It
doesn't make any more sense than using 15-15:15/15 does (vs. "15") but
both are equally valid inputs, in that they don't trigger an error.

Thanks,
Paul.
--

> 
> I think this should be separate helper which is called in places where it makes
> sense.
> 
> >  	len = _parse_integer(str, 10, &n);
> >  	if (!len)
> >  		return ERR_PTR(-EINVAL);
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
