Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E6F390405
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhEYOgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:36:21 -0400
Received: from mail-eopbgr110112.outbound.protection.outlook.com ([40.107.11.112]:35893
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234024AbhEYOgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:36:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyBVdBDkAhaodh3ZuceRHTni9Y4BCpXIRsanlz0p+Ss0D6cfpj8Pqw81OfW8d2PvPXflF/UdnJnW/WN+teEkhQcL6aOEtls4JWO9yEj3BZDcV8HUGdlSg7RAdy239fNa4sIHkZddLt+sYbqnOP2nwT8Nvuo4Z1qVlnqTVty4dx2a33/QaGWChXIRNaTXAXgO2lVunvDLnDnYtEZg5gcxgLsMws7/cEj/xe82M34YyiuCUmD8KdMHLzZEKvXaXxnS06WY7zdR4x8r7gQ4B20dMPikTFLD9HXIFiPQGJNo6xbCsabNYe7c7Ds/UCwzKnuvvQtaUPXxVly/+s5TkMuUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMHhm/pjsF4ufDo9X5m3enGmxTU4/l4yWsActk8eq6E=;
 b=XkmIj+HRQlZ/0WyAKYbxyOKThsh4foT+u8HkWnETqgWI4NLFDv5z4GiVo3GLvIjm0ZKwiOTTqH1PW4FPj6YaKQhZ72Nsp/H5abV+flBQeMrgvZi/WW+JKZdeItR60fYGNS6g2SCHTJtsUgdndnqxRXdSZIw7yzQ4iWe/D32GARH4wtI/I896r9Bc3iNkgO2faegR4/+WAkCVJhHmOL1wZaPeibMLisHZ+35iv/ZCpEYxGxHHfeEmtZhLr3dHB9Ln1WSBmDAnMr4044H+l8rr5Mo53gQZV8YGUYwre2dWLIAz66gNJExnqDM8gjIDT+zFenwkRegPi1a+6dn3TjDBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMHhm/pjsF4ufDo9X5m3enGmxTU4/l4yWsActk8eq6E=;
 b=unwzMyrkOY5e/I1QkmMLDBRk4kSOImt5+ncLHSzYQnZ3nzQjqcuh2tgVqmtKo8tNdc1qYgiOy53ri46W0h0yXp9+X38glNKMptO2t3LTQ/JBfYy9x8I6z6dayUreKnO9kiLkduR9eyAKVPlqAcSOXZqgMQm/OIc0tydBOdly6Fc=
Authentication-Results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=garyguo.net;
Received: from LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:16::23)
 by LO0P265MB3417.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:186::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 14:34:36 +0000
Received: from LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM
 ([fe80::944f:5a46:312d:8099]) by LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM
 ([fe80::944f:5a46:312d:8099%3]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 14:34:36 +0000
Date:   Tue, 25 May 2021 15:34:32 +0100
From:   Gary Guo <gary@garyguo.net>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Palmer Dabbelt' <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "nylon7@andestech.com" <nylon7@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: fix memmove and optimise memcpy when misalign
Message-ID: <20210525153431.0000508d@garyguo.net>
In-Reply-To: <17637b10e71b41b89126cbb1b2fa61cf@AcuMS.aculab.com>
References: <20210522232256.00003f08@garyguo.net>
        <mhng-fdda10f7-fc83-4654-a0b2-e9c86b92c37e@palmerdabbelt-glaptop>
        <17637b10e71b41b89126cbb1b2fa61cf@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2001:470:6972:501:81f9:56c7:d6ec:ac27]
