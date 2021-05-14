Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3134B380A70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhENNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhENNhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:37:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 833E66144C;
        Fri, 14 May 2021 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620999388;
        bh=SVrdacbDqwyIT1cfNRvEYHJGC8wvLyRFcGyMUtYAo50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vsbOqCM/DMDtOpfQviaa3o8jBt7/qilVgeSYuKUA5NtcmJxLEAWl+U6RRnIrm3wGn
         YVbB/O9BrL5vIl72TRQZNsCnFncaTDakypdUSd85yljA8EZ6GMWFvZbdmT05XWhy4H
         ms+5UBEhL5pRIqn8ks3f+DTtXLrOOdH+2GiWrdwI=
Date:   Fri, 14 May 2021 15:36:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Message-ID: <YJ582f3O9K9YD3QA@kroah.com>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:00:39PM +0530, Shreyansh Chouhan wrote:
> The gb_loopback_stats_attrs macro, (defined in loopback.c,) is a
> multiline macro whose statements were not enclosed in a do while
> loop.
> 
> This patch adds a do while loop around the statements of the said
> macro.
> 
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> ---
>  drivers/staging/greybus/loopback.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index 2471448ba42a..c88ef3e894fa 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
>  }									\
>  static DEVICE_ATTR_RO(name##_avg)
>  
> -#define gb_loopback_stats_attrs(field)				\
> -	gb_loopback_ro_stats_attr(field, min, u);		\
> -	gb_loopback_ro_stats_attr(field, max, u);		\
> -	gb_loopback_ro_avg_attr(field)
> +#define gb_loopback_stats_attrs(field)					\
> +	do {								\
> +		gb_loopback_ro_stats_attr(field, min, u);		\
> +		gb_loopback_ro_stats_attr(field, max, u);		\
> +		gb_loopback_ro_avg_attr(field);				\
> +	} while (0)
>  
>  #define gb_loopback_attr(field, type)					\
>  static ssize_t field##_show(struct device *dev,				\
> -- 
> 2.31.1
> 
> 

Did you test build this change?
