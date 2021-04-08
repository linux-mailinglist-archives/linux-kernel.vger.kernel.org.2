Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF33581A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhDHLZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:25:01 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:36097
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230411AbhDHLY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:24:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiJH1EVytfQ3Z0MIl2+OEF6ZYa6NKxnBobQC5g7aD4ZQkcs6CPpS5YvamcOxsHezrj6q6z4ZhatHBF6DCoa3Kv0FVct6eXcFF0ubL7f1c4bZmfo5+b8UJ9iNNeE7Y+YGnAHehF5msCSPvghNWgtGDzfpWtKj4HXKnz53Q9Z/RYZBm0VJiVygf0IZ8e3ViyCJFxI1pxe7XEieIVmbby10VxI8eb9hySleG5XbzcNkC/IaxIgF9AQTAwD6T5N3nrXTtpEcFm9V5Xewy5Vr8LDHTwvCocC3+V9U3YxnGof+vwnoqSTAjHqbAV5KgH7QQZMkkt4hJc/yvTY/t5GgnehXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6nUXeQqefxKe+jBMnHze3fW0jQtSJ2Ek48XiydazlA=;
 b=TtQB2G0uKmp+nsjnbhIkEkvIN5rHdq/cNf6I0MrumDD6BB4PQzu/Wk6aCxwrtAW9MHX3ItVP5KucC9a4fxixJ21BwX62nrkij5j12XmkyohPa86Kp9MZTNUnRvL0EcbixjzTd4+6cfbY929NWa1BsK5bkPtl+/i3lX9xMtAxGE+xWkBesbSHbyoGvwZUGTNs/yChdiBJQb0uxbwC3Scr73nKViq4Cz/ayWbM/R50Hw4ITHF3+y7kSxNCEPx/A8qxenWMqNUixhk/K0xQUOQJxgCDyi+lBSXGCsjcMoOTK+ZYA4mjooAXQLGzT3D5t+9SKtqoeasQsU7jN8+DcGdNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6nUXeQqefxKe+jBMnHze3fW0jQtSJ2Ek48XiydazlA=;
 b=V6uji/W5r9T3io35Tro+w/NrezDaOv8GianvMPfitUmboy9JWrssSswXU3UQIqSW1Eo8sx6qHA2kF9Hcn1hQ9xMIEpqbMTM4H890ILYDJwG98HbRy4E1J9OVhLO469vau3GSdviTXmJSWnLEi4T0+ZPUsG+fpy0l8F+KOeWbOoc=
Authentication-Results: orcam.me.uk; dkim=none (message not signed)
 header.d=none;orcam.me.uk; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB4423.namprd03.prod.outlook.com (2603:10b6:a03:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 8 Apr
 2021 11:24:45 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%9]) with mapi id 15.20.3999.033; Thu, 8 Apr 2021
 11:24:45 +0000
Date:   Thu, 8 Apr 2021 19:23:48 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT
 exception
