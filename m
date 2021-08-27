Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186F43F98FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245091AbhH0MbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 08:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhH0MbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 08:31:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20346C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 05:30:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n11so9600354edv.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K61xpCiRQ+3op5aOrhoO9Yb6+RQ2HLnwLmdSAbezAc=;
        b=qZ8+rzN6RoaXRywz+Z8KeRg95H6lNUxamSqFn7UPdpEs8cmI9OyM8dlqKh0ikdDKi5
         rabP883wFHFAKROr8f5CbVn6O12UReJbDOSHpL9+ISKG048WPfXAg9UeGCPJQKPgNDoN
         UXkP6EiXIwvjwVypxJkcZeByE+UCZWFrp6f9wVLLKYfsdq8EWJSmcvVV+0WfhhocibZ2
         4x04MxWsNc0oIfsefMRVWvPkjyIirXz1WY5juB3Rd0NTbihzz5tKwt9RHuk/nBWLoGS4
         3ldrvuVDuch/92tb7zRQyG8WGWjk7GfuUA3D63gxCom0UhOXFi6el54d8rFscCRMZn2e
         QD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K61xpCiRQ+3op5aOrhoO9Yb6+RQ2HLnwLmdSAbezAc=;
        b=pusAOhMM+OeVDNZQPbdNPchalVHgiYyjwYCbyqvBONjBvv1hnEp4XzGywl76h2WObF
         Wz/RpPJ7QmiBymGDT0cBaTYv6/8CaHQlfaK0bj1im0nwfmERl16rL2Q0fTJXIsdckGg8
         jz9LCYla0GlYUZ7UUIFlsHALUErome4WRrH7FaZUkKaltC5+600EEZniO1KyZGnHdu5I
         4KUrIPP+hyhC4IaQm1TKryubo3QFojpzCpAySayxP8OngxNrixWHEd+0doKjVTnngdwt
         RhgDlhfrWAIUGFAYuZbsTID8c7LR9fXCq7KsR0RqMaYxzdtFw/J8BQIYd716VisVbPpU
         DHkA==
X-Gm-Message-State: AOAM530L9uL+Ilvqb/qt7MFOn8va1eRZfVZkb2oDdem/rFn7iEHQkuCR
        ntDfBhcJBFGdctmNdnqDRZCGjS5KPplDLU3t+Kobdg==
X-Google-Smtp-Source: ABdhPJwRe8cK23eKdCq5fSm06hgcTMh7zB/AKYp9PJ+kEHGOT0MXrud7ctMxFfiBDpil8JcerbkiCS+rVRvl1cmTWvY=
X-Received: by 2002:aa7:d6d5:: with SMTP id x21mr9658075edr.213.1630067414703;
 Fri, 27 Aug 2021 05:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210826091343.1039763-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20210826091343.1039763-1-daniel.vetter@ffwll.ch>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 27 Aug 2021 09:30:03 -0300
Message-ID: <CAAEAJfCF_1HYd1K_YGeoqSgUrBQBUVhqCSOFM7SwOAs5EaxhYA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add dri-devel for component.[hc]
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, 26 Aug 2021 at 06:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> dri-devel is the main user, and somehow there's been the assumption
> that component stuff is unmaintained.
>
> References: https://lore.kernel.org/dri-devel/CAAEAJfDWOzCJxZFNtxeT7Cvr2pWbYrfz-YnA81sVNs-rM=8n4Q@mail.gmail.com/
> Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac58d0032abd..7cdc19815ec4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5707,6 +5707,11 @@ F:       Documentation/admin-guide/blockdev/
>  F:     drivers/block/drbd/
>  F:     lib/lru_cache.c
>
> +DRIVER COMPONENT FRAMEWORK
> +L:     dri-devel@lists.freedesktop.org
> +F:     drivers/base/component.c
> +F:     include/linux/component.h
> +

Thanks for taking care of this, much appreciated.

Ezequiel
