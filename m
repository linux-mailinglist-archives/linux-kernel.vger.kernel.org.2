Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3403D22AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhGVKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhGVKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:44:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2868C061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:24:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hc15so7877384ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zL2aOBuAI0jpx1RVe+pXYJunWCpyUrXi51PbpIodnNQ=;
        b=gzpBTRdQb4tmAtuw9XOdMUMm8drJOSGlWqw6GltvthXERDXTkyAu2IxjXmQLBZp3oX
         GWw/VS3byQ0fYdKJRUrXQTQbpfXf9bnVdybouqR4duUvhmg4D9LKMladshK44bizMuCw
         2dY31n+pyuto3FYcEOGpTsh/QWRUSTvPnqBJ54lQtMYC8RTUce8kszpINYbx1vHKmbgN
         Bj3jK2nn0kE+41oi1tjXi7WyNxJFvzjcXbGq7TIcrbQcpPdWHLyeLKV2PRnot2SU0Py4
         6qS/oSli5qXV/qgomvqTDwq+FakClDoQTk3ckJ5MPgb408L8+I/xWWPfKqdV3gQtNnLV
         u10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zL2aOBuAI0jpx1RVe+pXYJunWCpyUrXi51PbpIodnNQ=;
        b=oAk/cV0g5/GSN9sxVserQPWtdaZ4tCLuI05qq2q6Nyebrf9tO7/llpmWsFBg+HmlZz
         IaYxVz+QREtcC1cP7E0/KxiaE/F7JRLYZ3pwkQYPa6xbCahxGccPlgTO75532qRaAfzV
         JcrGskPLsgC1aPtb4n+DiwU7p5RUiDf4EcbX638DrBXA7wgA5C14TwcqjRfbiV6hWck5
         94efiPbq9aqzngHzrYUAGiG5fh0/XckhmJp5NIwfVeKWiCBOvsF8rUUTceWDGFUHWV5K
         fETeGjELuoMUUNrqvWJD7FebeADCn86CSHb+MHswdqzM94AtcL2MyxaALHfGpNqBp22c
         ouHg==
X-Gm-Message-State: AOAM531VFGxnugkC7uHXrCNK7loPxP1CfnVVBZCLm3ccFoCEI/bK4TyF
        rXBbr8W2+4Wle241Cqd5haBbrjP4Pm8MsEoYf/o=
X-Google-Smtp-Source: ABdhPJzCgQW9i9kPK7gINwayDcANDfADkeQXEdbaqZVjue4FRg439VRZFNB/kKP/8cbdP2T1zZqgSVdP+2BpW0fJK1k=
X-Received: by 2002:a17:906:3006:: with SMTP id 6mr43997084ejz.73.1626953083091;
 Thu, 22 Jul 2021 04:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210722105611.1582803-1-mudongliangabcd@gmail.com> <20210722111654.GW25548@kadam>
In-Reply-To: <20210722111654.GW25548@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 22 Jul 2021 19:24:16 +0800
Message-ID: <CAD-N9QWjjmUUSOmcBJX2n0zJrNRK3hPd03M=NbAfWNamEkfhJw@mail.gmail.com>
Subject: Re: [PATCH] soundwire: stream: add s_rt into slave_rt_list before sdw_config_stream
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 7:17 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Jul 22, 2021 at 06:56:11PM +0800, Dongliang Mu wrote:
> > The commit 48f17f96a817 ("soundwire: stream: fix memory leak in stream
> > config error path") fixes the memory leak by implicitly freeing the s_rt
> > object. However, this fixing style is not very good.
> >
> > The better fix is to move list_add_tail before sdw_config_stream and
> > revert the previous commit.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/soundwire/stream.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> > index 1a18308f4ef4..66a4ce4f923f 100644
> > --- a/drivers/soundwire/stream.c
> > +++ b/drivers/soundwire/stream.c
> > @@ -1373,19 +1373,11 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
> >               goto stream_error;
> >       }
> >
> > +     list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
> > +
> >       ret = sdw_config_stream(&slave->dev, stream, stream_config, true);
>
> There some sanity checks on the stream inside sdw_config_stream() so
> that's probably why we didn't add it until later.  (I don't know the
> code well, but that's what I would suspect from a glance).

I think those sanity checks are not much related to list_add_tail.

Except that, do you have other concerns?

I think this patch could improve the readability of code, so I submit
this patch to the mailing list. But I am not sure if the community
favors this kind of patch.

>
> regards,
> dan carpenter
>
