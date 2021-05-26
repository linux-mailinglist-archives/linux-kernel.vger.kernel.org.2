Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39719391794
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhEZMnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233731AbhEZMmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:42:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 327D061378;
        Wed, 26 May 2021 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622032871;
        bh=JaceLDw4qKh+kAo+B4z+hnPO5J4/nje2LBpHhaCidp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpVvIT0A/q4zCdmaOTRYSlUV2X9j+1gjNCHy3bMcpchV3rYtIwg9DwkykJnxAwbNU
         nCiz98LO4iitSrnjty0z6SARHCaS0XJcA5WxGdtkrKWSQkVNlyqc12e0nCrMatKKuc
         7ChN2y7m333drYUmx43rkdSPmRJRubuV49GW8LlcMbnj2Q0mFR+X6aGjBxae0hfkjH
         y7pwqzSIjWmBmwz+j5XSeiBDwHTQid9ma6ia9r1shb7PgXmgO3wEPqcCtCTHu/rHYe
         Bbma5iIK+6UD1j7Awt89ouIwphchEhmp+g8hy5A3N9wE+s3wUdpKBYEp4LU2On3FyE
         BZYxtHjDY6MGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A89864011C; Wed, 26 May 2021 09:41:07 -0300 (-03)
Date:   Wed, 26 May 2021 09:41:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v8 1/3] perf report: compile tips.txt in perf binary
Message-ID: <YK5B4/1d6ezmgxDs@kernel.org>
References: <20210524111514.65713-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210524111514.65713-1-dzagorui@cisco.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 24, 2021 at 04:15:12AM -0700, Denys Zagorui escreveu:
> diff --git a/tools/perf/Documentation/Build b/tools/perf/Documentation/Build
> new file mode 100644
> index 000000000000..83e16764caa4
> --- /dev/null
> +++ b/tools/perf/Documentation/Build
> @@ -0,0 +1,9 @@
> +perf-y += tips.o
> +
> +quiet_cmd_ld_tips = LD       $@
> +      cmd_ld_tips = $(LD) -r -b binary -o $@ $<
> +
> +$(OUTPUT)Documentation/tips.o: Documentation/tips.txt FORCE
> +	$(call rule_mkdir)
> +	$(call if_changed,ld_tips)
> +
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c


⬢[acme@toolbox perf]$        git am ./v8_20210524_dzagorui_perf_report_compile_tips_txt_in_perf_binary.mbx
Applying: perf report: compile tips.txt in perf binary
.git/rebase-apply/patch:42: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
tools/perf/Documentation/Build:9: new blank line at EOF.
⬢[acme@toolbox perf]$

I'm fixing this up.

- Arnaldo
