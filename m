Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25D3BF8D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhGHLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhGHLXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:23:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66897C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 04:20:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so6459595wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 04:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rFpDh7TVWZtaM5cs5d5LHXdV3TqKZpl99EHToFRBjzg=;
        b=Xnx0zHtsBOr98Vo5otxRILu0ikPe61GOmG7rqmRqh6XT1bOJdVJQUkn/kfK5NHZLFj
         ILsIVMYUoB2BuY9g9N1vz7NeLQdZmo/8dRhc2KmGnt2tPFsdKhR2UhQtCAQ6M3/U66oq
         3r4gTgizmGVOusPMoP4ysDG8SVE3/Byj0f1XW82bsvdXD32AjSTJ7garNje6lGn+zdRJ
         XvHgLbHXZJ5NpA0RBUjadOXEZypLMHGHQXzj2TYzJqFoPWs3LQHc8tjnH9ooR2Jd/GH7
         VdcpEIoZIEUZmshI80KVdwMJ/ldb6QXV/+8hZ5Ej5YcgQpeTreLwsO0dgLy6aRN7CpVs
         aPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rFpDh7TVWZtaM5cs5d5LHXdV3TqKZpl99EHToFRBjzg=;
        b=gQ+4DFNP5/c/7lIu5UARgelq0+LRakwNh/qH0btwRctnHSOQUV6UBdqUw3XxRWtkNd
         C6apSnND1G6VsgcXAYroxSwZ7O0z92gdsDLjtG4Fo7UZjVlHMUc7wm2kzfM/sPkz58Bf
         DmG3+q6MCQuR2eLYMxerwJvv/wSsC2RHQ2Iw/CQZbn25k+jL0RcUa4aeVQtTR09Cf/V/
         yF9WpKmjoozjpltcReAFJvguSz4+v4r8kdVBSftv9HLrZcgAG63w62IPURWOxXMDkJtx
         FQYBO/fgFbaM/pz0Q0jqxFpOqxb0utWeOmqOftBIeWuT/9aGOTWLvwZeXZCBs98VdxDM
         /Oow==
X-Gm-Message-State: AOAM530lDTheSbshu0CllwV8YBbpg3p7xpzlG59ZHR4NunjjkmI6qzul
        qRaY+bRdZCNK0Nn/SasRxGkTdA==
X-Google-Smtp-Source: ABdhPJx6exO8vO9udBHYfA8ebFe4eoju6SLYXTu4Sfdz7wzxhRRjMepfAj0J4wx5/njHb2XblKOFiw==
X-Received: by 2002:a1c:4603:: with SMTP id t3mr2262634wma.178.1625743238929;
        Thu, 08 Jul 2021 04:20:38 -0700 (PDT)
Received: from google.com ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id o11sm1711710wmq.1.2021.07.08.04.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 04:20:38 -0700 (PDT)
Date:   Thu, 8 Jul 2021 11:20:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Deepak Kumar Singh <deesin@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>,
        Mathieu <mathieu.poirier@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 0/4] Signaling api support in glink/rpmsg clients
Message-ID: <YObfhBXAu6g5S3ws@google.com>
References: <1599063847-2347-1-git-send-email-deesin@codeaurora.org>
 <CAF2Aj3gAqjVbcMayR7yYBb6UxY5ekC9gdhpmNdz1-zLwo10yLw@mail.gmail.com>
 <YOXOtRSpKO5WdlHZ@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YOXOtRSpKO5WdlHZ@yoga>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jul 2021, Bjorn Andersson wrote:

> On Tue 06 Jul 10:27 CDT 2021, Lee Jones wrote:
> 
> > On Wed, 2 Sept 2020 at 17:25, Deepak Kumar Singh <deesin@codeaurora.org>
> > wrote:
> > 
> > > Change from version 6
> > > In last series(v6) i had put wrong version(v5) for cover note.
> > > Which led to confusion for patch set series.
> > >
> > > In this series i have updated the label for cover letter(v7).
> > > There is no change in patches. Only cover note label is updated.
> > >
> > > Change from version 5
> > > [V6,4/4] rpmsg: char: Add signal callback and POLLPRI support
> > > Updated for sparse warning. Replaced POLLPRI => EPOLLPRI to fix
> > > warning.
> > >
> > > Change from version 4
> > > I am taking over these patches from aneela@codeaurora.org
> > > Fixed all the trivial review comments.
> > >
> > > Signal conversion to and from native signal as done in patch V4,2/4
> > > is intentional.
> > >
> > > Arun Kumar Neelakantam (3):
> > >   rpmsg: glink: Add support to handle signals command
> > >   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
> > >   rpmsg: char: Add signal callback and POLLPRI support
> > >
> > > Deepak Kumar Singh (1):
> > >   rpmsg: core: Add signal API support
> > >
> > >  drivers/rpmsg/qcom_glink_native.c | 125
> > > ++++++++++++++++++++++++++++++++++++++
> > >  drivers/rpmsg/rpmsg_char.c        |  76 ++++++++++++++++++++++-
> > >  drivers/rpmsg/rpmsg_core.c        |  40 ++++++++++++
> > >  drivers/rpmsg/rpmsg_internal.h    |   5 ++
> > >  include/linux/rpmsg.h             |  27 ++++++++
> > >  5 files changed, 270 insertions(+), 3 deletions(-)
> > >
> > >
> > >
> > Any idea why this died at v7?
> > 
> 
> I had some concerns about the actual users of this and wanted the API to
> be more generic. Deepak brought this up again recently and I think we
> have a common understanding of how v8 should look like.

Okay, great.

Deepak, would you be kind enough to Cc me on the next submission please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
