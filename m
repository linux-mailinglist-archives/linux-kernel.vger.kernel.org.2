Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB745F039
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353676AbhKZPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbhKZO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:58:25 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841EC0619F2;
        Fri, 26 Nov 2021 06:33:43 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n85so9117104pfd.10;
        Fri, 26 Nov 2021 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YX75Xm+1AS7y1jBvySQK8BxyX1jnK7N8WeJaX2rpj0o=;
        b=qJMJY5rkDlRLMAZAM35ZfZdQhahnF6C94D2/N8SgjoCYWxZpJ0IN0VBKJomH0SCJ02
         SLYd9zl6zA3jRwyucOp7PLb029i3QiwZxgnFQaQCeubnEZuICwpLMZ4qRS0O+/MdPoeH
         awo127bqomqxUy46GKjSPd2nHZdilYQtQPXaHhJs/D7B+ONY9qOMJZ+aYSXfR350jMJs
         RIdFyCqjv5D1HcLKgEz3ieQXY3LL32IgDVxDvVdzprt+Zfi8vfkIgrL40TEgBNboU3tg
         Sl8YK94w5KYDKfjYdAI0MsEZRM+qZHzW+LvclwDKnzaeObFPL1XmfM9VYE5YZnxhmTdv
         sDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YX75Xm+1AS7y1jBvySQK8BxyX1jnK7N8WeJaX2rpj0o=;
        b=3Ssp7BadPL5D044TUUJqAM6yQ/AsZSnVmHBtG3cypsLVyNuDfH5n/8an3WtYXq83tg
         1FXYP3umneyAWZTWpN74ywPkzAotlWmRV8s0VQTSRJxOsw2siaOFl0v6y/IIJLTSjIyW
         laU5axBr5/gVtwFksgvktg4cBEMo0TmpUlijbS7RrtDbRK/KA60fQ969uzjp0S0UddKe
         LCsMeOShK8Lx3z+Jv2nZClP5xtoWPtpORMCcrev7s3pC1nLNSpoNdhwkqBDYt5KJResO
         gCaSGH8bMKCYDSj6dSA6CrgLdELMwJ+KJ/kVY5+W+6M6GGJ3eeHRSKkzlrbNiUdRhh6m
         DZXg==
X-Gm-Message-State: AOAM5302zmgb2gXYFtxrQ0mnx+HaB/EF3YVgKP53F7U6brBU0x+LVOhY
        b/O0hUeXOY0FUEfbqU5tC8w=
X-Google-Smtp-Source: ABdhPJzuoh1S6Am/7fW3VVWnDqsXEBLM46Q1V78Q/NyQv9iX+xsyxxVet3kyEMlWf5kErzz9un9mGA==
X-Received: by 2002:a63:f94c:: with SMTP id q12mr7763826pgk.617.1637937223381;
        Fri, 26 Nov 2021 06:33:43 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ne22sm5806373pjb.18.2021.11.26.06.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 06:33:42 -0800 (PST)
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <13c40ed9-a51f-7496-7224-03b563bb6695@gmail.com>
Date:   Fri, 26 Nov 2021 23:33:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

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

So I have an issue with this simple change.
As I said to Jon in another thread [1], in which Jon didn't show any
interest, this update changes the look of generated HTML pages
(I should say) rather drastically, and it looks quite distracting
for my eyes.  The style might be acceptable for API documentations,
but kernel-doc has abundant natural language contents.

[1]: https://lkml.kernel.org/r/550fe790-b18d-f882-4c70-477b596facc7@gmail.com

I think there should be some knobs for customizing the styles.
But I don't know much about css.

Can anybody restore the current look of kernel-doc HTML pages
in a sphinx-rtd-theme-1.0.0-compatible way?

Sidenote:

The change (html_css_files) actually works with
   - Sphinx 1.7.9 + sphinx-rtd-theme 1.0.0

This contradicts the Sphinx documentation saying that html_css_files
was new to Sphinx 1.8.  This might be related to the changes in
sphinx-rtd-theme side, but I have no evidence.

Any suggestion is welcome!

Regards, Akira

