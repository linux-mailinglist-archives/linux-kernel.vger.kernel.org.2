Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD22325D69
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZGGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBZGGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:06:21 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E92AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:05:41 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id fb15so4044892qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYg4eVbwr39lKc3uuAMvjqg+Cg+k46HPoKOqEhnc4M0=;
        b=aNulaLbShHGrrGAIOIVnoMFS7GA1WPvqdgqQWloxZ36+5m+1dacki93PSG1AybZLsT
         ONqHjxDClQv34l5qUYtzQQIePQtqXkxIyzQ2bYGl2D0awkbMppG7O1ZbQsn8Od4ccqaC
         ZNWdw12Ns86zd7C15kdUIx3qfU+b8X3paOYscBqusL0VLnVxZglfkVmEnjFwOFcdoZYB
         zu5pAsNEoPp51XmSMrSk+n5pt7oz1OuuHPr1e/NOYu+6pOY2v6Zdn6hD1zhuFMakK49+
         ZHQos4snnW6qEFGykFFv9mTwodUaPzTp0Ur9iYGt3v0yl9IexGdV0QzWilaGHdudNxBG
         +u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYg4eVbwr39lKc3uuAMvjqg+Cg+k46HPoKOqEhnc4M0=;
        b=THXQFpMoyhVIP+ulPy0qHd1ISj8IWJlyOCy4IzaeqII0MlkvPRv0pOTr4bMsJre4KA
         SbyfVvF/04vI5KPTbNr8pqmduNXFdjD4HrBwGW3eHFOs/txatNpkbNsRnlZ6gP6i++3g
         rXT5EvAqjQPvxzlHe459vfs0K1NIfivpeczVnoQUx9iTkDfhoUDFgmbo5ZppmbRugJBG
         LzLn2C9AeJmuQwCWEblgG3VYuRor/TJQTa4A3PMDveQIfkst+DyDTF0qKjeckk/notnM
         +ZY6U6rfZgoSd30fdv0pSm7z2kMpLZZ6E9/pbOObn7BkMJmb4oJ33kssvdXJknF+R/C6
         tw4g==
X-Gm-Message-State: AOAM5316syQmdQnbe583LKLwcDBOHzw0jZlghm/zc7mTCs40df+F2kjO
        Vaw153LelN9aeh32iwa88TmQ3sX1tMhBmSTH6Io=
X-Google-Smtp-Source: ABdhPJz4IcW1QTMR8Q4qK11JcPLmCFKX5157oQa7Xb1qX1ne3DNkUuMc4+jGF09j4yAL3FUz6v/GMdGq8OyTTO5CPno=
X-Received: by 2002:a05:6214:76f:: with SMTP id f15mr1129944qvz.56.1614319540471;
 Thu, 25 Feb 2021 22:05:40 -0800 (PST)
MIME-Version: 1.0
References: <1614254912-15746-1-git-send-email-shengjiu.wang@nxp.com> <20210225131533.GA5332@sirena.org.uk>
In-Reply-To: <20210225131533.GA5332@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 26 Feb 2021 14:05:29 +0800
Message-ID: <CAA+D8AO8_ESHSyODXhx4Wf1Z5MbtxWRUa-k2d6wKSeA0yzD5uA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: simple-card: Add dummy dai support simple sound card
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
        kai.vehmanen@linux.intel.com, stephan@gerhold.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 9:17 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Feb 25, 2021 at 08:08:32PM +0800, Shengjiu Wang wrote:
>
> > If sound card doesn't need specific codec device, just
> > dummy codec is enough, then we can link the dummy component
> > directly.
>
> This is a big red flag - what circumstances are these?  If it's a simple
> CODEC with no control then the general approach is to provide a driver
> which announces the capabilities of the CODEC and can be bound to as
> normal, the dummy component should never actively be used.

For the DMIC, SPDIF, HDMI ARC device or other
similar device that there is no codec connected,  then dummy codec is
just used for registering the sound card.

best regards
wang shengjiu
