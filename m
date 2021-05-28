Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92239394802
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhE1UjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:39:25 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:34182 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229482AbhE1UjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:39:24 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6C38E8778;
        Fri, 28 May 2021 20:37:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id F410D2448B8;
        Fri, 28 May 2021 20:37:45 +0000 (UTC)
Message-ID: <0a78bd39b9ef40114bc7527709a533143415f0aa.camel@perches.com>
Subject: Re: [PATCH 6/6] pgo: Fixup code style issues.
From:   Joe Perches <joe@perches.com>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, samitolvanen@google.com
Cc:     wcw@google.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Fri, 28 May 2021 13:37:44 -0700
In-Reply-To: <20210528201213.459483-1-jarmo.tiitto@gmail.com>
References: <20210528201213.459483-1-jarmo.tiitto@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.39
X-Stat-Signature: 6wbnunbh3ar94pm7g95koecf5msryydf
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: F410D2448B8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18rjO0VftHNOo2CzdbAdYacbJQbxOtJvIs=
X-HE-Tag: 1622234265-802280
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-05-28 at 23:12 +0300, Jarmo Tiitto wrote:
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>

This should have some commit description like:

Do not initialize statics and use tab indentation.
Some would suggest this should be 2 separate patches.

> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
[]
> +	if (start <= p && p < end) {

Generally clearer / more commonly written using

[]
	if (p >= start && p < end)

> +		/* vmlinux core node */
> +		if (&vnds[current_node + 1] >= vnds_end)
> +			return NULL; /* Out of nodes */
> +
> +		current_node++;
> +
> +		/* Make sure the node is entirely within the section
> +		 */
> +		if (&vnds[current_node] >= vnds_end ||
> +			&vnds[current_node + 1] > vnds_end)
> +			return NULL;
> +
> +		return &vnds[current_node];
> +
> +	} else {

I suggest getting ride of the else and unindenting the block below too
in yet another separate patch so the function fits in 80 columns.

> +		/* maybe an module node
> +		 * find in what module section p points into and
> +		 * then allocate from that module
> +		 */

...


