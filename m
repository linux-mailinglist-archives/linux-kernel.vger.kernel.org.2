Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71201325F44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBZIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhBZIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:37:53 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCCCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:37:12 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k12so673834ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSZBqZAXKahwfjTFGR80Ph8JTZn6RkUpzBNuGwlAGdI=;
        b=gfVIEn0beAIzxTVbSLHOYYvkrceeXVeuGg7fF498f0/AzHxE28/Ozur2NMncMjnPGQ
         oxvslqVUlxCf1d0tn29rQYQ92y7Dwu46eErFrnLly48vf3KhFy4v1UIvWfDEmRxsbmgB
         Zw5rjDOj6XKB5MYum4ES7bZK4643V0faI8kB3PNMowmZ4z/UiUBcuwBaGDYD3B2GE1bH
         dzEBfGqkwK3LOMiEcYbF3ebaR3obGrSiVe6JNyHQsXR7BjbUvvxsOdO+6MHMEieyUKJf
         mDtUmUWegsz4po7HIZvChnujfU8FdigZGmQqsiAeeTrWz6vjV73ri18uvJF9P/aZiYwi
         0Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSZBqZAXKahwfjTFGR80Ph8JTZn6RkUpzBNuGwlAGdI=;
        b=bC5QyvuqFiW9to2ZySkxl22nsp5KSeloQ1F2u5jiOVHZmmH9oV3Y9R/KZcYaUn7ktT
         SJMlhVKQHzAYjJF2JebNEds3FuQ0Y8SlC6kHZF/Kc+vhMCLD34GDFXC5p7exCRjr1seD
         gpPbXJO01knayriDes5gCJfeX+/yANjW5AUaD/lwOmZrjII8H3OOsP8XWfiuttdhW68Z
         sTaXCzU3zVrRjgQW5FXiPL5nU/fWJp5fncsB4NVqzBighxUlH1Ei3/zwKlF3d+94EgP3
         XcQu0rCZpGNV36oJ1wLTacxSAUs5h2yrH2cUTcDUPG2l8XuwOI1i079k/MQS8qYCJ8pY
         kL/w==
X-Gm-Message-State: AOAM532ijy5+rbXa+BL1YzEzBu017bNLmzcC7duoVCXjcofjiHKNBUG9
        vrZrpn3wNKHl8b02nPWly3/xMG7KaR1NGYyhreEgsg191e3Nuw==
X-Google-Smtp-Source: ABdhPJwq5DG6Je3O4p6W7g8qgiWIQD4z9T1oUesfkIf9Sl8aSAeRZk6isjff68ct9wosc259MA1cNg5OImBP3W2znfA=
X-Received: by 2002:a2e:b814:: with SMTP id u20mr1091741ljo.370.1614328631073;
 Fri, 26 Feb 2021 00:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20210226064029.1143-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210226064029.1143-1-lukas.bulwahn@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 26 Feb 2021 14:07:11 +0530
Message-ID: <CABJPP5CZMecYBy3026JwTTW1d5zGp84xS0XiFFoarMVwUGDdDQ@mail.gmail.com>
Subject: Re: [PATCH for Dwaipayan] MAINTAINERS: clarify responsibility for
 checkpatch documentation
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:10 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> As discussed, Dwaipayan and Lukas take the responsibility for maintaining
> the checkpatch documentation that is currently being built up.
>
> To be sure that the checkpatch maintainers and the corresponding
> documentation maintainers can keep the content synchronized, add them as
> reviewers to the counterpart.
>
> Link: https://lore.kernel.org/lkml/bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com/
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210226
>
> Dwaipayan, you probably want to add this patch to your patch series for checkpatch
> documentation.
>
Sure I will add it to my series.

Thanks,
Dwaipayan.

> Feel free to add your Signed-off-by tag just following mine.
>
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 16ada1a4b751..6b48b79ba284 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4181,9 +4181,18 @@ X:       drivers/char/tpm/
>  CHECKPATCH
>  M:     Andy Whitcroft <apw@canonical.com>
>  M:     Joe Perches <joe@perches.com>
> +R:     Dwaipayan Ray <dwaipayanray1@gmail.com>
> +R:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
>  S:     Maintained
>  F:     scripts/checkpatch.pl
>
> +CHECKPATCH DOCUMENTATION
> +M:     Dwaipayan Ray <dwaipayanray1@gmail.com>
> +M:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
> +R:     Joe Perches <joe@perches.com>
> +S:     Maintained
> +F:     Documentation/dev-tools/checkpatch.rst
> +
>  CHINESE DOCUMENTATION
>  M:     Harry Wei <harryxiyou@gmail.com>
>  M:     Alex Shi <alex.shi@linux.alibaba.com>
> --
> 2.17.1
>
