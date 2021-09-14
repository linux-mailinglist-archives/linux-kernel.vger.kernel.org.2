Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1973340B421
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhINQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:06:40 -0400
Received: from mail-mw2nam12on2126.outbound.protection.outlook.com ([40.107.244.126]:43264
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234998AbhINQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:06:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AreKV5Cj1IWmJpiPo+T71SQOqhKu0r1FpcobgpYvbDER9UCw7Zso4/D6IcOwePZC48PXxK+Q1r9iByO9CMAAFZ80RxoU2hHhXCdbYI4kS/uaweSOcSdlaptqh+8xPPsaQLrfgf3zTyITiDRtvcgoGJQqiNke45xyPGrrbEPf/TRpi7L+wj+ljx4dfoZwCyWIB4n/k6e83cco2jw4nHzOMpB5vLXwxR8k7WYFbnmogifBfH0QHIqe2Ki4+5I6vlyGhgfXP3zwLAgeXWqylhxJzqimP+SlHvTEJY6vp9x5UWEEsu2gDYq3lG1xpgCKE6UM/lSWOXtupbpK9TML8wBzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Bwxw9rTcsDA5gJbls+upFXhfz2ew1DLhB6NR4XrsBls=;
 b=jThjkoo7sKGYa6pRMYHGSjWZlHmdaLMYjsawSoYDJXsH23JDFLCRtgxbVhcrJ45S4Sd3jT+rxxnmnlMPSyUynw0v6OPzY3ZG1kicc5TJ7ZdXytXYZbDeR6BOjqZ+K+gvSZZXCyjhKg3Dz+LcFJWz5VZcNXq7i4EVLfMqvYWOVJcYBYor2/fWWIrrDvNg/sKJiHJqvRgpHnMimevIUeqk0xwI/nLhk7TYAl17jtB2r0V8EzYfF7kdrx3dhaJIcMpPxzUzGmVjvksAsrcofuiFq0MXDbRcpVaY+4mmaSzB0iykyDW5eyLfL+/6JySDU1bsBkiaCf9aChFBy3hd8xao9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwxw9rTcsDA5gJbls+upFXhfz2ew1DLhB6NR4XrsBls=;
 b=LwQeTsV4w+OSrWBSU9mx+gY3uL5e0G28hgfGi9pJfUYmC9Sin0VtBhOp4JTx+YMDfGApDNRbaeqlY+fAR6NLYxBI4z8NHFNp1eTRQ19ACjbZcJJ6VQmXeCr7aRGpeKrB4ZRGqq42ZJNXvpwNunya3w7QFNeyrJ491i9pqqUYMWg=
Authentication-Results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by DM8PR13MB5095.namprd13.prod.outlook.com (2603:10b6:8:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.12; Tue, 14 Sep
 2021 16:05:19 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::b40c:9bd9:dfcd:7ff0]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::b40c:9bd9:dfcd:7ff0%5]) with mapi id 15.20.4500.010; Tue, 14 Sep 2021
 16:05:19 +0000
Date:   Tue, 14 Sep 2021 18:05:12 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: False positive for 'Possible unnecessary KERN_ERR' warning in
 checkpatch
