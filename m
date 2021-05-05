Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC00A37403D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhEEQdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhEEQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:32:43 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58289C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:31:46 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z1so3461285ybf.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRVzwOgIfTSllO4Wpxq3+JkI0Hw7DPEdTGB0dVwqKjQ=;
        b=IdOv2ekLdGnchPslFlPDDzQiNQdeseK4Ba8Jyex9e0ZFkwjpS4vHnqmVAKgQTY4Gs0
         NJT584bOfjuJOoiyeiXEW7Ye04nzU7Wg05vXbQ7n1aHfhK2Dz0h3UgaSdtBBPsz4piKu
         m7kweSyABh3p1UstIv2J4EG8ONKIqc5KyQq2aNsLCYNggHpxtDQkm+4LUdufaoJy8fJ+
         actO6D4HK2Jxc+8GMuLCE4T29bS3bvtgDyLpnmgZQHaPzefJhYbRYW5jdPCPzd9O/LoW
         P0qozxlmQeqTeumDGcjo87Xn7ECtPN18FDvfeQCc1DSCBDytP5ANKykaR5rL/4WOB1wL
         fzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRVzwOgIfTSllO4Wpxq3+JkI0Hw7DPEdTGB0dVwqKjQ=;
        b=L+OYNO3Z+bWzvIbX9AtSmtiV0d2a2LF3mUme5yOAQIUtiwxYIccldRFuCtIbG3PG+W
         70IqowGN/jcRptDxnHrUSZX6dYrAPlw6qvPiKUM/YWllC494Y9j87Emy2hvyZtod5j/6
         RvFgOziwU6WSzfLqa8h7OSgJR8WTzYtLLIFL1gUArFoQ2GjLNYr/oNnwUb2c1qBwcWeZ
         iVBDvTwRXSeduEvlK4IudbE7kcaCZYUYhzp8aUv3BGeT6QgklU+wrRmR1f3hwlW1z9NB
         idkbG+SxR4hvQL23p/pwARnIppkv/IInuUMKxxVF4RxuTvGa+jx+qvamFBV2vZFAK4GF
         q3xQ==
X-Gm-Message-State: AOAM532dcC/Q9e9B++s2wvFaF3vdonls4XITP6BVxOO/0CaX42nS6Vgp
        M0FEBeByfcneJxIbiUtYzCokszAkd4ii/QVTBa+hrLUchX8=
X-Google-Smtp-Source: ABdhPJyknOwqxU5ETkne37G2eSRG0nmQg+LKD3m8TppD3zQF2UMZipDo/13yR1+ALt0EXhxSdbYpM3t9JhYZLky4VX0=
X-Received: by 2002:a25:2d64:: with SMTP id s36mr40509310ybe.412.1620232305426;
 Wed, 05 May 2021 09:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210505031416.30128-1-saravanak@google.com> <20210505054838.GA22603@wunner.de>
In-Reply-To: <20210505054838.GA22603@wunner.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 5 May 2021 09:31:09 -0700
Message-ID: <CAGETcx9EnNKwq-KQ5dDifAV25jsJ3WCv6iqs7TqsAgXaUfFgbg@mail.gmail.com>
Subject: Re: [PATCH v1] spi: Don't have controller clean up spi device before
 driver unbind
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 10:48 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, May 04, 2021 at 08:14:16PM -0700, Saravana Kannan wrote:
> > @@ -415,6 +421,7 @@ static int spi_remove(struct device *dev)
> >                                ERR_PTR(ret));
> >       }
> >
> > +     spi_cleanup(to_spi_device(dev));
> >       dev_pm_domain_detach(dev, true);
> >
> >       return 0;
>
> Unfortunately this doesn't look right:  spi_remove() is run on
> driver unbind of the spi_device.  With the above change,
> ->setup is called on spi_device addition and ->cleanup is called
> on unbind, which is obviously assymetric.  What can happen
> here is that a slave-specific controller_state is allocated on
> spi_device addition, then on unbind that controller_state is freed
> and on a subsequent rebind it won't be recreated because ->setup
> isn't run on spi_device ->probe.

Good point!

>
> As I've written yesterday, calling spi_cleanup() in
> spi_unregister_device() should be fine if you move it to the end
> of the function, but before the final put_device().  For that,
> you need to open code the calls to device_del() and put_device()
> that happen in device_unregister() so far.

Yeah, I saw that email after I sent out this patch. I'll send out a v2.

-Saravana