X-ClientProxiedBy: LNXP265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::32) To LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:16::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2001:470:6972:501:81f9:56c7:d6ec:ac27) by LNXP265CA0092.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Tue, 25 May 2021 14:34:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d24965c-1926-44d2-cee4-08d91f8a382e
X-MS-TrafficTypeDiagnostic: LO0P265MB3417:
X-Microsoft-Antispam-PRVS: <LO0P265MB34179001B98251C14601E9E0D6259@LO0P265MB3417.GBRP265.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEnmAqo8clrzBWDeZjvQgdmOJ/0VqU4Q70hQmAucNUEjK57SuSUHmmH1cdajVaRuULD8ne3Gbt0VLEFNATqpLmVeeqRpHxl4CvP4YxmuDuSMIe1cRetAE0QsO6xJP/KjR+BnfBiwfnsTbufpgRvC8tTJeuecw5Oz7MUEXOM0afIbZlM5HSh48CBbVdGd8TmIHUNzl+BQpWSYgFG95IBVWy+3QPdmuqEpdJYeec+lc/QFfpU0ufx6RGyJ/h+yKVoZwO1dxXJ0oPy4Y99eGQmp3p5CEIF1OvhlERmdF7LkgNBgxz/+iW8E9Q3Shn3avhozEC7or4LcNZ8s5weWur9JMfhPuKzecTmeRRoRB6ey28dkSXGGXw6wCTMXN1/JH3IUtMdJQNCN+idvZemOBgMmXQFu5+hip8eRfXjg3BBlRKujnNeIdgiNQwUKVt4LETtqWAXZTM6v3n8waP/fCAmGxj1P3L8PjExRw07e2drNsdvXTsQfYoo5q8i3neDxPS+ldRC6UFNpVgjU9wy2heKJhX9NaD7G3gjcZukmsE85kmkiDFuQsPn+tEOeZz5EVJCpiaY/vO7HC34iILeh5RxffbeeUPIVPOdOPnLVwKs6tbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(136003)(376002)(346002)(396003)(366004)(8676002)(6496006)(66556008)(478600001)(1076003)(66476007)(52116002)(5660300002)(66946007)(16526019)(38100700002)(2616005)(36756003)(2906002)(83380400001)(4326008)(54906003)(186003)(6666004)(8936002)(86362001)(316002)(6916009)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FgAckPYeM1JC2i8zPbWljq93M7hvC/Q7b4jmYal0lk97nmDgZ8M3MrHcMt56?=
 =?us-ascii?Q?BIIVL+Bud59xRK6c+IiZ/LcyVyJyFMlM0P+UnxuHn4WBdcSSTQKzoGb6bQfn?=
 =?us-ascii?Q?Zgeippz9EpaArsbZdw2qO8bjjGQHTQ/0adKPODe/O8/ABIJ27310e/jbS4/Q?=
 =?us-ascii?Q?AL/u5WRB5A/LkgJg2qkGOZ8t8dnhxTxfHoDWqRdtflyj8WKIbjksPiowmajB?=
 =?us-ascii?Q?p2y3Hr80i7v4YuilXj6r7m5O3+u1neAAIXeug54lq9Mu2P1pyarcdxkyWtB0?=
 =?us-ascii?Q?V/GSQdEli9/mNKIA4IaTPSirKZXKyNQdfiIRWFWYexdaQTbpoZ8ubQGnCSHb?=
 =?us-ascii?Q?iyRl9bkl+AJuQdqWiTWb5gEfRDUbS5pTNEoBVMCGOiwjiu57AJPBfISaE6P/?=
 =?us-ascii?Q?6g5108q4IbgtVmE/5mDHi1tptc2ypueUQXvWszlvMI6hFz6Vi5mVUM0ui+s0?=
 =?us-ascii?Q?ZJrWAf/JeiyCNEfeoqjaAhL+6Ml5Zmurt66xR6xqXQD4IqhUAvuaxItut8ow?=
 =?us-ascii?Q?WOjXEs9dS+AntF7IoY0WyrZpwSo57wRkhdwb82APc+L8HDuk8g92VqD6Gl2I?=
 =?us-ascii?Q?Byzz9D8EGah2+ulsKb2JI6GjOUYMl0Abt2U+ZAHCoaFOTSPQW7A4NNcrzH3Q?=
 =?us-ascii?Q?2CNi3KfiLaj9qx7jAMK/6IuRyTLIGWxNr6SiYKhh9r5uXnsigp2ZAFtbBPkA?=
 =?us-ascii?Q?gSiv6pbsj0mKrSlU2rkY+S2H2wpyi0Uu9hu+BlIO9bWWtHleTLEEEDE1FJ5b?=
 =?us-ascii?Q?7rl+eb6nR43ZSsD9t8AgEdTdKwb08x++kT6EL3pe/PJKkSK1+lKf/IOCoE8O?=
 =?us-ascii?Q?ZtU6lbuCkCkrR/Gu+ffsFQy3mC/LYrYhPGh/pgVNFOuqFP28Q4fkQ+qSmr2h?=
 =?us-ascii?Q?mVG0bwtyPlGJpnTNcSSwms3YV+m0kascPgdrTWZkhlvvdPJD4Sd3RIHeSdnw?=
 =?us-ascii?Q?nnyNhOXo0QUx2YbRoeNz6na7jUmNCwnH1l9cwBpZLzjix2NaT5HrEkX8YC2D?=
 =?us-ascii?Q?kBkvFMaYPkSLBvfqphknz4G3m2/RdHHC8EWPXmAID0eAxKW086ZvFt95LJSX?=
 =?us-ascii?Q?qcRAGst2fe3PtM1Z1kdGoXzYnvegH9IxmknvlTVvbWdDDMKouGBTKeGhNdyd?=
 =?us-ascii?Q?eRZaKPNtz0mSQ4ia+NRmVsXvwUTVIIUXunYxMbkHHWiwSJVlIQkrcBtrRoq+?=
 =?us-ascii?Q?w9hsHx1Hu8uYgVosUMTgs8/Gqgdpm9v4xdnXR6YhnVkf12rgFtfEziF3NcXj?=
 =?us-ascii?Q?Vkzffn2pW1Rpu7Yyxk32lmtJrh5fCaEMLPbbRw6ymWCxP/P/+4tIU/2rkZ9h?=
 =?us-ascii?Q?TiLSNqENYfDqm5qP30mwbZksrIhkgb91oOdIEbDs/XJzlDAB7QPq4WwdX4fR?=
 =?us-ascii?Q?Xpr1wr7zdBjgXGxXlNnVSlXJHe19?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d24965c-1926-44d2-cee4-08d91f8a382e
