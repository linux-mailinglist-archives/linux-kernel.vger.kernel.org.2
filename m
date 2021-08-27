Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6644F3F9454
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 08:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244246AbhH0GPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 02:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhH0GP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 02:15:29 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B4C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 23:14:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d2so4546271qto.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 23:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6wH6VQ81UagFZrBDuQfg5acAy2kFwSXlQ1BsRDUlyk=;
        b=NHZ1G+5iMYP+XgOXH5UWH9rl5MgrCTsw24zUz0jzVVBz+Xmrufgkm+tVgv6ucD2UWG
         S74VU3T8byNcrBZ2G9VlqPDsKNIlVcW/r7j+CkdQxc+++4BXjItHwYo0t3ILCKB/wnAp
         CEKmr9AqAKKl9+MtHquG8IriOb8ywV+JJXsBmM4iUSnhM+hUfB9rj8osl8FsghWTCPB0
         Ed0v7eB71ig5k51ZQTX8nfHtVuy+Qq6tE+lYQcDGYTg2vpU35rphOC1jKOIDR2H4eiDT
         x2wJV28v4xylCa/M7SwI2380goxX5k+D7RH3VvD14mxt3AKl2gBkdxxTn6eiGYI3K//B
         0PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6wH6VQ81UagFZrBDuQfg5acAy2kFwSXlQ1BsRDUlyk=;
        b=fYjHXi2fi9xDnASlsOeqSQUr+HiV0f/TDduAyl4BhuBVlRDT+ixIrT3rmZgiFTIDXe
         eQo52e9EbjLrWF8QM5ptwUgE60LPtdHccuZbrNxazkpbc+GFg65rbRT3h2rjmqOFts6D
         vuug0z1PG3UtwIpdLvmXOThzZN1mit9XRJld6xL0W/Kra3rRvrAKjVMomA+b4lSK6ZVJ
         ByB/gfQjXOJHHumLQNL0vTH5Ke2KrSt3Suc7ElnrCrVUVp20GfIAa+GQwO1tBkTU9CyG
         yBsQx3m6GUNcxxvNM2Cgo+wEukIFykP+VTuCcrwYXhnRllyx2i2fNEMtpcAyLOeXhkM3
         POzw==
X-Gm-Message-State: AOAM5303T4lkxuMmwwAbyojIDcaErmW0tEiv99rPG5fbAF1+qbHprNrc
        1Y9demgBYgO4p7TP1n4hBYX4QTzIxyu2fk9KrjE=
X-Google-Smtp-Source: ABdhPJyrAdL7K8XPjqcwtnfWW1RsdpvIxn2uSbruNkxA69ge/iKoWUvnFJynkt+EtCBZhj7XUF4HWM80qKarwD1AKt8=
X-Received: by 2002:ac8:5805:: with SMTP id g5mr6951210qtg.360.1630044880150;
 Thu, 26 Aug 2021 23:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <1629975460-17990-1-git-send-email-shengjiu.wang@nxp.com> <CAOMZO5BCsTMjJJPtLN6_seVcWb24A2ms11FP3HzR0i7t3GLSuA@mail.gmail.com>
In-Reply-To: <CAOMZO5BCsTMjJJPtLN6_seVcWb24A2ms11FP3HzR0i7t3GLSuA@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 27 Aug 2021 14:14:29 +0800
Message-ID: <CAA+D8AOTAL9H8mr819v9VTQmJvNyKjnRNGPOX64LekjvXXGEcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_rpmsg: add soc specific data structure
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 7:54 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Thu, Aug 26, 2021 at 8:19 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> > +       rpmsg->soc_data = of_device_get_match_data(&pdev->dev);
> > +       if (rpmsg->soc_data) {
>
> This check is not necessary, because rpmsg->soc_data is always non-NULL.
>
> Other than that:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks, I will update in v2.

Best regards
wang shengjiu
