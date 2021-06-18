Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94DE3AC9B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhFRLWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhFRLWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:22:03 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B16C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:19:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d13so13473333ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVG4hdkF6QT4QWf7U6GmvAJj2w6Nre7+o+Q+Y7YqJ5A=;
        b=sDcla8/d7JvgNB55dGV7/B0y3RfSEPCIvy48k5NqZHea+yiD3zMPTPrhOH1SqMoGku
         NTittt6R5hzDfEkx8FL+urPIsnAJ3QUcEEqClVYCBB1Jye+MC1IiIu+52IcEG8Q9boAC
         IURh8QL6fKn3dtfESIJtM/+mLzbPyAzLedTG7tTIXvOWDGS1fGH0OAS5HD1fU9c6MwKS
         iZtb3abUeIAF717svBUvPu7hDT/0M1wRcvc6IJCtdGgz0BMiJ/PsQ3BFMxeqgeLbqETj
         zjgR6UPkp5z0AlInEwuSyT+nciXGKQw3RQhGAxGx0AoYDrwg2MwmnIqvOF0ad8MFImpv
         akNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVG4hdkF6QT4QWf7U6GmvAJj2w6Nre7+o+Q+Y7YqJ5A=;
        b=mf51Gz6HtXxUp5/J4tVefS7DMA+2dqexfhCT5z8PGfPHQYXCd6Gclcv2IK2lpYyplx
         UKDnxAIJfQmIY/xomt0srz5PDXff5lsHFxD7AoN1kqj2xvO+KWNk7DhvljJ2huAHL/MQ
         YzQ7s7tPgS3FHBcvq68G/0LpvZTIrmFuOapUv69+z6BOuGbw5AT+If18/5XhHfoaNURL
         XXlqSejF4H0AizKVrPdGmELosGsMFyBIcrQgZXLW2sNvkxFAmuvt1lcXfZ/V2aLc8ZhL
         kt7TZFfgCLzLKeCLh4lm+EYQd0yDPDvqafLABRRDMazg4rvEEPPF6jr8O0cfBoIehU4p
         +JCg==
X-Gm-Message-State: AOAM531yukHGiZc2+03E+88DCkfGA56TttKMVpLD0VwnZOQbLuR3YJDn
        sfdyND1b6cQ2zHIYHSRJK+ogJjqZeQIj0GadZOQ=
X-Google-Smtp-Source: ABdhPJydxR7AgdiAIqIH1e87/gxYPFVe8agJ0K7sv330BlV9E3hlziJN2vSapU/I6e013UlRGPO779DslbMOwIMFmGA=
X-Received: by 2002:a2e:b4ee:: with SMTP id s14mr9095877ljm.372.1624015189486;
 Fri, 18 Jun 2021 04:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <9eff854f-92ed-3f09-997f-f81c78a8b5a3@canonical.com>
In-Reply-To: <9eff854f-92ed-3f09-997f-f81c78a8b5a3@canonical.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 18 Jun 2021 13:19:38 +0200
Message-ID: <CAMeQTsaWZ8Y+sMr4BMS0r_xdwz3hJ+KRT3byyJmq+OeEo=5F1g@mail.gmail.com>
Subject: Re: gma500: issue with continue statement not doing anything useful
To:     Colin Ian King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 12:26 PM Colin Ian King
<colin.king@canonical.com> wrote:
>
> Hi,

Hi Colin

>
> Static analysis with Coverity has found a rather old issue in
> drivers/gpu/drm/gma500/oaktrail_crtc.c with the following commit:

Relevant code is in drivers/gpu/drm/gma500/oaktrail_lvds.c

>
> commit 9bd81acdb648509dbbc32d4da0477c9fae0d6a73
> Author: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Date:   Mon Dec 19 21:41:33 2011 +0000
>
>     gma500: Convert Oaktrail to work with new output handling
>
> The analysis is as follows:
>
> 114        /* Find the connector we're trying to set up */
> 115        list_for_each_entry(connector, &mode_config->connector_list,
> head) {
> 116                if (!connector->encoder || connector->encoder->crtc
> != crtc)
>
>    Continue has no effect (NO_EFFECT)useless_continue: Statement
> continue does not have any effect.
>
> 117                        continue;
> 118        }
> 119
> 120        if (!connector) {
> 121                DRM_ERROR("Couldn't find connector when setting mode");
> 122                gma_power_end(dev);
> 123                return;
> 124        }
>
> Currently it appears the loop just iterates to the end of the list
> without doing anything useful. I'm not sure what the original intent
> was, so I'm not sure how this should be fixed.

The code assumes there is only one correct connector so when iterating
over the connectors it checks for the connectors that does _not_ match
our criteria (!connector->encoder || connector->encoder->crtc
> != crtc). When the loop is done we end up with the correct connector set in the connector variable, hence the immediate check of "if (!connector) ...".

So the code is correct but perhaps unintuitive. You could do the
opposite (if that makes more sense to you):

list_for_each_entry(connector, &mode_config->connector_list, head) {
        if (connector->encoder && connector->encoder->crtc == crtc)
                break;
}

-Patrik

>
> Colin
