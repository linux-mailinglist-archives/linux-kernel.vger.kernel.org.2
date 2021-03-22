Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5343344B17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCVQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhCVQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:20:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7025C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:20:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w3so22260530ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cjec9CU03x97pBWfqnenhXim56P82KU3lpH+bXIIngU=;
        b=uW585N9tLgE5B2WscxSJyqPB8Wa7F1ez7t7R2yQfyouZAKUjKxJbVjmw8lj/nTeR+c
         NZBm90AeugRrYaCpipmWR48L35EETcdgm1bUzoy2waews42AVGmWUI/vJfcWNW7/MZeM
         7m4HZ+O0NhRYrWJuXnOadQUZcep8MAsHc/FHog94Qu1yKgxnSDjwCLzTYA4pref9TGsI
         bxz+kx7W7hGSDIVZnvHxQnZVeMt0ZWgwyeMm7cTimSJIvsEzhtvQbD7DEqRTJvvAPN1J
         Ji1RVVrYhwsgpL4RVt2uyV6IPUaGBcIfKaWgDrjXsusa6Eo4sgph079yunvFyPZ/sgax
         1PEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cjec9CU03x97pBWfqnenhXim56P82KU3lpH+bXIIngU=;
        b=lILpDnLKGihSKTNHKwqljF1tZ5PcNb3DAzVRT3jzMWSxeOBnFFjORdnnUU4oPZL+u0
         2hX2loy3iLaDFc9lCMPLFyenSc4T7rXqpbbsMbLgk0F7qz3idBSwHraHrjIjlS8OyIuY
         lHxTNFo4fQcv9bWVdB/xGmzskPccdkcVdZTXLyEgpB/Y7LN7D/Dcv3wzaRtqNB9dILTH
         Asz1ci5A1N84Y4BQTtFWYdH+mjjS+JQyHDdHkZ8ZKL6T/zSEW4GOep85pLH3Zmzggene
         5kEjVP2fyscmR5XhPpdNDvNq+x8WvZ34EGIYk7+BM+L6GxDLAw41vHXoZ5WO7Rskdk1c
         dFiQ==
X-Gm-Message-State: AOAM53348mGLkHktjf7PmbpzvkmhnFhKSGNBHDKok77SQDsGvON3Czpd
        kNj+rzmw+hxu8SV3wO2gmBu7E078eOuEw5DkaAhBjTL/9pA=
X-Google-Smtp-Source: ABdhPJxGRfI9FizVaqpi19V7UON819iIb7eUF5/21wIJRBeAMg48q8Cs8n87NEkDgVkpyN9EJ0yIOVNpO3Unb29+w6w=
X-Received: by 2002:a17:906:8447:: with SMTP id e7mr544109ejy.523.1616430055727;
 Mon, 22 Mar 2021 09:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210322114514.3490752-1-arnd@kernel.org>
In-Reply-To: <20210322114514.3490752-1-arnd@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Mar 2021 09:20:46 -0700
Message-ID: <CAPcyv4h-FS96xxnX0GLOfQ7G0arNL_f4=fpP1ag3GrfLn-Mt-g@mail.gmail.com>
Subject: Re: [PATCH] dax: avoid -Wempty-body warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 4:45 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc warns about an empty body in an else statement:
>
> drivers/dax/bus.c: In function 'do_id_store':
> drivers/dax/bus.c:94:48: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
>    94 |                         /* nothing to remove */;
>       |                                                ^
> drivers/dax/bus.c:99:43: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
>    99 |                 /* dax_id already added */;
>       |                                           ^
>
> In both of these cases, the 'else' exists only to have a place to
> add a comment, but that comment doesn't really explain that much
> either, so the easiest way to shut up that warning is to just
> remove the else.

Ok, applied, thanks.
