Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B13441459
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 08:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhKAHuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhKAHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 03:50:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE975C061714;
        Mon,  1 Nov 2021 00:47:34 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b203so5182543iof.1;
        Mon, 01 Nov 2021 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kd4BPRZ9sK8kBGUMQbngZukIs4D7nqGTCYCtGM0fwOI=;
        b=bOZ0dic5fwcUJXFHUmdbvSk/pbMnkfTPeiGDm+DOCeEkUVj9G6WlynL8SW158B4mEO
         lg7Pz7/I8PRT5KWSbIt85/E8HQ/D5G5yRN4mRKwk23YAQRsaBOw0NOrpKSh8Cl0Aa5A+
         OdccJvvdShMJDra7JqjXDV2kTM+uwcibd4Lsq6AjYI1+c2ufO3qQx8MkPlMgBz/mXFpP
         lDbvi/z2V4x8tIFMl4XXZpusgdQvhPErV7zG8VgqTQ6fEYkCHSi3G1kuNXDfI7mGIvjr
         fzuoG2U9FPJ7nO6Sz0ViaGDO1mgmEsazmgDk2rhw4Q7Cic/C7X6kwYJgKmy3lWy1WGOL
         Mq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kd4BPRZ9sK8kBGUMQbngZukIs4D7nqGTCYCtGM0fwOI=;
        b=GwRJgjUP9VKwg7qXZPJXEjnntpir4KHz52eeyPZZjMakYhqHGEv8/EwC+9lOEOUoUH
         i3ypGEC7EpVV8rhzwxXxfdBvCnuOkDCEDbJDw+TiK+G6cv1hSO+9+kfW8AoEPhE88tv2
         BxYKZPUI9oEjcQiVg1gWbLHSdNtirtXW+L2B2EglGWHFyiTt99Cc+9LOb6E0o/19cOrA
         TO9KgfyehkU35x0zhPLQypS3IaavWX0n9m8VeULlIoUhayLA3aaDRP4TiZqZUXVuqDGU
         9Hb2eptX2d/0X6KbL5fbb+bK7GnXj9JVP78rR2U0rnzY4pgQuDk3kIB480SuIJZCGaWU
         pRtA==
X-Gm-Message-State: AOAM533cxEPxvI6lsIjh31IBz0LpqMl2CmLY9NwpC8IM65ynGSBeULO7
        Ma+uMpjtbUKvZE7QYJ95UCg5syazYG4uXnt7Pj3Tcd62NvI=
X-Google-Smtp-Source: ABdhPJw61V19t70ObGqdAvRgYku+E/mnmBvyCooUjoLscT2KnaQ+lulIdqj1uuhxyXeSR8/aeQ1io+e4N1jQks8x6Q8=
X-Received: by 2002:a02:cb42:: with SMTP id k2mr6471995jap.25.1635752854406;
 Mon, 01 Nov 2021 00:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <b22b772c23f531708a9bc025d56c0312a53bd6c9.1634630486.git.mchehab+huawei@kernel.org>
 <878ryosocf.fsf@meer.lwn.net> <f0269915-4863-9ed6-dedd-592f2e308f46@redhat.com>
In-Reply-To: <f0269915-4863-9ed6-dedd-592f2e308f46@redhat.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Mon, 1 Nov 2021 15:46:58 +0800
Message-ID: <CAJy-AmnHht4=sNyQ5r78MwfOpMF8dRqrct8fasVX-ULadfMNvg@mail.gmail.com>
Subject: Re: [PATCH v3 16/23] docs: translations: zh_CN: memory-hotplug.rst:
 fix a typo
To:     David Hildenbrand <david@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 3:08 PM David Hildenbrand <david@redhat.com> wrote:
>
> Dumb question that probably has been asked a couple of times already:
> why do we even maintain a translated doc in-tree?
>
> Every time I do an update on the original doc, I for sure can only guess
> which translated parts need updating. And I really can only update when
> "deleting", not when rewording/adding. So we'll be left with stale doc
> that will have to be updated manually by $whoever.

cc to the translation maintainers and translator would be helpful?

> I don't feel very
> confident about this. No translated doc is better than outdated
> translated doc.

Uh, I don't know other languages, but in Chinese, 15 years before
translated books are still selling well in China. :)
https://item.jd.com/1075130482.html  ->  Linux device driver
https://item.jd.com/10100237.html  -> Understanding linux kernel

Thanks
Alex

>
> This feels like something that should be maintained out of tree. My 2 cents.
>
> --
> Thanks,
>
> David / dhildenb
>
