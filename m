Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF47400656
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348752AbhICUL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbhICUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:11:27 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17DFC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 13:10:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id f15so646158ybg.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP2bBlDJllmmHFJvDTszRJ/iVXWMJaLGjn6V7C/ZvWY=;
        b=QIgQHvFa7Q9UW9hHmoWcsX0yYzphBVNkNumIGLtgdMy79Lm/5ihpFSqSzx2ORHRHxd
         w2WZ6D1VTkux8OlpFAeZXueSNHxAiQQVslH3yoUtix5t19kwk8dwlTKqMK8SMqr55kFj
         zVar8MJxA6fMpP3oUq9W6y0m67z+wQh9AsXWt9TsYk5WYWD3kkjUWpNMzYWDoaPJpaKu
         mWWgE6F1r8DZVOPC9gaEcCyIldXybqjw41EOqBbOWo5ZOM3SHN9me2ndWSkKdYE0vekH
         lYNpJkODbNsHc1mI6imR0fePkyLu0OBM2gchlyh8/iF6wJRyaBqErL39UndgW+aAYHxO
         ACmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP2bBlDJllmmHFJvDTszRJ/iVXWMJaLGjn6V7C/ZvWY=;
        b=L92lrWun5tbUn4BdA30yT9DlckesXzBtYBNc5ooXceshVM0+4vnjYW13Q4+WmHVe8a
         vn0qRUOOauFp7tPqkjXXsWJUUsz+xesU3xEat6RPZ92nFovi8LEHoz9N+OVOGjfvTvMU
         V4Dxbdi9YptS8YdwdNAYQaVF9LV/wbp0cHgJZSXnWy1yfmAkMu+sIHZrdaPaa5zx3VVv
         lFVoGjelscMrpx6fLU6j/JBkLDfLpCd2SkfiVyyUY/b97CWCN22QU+AqPPyDJbTNrvW6
         C5vnlCmv8rKk28HlAuQDsy2AZ9Agfy1Ztp7vNz1oUNIF9vhKNZ+yVVlpWig7k5I0ud+k
         xaag==
X-Gm-Message-State: AOAM5331YwZbQ/s4Iy2TEJZJWSHX5sgOT6zjsBaSfl8S+4ln5ZmDNrUV
        UFoPHcdneInCZ7IAYCJUkQ1At6WBh0xC2Qo67sFLgT0SnOg=
X-Google-Smtp-Source: ABdhPJyz9dgUh4N2QxnWbIat+3XPtafsZbC1TLsbwyBA4gMbJEVcpOhBvWCL7Oj5hrXl/X4XHAjPDTjawJ6AjTD2gWs=
X-Received: by 2002:a25:b7c6:: with SMTP id u6mr1053989ybj.16.1630699826098;
 Fri, 03 Sep 2021 13:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <CADVatmPB9-oKd=ypvj25UYysVo6EZhQ6bCM7EvztQBMyiZfAyw@mail.gmail.com>
 <20210903160302.yh42vpkuob45dbpb@gilmour>
In-Reply-To: <20210903160302.yh42vpkuob45dbpb@gilmour>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 3 Sep 2021 21:09:50 +0100
Message-ID: <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
Subject: Re: Regression with mainline kernel on rpi4
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Fri, Sep 3, 2021 at 5:03 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Sudip,
>
> On Thu, Sep 02, 2021 at 10:08:19AM +0100, Sudip Mukherjee wrote:
> > Hi All,
> >
>

<snip>

>
> >
> > You can see the complete dmesg at
> > https://openqa.qa.codethink.co.uk/tests/76#step/dmesg/8
>
> What test were you running?

Nothing particular, its just a boot test that we do every night after
pulling from torvalds/linux.git


-- 
Regards
Sudip
