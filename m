Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FFD33EBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhCQItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:48:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6F5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:48:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x16so935431wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBpt3cP49rkhcN1HDm3Z0MkEX5WMSS3fRvn/Ddo7Grk=;
        b=mnAGudcJmPDXj3PsCg383Zafr1alCSpuwgLfOQu4c4uXl480/f/Jb9eoNmwq1ZRCZW
         gSOPiEy0VwEc4Lp6MTCzjzfT+Ns/8saO+vDxOzk7kmx6vyXn7glnU6SOxKdZAyp0qytw
         ZJDJpVoZg75JxMwsRT2VPGJlePl1T5OlBzw2cDic7ZjhInRw4mxei0z0YVyIwsjNNiQn
         ikyF3KhIsF0kN1bpamn9xQwg5RNz7X97CaAfdzpK7cKg42IsEhN3SFxj1NVmv2XRZhF0
         Ps3qSAWQXWAZ/qAt1XBYGxeJfnuelMKXcVWWLXiofD0P4XxrimOfgoSlRL7rDa180oJo
         Y6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBpt3cP49rkhcN1HDm3Z0MkEX5WMSS3fRvn/Ddo7Grk=;
        b=kbgufmdI83JH4QcEy7fmWnUP+VE7siEttqP0WY5yYehVc/mry3T5xEl1tBIaiNcATM
         ODF3e9vxqr3AH7F4nsGu5/ql1Kz3CAPlERq6GE+hr7D2LWLbqsMki1TPGJO+8PvmMYaD
         3sf0GlA/p00qRfnSBhOGRoP6tKEVInqCLwj6qfwiJwjH4R1bgd5vllgNqOUpxb3zqkV+
         RE494RlLGwLW6+2NWu85tgfafdFUHWT/urm/z7SI9R+4UjUv6dve7+YM+UDGK5xImYEA
         qOl07T7ExesloHe6GEDj2u/c3R22tT59jKx7iKrtVRwyw65o11JgsxE9CHjeQ7qmkUkb
         6yEg==
X-Gm-Message-State: AOAM531SdH5sXKaMHHY7PmNKoR3onP/ysw40187m7/yuXczS+zhPlCcc
        A55XPtvZDERNmF9n+ZLEeQPwX1mOsJf7N8iLu9M=
X-Google-Smtp-Source: ABdhPJwNbkasdtkhEZRdHf63ZqK5QSWkTi1rSy/5Vg7bz4EmHLSj2PEtEu5k8z2p7n7pWIUZG0FutNwXSSTIiLXKnis=
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr3264627wrn.174.1615970925417;
 Wed, 17 Mar 2021 01:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210309082328.38388-1-daniel.baluta@oss.nxp.com>
 <20210309153455.GB4878@sirena.org.uk> <CAEnQRZB_VgsEPYgxtWQWUgs2+noRt1AMMHf2crJ_9Hg7s7NJ0Q@mail.gmail.com>
 <20210312104931.GA5348@sirena.org.uk> <CAEnQRZDe_Q-N7L_7z7aVz1o3guKd6R+WFrOfT9KPbggJP8SPZw@mail.gmail.com>
 <20210312115748.GC5348@sirena.org.uk> <CAEnQRZAAU34YS778WJVD6uubSwQxjA-5LTG9g0CvSdSZOuO+tQ@mail.gmail.com>
 <20210312142300.GG5348@sirena.org.uk>
In-Reply-To: <20210312142300.GG5348@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 17 Mar 2021 10:48:33 +0200
Message-ID: <CAEnQRZB7BDA7gdiWH1PR_=XDiFiDW0=tPH4xY2D98=s_-mV7nw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: core: Don't set platform name when of_node is set
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 4:24 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Mar 12, 2021 at 02:37:30PM +0200, Daniel Baluta wrote:
> > On Fri, Mar 12, 2021 at 1:59 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > No, just the opposite!  If there's an explict name configured why do you
> > > want to ignore it?
>
> > Because the initial assignment:
>
> > dai_link->platforms->name = component->name;
>
> > doesn't take into consideration that dai_link->platform->of_node is
> > also explicitly configured.
>
> But why should we take that into consideration here?
>
> > dai->link->platforms->of_node
> > configured and we hit this error:
> >
> > soc_dai_link_sanity_check:
> > /*
> >  * Platform may be specified by either name or OF node, but it
> >  * can be left unspecified, then no components will be inserted
> >  * in the rtdcom list
> >  */
> > if (!!platform->name == !!platform->of_node) {
> >     dev_err(card->dev,
> >     "ASoC: Neither/both platform name/of_node are set for %s\n", link->name);
> >     return -EINVAL;
> > }
>
> OK, but then does this check actually make sense?  The code has been
> that way since the initial DT introduction since we disallow matching by
> both name and OF node in order to avoid confusion when building the card
> so I think it does but it's only with this mail that I get the
> information to figure out that this is something we actually check for
> then go find the reason why we check.

I will enhance the commit message and send v2. Hope to catch all the
inner details.
