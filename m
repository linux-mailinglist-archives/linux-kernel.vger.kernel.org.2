Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C695341795
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhCSIh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:37:27 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38344 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234402AbhCSIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:37:05 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AsRbKv6+e9LTmSGQ2IEduk+BWI+orLtY04lQ7?=
 =?us-ascii?q?vn1ZYxpTb8CeioSKlPMUyRf7hF8qKRUdsPqHP7SNRm6ZyIV85pMfMazncA7tvm?=
 =?us-ascii?q?apK48K1/qG/xTLHSri+ulBkZpxaqQWMqyTMXFWhdv3iTPXL/8O29+CmZrFuc7/?=
 =?us-ascii?q?yDNXQRhue+Vc6W5Ce2WmO2lXYCUDOpYjDpqb4aN8xwaIXXgMdMy0Cj0kcoH4yO?=
 =?us-ascii?q?Hjr57tbR4YCxNP0mDnsRqS5LH3CBSe1BsFOgkj/Z4Z7WPHnwblj5/Jj9iHzHbn?=
 =?us-ascii?q?vVP7045bg5/IxNdFGaW36/QoFg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,261,1610406000"; 
   d="scan'208";a="498822125"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:36:38 +0100
Date:   Fri, 19 Mar 2021 09:36:38 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Evan Benn <evanbenn@chromium.org>
cc:     Gilles Muller <Gilles.Muller@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/coccinelle: Add script to detect sign
 extension
In-Reply-To: <20210319142952.1.I2c82789dba4e68d61595862188e8bf4d31a05d38@changeid>
Message-ID: <alpine.DEB.2.22.394.2103190932280.2947@hadrien>
References: <20210319142952.1.I2c82789dba4e68d61595862188e8bf4d31a05d38@changeid>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Mar 2021, Evan Benn wrote:

> Hello,
>
> I am attempting to create a coccinelle script that will detect possibly buggy
> usage of the bitwise operators where integer promotion may result in bugs,
> usually due to sign extension.
>
> I know this script needs a lot more work, but I am just beginning to learn the
> syntax of coccinelle. At this stage I am mainly looking for advice if this is
> even worth continuing, or if I am on the wrong track entirely.

I'm not really an expert in the problem, so I don't know exactly what are
the kinds of code you want to find.  Coccinelle is good at matching the
types of things and the structure of things.  If you need to know the
actual values of things, you may want to try smatch.  Coccinelle probably
doesn't have complete knowledge of how various operators affect C types.
For example, it would not have known that BIT results in a long.

The best you can do is try some rules and see what the results are, and
try to collect some relevant examples and see if you can match them with
your rules.  Please write back if there is some specific code that is not
matched as expected.

julia


>
> Here is an example of the bug I hope to find:
>
> https://lore.kernel.org/lkml/20210317013758.GA134033@roeck-us.net/
>
> Where ints and unsigned are mixed in bitwise operations, and the sizes differ.
>
> Thanks
>
> Evan Benn
>
> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> ---
>
>  .../coccinelle/tests/int_sign_extend.cocci    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 scripts/coccinelle/tests/int_sign_extend.cocci
>
> diff --git a/scripts/coccinelle/tests/int_sign_extend.cocci b/scripts/coccinelle/tests/int_sign_extend.cocci
> new file mode 100644
> index 000000000000..bad61e37e4e7
> --- /dev/null
> +++ b/scripts/coccinelle/tests/int_sign_extend.cocci
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Mixing signed and unsigned types in bitwise operations risks problems when
> +/// the 'Usual arithmetic conversions' are applied.
> +/// For example:
> +/// https://lore.kernel.org/lkml/20210317013758.GA134033@roeck-us.net/
> +/// When a signed int and an unsigned int are compared there is no problem.
> +/// But if the unsigned is changed to a unsigned long, for example by using BIT
> +/// the signed value will be sign-extended and could result in incorrect logic.
> +// Confidence:
> +// Copyright: (C) 2021 Evan Benn <evanbenn@chromium.org>
> +// Comments:
> +// Options:
> +
> +virtual context
> +virtual org
> +virtual report
> +
> +@r@
> +position p;
> +{int} s;
> +{unsigned long} u;
> +@@
> +    s@p & u
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +cocci.print_main("sign extension when comparing bits of signed and unsigned values", p)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0],"sign extension when comparing bits of signed and unsigned values")
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
>
