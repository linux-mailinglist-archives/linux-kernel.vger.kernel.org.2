Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E799E3A2958
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFJKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFJKbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBD7F613F5;
        Thu, 10 Jun 2021 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623320968;
        bh=eCzkqws2HXt/qmIfkeMv1/yKpH5J7bcLo8pRkoLVda4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iBWfIw5C5EZb6Q/Qargdb85OEILyOmxB5exVIgkN+8UFEZj2JoWUNZW6DzDbNjx/Q
         UrpiQQEbjPag52v6v80agUfupKvRrRf3moblDfd5VL6YpQCzovhkhEoHaCh2kt4erc
         9wvXiEECoXKI3G9mCFa53Epm8MVn8lthngh5sJm4qglWtNdoX/w7CVlrpZPaaGxO+9
         qrPxAhzHfNMyFSUkl5hCRSVPuEkXhINdMsmrMPnAmgbueK8Bt7OOiSUMoOmeBs9igL
         +KMSzd+HJi2H+ybvtFFYS69GJbmgn/bn3cCVtphKbeWdlGiuIXlfkV7m0SCSXBuKem
         am0k3K+RU0jSQ==
Date:   Thu, 10 Jun 2021 19:29:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] tools/perf probe: Print a hint if adding a probe fails
Message-Id: <20210610192926.6f7b606f1fefd285b3907cd5@kernel.org>
In-Reply-To: <20210610094442.1602714-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20210610094442.1602714-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Thu, 10 Jun 2021 15:14:42 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Adding a probe can fail in a few scenarios. perf already checks for the
> address in the kprobe blacklist. However, the address could still be a
> jump label, or have a BUG_ON(). In such cases, it isn't always evident
> why adding the probe failed. Add a hint so that the user knows how to
> proceed.
> 

Thanks for the report.

Since now there is <tracefs>/error_log, if you see any errors in registering
probe-events, perf probe should dump the error_log for the hint message.
Also, kprobes should return the correct different error code for each
errors.

Thank you,

> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/builtin-probe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 6b150756677014..ff9f3fdce600dd 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -352,8 +352,11 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
>  	}
>  
>  	ret = apply_perf_probe_events(pevs, npevs);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pr_info("Hint: Check dmesg to understand reason for probe failure.\n"
> +			"      Consider probing at the next/previous instruction.\n");
>  		goto out_cleanup;
> +	}
>  
>  	for (i = k = 0; i < npevs; i++)
>  		k += pevs[i].ntevs;
> 
> base-commit: 0808b3d5b7514dc856178dbc509929329bbf301d
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
