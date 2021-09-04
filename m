Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5547A4009DA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 07:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhIDFVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 01:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhIDFVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 01:21:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C29C061575;
        Fri,  3 Sep 2021 22:20:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q3so746740plx.4;
        Fri, 03 Sep 2021 22:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RSMZPjK8zK6zYAuCWMi2oraARmy+KAyVPSb4ElN4gmo=;
        b=iA58VgAKUZukTmCCiG7UrE4s9Px/h30IHUXYDt1OXpbSjNBs2zO41zIgU/p3Y3N8cX
         v1+ybpXdVqckdvANv7LI4gg30RfbE2iDQ4z/Oe027gevr7o8x55Mb5tpDYmsILzYwsBk
         nCC8bBay1wTY44jz5lBVZ5mBt4/iLN02jI5H+KoAf4aY/LchUMOpvmJZuT43iFxDO2cL
         YBGjvL68+yEpwuiLLsknk5VQJYnmvnAEm8/XHSjqAzprVxGdAN2WbXAlzQ7qe8vEvyCQ
         n7eVSTSrTk40W4VpLHaMUsPK9ZgxLWxytu7mvD/e1bl6uKu6DZGsVtDbCWFOILclxTLK
         K8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RSMZPjK8zK6zYAuCWMi2oraARmy+KAyVPSb4ElN4gmo=;
        b=e+WC62zffkt4Jv4aadDwn51lMdH9P7YBY7SZZpSxmWs7TbO4jvbVwZZv6y4xpxxuwk
         mg5Du5kthWjOCthsCEN292MKRYwnWwhjBoZgVqEnLGPtvgVwLKKrqCjZ+3HDzPjdag0B
         YzPnDWKRAa2TgzSlQOlq/T7T/W7yO6tOgHnxGFjZfINImU3EfD7sT/db9LHpBySRRIFC
         C7Jo0+K2+P1/bw1UvaF56zgpDlo+KWZbzmKcD1pyICmcTJx93btMEPK4+n8o4KQfHfco
         aSYk7sOA/ABJiHEhGp/tLHIKoSSZkYW5oKFKJshQrowcWCfIlcnRsTxWdeDtzalscsKY
         Sygg==
X-Gm-Message-State: AOAM531eRR8Q/kPJD322GnIIeZ6jNw7Kjmq8M/5jQCXs/V2HnyeFqkMn
        EEGaUF+a6eHBlMbFXGT3w1l21hU6ah8=
X-Google-Smtp-Source: ABdhPJx4qkE5Lij6CmU95GvezGlyV3U/7Nu2ZMNOIZYhqJzFbYOtFfROVZKkEK/sgy5WRnB7vSGP6w==
X-Received: by 2002:a17:90b:902:: with SMTP id bo2mr2544531pjb.20.1630732820555;
        Fri, 03 Sep 2021 22:20:20 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id qe17sm840389pjb.39.2021.09.03.22.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 22:20:20 -0700 (PDT)
Subject: Re: [PATCH] docs: pdfdocs: Fix typo in CJK-language specific font
 settings
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ad7615a5-f8fa-2bc3-de6b-7ed49d458964@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <bb148975-2839-7ad7-8bd0-b3b844820c9a@gmail.com>
Date:   Sat, 4 Sep 2021 14:20:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ad7615a5-f8fa-2bc3-de6b-7ed49d458964@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon, [most CCs dropped]

Just a reminder in case you have missed this fix.

On Sun, 29 Aug 2021 11:06:16 +0900, Akira Yokosawa wrote:
> There were typos in the fallback definitions of dummy LaTeX macros
> for systems without CJK fonts.
> They cause build errors in "make pdfdocs" on such systems.
> Fix them.
> 
> Fixes: e291ff6f5a03 ("docs: pdfdocs: Add CJK-language-specific font settings")
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
> Hi Jon,
> 
> I thought I had tested the v4 patch on a container image
> without any CJK fonts, but apparently I had not.
> 
> These typos affect "make pdfdocs" of all the English documents
> as well.
> So, if this doesn't make the initial pull request for v5.15,
> please consider sending it as an urgent pull request during
> -rc stages of v5.15.

I think this regression fix should go to v5.15.
What do you think?

        Thanks, Akira

> 
> Apologies for the lack of test on my side. 
> 
>         Thanks, Akira
> --
>  Documentation/conf.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 75650f6443af..948a97d6387d 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -463,8 +463,8 @@ latex_elements['preamble']  += '''
>  	\\newcommand{\\kerneldocEndTC}{}
>  	\\newcommand{\\kerneldocBeginKR}{}
>  	\\newcommand{\\kerneldocEndKR}{}
> -	\\newcommand{\\kerneldocBeginSC}{}
> -	\\newcommand{\\kerneldocEndKR}{}
> +	\\newcommand{\\kerneldocBeginJP}{}
> +	\\newcommand{\\kerneldocEndJP}{}
>      }
>  '''
>  
> 
