Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75C390BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 23:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhEYVvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 17:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232114AbhEYVvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 17:51:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C07D6610CE;
        Tue, 25 May 2021 21:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621979388;
        bh=zSwRPX4nYk6DG98wVlMJzLhygb/jgLIkgBgL/OHg4AI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uHTbcwtM8wlcrr0STARcdKKHXQlpJMHXsHqYXxznsKO6TtjhtC0WqmZAMprnEjXol
         I9f92CT9wjJTYy4p6JMctWwcImwqxtf1TwGT8vZvAkkV3gqq93A9s2fSkm0lTA4skr
         rizT7ryrHWIuSmbKbNYp8Gjhx42PGB20s1fxgUUs=
Date:   Tue, 25 May 2021 14:49:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andy@kernel.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH v2 2/2] lib/math/rational: Add Kunit test cases
Message-Id: <20210525144948.5bf487414edd6e0655902cf4@linux-foundation.org>
In-Reply-To: <20210525144250.214670-2-tpiepho@gmail.com>
References: <20210525144250.214670-1-tpiepho@gmail.com>
        <20210525144250.214670-2-tpiepho@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 07:42:50 -0700 Trent Piepho <tpiepho@gmail.com> wrote:

> Adds a number of test cases that cover a range of possible code paths.
>=20
> --- /dev/null
> +++ b/lib/math/rational-test.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <kunit/test.h>
> +
> +#include <linux/rational.h>
> +
> +struct rational_test_param {
> +	unsigned long num, den;
> +	unsigned long max_num, max_den;
> +	unsigned long exp_num, exp_den;
> +
> +	const char *name;
> +};
> +
> +static const struct rational_test_param test_parameters[] =3D {
> +	{ 1230,	10,	100, 20,	100, 1,    "Exceeds bounds, semi-convergent term >=
 =BD last term" },
> +	{ 34567,100, 	120, 20,	120, 1,    "Exceeds bounds, semi-convergent term=
 < =BD last term" },

It seems to be asking for trouble to use these characters in kernel
output - heaven knows what sort of weird output devices people
are using.  So I think I'll switch to "1/2", OK?

> +	{ 1, 30,	100, 10,	0, 1,	   "Closest to zero" },
> +	{ 1, 19,	100, 10,	1, 10,     "Closest to smallest non-zero" },
> +	{ 27,32,	16, 16,		11, 13,    "Use convergent" },
> +	{ 1155, 7735,	255, 255,	33, 221,   "Exact answer" },
> +	{ 87, 32,	70, 32,		68, 25,    "Semiconvergent, numerator limit" },
> +	{ 14533, 4626,	15000, 2400,	7433, 2366, "Semiconvergent, demominator li=
mit" },
> +};
> ...
> +static struct kunit_case rational_test_cases[] =3D {
> +       KUNIT_CASE_PARAM(rational_test, rational_gen_params),
> +       {}
> +};
> +
> +static struct kunit_suite rational_test_suite =3D {
> +       .name =3D "rational",
> +       .test_cases =3D rational_test_cases,
> +};

And let's use tabs to indent here.  checkpatch detects this.