Message-ID: <YUDIOLTCe0/kzVSW@bismarck.dyn.berto.se>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0334.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::19) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
Received: from bismarck.dyn.berto.se (84.172.88.146) by AS9PR06CA0334.eurprd06.prod.outlook.com (2603:10a6:20b:466::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 16:05:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25357c23-6135-43e4-9d36-08d9779972d1
X-MS-TrafficTypeDiagnostic: DM8PR13MB5095:
X-Microsoft-Antispam-PRVS: <DM8PR13MB5095E8E5A58916BC925E8A0EE7DA9@DM8PR13MB5095.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jJi6/0fDHSB9jGVIm/3K3Nk8FQnvLXjJAJ/ThWdt2ItrAlfNG9OUNsf8jb7iLC41gRL2LQt7zuMj8qVa8jQ7h/n/YXcB3u7a6Pajj+InY2zw7940wMrHPWgEjrW4TRyb7IDl9gZIbye21NmTBjKg5f6Sr/J9ec+W+XU8kaDTGtrr9JCrR7cH6tZXLvRArubC9bSgG0IRPI1Blwdbl5HpLixW6Fy+E8Ww1PBSrWfVVSpSzmE9pBvqkpn//7n7m/wDQ2EFtOFPkaT0HgSipSrUJu61oBY9osdboym1lTRygxJ8N+/mXS2DT9WuyQ87F9PnaaXXqRbBBvBpNjY/xjFuDeHU54HhcuI1TsX0m4B6qZ057bnm7MfReKPK7Xro7MLdLYdsipev18XZDxvU3iQhdCiZfcDJIBs1lFooDA6ZLJ4/3bz5zPGzPaZiNkFyHNiJdnVKl6RNVNEDLSrE9aCdZ91POfJzW7bV5vxDjPyoRw9QgbL/ttI4zGm5FPx2EeedMWol41Y7emv1pyCmIdeAk/8Gzl143O6h/3rwhNEKEBNEjJ89ODCLNxnD9gMLoVTSLR0ixbIMEOyAju/GmHffx6erO4AON8HQnRdqqaHv4GcLgqsX5WtP/4GKvbYu4O20JSmiG53iN0al0MceAL82kNOQrKhT5qoAg+rmslvmSIdLI8Tv72rS/i4R/era3rJHWemsUMjcVXC+S1VslV4CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39830400003)(6666004)(55016002)(9686003)(2906002)(8676002)(6916009)(66556008)(86362001)(38100700002)(38350700002)(956004)(316002)(478600001)(66946007)(6506007)(186003)(66476007)(83380400001)(4326008)(26005)(66574015)(7696005)(5660300002)(8936002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1DINHYzL0XuwR/oAluowOxFMkIwhtHhw8+SKXRyYzJvtu8WkjE2DwTAuqd?=
 =?iso-8859-1?Q?kqFjfzOlxEXGZ+7wQbTX/38phux3dgHNzR4AwQYD1KDyZvZHBYFfJIRNqX?=
 =?iso-8859-1?Q?g1YD6m8QQyB1sPIrTFf+a5hmdUORHcWgl7XEaPydtj3OOBOtMfOSGDF8Or?=
 =?iso-8859-1?Q?+f5gsX5vj//cPxaBmAbX1+6v93R3oZK0ylmgORUuF6y7DtYD3t658rsfaJ?=
 =?iso-8859-1?Q?sD/Xn91oQqYQ2pVBG8mJqu3NLsaFwaTBsxK30kqoE4H4R9TqDHKZDnlxPY?=
 =?iso-8859-1?Q?Kb8Yc1ibKF0D0SDWUfwTqkXonI+2PLFIoIj70t0xU2kPO0iDOcgNWavJWA?=
 =?iso-8859-1?Q?RLnd7puZPp/nV2Z2lw0WaQ/k5F4QnbX00X1A7tW0HPIJ14bk7tS3mcSN8Q?=
 =?iso-8859-1?Q?yUnOfz2rJUDAqKvfFl184rsT9fWdVDfb70n8ZYCLAdwT/7wPmfpLV5b8VD?=
 =?iso-8859-1?Q?/GzQ0tDA08fiAZ50juKtjyh/zRZ+NUx/hO7N2zxz3F9Qj6LctmnbaJZ+3Z?=
 =?iso-8859-1?Q?ggzxyg3Y2LWBNO9OHpdSQBbFX8dBdX/frJo6IYEAYA305db4hQWbL1PIR2?=
 =?iso-8859-1?Q?l9CIsGTc2+wwTweLdP9YkAUUUaQITxQwy0nv5MBSslFqA35xZ28gmXN+4T?=
 =?iso-8859-1?Q?OXZVJElpFYlKS84PAMO7g4pDcMJnyYIk5O3lwxjVDbmhcsiKsPeBjED8b9?=
 =?iso-8859-1?Q?MLkGyo/RSraaQxAnFsY4RvC2B3Se5oWXuCKZSdL+hizISE4sR+r6XBQmpy?=
 =?iso-8859-1?Q?Cv/tQpsmKWKnjQlgq17H7qy55ssYg7vGrJsIFC5LpET2L4teQm+fzQo+iW?=
 =?iso-8859-1?Q?mkNfCsIQ8GvB5MUs3dQiqxtWAhz56qT3COfZQO6GJ6UF3lwkkKIkyh70Dr?=
 =?iso-8859-1?Q?bVxnSKP5tSSkkBOW7AtmUtlIfNE0eWnZXF/AJPyXD7oG2VsD4fs8oybVCO?=
 =?iso-8859-1?Q?fqjl4UHKxf4IlqpBA++O1xZX9Zmso4HykF4en75I1d6N1kQosyqPWLdfcV?=
 =?iso-8859-1?Q?P/6yP7IzF9y78bHrAApL6WE0Q+Zc+ffghlFIX6GmUiNCCNBgPnHPW3R2w9?=
 =?iso-8859-1?Q?EeMHxk1VrvqtyxAyLGYj1tncp3vQ/MNe3W1jq4XSlkI6quRrLNXfY+XTwz?=
 =?iso-8859-1?Q?EjX+r1BGRDoQ0ZdJ8FQpsx6TKDZxSMuMUxydWZSl8TI7V00aHwzGQnC8ld?=
 =?iso-8859-1?Q?P+31vXfGLSrF7X1DbwTOgzTLayLyt39Bd4sJCWXFVmMLkV3wY2BrNQLVnl?=
 =?iso-8859-1?Q?DH2xYEDUx/khkXmOgF8B84ptuBTrX9sa9arHjdRoo16uFztYSVUASRS+xd?=
 =?iso-8859-1?Q?GkMLF1ivyWmtTcrqYQ1iCzMmA1Z3vl7ULwkOxNEBKsRJ9pU1rvSPnNSBzU?=
 =?iso-8859-1?Q?KelnsCxZkA?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25357c23-6135-43e4-9d36-08d9779972d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 16:05:19.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irz1quEGf+Mt6n23+0OzvlIs2IFh+LJRMijYuUab9R7j4zZlCm+J4BODgFtVAJGuLVlJ8NcIr7dhmI4y0uNrPhznKZGrNdWC6fYNhqDBZSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Maybe you are already aware of this, but in case you are not.

The issue is the checkpatch check for unnecessary KERN_<LEVEL> for log 
functions. If a single line contains a statement that match a log 
function name from $logFunctions, such as foo_err() and the same line 
contains a KERN_<LEVEL> statement the 'WARNING: Possible unnecessary 
KERN_ERR' is triggered. This is true even if the KERN_<LEVEL> statement 
is not part of the arguments to the foo_err() definition that triggers 
the first part of the check.

This can be demonstrated by,

    ./scripts/checkpatch.pl --mailback --git c821e617896e99b8

Where we get (among others) the warning,

    WARNING: Possible unnecessary KERN_ERR
    #38: FILE: drivers/net/ethernet/netronome/nfp/nfp_net.h:63:
    +#define nn_err(nn, fmt, args...)	nn_pr(nn, KERN_ERR, fmt, ## args)

Looking at the code in checkpatch.pl we have,

our $logFunctions = qr{(?x:
        printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
        (?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
        TP_printk|
        WARN(?:_RATELIMIT|_ONCE|)|
        panic|
        MODULE_[A-Z_]+|
        seq_vprintf|seq_printf|seq_puts
)};

...

# check for logging functions with KERN_<LEVEL>
                if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
                    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
                        my $level = $1;
                        if (WARN("UNNECESSARY_KERN_LEVEL",
                                 "Possible unnecessary $level\n" . $herecurr) &&
                            $fix) {
                                $fixed[$fixlinenr] =~ s/\s*$level\s*//;
                        }
                }

Looking at the line from above that triggers the warning,

	#define nn_err(nn, fmt, args...)   nn_pr(nn, KERN_ERR, fmt, ## args)

We see that the warning is triggers by the regexp but that it matches 
the first part on nn_err( and then the second part of on the second 
argument to nn_pr, KERN_ERR. I believe this to be a false positive.

Unfortunately my Perl skills are not good enough to fix the check to only 
look for KERN_[A-Z]+ inside the argument list to the log function name 
that matches the first part of the regexp.

-- 
Regards,
Niklas Söderlund
