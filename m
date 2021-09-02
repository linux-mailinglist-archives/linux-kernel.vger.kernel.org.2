Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DFD3FF528
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhIBUzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232398AbhIBUzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:55:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7A3360FDA;
        Thu,  2 Sep 2021 20:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630616076;
        bh=sqPOEoXe9QCxGolmFki6zue1BUYhcwDeYBk+iwiSinI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EVl6nqh6QtaoTE3SjKxyPV8FXCmMac/WMd7ElO2ZnQ22QJNQlX2awOdX0ruvfIfre
         M6SyFZw/t+wx2q3EWnQx0HP8kzVlxqNl6Bt0RuKK0D3QwtFfp/JDR3kfVZkTWacD1m
         Ia8N/Cwg3t18c8Csy3UNBM0Htx0qYj1BXNWMxci5CBcNis9S+KpNMn+GgNVnTp3c67
         2Trq95Xv/VkYEfRAWvqbQWVmjWoM0ZkW3uJ6Hr8ep2SVtC21tc2US60k5uuquUKK5Z
         47dxrS/8fEjBkCE3nyKZ4kQLCnIPu7sGEtXH6wimHbCQN4NGViyLV7TIbBHkI7sARz
         AvtroQA8DxPcg==
Message-ID: <df073c9f719a7da37a68148ea51aa28d06a14e40.camel@kernel.org>
Subject: Re: [PATCH] tracing: synth events: increase max fields count
From:   Tom Zanussi <zanussi@kernel.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 02 Sep 2021 15:54:34 -0500
In-Reply-To: <20210901135513.3087062-1-dedekind1@gmail.com>
References: <20210901135513.3087062-1-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Wed, 2021-09-01 at 16:55 +0300, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Sometimes it is useful to construct larger synthetic trace events.
> Increase
> 'SYNTH_FIELDS_MAX' (maximum number of fields in a synthetic event)
> from 32 to
> 64.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  kernel/trace/trace_synth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
> index 4007fe95cf42..b29595fe3ac5 100644
> --- a/kernel/trace/trace_synth.h
> +++ b/kernel/trace/trace_synth.h
> @@ -5,7 +5,7 @@
>  #include "trace_dynevent.h"
>  
>  #define SYNTH_SYSTEM		"synthetic"
> -#define SYNTH_FIELDS_MAX	32
> +#define SYNTH_FIELDS_MAX	64
>  
>  #define STR_VAR_LEN_MAX		MAX_FILTER_STR_VAL /* must be
> multiple of sizeof(u64) */
>  

This looks fine, but it does also bloat the arrays that use it as a
size.  There's only one that I'd be worried about, the per-elt
hist_elt_data[] array, but I'll send a patch shortly that gets rid of
that limitation.

Acked-by: Tom Zanussi <zanussi@kernel.org>

Thanks!

Tom

