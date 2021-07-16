Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4341F3CBA68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhGPQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhGPQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:18:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32358C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:15:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso9142087pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=m2G2S0hTEjLHYuCAAFhFmoR9GFCJjaKUds8niu/vBnY=;
        b=rKbQVfed4Y0SdijlmppKCylEMkjxapr03LBMQ2QhrF4iKLG/I7VL3Qr6tArY+S5v6u
         J1GsJHLXmnMQ9JWhaC89Dj8MEV3oqrdXV6elC3O9o5t0sMxKVNsCCN0EzgHyjE+enzM7
         EI4E9euoqdKoZU8fkpsuIAzrw4VLxQq144KOT1mxwAN6tNeAoXt3vRaN+L1wU0KIUdYZ
         ym7oxZekhmsBmfqVIhHGAKHZxRKB38f+M9lErgqo5OdbGRzkSZWVvBOLpm/6bN4kzuWR
         lrDl4sVBl5Gx7e9TsY7IWx0wJc/QaTagUIPjVKGWxL5B4bhk/MY6QPLZ09J63dAbo9vH
         qrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=m2G2S0hTEjLHYuCAAFhFmoR9GFCJjaKUds8niu/vBnY=;
        b=reLLbtwpTSUVFbWIWrpk8veyUero0lD16XViRmSGWt6tU8RhwnQOde4/98XGI3B6Du
         ZVcfOzHNAy+yB5RvTsZAb3XQb2JKB97XeXQC1DpdwLIDkwSgbLY78a1NVHVq4WF5jIY+
         vKqvadCAKSbYxTebEZPYBBHaCLfQBkzRp1g830rQniVnVUU5eUcBMSdbzzYV7bcbSopR
         cIJCxiorUEv62kHujh2o/4LTfvsX5KJBFCT6LTRE/SiBaOK/Ut+6f1cYzXIsGSoLgt4L
         ke5QEL4KO2mPRBNXp+9JOAKeZC4606UR++Fvmz3+81+x48PkxGLSQLmYsIDrsU7F962z
         yfRg==
X-Gm-Message-State: AOAM531aL+i7B+eAPUj3ahtTpTaxDmUKsZhHArnhVp9uTEXWQVUHHWAW
        KqpgjMdYF69eFC+L2vymSRv4BQ==
X-Google-Smtp-Source: ABdhPJySgePBV3G8Y7CguuxTBwCOCo8r2eWuRxQshnyL+R+DP82ZxEGq/X7efikhdPnSySELbTcR9w==
X-Received: by 2002:a17:902:ea09:b029:12b:1dc0:ac74 with SMTP id s9-20020a170902ea09b029012b1dc0ac74mr8430870plg.82.1626452149535;
        Fri, 16 Jul 2021 09:15:49 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.136.242])
        by smtp.googlemail.com with ESMTPSA id s7sm8560556pjr.11.2021.07.16.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:15:49 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Fri, 16 Jul 2021 21:45:43 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Ani Sinha <ani@anisinha.ca>
cc:     linux-kernel@vger.kernel.org, anirban.sinha@nokia.com,
        mikelley@microsoft.com, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block comment
 style
In-Reply-To: <20210714063422.2164699-1-ani@anisinha.ca>
Message-ID: <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo>
References: <20210714063422.2164699-1-ani@anisinha.ca>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch maintainers, any comments?

On Wed, 14 Jul 2021, Ani Sinha wrote:

> The preferred style for long (multi-line) comments is:
>
> .. code-block:: c
>
> 	/*
> 	 * This is the preferred style for multi-line
> 	 * comments in the Linux kernel source code.
> 	 * Please use it consistently.
> 	 *
> 	 * Description:  A column of asterisks on the left side,
> 	 * with beginning and ending almost-blank lines.
> 	 */
>
> It seems rule in checkpatch.pl is missing to ensure this for
> non-networking related changes. This patch adds this rule.
>
> Tested with
> $ cat drivers/net/t.c
>     /* foo */
>
>     /*
>      * foo
>      */
>
>     /* foo
>      */
>
>     /* foo
>      * bar */
>
> $ ./scripts/checkpatch.pl -f drivers/net/t.c
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> line #1: FILE: drivers/net/t.c:1:
> +    /* foo */
>
> WARNING: networking block comments don't use an empty /* line, use /* Comment...
> line #4: FILE: drivers/net/t.c:4:
> +    /*
> +     * foo
>
> WARNING: Block comments use a trailing */ on a separate line
> line #11: FILE: drivers/net/t.c:11:
> +     * bar */
>
> total: 0 errors, 3 warnings, 0 checks, 11 lines checked
>
>
> For a non-networking related code we see the following when run for
> the same file:
>
> $ ./scripts/checkpatch.pl -f arch/x86/kernel/t.c
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> line #1: FILE: arch/x86/kernel/t.c:1:
> +    /* foo */
>
> WARNING: Block comments use a leading /* on a separate line
> line #7: FILE: arch/x86/kernel/t.c:7:
> +    /* foo
>
> WARNING: Block comments use a leading /* on a separate line
> line #10: FILE: arch/x86/kernel/t.c:10:
> +    /* foo
>
> WARNING: Block comments use a trailing */ on a separate line
> line #11: FILE: arch/x86/kernel/t.c:11:
> +     * bar */
>
> total: 0 errors, 4 warnings, 11 lines checked
>
> In the second case, there is no warning on line 4 and in the first
> case, there is no warning on line 10.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  scripts/checkpatch.pl | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> Changelog:
> v1: initial patch
> v2: commit log updated to reflect the output from checkpatch.pl
>     when run against the same file both in networking and
>     non-networking case. This helps in comparing results apples to
>     apples.
> v3: line numbers got lost in the commit log as git eliminated all lines
>     starting with '#'. Fixed it by prefixing with word 'line'. The work
>     'line' does not however appear in the checkpatch.pl output.
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 23697a6b1eaa..5f047b762aa1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3833,6 +3833,14 @@ sub process {
>  			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>  		}
>
> +# Block comments use /* on a line of its own
> +		if (!($realfile =~ m@^(drivers/net/|net/)@) &&
> +		    $rawline !~ m@^\+.*/\*.*\*/[ \t)}]*$@ &&	#inline /*...*/
> +		    $rawline =~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-blank
> +		    WARN("BLOCK_COMMENT_STYLE",
> +			 "Block comments use a leading /* on a separate line\n" . $herecurr);
> +		}
> +
>  # Block comments use * on subsequent lines
>  		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
>  		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
> --
> 2.25.1
>
>
