Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03142312342
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBGJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBGJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:49:52 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01AC061756;
        Sun,  7 Feb 2021 01:49:11 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id r77so11524888qka.12;
        Sun, 07 Feb 2021 01:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbbpsfQOSGbGs7R9zUS8hYozEigpvRyjnIt3/cvm3W4=;
        b=diViRcfhsBkjhy6mWySEJOvsQpOFK8pZMbHHTOXwUoPo1Ufs827UZAvqXypn/cYfbC
         w6BVY6DkW3CKlG2KmSRpgU5z2KocTnpA6/MSr+resHu5Lry5t6So7Ij6KP0YOIUAM9W/
         huFYnUNtqpAcUFTaoClhw4N7n27WmMKnsKfev01KHJxc+8bzxTWIJGGdzL6ZJgkcbpJg
         IdB8X6n+ct1xkjqGPnj+HWL0/tirsOdYu2VRr7ftt2i//YyLHiP9LHr7JFBytNJUAaI1
         5cgpzZ3gAIyg49t2FiBhrd7VMbFLD9n5qn+iTRwhsPWZI1OMMqICxBPAgxO5SQLVPtx/
         NDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbbpsfQOSGbGs7R9zUS8hYozEigpvRyjnIt3/cvm3W4=;
        b=S2sN5X3+CKTIEKySU/HdJfUJqkf3RZGejze9h79tt2SUy+oUxw1Bfatvu5mExexaBE
         qgZt4e4OBBpPTTRSZCyvXhV5rCXx33IYMmEv/cbpTLMPAbIQcXJKwGEuGCBKB93kHq+7
         yMai9M94TzvyN5qfD5RP7GMoFXBcMeqTtcJ+2Y20fhALxn8EssX1YhqJzfURW4FlkBIG
         tpFmzsaUBc4GjhY+iUJ4VxjZc9rR9gyrYvbWjxuQBrX1eM2OP5twDS5MtqhC8CUVDgAk
         89DsEygo+WNpFkHJ5asoW79oLU5Mk0pe0HKbhjDfBUSGzLTZ+BusJluZAtJlJaDf1lON
         qhJg==
X-Gm-Message-State: AOAM531w36QWr3EDAqzrw1hzEkgwGosUNoNaV7YiJQW1RTi58lf+g3K4
        7UoBVMPi/0fXEtLXY0Ep7ZBpSXXCZCsOVznLj+Y=
X-Google-Smtp-Source: ABdhPJz7+XOZYuIE5pcblvhRQewVLTixRZW/R/cp3G96D5R/aLCDqK4IrND0zV4hhmv9HidC2Ycs1HEyKDlklGV2C98=
X-Received: by 2002:ae9:e80e:: with SMTP id a14mr2346374qkg.103.1612691351108;
 Sun, 07 Feb 2021 01:49:11 -0800 (PST)
MIME-Version: 1.0
References: <1612508250-10586-1-git-send-email-shengjiu.wang@nxp.com>
 <1612508250-10586-3-git-send-email-shengjiu.wang@nxp.com> <20210205140251.GB4720@sirena.org.uk>
In-Reply-To: <20210205140251.GB4720@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sun, 7 Feb 2021 17:49:00 +0800
Message-ID: <CAA+D8AOa73k4yRsy20w2yHOTPoKATm0pwsBdJvtxthEtff6WrA@mail.gmail.com>
Subject: Re: [PATCH 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio base on rpmsg
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 10:04 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Feb 05, 2021 at 02:57:25PM +0800, Shengjiu Wang wrote:
> > This is a dummy cpu dai driver for rpmsg audio use case,
> > which is mainly used for getting the user's configuration
>
> This is actually doing stuff, it's not a dummy driver.
>
> > +static int fsl_rpmsg_remove(struct platform_device *pdev)
> > +{
> > +     return 0;
> > +}
>
> If this isn't needed just remove it.

Thanks Mark. I will update them.

Best regards
Wang shengjiu
