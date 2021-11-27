Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0545FE73
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 13:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354463AbhK0MSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 07:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354079AbhK0MQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 07:16:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9619C06174A;
        Sat, 27 Nov 2021 04:13:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g18so11497618pfk.5;
        Sat, 27 Nov 2021 04:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CYTss4uDcyydBSo43mqDgnezuE5sTvAFFevF63UoL6c=;
        b=G2llcNJS6DP6phoIe1aneOPGnpAo4J7N10bpsbolRTn2ePBkVmAm5i/ozxxXiliYCj
         5Pa4W8PP+F/ITf7GTmowZxztefT1N7EvHEQBMjuytc1LoevSmRYk8t/7CxkFdYrClRo6
         8n0vN2xkNlM1XpPl//dSamW4SrmR+C1/cSnVUhBw9So1phiZUTI7Zsmr9PVstHSDCRFj
         rigg1TF1toWq6uuX69Ys5dLkL6sc2iUCxbhmcUvPLxwKcCE/TTXghblfyC9mFmw9sKqX
         TQCFxxP6bbBGUUoFfgaNDfoMX4mi9PTiq9FXtY0Z8ZE3cDxy2NqBNXru71llfXjzD7F9
         J3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CYTss4uDcyydBSo43mqDgnezuE5sTvAFFevF63UoL6c=;
        b=zrC9Gn2aaJMJ4UeM+yIQtWNHdhgAgDk5DwGiG9rTy51bRsqC4cwWEtHnYAYhSa3JTO
         032bBnWZSDwN+CrBpR8lTmhvhLig2GMcaqREuBibZXwuF2mlg5zMfqdap9wwvo7jDpC5
         gyRpRZQM8ZKGpCFOkJwh8+rfujZzXX1Ouq9MQ1FcC9zG6igpL9wW1KBmFOKteZnX8Mei
         HTiWsfmz8PUa+dnC7aGSgrGtcFTXBS1jMBIZTxIK15l9KApUe5suvTmY5bdVZyTWLGBO
         6z+kGZVoyqSJ4nBj7AwfcpBINpyCqB9Ofi27xKSv1/4ACAbHFeHrceHmZYw3kjWrWaJz
         BnyQ==
X-Gm-Message-State: AOAM530fc3jje6rR8Jm32OxqcT5kIg3mLxN1GNNjR+SXHiN+9shYPb3N
        IboLGrQgQrzWzJ8C1ZEK4lGwu149FJc=
X-Google-Smtp-Source: ABdhPJwPO4pWvWX6ZjdDIEcADyEN3Zh6EmLSxj6RMzEMA/0pyEeWH/8lkoLs5+4XnUPQviEPx2gCDg==
X-Received: by 2002:a63:b515:: with SMTP id y21mr11781563pge.615.1638015202534;
        Sat, 27 Nov 2021 04:13:22 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id mh1sm9182847pjb.6.2021.11.27.04.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 04:13:22 -0800 (PST)
Subject: Re: [PATCH v2 1/1] docs: conf.py: fix support for Readthedocs v 1.0.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <cover.1638004294.git.mchehab+huawei@kernel.org>
 <80009f0d17ea0840d81e7e16fff6e7677919fdfc.1638004294.git.mchehab+huawei@kernel.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <1d057059-d44d-a439-91b3-2a497015a8e8@gmail.com>
Date:   Sat, 27 Nov 2021 21:13:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <80009f0d17ea0840d81e7e16fff6e7677919fdfc.1638004294.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2021 10:14:49 +0100, Mauro Carvalho Chehab wrote:
> As described at:
> 	https://stackoverflow.com/questions/23211695/modifying-content-width-of-the-sphinx-theme-read-the-docs
> 
> since Sphinx 1.8, the standard way to setup a custom theme is
> to use html_css_files. While using html_context is OK with RTD
> 0.5.2, it doesn't work with 1.0.0, causing the theme to not load,
> producing a very weird html.
> 
> Tested with:
> 	- Sphinx 1.7.9 + sphinx-rtd-theme 0.5.2
> 	- Sphinx 2.4.4 + sphinx-rtd-theme 0.5.2
> 	- Sphinx 2.4.4 + sphinx-rtd-theme 1.0.0
> 	- Sphinx 4.3.0 + sphinx-rtd-theme 1.0.0
> 
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> Tested-by: Hans Verkuil <hverkuil@xs4all.nl>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH v2 0/1] at: https://lore.kernel.org/all/cover.1638004294.git.mchehab+huawei@kernel.org/

Hi Mauro,

Good to see the nice looking HTML pages as before!

Tested-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

> 
>  Documentation/conf.py | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 17f7cee56987..76e5eb5cb62b 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -249,11 +249,16 @@ except ImportError:
>  
>  html_static_path = ['sphinx-static']
>  
> -html_context = {
> -    'css_files': [
> -        '_static/theme_overrides.css',
> -    ],
> -}
> +html_css_files = [
> +    'theme_overrides.css',
> +]
> +
> +if major <= 1 and minor < 8:
> +    html_context = {
> +        'css_files': [
> +            '_static/theme_overrides.css',
> +        ],
> +    }
>  
>  # Add any extra paths that contain custom files (such as robots.txt or
>  # .htaccess) here, relative to this directory. These files are copied
> 
