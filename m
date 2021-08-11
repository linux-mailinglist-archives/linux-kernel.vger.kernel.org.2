Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5503E92BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhHKNeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhHKNeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:34:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82752C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:33:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n17so5682762lft.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpMZAUiu4CHidBpx9zRuTRmjPXDZ5iwYMFLqgNELNuE=;
        b=FfCZF8D4xFPjIX1+di0EhQfTW4wx0dhjkLAqyPBwWNhOGN8XvxqM3fXl+tvJTFnlem
         v2bXWWauVd0qZ1ptB2PtX+WPcZW45fAtlrjIlssMtnwZMrnqoG4MIlO2jO9+loGK5DeV
         FknQsDTiHHjON/r60/6+mnFfD1yEqa1+LlXPoqtEj4JQzwOsTR+CP5rvIznsAJUUKz3/
         WTbasN5+5bAvp45BpC9JPoFoLKSU0eeOaJYlwKOeh3YKUkrD4n7NmL/98JMQQ3gl3ami
         2xmHhmRP/Mh1DOCt0Or/0i16maEj31JnmXSBZN0We8elI7aFpBQn5qDHK5F2tqK1er0j
         QCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpMZAUiu4CHidBpx9zRuTRmjPXDZ5iwYMFLqgNELNuE=;
        b=TpyY5e71OEjrVAlHcDZ4b3dG4IsFrvEY7NyacwsrG2A/r3pep+DXmdCSLmdGZm+LdX
         ug0fRfeTDbUUDuT4yXEU+suEzkQc7GvbnRx6l8sGHZUYj1wh5nTWJlnkfmQ8AXP9MqLp
         bQeGyec+rL4F1yFkplkI+C6FXooAChmuK0n9Jb/EVqpWbFIinbfDuY7z/Zd9bqj+aW1K
         rkEdFgCRPV3HzRpCxKWbmrJhrQhwRxbxy6FdHq0OAitiy2HfxP33eELL07mkXHjgSgKL
         qM/Rf/cRVPDnTTqgITJKV8XOMslXqmxZkF289ov8TqlSJ+02US1EbGoVpZ8dpT+nVuGC
         2eCQ==
X-Gm-Message-State: AOAM532CuO6BuD0nrdaTJvaSFAy3jRzRK2WYNR5/0cISbRZeGle1paad
        RrvXoyZ73YTu1oJpSLfYDg6vwwT1MCnjx45D3x+Yqg==
X-Google-Smtp-Source: ABdhPJw/s61tPbcLYdIVemcOcuVHrDRJbkbD9xzP1eg2Tu6BRNW+LPTD/jTUlAvQbqg/p3pm6Ne4iiLVxITFONIXJuA=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr25216383lff.465.1628688827875;
 Wed, 11 Aug 2021 06:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210810191724.24452-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210810191724.24452-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 15:33:37 +0200
Message-ID: <CACRpkdaoheT3b8oZkQCUOVw9bdioG+b5BW4T5-Hj8dHoD5yX0Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust ARM/NOMADIK/Ux500 ARCHITECTURES to
 file renaming
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 9:17 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 8f00b3c41ae7 ("mfd: db8500-prcmu: Rename register header") renames
> dbx500-prcmu-regs.h to db8500-prcmu-regs.h in ./drivers/mfd/, but misses
> to adjust the ARM/NOMADIK/Ux500 ARCHITECTURES section in MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>
>   warning: no file matches    F:    drivers/mfd/dbx500*
>
> Remove the obsolete file entry after this file renaming.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210810
>
> Linus, Lee, please pick this patch on your -next tree on top of the patch
> mentioned above.

Thanks for fixing this Lukas, I see Lee already applied the patch!

Yours,
Linus Walleij
