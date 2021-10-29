Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F86543F4BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 04:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhJ2CEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 22:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhJ2CEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 22:04:04 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3550460C40;
        Fri, 29 Oct 2021 02:01:36 +0000 (UTC)
Date:   Thu, 28 Oct 2021 22:01:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, mhiramat@kernel.org, zanussi@kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/histogram: Optimize division by constants
Message-ID: <20211028220134.23e2d840@rorschach.local.home>
In-Reply-To: <20211028032854.2458440-1-kaleshsingh@google.com>
References: <20211028032854.2458440-1-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 20:28:54 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> +/*
> + * Returns the specific division function to use if the divisor
> + * is constant. This avoids extra branches when the trigger is hit.
> + */
> +static hist_field_fn_t hist_field_get_div_fn(struct hist_field *divisor)
> +{
> +	u64 div;
> +
> +	if (divisor->flags & HIST_FIELD_FL_VAR_REF) {
> +		struct hist_field *var;
> +
> +		var = find_var_field(divisor->var.hist_data, divisor->name);
> +		div = var->constant;
> +	} else
> +		div = divisor->constant;
> +
> +	if (!div)
> +		return div_by_zero;

Do we really need a div_by_zero constant function? What about just
erroring here and perhaps return -EDOM?

-- Steve

> +
> +	if (!(div & (div - 1)))
> +		return div_by_power_of_two;
> +
> +	/* If the divisor is too large, do a regular division */
> +	if (div > (1 << HIST_DIV_SHIFT))
> +		return div_by_not_power_of_two;
> +
> +	divisor->div_multiplier = div64_u64((u64)(1 << HIST_DIV_SHIFT), div);
> +	return div_by_mult_and_shift;
> +}
> +
