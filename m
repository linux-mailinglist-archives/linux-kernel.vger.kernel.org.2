Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD440332A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 06:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhIHEOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 00:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhIHEOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 00:14:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9B7C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 21:13:05 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso1216930ott.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 21:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HkIuLVDKn7TgiCzRztoLPo7WO6itaQ7BA8yRHyvqmmo=;
        b=Ur8IPF1yWy22Q0kJ/WFmntzBviiE2zn/rwKijChNN1Wm+xfBYvALfoYlSH/nLo+5Fa
         DZ5M0bNGH1eAOziJCp3RiQ5URJKyfRK34JqRBsLFyRi8xYhsA9QxAoVp8bpyzBMYVluu
         3HGtkrIKzyC+wDzrzJjVWSP6tUIZjFHZo+Bpojuh56NtlRL/zyid3hJQTm1xtJCou7/q
         7WN3rYKpGAeatm3UQACj38hDs+GaEO7wVh5c/t5d5nXWpMpSoWKrRdwxwQw54FH3cfjH
         E+C3kvlmn3N33fUrMrAVBuDK5PWqvfGIGH0xKF7d167ywTtksTyi5w/UpGHGacZuJ1TW
         xZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HkIuLVDKn7TgiCzRztoLPo7WO6itaQ7BA8yRHyvqmmo=;
        b=lxJMok9dlejTfli3T/gZoYL1CXg0jpVcMf7mo8ehBv9ueCqCTe+H3/Ifig6H5syfNh
         RTv/SQ/VlCiGHEzAbRcKH7YlcTpEezo3id9sdG8Se+q4VYxLfVj+SHQpquNpJdZrZ/dg
         l78QStgkrQXuisTJW2d2e2+N6TSxTJnMXtKaQGbK/SfzPtn1mzL821wBepkfqgLk/oZo
         v1vB6IowQKciQwQ6AHPYMmbc5zsY+NJVfooqING3vR/JnoTsyf3ggUoUqR5X2YLNqzF3
         c+qcV1xydEcHDz0Pz4qKF6h1RbCp8E6es4ZWNscmsSHbeSqlPYwoUEX5H9Pl/z7tfDsy
         A0ag==
X-Gm-Message-State: AOAM531d+0MqX5zQ2rV/UqqWhloh3oTphZsPiQyTUutBaeVEe8bTFlgQ
        lRixLgmautVW2t6U8hNolElonNmTO+s=
X-Google-Smtp-Source: ABdhPJxPC/ElUQrxDzILrbmOrghUnICdEMQf0kufEGvSFVx5WCxFtQVy+RXq9o6FxgGv6ItwJ8/iqQ==
X-Received: by 2002:a9d:828:: with SMTP id 37mr1509555oty.0.1631074384551;
        Tue, 07 Sep 2021 21:13:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c75sm209181oob.47.2021.09.07.21.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 21:13:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Sep 2021 21:13:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mvme: Remove overdue #warnings in RTC handling
Message-ID: <20210908041302.GA2585571@roeck-us.net>
References: <20210907124511.2723414-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907124511.2723414-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:45:11PM +0200, Geert Uytterhoeven wrote:
> The warnings were introduced when converting the MVME147 and MVME16x
> RTC handling from gettod to hwclk.  Replace the #warning by a comment,
> and return an error to inform the upper layer that writing to the RTC is
> not yet supported.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/m68k/mvme147/config.c | 4 +++-
>  arch/m68k/mvme16x/config.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
> index e1e90c49a49624cc..dfd6202fd403e92b 100644
> --- a/arch/m68k/mvme147/config.c
> +++ b/arch/m68k/mvme147/config.c
> @@ -171,7 +171,6 @@ static int bcd2int (unsigned char b)
>  
>  int mvme147_hwclk(int op, struct rtc_time *t)
>  {
> -#warning check me!
>  	if (!op) {
>  		m147_rtc->ctrl = RTC_READ;
>  		t->tm_year = bcd2int (m147_rtc->bcd_year);
> @@ -183,6 +182,9 @@ int mvme147_hwclk(int op, struct rtc_time *t)
>  		m147_rtc->ctrl = 0;
>  		if (t->tm_year < 70)
>  			t->tm_year += 100;
> +	} else {
> +		/* FIXME Setting the time is not yet supported */
> +		return -EOPNOTSUPP;
>  	}
>  	return 0;
>  }
> diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
> index b59593c7cfb9dfbf..b4422c2dfbbf4f7c 100644
> --- a/arch/m68k/mvme16x/config.c
> +++ b/arch/m68k/mvme16x/config.c
> @@ -436,7 +436,6 @@ int bcd2int (unsigned char b)
>  
>  int mvme16x_hwclk(int op, struct rtc_time *t)
>  {
> -#warning check me!
>  	if (!op) {
>  		rtc->ctrl = RTC_READ;
>  		t->tm_year = bcd2int (rtc->bcd_year);
> @@ -448,6 +447,9 @@ int mvme16x_hwclk(int op, struct rtc_time *t)
>  		rtc->ctrl = 0;
>  		if (t->tm_year < 70)
>  			t->tm_year += 100;
> +	} else {
> +		/* FIXME Setting the time is not yet supported */
> +		return -EOPNOTSUPP;
>  	}
>  	return 0;
>  }
> -- 
> 2.25.1
> 
