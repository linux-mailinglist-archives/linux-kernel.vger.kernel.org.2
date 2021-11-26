Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4CB45EED0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbhKZNM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:12:29 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:52536 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbhKZNKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:10:23 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 63C61340;
        Fri, 26 Nov 2021 14:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1637932029;
        bh=l4FMeCVerc2PEX9cpgk4Euxcw3uzZpp4U3PzawrM6Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbQEzhZTFd0YMHIQj5HTWMo0/AV1KrfjQBfLO4L1Ysgg1WM308Ar6ulu2wWFMVRHe
         0g+qWcw5NPtnOTTvG9cDoFCI8kpj/vZm8bXX+EcA8KSpo/cXpdbz8qR5LpFNDjGPZP
         ICyxtBWx5uPBXaHwB0UAY4Q7IzwisIJfl9/fCpa8=
Date:   Fri, 26 Nov 2021 15:06:46 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
Message-ID: <YaDb5nMm88NwDOiF@pendragon.ideasonboard.com>
References: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Thank you for the patch.

On Fri, Nov 26, 2021 at 11:50:53AM +0100, Mauro Carvalho Chehab wrote:
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

No need for parentheses.

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

You could also write

html_css_files = [
    '_static/theme_overrides.css',
]

if major <= 1 and minor < 8:
    html_context = {
        'css_files': html_css_files,
    }

which would be slightly easier to drop when support for sphinx 1.7
(which is the minimum required version) is removed.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  # Add any extra paths that contain custom files (such as robots.txt or
>  # .htaccess) here, relative to this directory. These files are copied

-- 
Regards,

Laurent Pinchart
