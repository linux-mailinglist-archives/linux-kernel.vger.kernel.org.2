Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2136B6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhDZQjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhDZQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:39:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C123FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:38:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n3-20020a05600c4f83b02901425630b2c2so1065536wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FDZzzHKbsYqZn5frbpoGuHTwSKd8DRzK8DqNijAvNi4=;
        b=YTI28TQVuduZ/h/UOSs2lxT9/zjv2jTjBgaCFbi8IzJAMgivy7lqd+o/h5dzKRVh/5
         3wB5vSjCfVnmP9vWRZJveDYc4KXUtj/iAeX0EQSV9bOvYIeRrALs6stve7OKh+C8yggc
         1skjLaMHPMvyU6SnJ4Imv2pKz0TQ6WBDYQNnid4D+R3+RT+Xk+CMAzK5c3HpYedJyW+K
         2OgRDH8YpsrusEKmgfHphBAYzNIzRtp1pAng38uuEhuAXP/HJc9c8Bkm3fDrXyYMuEsO
         C1XyhbnuQD49wSWH/WYgzca+E6rXyKf8pTeDj4Po5FTbkEu9Xr6QuGeYK+9vVVq3nFIp
         9faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FDZzzHKbsYqZn5frbpoGuHTwSKd8DRzK8DqNijAvNi4=;
        b=ipdgm5sRodVEs7GXJAb7WMvWgkzO2a6TDpNg4VSAhFPb8BAuk/qSIvht7e3NB3k9gu
         mSmb6dpmSVN1bKoDnoRWE2JhwIeCYTjEcV5ydiCXtbTWOGswGrWwqoPzseY6zJOPNwJq
         lQRZ0/ZSObKEb8nlvUqz02noNiw0e03310XyG3X7OQpWRcgWmSZfiAubIb21U1L9ThkA
         5iiULqqOcmnLwB8A9/LgsEo3P6ANtGb/5ODxc+r5nBAuSCk/m6dWAWHfw2KbzSxQtWzG
         HxivsNGQXNwAhyHQSNmfM8vYO3hgoeG/p+bOxczztCYFP8eyFCrAU8oL3YIxS/PrxHA3
         RK6g==
X-Gm-Message-State: AOAM532SMCdvqLbIG/F6BJ6wbGcgfC8ScClJ9lrjCUw+a7adzq+E+Ov6
        Ol7HeMnKAk6aROQpaQDmaPU=
X-Google-Smtp-Source: ABdhPJyVcVgM+GHjJC9eo1UTz9xIh4U7KMDUrTC1650I0m3caIXEW0XF+X4wzSR+0GYfYfFW/McQCA==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr22159778wma.21.1619455131474;
        Mon, 26 Apr 2021 09:38:51 -0700 (PDT)
Received: from [192.168.1.102] ([37.164.229.71])
        by smtp.gmail.com with ESMTPSA id o13sm685211wrf.91.2021.04.26.09.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 09:38:50 -0700 (PDT)
Subject: Re: [PATCH] dyndbg: fix parsing file query without a line-range
 suffix
To:     Shuo Chen <giantchen@gmail.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Shuo Chen <shuochen@google.com>
References: <20210414212400.2927281-1-giantchen@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a053afb1-bd3c-78f2-6414-e43014692a56@gmail.com>
Date:   Mon, 26 Apr 2021 18:38:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414212400.2927281-1-giantchen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/21 11:24 PM, Shuo Chen wrote:
> From: Shuo Chen <shuochen@google.com>
> 
> Query like 'file tcp_input.c line 1234 +p' was broken by
> commit aaebe329bff0 ("dyndbg: accept 'file foo.c:func1' and 'file
> foo.c:10-100'") because a file name without a ':' now makes the loop in
> ddebug_parse_query() exits early before parsing the 'line 1234' part.
> As a result, all pr_debug() in tcp_input.c will be enabled, instead of only
> the one on line 1234.  Changing 'break' to 'continue' fixes this.
> 
> Fixes: aaebe329bff0 ("dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'")
> Signed-off-by: Shuo Chen <shuochen@google.com>
> ---
>  lib/dynamic_debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c70d6347afa2..921d0a654243 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -396,7 +396,7 @@ static int ddebug_parse_query(char *words[], int nwords,
>  			/* tail :$info is function or line-range */
>  			fline = strchr(query->filename, ':');
>  			if (!fline)
> -				break;
> +				continue;
>  			*fline++ = '\0';
>  			if (isalpha(*fline) || *fline == '*' || *fline == '?') {
>  				/* take as function name */
> 

SGTM, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>
