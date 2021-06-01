Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C3397778
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhFAQHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:06:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88414C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:05:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l2so7453193wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=6hYvV1ZLP+xMrFDhtMUMFiYVGTkJ+UiqIQSVG/EohRE=;
        b=HLjN80P0ak7Jx9CtCQYucHtcNmJ6urFt2HolmpDzUZ2je8iVTeqGx8fQ1TOJrci8bv
         xHosrB8C2ihkl3nQJwyf/Qs+xfI33Eod1BG/RkgRt3CmFQRoYCg6qTNtKzpAdjKOiWmB
         kCfu9Jm3JAyBAi0QkbqJYy0h+f7jR698S8DrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=6hYvV1ZLP+xMrFDhtMUMFiYVGTkJ+UiqIQSVG/EohRE=;
        b=jkvm0hWJRvHDOt9kyUtzhFCVs5yf+YycRObKXkgPm+5R91WpIWtyG+GaufMViZ15z9
         Ks8L6D71AwQA8ctkY88B3+6AwvB9uEX6Ba1a/jjEJGAnGpMRo5wzBXi1yo56JL0NZb/O
         xeDNWZPGqXLI1wCJrMZSNXGNf6aV/LVx00sLJvToz7VnntmTAOOvNw5ONeyxI3LCN0KA
         FeoVvpEviYRMllnT5YK+Ei+2YpQF8+JKhMU1AprnjCd8LfhR+m4y0XoFv5/QMI2WcdKz
         fIlyg1m7vucu+vT10y+zqWP/DINVE3ivsaJ4kSuNo0dAU5keY9V1DVRPkL0J2E1pWYmE
         z4vQ==
X-Gm-Message-State: AOAM530pCMoDu24qc1y+32OOqHMLDBxk+UdC/qzNUaOF9ndqt84MWtuD
        QWEq4s8TkOn8KjDpL66JXiLtwA==
X-Google-Smtp-Source: ABdhPJzq2ewoSxbWvhQouYQM3hTC5PtMTjQisz0uB+MLFo9IL0F9rkkfvAdPT+tbNS77wjgurbim8g==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr28459183wrm.369.1622563516048;
        Tue, 01 Jun 2021 09:05:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d131sm3143120wmd.4.2021.06.01.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:05:15 -0700 (PDT)
Date:   Tue, 1 Jun 2021 18:05:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     lijian_8010a29@163.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: Re: [PATCH] video: fbdev: atyfb: mach64_cursor.c: deleted the
 repeated word
Message-ID: <YLZauT5Awwf3UlOw@phenom.ffwll.local>
Mail-Followup-To: lijian_8010a29@163.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
References: <20210601012747.38884-1-lijian_8010a29@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601012747.38884-1-lijian_8010a29@163.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 09:27:47AM +0800, lijian_8010a29@163.com wrote:
> From: lijian <lijian@yulong.com>
> 
> deleted the repeated word 'be' in the comments.
> 
> Signed-off-by: lijian <lijian@yulong.com>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/video/fbdev/aty/mach64_cursor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/aty/mach64_cursor.c b/drivers/video/fbdev/aty/mach64_cursor.c
> index b06fa6e42e6e..4ad0331a8c57 100644
> --- a/drivers/video/fbdev/aty/mach64_cursor.c
> +++ b/drivers/video/fbdev/aty/mach64_cursor.c
> @@ -46,7 +46,7 @@
>   * The Screen position of the top left corner of the displayed
>   * cursor is specificed by CURS_HORZ_VERT_POSN. Care must be taken
>   * when the cursor hot spot is not the top left corner and the
> - * physical cursor position becomes negative. It will be be displayed
> + * physical cursor position becomes negative. It will be displayed
>   * if either the horizontal or vertical cursor position is negative
>   *
>   * If x becomes negative the cursor manager must adjust the CURS_HORZ_OFFSET
> -- 
> 2.25.1
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
