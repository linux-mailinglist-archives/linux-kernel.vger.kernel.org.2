Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C990D331BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhCIArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCIAr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:47:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF87C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:47:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m9so17490747edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lN3ZnzypLBcXQIQsrg5996DIvMhTqbj3VD67InnBKe0=;
        b=xuPq8c8isCABiU33a6OJHIh/aQgDgXAIV2d8Zwm6DqxH+rh7teoCLm+3FQewmQgeTh
         KDyeXc8x9GmgEQcgr+qBIAZV4Zzn+15RsGW0X80LiKugWjQOU30J7Z9C2xhqnTYKTu65
         zuCDWxLEAAvxXcm3nQjhED93rzSKkqJ0JLUwa6Ze7J0fuQp5wyWH/HT7jF3krWc2gRsn
         l1wQ0NLqYSiRWcsvB0qiTXYeQYEjiEKL6BadHQXyu5qE2bHZ61c1W5+Ec6GgQ5X1rpky
         tljgagGBw50TYxetH5LwDB6yANtRfDm0mTpOprfW/PrG0MxxBw46E1yaRWZE0WtEDSHG
         rC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lN3ZnzypLBcXQIQsrg5996DIvMhTqbj3VD67InnBKe0=;
        b=MFrON7BkEk+A1G54SV7ylHfZGU1x4FzGh6QxrhL92+AvLuMnoAUOxir9p86nBS7ntM
         usoinKSPILZj1S3Ol8jJkSQa6QSa3tktNH7DKSlDomW44oVC3OF2SauByY+W3PWXPMPZ
         xczLmdczh8WmnEHprvpXgo1F7ANlPVSYgEJiNP8p+Z7K395+9bcLNxw+aBXJ9odz7DJ9
         gejUVfU25JRfXYnpxfpf/IdbyggyE+mZPRg2/yFjRHmquAGI9/83pZ3pyAdgYApETzKk
         bLhWPNCKouu7HYig1+qEjz8PncG9IK8C0OFcxngqcZFrYeSTKx3IGjTGj37nuu2oGsvM
         +/2A==
X-Gm-Message-State: AOAM530zJeUvtvo/3cjTXeB3y5JqETnvPp6Ra3z1GIkgdgvfvApGSS5p
        il2tSJ/FY4l2k5qmPGLtkhVIkA4Qexwha0IpbdR3
X-Google-Smtp-Source: ABdhPJwGUHU9PrTxrGBtoYtSKMYAcXnBiw9XKjgugmd9yKbdvXHZLTtrBwQzl93xDROZ7Cv7xCTVwxk20cwg0r4af5s=
X-Received: by 2002:a05:6402:3c7:: with SMTP id t7mr1214463edw.196.1615250844975;
 Mon, 08 Mar 2021 16:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20210308111939.261079-1-xiong.zhenwu@zte.com.cn>
In-Reply-To: <20210308111939.261079-1-xiong.zhenwu@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Mar 2021 19:47:14 -0500
Message-ID: <CAHC9VhRObSaufq1kvvFqy_djSi15QbGOzQLNOE2=q3G9_hY7iw@mail.gmail.com>
Subject: Re: [PATCH] security/selinux/include/: fix misspellings using
 codespell tool
To:     menglong8.dong@gmail.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        nramas@linux.microsoft.com, tyhicks@linux.microsoft.com,
        xiong.zhenwu@zte.com.cn, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 6:19 AM <menglong8.dong@gmail.com> wrote:
>
> From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
>
> A typo is f out by codespell tool in 422th line of security.h:
>
> $ codespell ./security/selinux/include/
> ./security.h:422: thie  ==> the, this
>
> Fix a typo found by codespell.
>
> Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
> ---
>  security/selinux/include/security.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

-- 
paul moore
www.paul-moore.com
