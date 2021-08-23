Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C2C3F4345
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 04:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhHWCCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 22:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhHWCCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 22:02:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F9AC061575;
        Sun, 22 Aug 2021 19:02:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d11so33537523eja.8;
        Sun, 22 Aug 2021 19:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qn2X6yCZVQS4i5pjYYMheZPlPQ7wgcjmX5krI/88Nfg=;
        b=E0hH8hOwsJC9GpncoE+fBebmCo03rqjvfyWhGq9KDzEEYosyY+8/tTcs7dNl0eY4Q1
         wjbsdcvxN08K7d2MmVTc6KtMVWN49QhHlSHbGjULwvLdU+fC50m8QQd9gFyYbpfrjaAW
         8EYds/zXxDSpklieOzDbUk/iH3AGHe23WAkuUghtnh0jDWi8gwxHOOcROHNHx2jOxcYR
         xwEwQLXmXRyQNdLCrZz8m1T+mjkkbh2vqKjvrtje885kOVMR9rlrG5so8a3nFg7/+JdM
         1gHA9icA8LU2UeZAnh3Nt205c8vCu6lkY9uAKGGlDfwhLkarLWHskA34Sj2iML0HNPXd
         CqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qn2X6yCZVQS4i5pjYYMheZPlPQ7wgcjmX5krI/88Nfg=;
        b=quvSskxB5j57GRRKGOJORv6XXnBBNhZmu1yz1WSDa93XDMtfu6lSE1ERmCaDgP6+IQ
         UONVjIpPf/01MXvNYF9yKkPp9EEd5OyftTIb5fCy4OyBvEC6cwRpmOAxITdUvIArx+TX
         FYJwDwLL/3q4HcAPLpFH1MSt+Fo8HHrB69+TPkeQe4hm3lsfoPEp0MZCI3+pnBB4T14e
         XPZbDMT55y9ejDgGqUmWoqZ8nkzFX+nNJzldmp7b7rCs4S6UXzNweM/lM+pHVjHgr5HY
         mQ9LbVa6nIfD4yDJ8WpVyI16wQe+ffPR/LvYS2wWFx+XhyYcrBYDgOfFafcvn93f4xx9
         1pNg==
X-Gm-Message-State: AOAM530d/sAynPyEG6iIUk+mNVK9mquL34ye6V12dirIEo4gjf5GedYu
        nRJm55IuCfzq7vubtqG9Gly2W9e8CDtA/WoAZwA=
X-Google-Smtp-Source: ABdhPJxFWb2CojRQAgE1XDSqAQzntJfQJFnB5KPBXkeGhr4F/jjqOtYOM2vy8DfoWrw+xSj1xTSnXfTN65/1eM9fdhA=
X-Received: by 2002:a17:906:c246:: with SMTP id bl6mr33704490ejb.80.1629684128047;
 Sun, 22 Aug 2021 19:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210823014908.43982-1-jing.yangyang@zte.com.cn>
In-Reply-To: <20210823014908.43982-1-jing.yangyang@zte.com.cn>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sun, 22 Aug 2021 19:01:56 -0700
Message-ID: <CAEdQ38FvspQYf75wMuNKDpj+C1agXdLzfvjYR3fud+V=iXP_JQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] alpha:smp: fix warning comparing pointer to 0
To:     CGEL <cgel.zte@gmail.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 6:49 PM CGEL <cgel.zte@gmail.com> wrote:
>
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
>
> Fix the following coccicheck warning:
> ./arch/alpha/kernel/smp.c:271:39-40:
> WARNING:comparing pointer to 0
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
> ---
>  arch/alpha/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
> index cb64e47..adc05c2 100644
> --- a/arch/alpha/kernel/smp.c
> +++ b/arch/alpha/kernel/smp.c
> @@ -268,7 +268,7 @@ enum ipi_message_type {
>                         memcpy(cp2, cp1, cnt);
>                         cp2[cnt] = '\0';
>
> -                       while ((cp2 = strchr(cp2, '\r')) != 0) {

You may as well compare with NULL, for clarity.
