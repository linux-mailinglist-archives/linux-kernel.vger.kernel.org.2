Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471AE43DE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhJ1KDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhJ1KDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:03:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9248C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:01:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i13so2832084lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGBiy7a8G7oR5F6DyXz2xyj+Rcnf2xoUsqDj5a5PwIE=;
        b=V0xQFWVEEdsy62NqWxmnYhcAWZXtzA8H3Ae95eo2PyHilcECmYUmOB7M+klZhK3pGl
         3HfRtp4OC7l4y6mIXbhEi1YWVBoOkWqm+8Z5WXVyfGYllUiRK7nvMAhuxtRUIsxwSlgs
         B4Kr2PpN6OD5bnDqgMo6A5kFh2/Ny4OCUIy1K4NmUGx0laoSBFRY1EgWxtTKURHncmhC
         GDr+h+RDbQBPLk5vNQUFWkjWmf4PFJ/YDfgT4s2aZmUMMjDhWG5Qtl/Q2o8EftxNai2G
         7Jigxvnurf0odgfUb7y0CojZzIj2sd7TVxuigzuW6j1KRZDcuZb3tV+nAnYfQc5o+SWe
         14hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGBiy7a8G7oR5F6DyXz2xyj+Rcnf2xoUsqDj5a5PwIE=;
        b=NUoY/6zcE+mBsIsQvqN9b7x6PZpLKlQ7LihmLWB5mfzEzoc89Rlww6o3wDpjh06MT9
         KsPjj+y4KtpQ4rmfdGHGeFG5Stf8Fkh7ABC60JXqvGZIh3hlqg3bA7fIxHrc4uZKk5AA
         iNT9/RSgKHovi36j2gJR9GxUpqB1BMN8Un7iXLNgjaKvzTFmHUKHQYe6/fPGsSPKqb9N
         GsLq0ObD+fGQhtJnvdYmZHuE8bUI1w08c53psywBTQW6IDiU+GHF2gVoqMNAsJiW7weJ
         ZWeIs82uLx1lOqC1oWZWLxieg9Uv3TjYKal6J2e19vvaFiAaMzvq3goVsz2AEELkbUFR
         lvGA==
X-Gm-Message-State: AOAM532eaHI5I8Oaxj6K7kz5jGm+sSlddyNjZXzRQNv7MvYZxoDEFqoR
        /oliu3CJMW580PpafdRCFM8Y/3e/7PbDBsxrJzARdQ==
X-Google-Smtp-Source: ABdhPJythDnG9fEkitz3W/LsxTx1pEvwh8OLMZ19ogSESq1/MSLxciKhd1VL/h6p/gJ7lf23WF0EC7ai0Krz4swFAZ4=
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr3329177lfm.184.1635415260225;
 Thu, 28 Oct 2021 03:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211027230505.GA23994@hexapodia.org>
In-Reply-To: <20211027230505.GA23994@hexapodia.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Oct 2021 12:00:23 +0200
Message-ID: <CAPDyKFpG66uzG7RmzXKf44_RAZyUWG3T2Qgk12cWY_iw4cvCPg@mail.gmail.com>
Subject: Re: [PATCH] docs: mmc: update maintainer name and URL
To:     Andy Isaacson <adi@hexapodia.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 at 01:05, Andy Isaacson <adi@hexapodia.org> wrote:
>
> The mmc-utils repo is no longer in /cjb/ and Ulf has taken over
> maintenance.
>
> Signed-off-by: Andy Isaacson <adi@hexapodia.org>

Thanks for updating this, I have completely forgotten about it.

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>  Documentation/driver-api/mmc/mmc-tools.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/driver-api/mmc/mmc-tools.rst b/Documentation/driver-api/mmc/mmc-tools.rst
> index a231e9644351..eee1c2ccfa8f 100644
> --- a/Documentation/driver-api/mmc/mmc-tools.rst
> +++ b/Documentation/driver-api/mmc/mmc-tools.rst
> @@ -2,10 +2,10 @@
>  MMC tools introduction
>  ======================
>
> -There is one MMC test tools called mmc-utils, which is maintained by Chris Ball,
> +There is one MMC test tools called mmc-utils, which is maintained by Ulf Hansson,
>  you can find it at the below public git repository:
>
> -       https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
> +       https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
>
>  Functions
>  =========
> --
> 2.20.1
>
