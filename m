Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16873FA3EB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 07:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhH1F73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 01:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhH1F72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 01:59:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDBC0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 22:58:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g184so8013789pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 22:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R3mb2rhS2u7S3omh2zJdH1TEvW5cGjzt05hjTIDMHQ4=;
        b=RVsH2KLdLXQcpR2li5c2qSRrl37F8W3U0bhcLBVW/RO5gngXQ4sJUiLsVULF42xzaO
         BFTITyKD+iXSsf3jG3l+xxv6h/a5bujb9EnLriwo4vb0MHTSvo7JAYfnwqEwWMsulhJA
         rAymlBAtmK+JrYrPbwOkPBeGaZb+3gQI6Ui7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3mb2rhS2u7S3omh2zJdH1TEvW5cGjzt05hjTIDMHQ4=;
        b=KRGhJ2uLfunE1Vx0/jNPA0sqZV4iOfQXwSutDHbgcGA0or4VOM9JyBbd2ILuVVVLEg
         WpjojJ5VYRyQJ3QQPNO4IKq8bV2zaiuFE7D0JMpogwZLp3uGJ5hN8Cmluph+Bg1EPm5V
         Gk+SGgCq5tkNLjl3MxSp8GAlzG1fh9Qf0Gy4DW+CQQMxe9SwYJl8Gr3yow1mFt3CYqWw
         C2gVqU+6NQc2vjsUKk0GWcknNReNDQevXJenrlqtOuGBTZC1JtfvPAI/BmKbYSRwDnrX
         YwS6wl442iPp7ckQQDNJI7wAW3eJHFfabHa/Iw/bOQtTUFuw4CiKpMf4hAVpGk/O8wzN
         To4Q==
X-Gm-Message-State: AOAM533YMzqYkwXzWr3fzLT1oEw9RUkUClJqhQC+jffw4t9/ivLwtInZ
        TLiIG7ggmj72+dy85ORqOGHQ0w==
X-Google-Smtp-Source: ABdhPJy3fH8qpUID13Aan+Rrc1+kibcu1N+rmIx0QpCgZcHQ+UC+bjvDgoRjFp6Kng4ySbbLH11obw==
X-Received: by 2002:a63:d14c:: with SMTP id c12mr10917973pgj.412.1630130318435;
        Fri, 27 Aug 2021 22:58:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 31sm8517828pgy.26.2021.08.27.22.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 22:58:37 -0700 (PDT)
Date:   Fri, 27 Aug 2021 22:58:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: fix invalid assignment warning
Message-ID: <202108272257.7396C4D146@keescook>
References: <20210828042949.2276341-1-aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828042949.2276341-1-aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 09:59:49AM +0530, Aakash Hemadri wrote:
> p80211_hdr->frame_control is u16, change to __le16
> to satisfy sparse warning:
> 
> wlan-ng/prism2sta.c:253:43: warning: invalid assignment: |=
> wlan-ng/prism2sta.c:253:43:    left side has type unsigned short
> wlan-ng/prism2sta.c:253:43:    right side has type restricted __le16
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>

Whoops; thanks for catching that.

Fixes: 6277fbfdd29c ("staging: wlan-ng: Remove pointless a3/a4 union")
Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/staging/wlan-ng/p80211hdr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211hdr.h b/drivers/staging/wlan-ng/p80211hdr.h
> index dd1fb99bf340..5871a55e4a61 100644
> --- a/drivers/staging/wlan-ng/p80211hdr.h
> +++ b/drivers/staging/wlan-ng/p80211hdr.h
> @@ -149,7 +149,7 @@
>  /* Generic 802.11 Header types */
>  
>  struct p80211_hdr {
> -	u16	frame_control;
> +	__le16	frame_control;
>  	u16	duration_id;
>  	u8	address1[ETH_ALEN];
>  	u8	address2[ETH_ALEN];
> 
> base-commit: f6bc526accf861728d36b12fbc25ac94cd057fc9
> -- 
> 2.32.0
> 

-- 
Kees Cook
