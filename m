Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D87E399941
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 06:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFCEnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 00:43:22 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:39684 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFCEnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 00:43:16 -0400
Received: by mail-pl1-f169.google.com with SMTP id q16so2243476pls.6;
        Wed, 02 Jun 2021 21:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xnrr2w6iocDmMx7+v3CvqnKF/FYjeeIOjuctS7i/Pvk=;
        b=Z/klsuCIkcvnFhXm67qeLH9LYlnM9y4AQLXm1ctuXb5oiY5NhU2B3VCuXQsqQqgJ4M
         SCn+k4nvGyiFG1So/YaJ1Pvij2uSI+wnrjjFZWb6ix15qCR5pgRHibV4rjjjuaARpUSf
         blsf+XX2flelnQeaDLYNzZwL3wsZ9ynpREI62v6t6ACaa82g//Un15Itxo+2IVXm9XM2
         VNRWegu+kxezO1AGpciDw09eFphOhIoxwz0q7vn0uTGd3ZDA64tF5xGm5xYnUuPAO3fh
         AU0/z7our6T1Ugoy6gEW3R2wq2659gkaNGvsTXKHHBUGsVICDU1/p+S8YW0iJ6osSIPm
         mhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xnrr2w6iocDmMx7+v3CvqnKF/FYjeeIOjuctS7i/Pvk=;
        b=HMbyDwflonXZvZeP80gNF7i+A50JqOOFQlqL4i6C5yRxBpmp/TGrDulhczzsBHrFgF
         FD/5xNCMo/sTFn2ytHK6z0Fo7bHUllKorKEPgkJDqGUYPw2wa1IAfHteVgw5CvYc2Uup
         n3dh8BBpSDsrEWAI4iRBbHsEYCeOPH/mdxc6PYys+DWTN1TPFvRVVZHywqup1v2cbvau
         kcWTHFmn6tbE/4xHWb83w6h7B1fJyZwZFIh934YVCdRzejAk9wUGsIX+PdxLyu0LcFVJ
         Jek5H6fklw87w5BS33MBtn7L7l3cR4gxeHIygjawJWBO23Zl1chE0jRkrdy6t9VO+HTo
         bjbg==
X-Gm-Message-State: AOAM530v+VN4ctAhNaWKuFUa3kKeiSlQ+S0G3SVQZjTehIhuE6YalYAe
        fEtuIheb8AwPhFPvmUkf4cI=
X-Google-Smtp-Source: ABdhPJz/aCAZKYQNPD03WCFx0yF91euUFLrJihtUmKLW7W/8aNPO77fCoGNf30KEguCE8Sl+BQu7gA==
X-Received: by 2002:a17:90b:1283:: with SMTP id fw3mr30116462pjb.133.1622695232178;
        Wed, 02 Jun 2021 21:40:32 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:fc6a:97ca:f00c:8377])
        by smtp.gmail.com with ESMTPSA id bv3sm894880pjb.1.2021.06.02.21.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 21:40:31 -0700 (PDT)
Date:   Wed, 2 Jun 2021 21:40:28 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: networking: Replace strncpy() with strscpy()
Message-ID: <YLhdPEFO2zdzWef+@google.com>
References: <20210602202914.4079123-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602202914.4079123-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:29:14PM -0700, Kees Cook wrote:
> Replace example code's use of strncpy() with strscpy() functions. Using
> strncpy() is considered deprecated:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/input/joydev/joystick-api.rst | 2 +-

FWIW:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>  Documentation/networking/packet_mmap.rst    | 2 +-
>  Documentation/networking/tuntap.rst         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/input/joydev/joystick-api.rst b/Documentation/input/joydev/joystick-api.rst
> index af5934c10c1c..5db6dc6fe1c5 100644
> --- a/Documentation/input/joydev/joystick-api.rst
> +++ b/Documentation/input/joydev/joystick-api.rst
> @@ -263,7 +263,7 @@ possible overrun should the name be too long::
>  
>  	char name[128];
>  	if (ioctl(fd, JSIOCGNAME(sizeof(name)), name) < 0)
> -		strncpy(name, "Unknown", sizeof(name));
> +		strscpy(name, "Unknown", sizeof(name));
>  	printf("Name: %s\n", name);
>  
>  
> diff --git a/Documentation/networking/packet_mmap.rst b/Documentation/networking/packet_mmap.rst
> index 500ef60b1b82..c5da1a5d93de 100644
> --- a/Documentation/networking/packet_mmap.rst
> +++ b/Documentation/networking/packet_mmap.rst
> @@ -153,7 +153,7 @@ As capture, each frame contains two parts::
>      struct ifreq s_ifr;
>      ...
>  
> -    strncpy (s_ifr.ifr_name, "eth0", sizeof(s_ifr.ifr_name));
> +    strscpy_pad (s_ifr.ifr_name, "eth0", sizeof(s_ifr.ifr_name));
>  
>      /* get interface index of eth0 */
>      ioctl(this->socket, SIOCGIFINDEX, &s_ifr);
> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
> index a59d1dd6fdcc..4d7087f727be 100644
> --- a/Documentation/networking/tuntap.rst
> +++ b/Documentation/networking/tuntap.rst
> @@ -107,7 +107,7 @@ Note that the character pointer becomes overwritten with the real device name
>         */
>        ifr.ifr_flags = IFF_TUN;
>        if( *dev )
> -	 strncpy(ifr.ifr_name, dev, IFNAMSIZ);
> +	 strscpy_pad(ifr.ifr_name, dev, IFNAMSIZ);
>  
>        if( (err = ioctl(fd, TUNSETIFF, (void *) &ifr)) < 0 ){
>  	 close(fd);
> -- 
> 2.25.1
> 

Thanks.

-- 
Dmitry
