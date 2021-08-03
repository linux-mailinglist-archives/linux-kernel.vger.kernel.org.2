Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807AA3DE905
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhHCI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhHCI4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:56:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF342C061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 01:56:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2866558pja.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VSBHI2kOyfU03u1WdUTP9YGD6lc5dbX5FmCawILdkw=;
        b=xFyAfNKpx2lHljwdqXYLDuofUx/eI05GpD7CjNHjSTi8OzGQi6nhKb/M67VmZsIo5l
         zgZZMg9JuCvYqwMt6HwWXuvZlVcen+VNhITVZNn4VZTLdo+zZbl7k3bQocWzR1lfvnJ7
         s7/ZpmzSnx7ciwZjQm/x3Z8Q1fpQXLy31V2OBrGTPPOrUvlUGeDxFcW4pbce1HRnLZxc
         6qHPZEcN5kwzyUwpTQ2ivR8gwSTDz4lFkNNr40VrvmoFb2MOnfpLCyv2Tk8a7nPJmiAI
         xD9ScBoY0hevG7RuaXFXFPu+TS+nThE779jNPUZbARFbaoeVb/gxUO3BPVihQ5zEIpsK
         tBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VSBHI2kOyfU03u1WdUTP9YGD6lc5dbX5FmCawILdkw=;
        b=tF6reeYFXaZnsdyCEKS/Iqa/Cs4txLOOsmcUcqSrCl7uexHWubWNSVmjTsuVBF4w2R
         w4xD5JkjiXCcaMFDeSFUzzSiZ8S7FAjwAIdl3JiO4a0qxIlwUq7oRfILM0ibPMEnfCeQ
         3RgJ1v15TYE8VeBlnlGXUYzP8m+0zt6BS67eN4qr3IByOaG2kJycvKiGLFAQcoNDKvbV
         mZtPNDjPNxYMOaimX4VycCKAgestge8X1X0NNnvlEiDfATikgrNK0CvyffW0f8ivkZXy
         TuePe7ZwfZVtFPyds/PqFgn+tjpCmVlI1KQ8TTBqShtFcoke/CaZ8H06XJprQ2eHBoOD
         Xu1A==
X-Gm-Message-State: AOAM532yTeCh6BafVf49xsXuYsZcbiuESHU5BSPQN4d4r0MOrmXBikXk
        X69b+jH8uIsYgqhTgxPzwAWwGi9EnwXCONXVEwllVg==
X-Google-Smtp-Source: ABdhPJzPp7C0RinR/iokila0E0mzC0TMDoH9Ys8TEaTlWqVMLd+0B6mNL7o+4jpCfMcAD5navb9xQle/6NO9/YMqSJs=
X-Received: by 2002:a17:903:2302:b029:12c:bb4f:cbdf with SMTP id
 d2-20020a1709032302b029012cbb4fcbdfmr6974312plh.22.1627980973355; Tue, 03 Aug
 2021 01:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210803071811.8142-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210803071811.8142-1-lukas.bulwahn@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 3 Aug 2021 09:56:02 +0100
Message-ID: <CAA=Fs0=V_gcfDUxn1m9OkR78cht0S=j02BsHajG1A3vuGTqQJw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update STAGING - REALTEK RTL8188EU DRIVERS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 at 08:18, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 55dfa29b43d2 ("staging: rtl8188eu: remove rtl8188eu driver from
> staging dir") removes ./drivers/staging/rtl8188eu, but misses to adjust
> the STAGING - REALTEK RTL8188EU DRIVERS section in MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>
>   no file matches    F:    drivers/staging/rtl8188eu/
>
> A refurnished rtl8188eu driver is available in ./drivers/staging/r8188eu/
> and there is no existing section in MAINTAINERS for that directory.
>
> So, reuse the STAGING - REALTEK RTL8188EU DRIVERS section and point to the
> refurnished driver with its current developers and maintainers according
> to the current git log.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210803
>
> Philipp, Larry, please ack.
>
> Greg, please pick this minor cleanup on your staging-next tree.
>
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36aee8517ab0..ef32c02b3e4d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17723,8 +17723,9 @@ F:      drivers/staging/olpc_dcon/
>
>  STAGING - REALTEK RTL8188EU DRIVERS
>  M:     Larry Finger <Larry.Finger@lwfinger.net>
> -S:     Odd Fixes
> -F:     drivers/staging/rtl8188eu/
> +M:     Phillip Potter <phil@philpotter.co.uk>
> +S:     Supported
> +F:     drivers/staging/r8188eu/
>
>  STAGING - REALTEK RTL8712U DRIVERS
>  M:     Larry Finger <Larry.Finger@lwfinger.net>
> --
> 2.17.1
>
Sorry, not sure how I missed this :-)

Acked-by: Phillip Potter <phil@philpotter.co.uk>