X-MS-Exchange-CrossTenant-AuthSource: LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 14:34:35.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X69Dq6DMorI8x7N5e43wZWx2DyMd84MpQ/6cLeg8Rgy1SLN9mOzHcmRF4v8bfUFAJ4zIiV4/BD/IUjyzSHSkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3417
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021 17:12:23 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Palmer Dabbelt
> > Sent: 23 May 2021 02:47  
> ...
> > IMO the right way to go here is to just move to C-based string
> > routines, at least until we get to the point where we're seriously
> > optimizing for specific processors.  We went with the C-based
> > string rountines in glibc as part of the upstreaming process and
> > found only some small performance differences when compared to the
> > hand-written assembly, and they're way easier to maintain.

I prefer C versions as well, and actually before commit 04091d6 we are
indeed using the generic C version. The issue is that 04091d6
introduces an assembly version that's very broken. It does not offer
and performance improvement to the C version, and breaks all processors
without hardware misalignment support (yes, firmware is expected to
trap and handle these, but they are painfully slow).

I noticed the issue because I ran Linux on my own firmware and found
that kernel couldn't boot. I didn't implement misalignment emulation at
that time (and just send the trap to the supervisor).

Because 04091d6 is accepted, my assumption is that we need an assembly
version. So I spent some time writing, testing and optimising the
assembly.

> > 
> > IIRC Linux only has trivial C string routines in lib, I think the
> > best way to go about that would be to higher performance versions
> > in there. That will allow other ports to use them.  
> 
> I certainly wonder how much benefit these massively unrolled
> loops have on modern superscaler processors - especially those
> with any form of 'out of order' execution.
> 
> It is often easy to write assembler where all the loop
> control instructions happen in parallel with the memory
> accesses - which cannot be avoided.
> Loop unrolling is so 1970s.
> 
> Sometimes you need to unroll once.
> And maybe interleave the loads and stores.
> But after that you can just be trashing the i-cache.

I didn't introduce the loop unrolling though. The loop unrolled
assembly is there before this patch, and I didn't even change the
unroll factor. I only added a path to handle misaligned case.

There are a lot of diffs because I did made some changes to the
register allocation so that the code is more optimal. I also made a few
cleanups and added a few comments. It might be easier to review if you
apply the patch locally and just look at the file.

- Gary
