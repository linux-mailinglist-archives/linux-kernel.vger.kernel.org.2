Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7245ECDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347412AbhKZLrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376874AbhKZLpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:45:24 -0500
Received: from lb1-smtp-cloud7.xs4all.net (lb1-smtp-cloud7.xs4all.net [IPv6:2001:888:0:108::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E25C035407
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 03:06:08 -0800 (PST)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id qZ3Jmw333CMnAqZ3Mm4QdY; Fri, 26 Nov 2021 12:06:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1637924765; bh=6jqLRaVWxvzfwNzbh9z4cF802Tbb77anMzzoXodYiqU=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=mtqkoDaGDI0CI1M/KEq8tlBKom9LwM8RI0XhycNR9jnQuy2zWeDRQprJhlRM/l5nE
         V6YLlZ3VL7qQ/eZwrGnmy0WEk3MIboyGy5ng2IkI98e1d38EN3eWIvpyH6b5aCMkOa
         LuVgLwbzy/4mEqj7lRYLiC6qykP2LPHO+oU9BxLup7lnBSy5rrA/fDdVbrkf6QAD+W
         OSTDEiZ/0+TQlAb7i2SqIgUlkbq72nNI8+BbdODi+JL1jvFFX/zuqEMDRiF/jWOwte
         rzlrOTv+QDRCEOnQxtp6FAkw9souBjgEezz0A4t3YHekMDqa+PU8v6MIanSkpGGaoE
         pV29OxqCkVaUw==
Subject: Re: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
References: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c3b0fdfa-6cfa-875f-e1d9-938b3f3d77c4@xs4all.nl>
Date:   Fri, 26 Nov 2021 12:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOlZ3D9arNt5xBzCivu0KOlT0txwo2pyVL1ePjBwwYvM8ASduyNV6wDH/e+fVcjKvOzquM4p7aPMDdUnp25M3k+f7LmLFvnxjE8X7eoWBRFKokAmb5mY
 ps+KVUeLvnTCaBpdyg50gCvp8WsN0A2IdhIIeXvWdLOyN6IdHM8E7/S8O6sPOlHUn15fuBJG+36glB+u7BHui4mMlltZhW0j4C0H1PH48B5Jx2ILm5sCZLoQ
 4LBeWGi0zAYrM4WJ76zwfGJzUP4ZBZakmo333mCB5jo+VespNOcQcH7DtvGSJzarzeWjyMZK/+OU60rP3wfH3g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 11:50, Mauro Carvalho Chehab wrote:
> As described at:
> 	https://stackoverflow.com/questions/23211695/modifying-content-width-of-the-sphinx-theme-read-the-docs
> 
> since Sphinx 1.8, the standard way to setup a custom theme is
> to use html_css_files. While using html_context is OK with RTD
> 0.5.2, it doesn't work with 1.0.0, causing the theme to not load,
> producing a very weird html.
> 
> Tested with:
> 	- Sphinx 2.4.4 + sphinx-rtd-theme 0.5.2
> 	- Sphinx 2.4.4 + sphinx-rtd-theme 1.0.0
> 	- Sphinx 4.3.0 + sphinx-rtd-theme 1.0.0
> 
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>

Tested-by: Hans Verkuil <hverkuil@xs4all.nl>

Much appreciated! Looks a lot better now :-)

Regards,

	Hans

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/conf.py | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 17f7cee56987..7bc72be63fd2 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -249,11 +249,16 @@ except ImportError:
>  
>  html_static_path = ['sphinx-static']
>  
> -html_context = {
> -    'css_files': [
> +if major <= 1 and (minor < 8):
> +    html_context = {
> +        'css_files': [
> +            '_static/theme_overrides.css',
> +        ],
> +    }
> +else:
> +    html_css_files = [
>          '_static/theme_overrides.css',
> -    ],
> -}
> +    ]
>  
>  # Add any extra paths that contain custom files (such as robots.txt or
>  # .htaccess) here, relative to this directory. These files are copied
> 

