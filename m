Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9933638F38A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhEXTRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhEXTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:17:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17203C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:15:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b7so10964131plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Zyh8yQ2ZCiVsG1nA0x7435ZL3dg8aG3PAXeH5YI36I=;
        b=GSzSDKNLDGdqSnLjfHG7OyE6uBpBfcLuvt7YYM1FFZdXJkX7ULe2HRTOp0yPU29/tH
         i81bvNd/keuW41+SU0o4y2yltaaFwBgm3ag7ukuF7QUsgpj7523+qwsngu6NWREwdOVG
         ONfa+aWX5HaOPkugY/vjSER3ZdnZzmTVREgZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Zyh8yQ2ZCiVsG1nA0x7435ZL3dg8aG3PAXeH5YI36I=;
        b=gmDqxa2vTTUvEH20sDrx+I4UOyyOVhtDtVoI2ozJ/DmRJlDrR1f3G1JYR4Fk7aNr57
         0fPvTkPiYhhx6/waP15gSU7/2JeKtrKcj0xd70N8mV8lovRwQNLHciroSaHyRP+3vKHJ
         iwhPLeebBgFavv2rlSYLoDBqYtUW95DUqA/mQQpt3Ypa8OnToJLgcmoJpOmo0+eKEJWY
         gQVIl0jHzkNJ3HmXQmSI/a4at3H0IgFJajU/uY62tKUCAV3icmo+SxpH6MET5z/1FW6f
         RBVPu+0WDBWM5Y49xXfO7psMxacr/yMXbWtq672h8c5mwfahkKyPnIZ6JPpQZjmA3WJ/
         obsw==
X-Gm-Message-State: AOAM533g8dnB44AnZQl0wrkqGBmyzZZoN6sP5AqhkArwaH1dQVCe6TB4
        9DXTN+idGmxjMRl9UgPtNkSYSA==
X-Google-Smtp-Source: ABdhPJyThkgDdEpF80rem31oF7eOnsOh76H58864VAhj6tOvZMt9aZhv8zEpt/avIXnP1b1JorY3kg==
X-Received: by 2002:a17:90a:2a4e:: with SMTP id d14mr628056pjg.219.1621883744489;
        Mon, 24 May 2021 12:15:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2sm191906pji.28.2021.05.24.12.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 12:15:43 -0700 (PDT)
Date:   Mon, 24 May 2021 12:15:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     masahiroy@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: Re: [PATCH] init: Remove leading spaces in Kconfig
Message-ID: <202105241215.85B9E20@keescook>
References: <20210517095848.82033-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517095848.82033-1-juergh@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:58:48AM +0200, Juerg Haefliger wrote:
> Remove leading spaces before tabs in Kconfig file(s) by running the
> following command:
> 
>   $ find init -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

I'm impressed this is the only one! :) (And it's been there a long
time.)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 1ea12c64e4c9..9f1cde503739 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2149,7 +2149,7 @@ config MODULE_SRCVERSION_ALL
>  	help
>  	  Modules which contain a MODULE_VERSION get an extra "srcversion"
>  	  field inserted into their modinfo section, which contains a
> -    	  sum of the source files which made it.  This helps maintainers
> +	  sum of the source files which made it.  This helps maintainers
>  	  see exactly which source was used to build a module (since
>  	  others sometimes change the module source without updating
>  	  the version).  With this option, such a "srcversion" field
> -- 
> 2.27.0
> 

-- 
Kees Cook
