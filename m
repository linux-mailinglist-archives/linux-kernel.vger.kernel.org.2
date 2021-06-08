Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217FF39FD09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhFHRFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:05:32 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:40802 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhFHRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:05:30 -0400
Received: by mail-pl1-f178.google.com with SMTP id e7so10984291plj.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4usFl7sIsVthQj7CAaTLNOirYn+9w5CcbbsPb6gzTZs=;
        b=JlUf729Lw0qh8gpM+lacYrwI/BZHfR8iaIh6HWob68cqLRbEOcHJt9U9t2YgpQU93j
         5p+//oTnvpy2Z43uQrbn65F8sQfCvpsHOcdByFr2F9G3lB39uVlA7OfOv5iL0bwRwVfq
         YTTgYWPVApdUTu3XoW2nGATAhWdVzSTq61Bg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4usFl7sIsVthQj7CAaTLNOirYn+9w5CcbbsPb6gzTZs=;
        b=KtS5ShpFBFEBPU/f/1hxR5P4IFq7IbYZ5ZJmDVN5txa8FybPZHyRxpxW2APqFGLKBU
         uk9gldiDlWVZSGBjMXWy0zmHtviwfJ6FWZonnJ7bgBeGTObrR23Jaw15nTZfJ1rrN2OS
         xTJ8bTAXStIkSZnIO2b6XpboWxlaSJyTAtLMJzAKeNKTReo8ACPQiLjZ0ubWJan2FBct
         tqYfnj1E+Vgu+s2dqgUfkYqSWQdI4R5PbAKBDfekXIJWVgvMY1V9WDe4lGfVkuCxvZKn
         KyD5lJ7WvdjDrj2rghGZsyN9ZAJnWKDKrAg9wb+xXda7ZVIU4CElhBmgxwp9utHgyqeA
         8HDQ==
X-Gm-Message-State: AOAM530flSa5JsRtxfIy2U63q6cfGYTMxHl6PvOqupXyBvrYrBWD6N1X
        snO4nKTcR/a5l0LA8nPqtq33HQ==
X-Google-Smtp-Source: ABdhPJxaSatIHX/sZrfjfZA+xFPKOXe2WFUxGqcRbH4r+NdC1vX/iNz1cah9e+xIGvpANxz9gqGpmQ==
X-Received: by 2002:a17:90a:b28d:: with SMTP id c13mr5823656pjr.80.1623171757403;
        Tue, 08 Jun 2021 10:02:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2sm11476540pfc.126.2021.06.08.10.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:02:36 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:02:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ima: Fix fall-through warning for Clang
Message-ID: <202106081002.252C11321F@keescook>
References: <20210607204934.GA63263@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607204934.GA63263@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 03:49:34PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> fall-through warning by explicitly adding a break statement instead
> of just letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 13 in linux-next(20210607). This is one of those last
>       remaining warnings. :)

Looks right to me; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
>  security/integrity/ima/ima_template_lib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 518fd50ea48a..8f96247b4a5c 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -119,6 +119,7 @@ static void ima_show_template_data_ascii(struct seq_file *m,
>  		default:
>  			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.27.0
> 

-- 
Kees Cook