Message-ID: <20210408192348.1d50c588@xhacker.debian>
In-Reply-To: <alpine.DEB.2.21.2104032020100.65251@angie.orcam.me.uk>
References: <20210330021624.2b776386@xhacker>
        <20210330183316.942215efe8e6e8455ad14113@kernel.org>
        <20210331222244.45a5807c@xhacker>
        <20210401093036.037f2abbce7ed5d1e68466b7@kernel.org>
        <alpine.DEB.2.21.2104032020100.65251@angie.orcam.me.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR16CA0036.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::49) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR16CA0036.namprd16.prod.outlook.com (2603:10b6:a03:1a0::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 11:24:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8130316d-07b3-45ba-aa9d-08d8fa80e95e
X-MS-TrafficTypeDiagnostic: BYAPR03MB4423:
X-Microsoft-Antispam-PRVS: <BYAPR03MB44236DAC517E7050395E0C0CED749@BYAPR03MB4423.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHfohw170oZWeiqI9WKcHEeif11G/paGCrqZoxD4foyjY8PA2ib1I5bKNR75SjyoIoZPST70mRr1jzMzuZOQFUDx9DCy2O7F7qxhR3o09pClLIxIOG91/VF/nYtf+YQBPK/uuNdU5ni73XgeP8IxwcMKbpgk+/8Se8WPvvnKqwf/7SV2MFdncmCB5x18GMads33WFJl1R/aRRYIdOZIU1B9AFpcdH3O+afmeZnc7zOK6I6Je7znjs7BphGsdUpluFIDC9RS9FQvD5PfefYgBnWVaSpvw4Kwsx8GT9vLpLTN6XNKFRDZ2ISxjYfYfN+F3nHePNOu/SmSPYBNTH7Hp7SHZIExotqWFbZFeVMOVWCZ0lWpxc22GhqDms9bsh84JETNcufJbcLmJ98OfWfUKurezLYtUlI8t9HYQ6+v3nApmgG0CfmH271mUJJuRD/b+JtNvTt3XB+Fj0cPcY0ayVhDFi3KiI2enEg2rUuPzyZo41uJtpgkZk9Q+mmXvQKkW0IJP9vxqwhQMvKgEc/WsE+tp/Any5VqKxXmi7YI8mrZvrRYL6hrfujeaXuwXqQuSZN5gn1EJr4bTF9X1jknTVN4zmgNf7MRquNCqYV6BCYKLYhOXte6KMZZttg+Ko0dWNmdoSYe0G90cZUozz3NuxNmBj8N+1HGPRkDeZa+PIiPvuPEWaJ2P9RvNmdev6mNt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39860400002)(346002)(136003)(2906002)(9686003)(52116002)(7696005)(4326008)(5660300002)(55016002)(66946007)(26005)(6506007)(86362001)(38100700001)(66476007)(66556008)(186003)(478600001)(316002)(8676002)(83380400001)(6916009)(54906003)(38350700001)(1076003)(956004)(8936002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?544R491pXTDksRYrmIzCsgx0+UfZfoclw4cCwuFoF8pmSxGPkmniIxg+h8y8?=
 =?us-ascii?Q?giI5uSZSGXwNRUJPZMP/SZku19RlbqoW3P9SR+JJ7L+61Bac2y4Im+sF+yoX?=
 =?us-ascii?Q?+gAU+yYJ1FcxRLDNgbioE6i+RIVRnx7o1L/3GQKgRTyHKeFrpBhFUpoddqtg?=
 =?us-ascii?Q?VCZgBI62ltLj4d2W60B7hBVgXSgGHUVv6bFT9TRoGby2OImOeToYTXF8MajM?=
 =?us-ascii?Q?NuFWDHHmY+fdFdbbW6Tt4GnqksGqewuXbsjhoZ8NpzkLiXqBNG5P1FREKXud?=
 =?us-ascii?Q?HUWQhgoB/Bf+hqoZVL4jdGBrAzk2U4ov0lfkLLYsY7mRtNI2yVGl6m7G6uST?=
 =?us-ascii?Q?HzAfi/+jtSdBJlYazgFfoxBxhjUeJ3vExbcxQ3XMPefwhU6pVaq/LNANqbDE?=
 =?us-ascii?Q?ur9wpFOs2VuCKmyF107QWsHqHLfLelp9ZRfJi9zI38rMb++mRxxxF9UpY/tK?=
 =?us-ascii?Q?oJoF8Zao4xdlnX8qF1fN4Ezf3hgxej2E6xPZC9HPuLs60VGyCrPhBSSI+AaM?=
 =?us-ascii?Q?kAOBKiwdlpok4TAWDiStFyD8CzTTQrgACKb/xkipcy+aVZoAo+dKIFWpJS6n?=
 =?us-ascii?Q?lPiyrFs4+D0t+BmRgc78om04r/ViDZmbIfjYVr6h31jKtZpjmkr0+RRNGQEa?=
 =?us-ascii?Q?YxjnB+9c+iEhjrub2xA1Ati0/D/qrdtlovHC4UfUvNtcmkTRYv8rOZEOnHHZ?=
 =?us-ascii?Q?nzMrRKuN+fJKZQKn3CXy8/5h4PtQvXZABV/3m7Quc5rGO+ZH5h2ImU1qDNCL?=
 =?us-ascii?Q?/vh6H3qNqAgZdB6P4W/9Jcimujwzb77Ne4S5pInsCuwYBdUQBvRe0AeHMxoA?=
 =?us-ascii?Q?g78tOgUtJaAi0yFMgdcbKjT54+IRlzONMUKiL/UehJUooBVFkBezE0tMld33?=
 =?us-ascii?Q?Vac6j/HBQqsATWtzGX2Kz0DWy6d14ui403Ocj3TVGLhadCQXhtBz2K7DdzMF?=
 =?us-ascii?Q?vlwMsJmeaAk7dAe81kjI8M4VwGpZdrKnXXNwz53w2ruRLcfJ+n6BhKCU4vad?=
 =?us-ascii?Q?4fiLLgeXVTIdWdeOHr9dv4KSy4w/9QaMJRe0lRBKdDW7H03PeE9tvPX4zUuJ?=
 =?us-ascii?Q?3e586fVkpPzU4RnHuw/wHs0KmK1Dcl9Ar0VVpJFiQDPCP205vh7r+sWgx1Rb?=
 =?us-ascii?Q?ZiTOOf8jPT72g6ogkMJDhZ5n9ieNPlWSaYiIJ320QW5iwsJa6szgQIAk5kzp?=
 =?us-ascii?Q?OjT6sKlUQTrcmvQGCJ+2PA4UH72iyMntODTeo7NHwupixp6QZP4RPLdFT9zz?=
 =?us-ascii?Q?w9S6rtqL734wTOsUjCQTgEKyqnIwCoJKOuU4S0wXsgFC+1I76x0kxzXzaeQn?=
 =?us-ascii?Q?QA5liQtzCrptZr3qoteBaEtC?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8130316d-07b3-45ba-aa9d-08d8fa80e95e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 11:24:45.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8v48ak4WF4Kn9oOMM0xyERmyVZekGM6wpX0TQaVHnZdJj5TTnb1NI0zqoXSb/BZOgC/mn7K7Ds6dhtm+D5uEYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2021 20:30:53 +0200 (CEST)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Thu, 1 Apr 2021, Masami Hiramatsu wrote:
> 
> > > > > Current riscv's kprobe handlers are run with both preemption and
> > > > > interrupt enabled, this violates kprobe requirements. Fix this issue
> > > > > by keeping interrupts disabled for BREAKPOINT exception.  
> > > >
> > > > Not only while the breakpoint exception but also until the end of
> > > > the single step (maybe you are using __BUG_INSN_32 ??) need to be
> > > > disable interrupts. Can this do that?
> > > >  
> > >
> > > interrupt is disabled during "single step" by kprobes_save_local_irqflag()
> > > and kprobes_restore_local_irqflag(). The code flow looks like:
> > >
> > > do_trap_break()   // for bp
> > >   kprobe_breakpoint_handler()
> > >     setup_singlestep()
> > >       kprobes_restore_local_irqflag()
> > >
> > > do_trap_break()  // for ss
> > >   kprobe_single_step_handler()
> > >     kprobes_restore_local_irqflag()  
> >
> > OK, thanks for the confirmation!  
> 
>  Is this approach guaranteed to keep interrupt handling latency low enough
> for the system not to be negatively affected, e.g. for the purpose of NTP
> timekeeping?

IMHO, interrupt latency can't be ensured if kprobes is triggered.

thanks
