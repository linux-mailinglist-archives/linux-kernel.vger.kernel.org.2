Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13437F3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhEMHqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:46:53 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39682 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhEMHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:44:28 -0400
Received: by mail-ed1-f53.google.com with SMTP id g14so29975245edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 00:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5hWrYJTUVs9h+SvEicdegXC+w97qSVwDUfrT09Zb1Do=;
        b=t6oa6WgIXmXvWJq5ZGjHIXqSGM26Q0dBjCrZilmZRNNtZ7YD5uJ5cC/8/vu+XX3aTF
         xeV/RjZiF0I904RjEx0hmdkrcH1uBorpFNce+ZT5FLGqQFLLBQiCHEXYtOBYEzYL59mB
         X79WQ9i/LunENiS50DkX3vrojAwqZ8HVmvYxZxjqHStDdoUFjrx3ZSZc3aYdOchgwK/4
         hFyWbuivwWW2P7+vrBBo0wR+dRWOt7Z2lxX8ZEFrRhOXSv3TGmFkF6dTqcEH0igQoy7c
         1OwIWIAfTsAZ27kToOZ3ZVGnGd1sP7zoeb0yoagC3uaIobpa+AGXfbQObTC1E0/prngD
         ycJQ==
X-Gm-Message-State: AOAM5300VbMTjnMis349Cvw68nHMKPc9y/I7YmyM+1z5NYUmQgQ7chog
        zvqJOzJvrLYj/1yXdMdelso=
X-Google-Smtp-Source: ABdhPJzR4+lZHj6B6CkTUYhOxoowjrBvgCQt2l3LkOg6gqHte/VZDmZIx0k8F7SHvnznleCu8jUd9g==
X-Received: by 2002:aa7:db94:: with SMTP id u20mr27035398edt.381.1620891797131;
        Thu, 13 May 2021 00:43:17 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i19sm1333111ejd.114.2021.05.13.00.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 00:43:16 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] vt: Move custom isspace() to its own namespace
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
References: <20210510144947.58270-1-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <fc213ba0-c831-bd4a-2bc1-76d4bf46869c@kernel.org>
Date:   Thu, 13 May 2021 09:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210510144947.58270-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 05. 21, 16:49, Andy Shevchenko wrote:
> If by some reason any of the headers will include ctype.h
> we will have a name collision. Avoid this by moving isspace()
> to the dedicate namespace.
> 
> First appearance of the code is in the commit 24a1c2a769cf
> ("Import 1.1.92").
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vt/selection.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index f245a5acf7e9..bcb6bc5731cc 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -33,7 +33,7 @@
>   #include <linux/sched/signal.h>
>   
>   /* Don't take this from <ctype.h>: 011-015 on the screen aren't spaces */
> -#define isspace(c)	((c) == ' ')
> +#define is_space_on_vt(c)	((c) == ' ')
>   
>   /* FIXME: all this needs locking */
>   static struct vc_selection {
> @@ -209,7 +209,7 @@ static int vc_selection_store_chars(struct vc_data *vc, bool unicode)
>   			bp += store_utf8(c, bp);
>   		else
>   			*bp++ = c;
> -		if (!isspace(c))
> +		if (!is_space_on_vt(c))
>   			obp = bp;
>   		if (!((i + 2) % vc->vc_size_row)) {
>   			/* strip trailing blanks from line and add newline,
> @@ -238,9 +238,9 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
>   		new_sel_end = pe;
>   		break;
>   	case TIOCL_SELWORD:	/* word-by-word selection */
> -		spc = isspace(sel_pos(ps, unicode));
> +		spc = is_space_on_vt(sel_pos(ps, unicode));
>   		for (new_sel_start = ps; ; ps -= 2) {
> -			if ((spc && !isspace(sel_pos(ps, unicode))) ||
> +			if ((spc && !is_space_on_vt(sel_pos(ps, unicode))) ||
>   			    (!spc && !inword(sel_pos(ps, unicode))))
>   				break;
>   			new_sel_start = ps;
> @@ -248,9 +248,9 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
>   				break;
>   		}
>   
> -		spc = isspace(sel_pos(pe, unicode));
> +		spc = is_space_on_vt(sel_pos(pe, unicode));
>   		for (new_sel_end = pe; ; pe += 2) {
> -			if ((spc && !isspace(sel_pos(pe, unicode))) ||
> +			if ((spc && !is_space_on_vt(sel_pos(pe, unicode))) ||
>   			    (!spc && !inword(sel_pos(pe, unicode))))
>   				break;
>   			new_sel_end = pe;
> @@ -276,12 +276,12 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
>   	/* select to end of line if on trailing space */
>   	if (new_sel_end > new_sel_start &&
>   		!atedge(new_sel_end, vc->vc_size_row) &&
> -		isspace(sel_pos(new_sel_end, unicode))) {
> +		is_space_on_vt(sel_pos(new_sel_end, unicode))) {
>   		for (pe = new_sel_end + 2; ; pe += 2)
> -			if (!isspace(sel_pos(pe, unicode)) ||
> +			if (!is_space_on_vt(sel_pos(pe, unicode)) ||
>   			    atedge(pe, vc->vc_size_row))
>   				break;
> -		if (isspace(sel_pos(pe, unicode)))
> +		if (is_space_on_vt(sel_pos(pe, unicode)))
>   			new_sel_end = pe;
>   	}
>   	if (vc_sel.start == -1)	/* no current selection */
> 


-- 
js
suse labs
