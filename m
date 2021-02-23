Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906A3228F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhBWKlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:41:37 -0500
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com ([40.107.237.52]:39105
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230142AbhBWKla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:41:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQLKROJCoPwCuIi5iV0Dc74Sr3NBbpDnCTsHwzjebNR5QJGTLW39JH4PNcj+Duu4lK31vBlDFi1BN39+DF0zLIckAISN1DeYqeorkMljgPqvzvunnoAJzfVY6NvoPtuIqTD5xSuaNAmcowBBvD/19W+clHW36P/rSF4EHX+WdKHNdIiEt109CLOnHEwWK5GhTO/30G7SrLbG9MaJPwOWBsI785Y494Nva2k9TK5vlZaGfRFqy8vARICCw5xKUn8eb7RsxzsYDZZPc1KUNIndgDVXSATOqILy+Hh/ZYwxZDGzfH3J/pc3RmRIcF08rgamMhhXQU1hnVVkPtMbCmDvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6pioiChJ2+2NnRAGPEMpg0nw0ocy9JCTlHiy1gqnD4=;
 b=bLpiPV7I7ZPNHflmH/lRxSksYFT3C4OFziQwGsnICahzZ+CmJDBPG0YD/tHntn3OmKS1m8IVyZizpo7dF1JsCXYmPPOzPUqB3iWH/gBJtlrIe3ZrSDLcE7TwItNqgH0QACh+k8dL8WtOn+e4rHw/ORYkmGmhjziSVk4I0lo8dQ29siQYRNFykiPNDVKXFTFL7aAsKUP6d90/9tjX/o2DsCG6UM8VPCNT33RrCSoyfvOSJFOQN+/xqlcl3KlTqRI/sLIwWZUB6naPRbGlM0LwkgKUaXo9qukTbbuswP64THyp/kjd1l43iCPlJryqywVmvlzUnykvhWS1VORwSv+pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6pioiChJ2+2NnRAGPEMpg0nw0ocy9JCTlHiy1gqnD4=;
 b=lqRioydN15JdvWS8QxU+FKBGNn5SAL2p1j8XAUJB7RFurmqvO4+O7MFs2EX0SPM16urv22C3qjsLGcg7fInUTcORzwwRelKidOCXbdW1a9x5/af/Dg9TR7WZ+r+HjjTtNH5J1zefWIPxs4ukFvSb/ZzEAIQvrcBjjbs7JufHrJs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16) by BN3PR03MB2306.namprd03.prod.outlook.com
 (2a01:111:e400:7bbb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Tue, 23 Feb
 2021 10:40:40 +0000
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56]) by BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56%4]) with mapi id 15.20.3846.044; Tue, 23 Feb 2021
 10:40:40 +0000
