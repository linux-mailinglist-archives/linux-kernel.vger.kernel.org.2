Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEEF3B5A16
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhF1Hyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1Hyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:54:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630CEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:52:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l21-20020a05600c1d15b02901e7513b02dbso7648068wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=26Jo7b1uCcAsRn7cA2/UX0PAm6+96/bC+S5nPYvJDSs=;
        b=d/FLb0ur37yuvi/he3rJ4++VzOSF9BgsmO7AnOKJaMPVCqDjbfyONooNEP62zZFOlu
         2NyFCToeZGGdFkXuf6bOuhgWGJD7Vc1V4GKMroCPY6Gz7Gd7CUh9IGASAPhP+sG1M1OM
         RGvibommRmMaBdxFs996P+K50jJGrgqOLdVhaEP7KqaU4XeWopFwzmljenckuB41bscq
         PRH2FvQ8zGpaTQaw7ylPTYUuQB9KI5ccN5aMXpto+GZMut7P62R/EMDSjHWADEvimZUZ
         /3I394wdpriRggUihQq42fGvGf8ej3ZcIu139+J5iq7Z+HrsHANwdL7aE6oXU9WOWyOx
         Xb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=26Jo7b1uCcAsRn7cA2/UX0PAm6+96/bC+S5nPYvJDSs=;
        b=rk5oDWRlAcizPOg5EVzyywZZ/NOC5D4zkvxpwxoUGhMCMkPz8kDErzQ7gEN+J7yqEu
         N6CtsKQ9qa0YSM1ZJdNBVwmE3jRu1dAPjil55GctxHwsfmhp+WBvPvV74ikJ6gUszYHD
         bFl3CzDvh6MqXIjTPmIPuDDb5dUPLElGHaoIiV6BYMhFLzqYmvwm5JZjL7C5s6zof3TN
         1S6POFqEi0f8UZyajGOlBvnZVaN90tU+U6EzAE0qH2M1mcOXDaFgvQlAGnOscX8rwMj+
         212+MnjzJGZTo065eNmRh1ECqG7VWpZ6KH4tC52ulgkno1UNQpeQ8IRCHRzjN5X5sc5C
         jltg==
X-Gm-Message-State: AOAM530Qvhzsyx3tJnyEZRyHKq+rJAObXOAKZ0fDNemhXPbtmnb0iy2O
        1Gdxxasu1J1GpnyVgLL5ICcfUM2XIng=
X-Google-Smtp-Source: ABdhPJyEs4DQY1q9IDG/fz/JGbGFyvIJQcb6b1lWA7LabpLizJxLmgFKid93Qh6/jk5JTWQ3WRrRgg==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr24726348wmi.87.1624866733991;
        Mon, 28 Jun 2021 00:52:13 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id e12sm14094999wrw.34.2021.06.28.00.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 00:52:13 -0700 (PDT)
Subject: Re: [PATCH v2] checkpatch: Fix regex for do without braces
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>, joe@perches.com,
        apw@canonical.com
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
References: <20210627184909.6000-1-dwaipayanray1@gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <dfc6106b-81cd-a78f-a002-2a4b4c04155e@gmail.com>
Date:   Mon, 28 Jun 2021 09:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627184909.6000-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/21 8:49 PM, Dwaipayan Ray wrote:
> The regular expression for detecting do without braces
> also passes when checkpatch encounters the "double"
> keyword. This causes wrong recalculation of $stat in
> checkpatch which can cause false positives.
> 
> Fix the regex to avoid the above. Also update the comments
> for the check.
> 
> Reported-by: Alejandro Colomar <alx.manpages@gmail.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
Reviewed-by: Alejandro Colomar <alx.manpages@gmail.com>
Tested-by: Alejandro Colomar <alx.manpages@gmail.com>
(is Acked-by/Reviewed-by implied by Tested-by?)
> ---
> 
> Changes in v2:
> - Check word boundary on both sides of do
> 
>   scripts/checkpatch.pl | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 8d19beca3538..64036e7eff71 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5488,9 +5488,8 @@ sub process {
>   			}
>   		}
>   
> -# Check for illegal assignment in if conditional -- and check for trailing
> -# statements after the conditional.
> -		if ($line =~ /do\s*(?!{)/) {
> +# If we have sufficient context detect and handle do without braces ({).

s/context detect/context, detect/

> +		if ($line =~ /\bdo\b\s*(?!{)/) {
>   			($stat, $cond, $line_nr_next, $remain_next, $off_next) =
>   				ctx_statement_block($linenr, $realcnt, 0)
>   					if (!defined $stat);
> @@ -5511,6 +5510,9 @@ sub process {
>   								$offset} = 1;
>   			}
>   		}
> +
> +# Check for illegal assignment in if conditional -- and check for trailing
> +# statements after the conditional.
>   		if (!defined $suppress_whiletrailers{$linenr} &&
>   		    defined($stat) && defined($cond) &&
>   		    $line =~ /\b(?:if|while|for)\s*\(/ && $line !~ /^.\s*#/) {
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