Date:   Tue, 23 Feb 2021 18:40:26 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210223184026.22c86356@xhacker.debian>
In-Reply-To: <CAHUa44E-_czjhRxr2JjggYu0sDCsRvOA3Uc=hqp7j5Cmtb9q0w@mail.gmail.com>
References: <20210210144409.36ecdaed@xhacker.debian>
        <CAHUa44E-_czjhRxr2JjggYu0sDCsRvOA3Uc=hqp7j5Cmtb9q0w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:a03:54::49) To BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0072.namprd02.prod.outlook.com (2603:10b6:a03:54::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 10:40:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0270645-8974-4ea4-2152-08d8d7e776e9
X-MS-TrafficTypeDiagnostic: BN3PR03MB2306:
X-Microsoft-Antispam-PRVS: <BN3PR03MB2306B9AC2B1E60A01700CC9DED809@BN3PR03MB2306.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lTjqCDelkeUlkGQeD15SiVZZQtVneFpwXDDa7HZSqW9xXKQHE08zO4IGF8OsPl51/G8D8icX8zyv28fNfnW/2TPdEoCfLCA/L6UrNg5y3U9ulXCvfUlsD9fBhK7CTo+bzC+IcuWh+UHrzV4LZw+dBH3IYv0Adxe/fxVNvXI+mVzxDBzVjLAnxsADVcnQcdAd3ctuRcD953t7l3rfjWhWDrYlvHZ6y8x/BEy0FbYKIDE9IMyzdrzcYkz21kxLYtfT5VOFSUY1kbGio86YKLQqjNYiK4wO5aCcRKlUaJsVXwYpNaMNQ5rpj+bduZT4fJiTFb8Bk3on4SWIyjyPZszmwQFx48PxJf/+s4ExaETsFIwQv2ndOsdHOW/5TvMLlYwIIVDZEdwSuwH5zqe2/m2utBDDW2v7ZFQn7ZPrfSwopVvlMUqyQDKiEUCA/aGRw4yonPfHiai1OtFYb0Nkg0ZTYuJkjHoKFPeF9cQh4Q7UIiXnEq9/krCjTSa/6kaVWFWhQWSpLPlqwvqoX7IV5qKvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR03MB2307.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(66476007)(478600001)(83380400001)(316002)(16526019)(52116002)(4326008)(26005)(6666004)(186003)(9686003)(6916009)(66946007)(66556008)(8936002)(956004)(2906002)(7696005)(55016002)(86362001)(1076003)(8676002)(53546011)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fUz3SlmIkdzl5h2jT+IY3pfrrL8CmWuQTLkrrorb5y7qn1SPq+NQ9Nx/Y9r2?=
 =?us-ascii?Q?rDc2ml5b3b/r4jVuJkF8eDt7AnluSO87Box/pSHh3DyN8/rvF5aikoCDZGn5?=
 =?us-ascii?Q?2SbrxuDGZMUcxrlf8j+l29xlQ8QDzBJtWRnZ6jXtsmuAgODoxhhrakGwGOGD?=
 =?us-ascii?Q?EaQDgCytTDk1jy9O+ySr4LHw8k3A9DN+vlVVzPw4P4OqyIy9gKkzzeoG7PZ3?=
 =?us-ascii?Q?wh+LRxUZrKQiCfqJAq2lS2VPG2xzzCkZgRAJb4oeDuLXKK2/TUw1pU7b+ITz?=
 =?us-ascii?Q?5WTpHyYiuHDfuq8+rFB8OJIbobQ3MVrqPxRACN9jbY26D/PNzlIgbXQtWAto?=
 =?us-ascii?Q?kykEdqF0IwOYSX1o62cm10IZKKXw0BBHgp0MQPghVf+bNmGvb6832k9fwMyF?=
 =?us-ascii?Q?/lB1Y4k1fp15XnamzDkd28JrwUlSs5NtFX1QfGWRI8CrqG6mUZomAyGHeX22?=
 =?us-ascii?Q?EpSiBwmX8x/6nHMfs4sedjuWDQl+SuWtJvCo7z949UpgbPexVyh9RqDvV15u?=
 =?us-ascii?Q?RElSUiPZJCxTJABIqBsg4d0PdHGg37xFh8J9sqlM/DYwAzDx8/Tjl8Iw5Xxg?=
 =?us-ascii?Q?PcLF3rW5D7dKxFatCkf+wAXI/TuZEbsNlqcb6jjOyyF0KWvfO6QcwE9PGrkQ?=
 =?us-ascii?Q?i0G6ChvNzGU1aqhVAhO1X3Z//YNpqv+SFqNuDJMSqydNTlIm1YE2PRH0WMrE?=
 =?us-ascii?Q?Um1WaeJ9/4rx9SLTfqN4mmC5ovKTNxYDkJOqne+tv6U6xdJeM8ErziwT8JyF?=
 =?us-ascii?Q?Ztw8WZT5SCLv7kT0rZlyfY05CMFxrg4oaYohYGGmseCuYJIjNj3Zjx2m/Mv3?=
 =?us-ascii?Q?ivHFiEkGEFKNcxCg3VdZVWC0pB7Cb6CzErZlxXFmnwRD/fFDB+7vzEmdwr+x?=
 =?us-ascii?Q?Bv6fGORt/yuAKy9E7CmuF9mXoK5N32nr+frXEjzLUeFLxDt13ziEFtQhEGKe?=
 =?us-ascii?Q?qa38wVP9J2DbIUycQUw6jXhDLHkTr1kG53+XnnoV6dxzCk1DQ3DSADkr4IhQ?=
 =?us-ascii?Q?lV9sXMDo0OdJl/Mzr141uBNdu9DYNbPFGHbpjtnyHnQ6dIV6OIvQD5jcHM03?=
 =?us-ascii?Q?QZTE7ZN7QMm2c1ruf3dPz2uTczdffxzTVXX69at8Kl6kGSEVl1rPYrc6iwEE?=
 =?us-ascii?Q?ey1gbLyrySBKk0gSyQndFj/dZY8IKu9neLnyYz/cvWRjXPKCZzhS6LivLFcI?=
 =?us-ascii?Q?zqCWOpEsqRbWgGhvXQdgBy29JjWTP/vHPQ6lSBLVsPwFUBV/1FMEArzJfGy9?=
 =?us-ascii?Q?Vm8fKYDsCRzotcG+JkuD2y/lb6bJvkJs0qWQ5WJnVrREC9fs8ZLbAjtN1uhE?=
 =?us-ascii?Q?ogrImjD+6hZ1WbcHwFQ+5Gaa?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0270645-8974-4ea4-2152-08d8d7e776e9
X-MS-Exchange-CrossTenant-AuthSource: BN3PR03MB2307.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 10:40:40.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUgcMcnho9FfqJcOq8/xTDDZQbwqrmAHCRDCf79ZdA1DcN51EvJCPYoOOKFrDtZ2MNYh7TU6JZ524EZid5w8/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2306
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 08:59:22 +0100 Jens Wiklander wrote:


> 
> Hi Jisheng,

Hi Jens,

> 
> On Wed, Feb 10, 2021 at 7:44 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > Add tracepoints to retrieve information about the invoke_fn. This would
> > help to measure how many invoke_fn are triggered and how long it takes
> > to complete one invoke_fn call.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >
> > Since v1:
> >  - add BUILD_BUG_ON() macro usage to make sure that the size of what is being
> >    copied, is not smaller than the amount being copied. Thank Steve.
> >  - move optee_trace.h to keep include headers sorted
> >
> >  drivers/tee/optee/call.c        |  4 ++
> >  drivers/tee/optee/optee_trace.h | 67 +++++++++++++++++++++++++++++++++
> >  2 files changed, 71 insertions(+)
> >  create mode 100644 drivers/tee/optee/optee_trace.h
> >
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 780d7c4fd756..0da6fe50f1af 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/uaccess.h>
> >  #include "optee_private.h"
> >  #include "optee_smc.h"
> > +#define CREATE_TRACE_POINTS
> > +#include "optee_trace.h"
> >
> >  struct optee_call_waiter {
> >         struct list_head list_node;
> > @@ -138,9 +140,11 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
> >         while (true) {
> >                 struct arm_smccc_res res;
> >
> > +               trace_optee_invoke_fn_begin(&param);
> >                 optee->invoke_fn(param.a0, param.a1, param.a2, param.a3,
> >                                  param.a4, param.a5, param.a6, param.a7,
> >                                  &res);
> > +               trace_optee_invoke_fn_end(&param, &res);
> >
> >                 if (res.a0 == OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
> >                         /*
> > diff --git a/drivers/tee/optee/optee_trace.h b/drivers/tee/optee/optee_trace.h
> > new file mode 100644
> > index 000000000000..7c954eefa4bf
> > --- /dev/null
> > +++ b/drivers/tee/optee/optee_trace.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * optee trace points
> > + *
> > + * Copyright (C) 2021 Synaptics Incorporated
> > + * Author: Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM optee
> > +
> > +#if !defined(_TRACE_OPTEE_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_OPTEE_H
> > +
> > +#include <linux/arm-smccc.h>
> > +#include <linux/tracepoint.h>
> > +#include "optee_private.h"
> > +  
> 
> Checkpatch has some complaints below. Is that something that could be
> fixed or is this so far from regular C-syntax that we don't care?

I tried ./scripts/checkpatch.pl in Linus tree to check the patch, there's
no any error, and except the "MAINTAINERS need updating" warning, there's
no other warnings.

git log  -- scripts/checkpatch.pl
shows the latest checkpatch.pl is at commit 62137364e3e8afcc745846c5c67cacf943149073

I'm not sure what happened.

Thanks

> 
> Thanks,
> Jens
> 
> > +TRACE_EVENT(optee_invoke_fn_begin,
> > +       TP_PROTO(struct optee_rpc_param *param),
> > +       TP_ARGS(param),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(void *, param)
> > +               __array(u32, args, 8)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->param = param;
> > +               BUILD_BUG_ON(sizeof(*param) < sizeof(__entry->args));
> > +               memcpy(__entry->args, param, sizeof(__entry->args));
> > +       ),
> > +
> > +       TP_printk("param=%p (%x, %x, %x, %x, %x, %x, %x, %x)", __entry->param,
> > +                 __entry->args[0], __entry->args[1], __entry->args[2],
> > +                 __entry->args[3], __entry->args[4], __entry->args[5],
> > +                 __entry->args[6], __entry->args[7])
> > +);
> > +
> > +TRACE_EVENT(optee_invoke_fn_end,
> > +       TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
> > +       TP_ARGS(param, res),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(void *, param)
> > +               __array(unsigned long, rets, 4)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->param = param;
> > +               BUILD_BUG_ON(sizeof(*res) < sizeof(__entry->rets));
> > +               memcpy(__entry->rets, res, sizeof(__entry->rets));
> > +       ),
> > +
> > +       TP_printk("param=%p ret (%lx, %lx, %lx, %lx)", __entry->param,
> > +                 __entry->rets[0], __entry->rets[1], __entry->rets[2],
> > +                 __entry->rets[3])
> > +);
> > +#endif /* _TRACE_OPTEE_H */
> > +
> > +#undef TRACE_INCLUDE_PATH
> > +#define TRACE_INCLUDE_PATH .
> > +#undef TRACE_INCLUDE_FILE
> > +#define TRACE_INCLUDE_FILE optee_trace
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > --
> > 2.30.0
> >  

