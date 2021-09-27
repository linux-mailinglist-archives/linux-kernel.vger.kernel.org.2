Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B26A419692
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhI0OoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbhI0OoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:44:18 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AAFC061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:42:40 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id q14so19532182ils.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvtZBZ+cLSMTupAyX2ZKGNNGtfrOCy1D4m7ug1Iv9X0=;
        b=FoMhf7fbYbBHrVsX94BuI5a4xIeWR401smJ1jgv4AMdBDP7eETvTkECdzoAIfy84gR
         uEtEaHGmIkJ50ww2IBTfO31HvsgASAV5T9/IBhedUO+md2ElfKEb1ht1YMOyJs+b+O6z
         nw44azCCLeZ8Xsm5V4J0cx4XySUVHvNNX+zPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvtZBZ+cLSMTupAyX2ZKGNNGtfrOCy1D4m7ug1Iv9X0=;
        b=2c3AnIZjbJBWHXeuIyqLDjwQKl2ImWh3AuO9cWkCpPztJnXnNQ3nOaBiH6vh3NuP59
         bfy//iItlifalhgWjZZ5SBFlwDcch96wl6q8yRVvVJyPqS5MEvhvMy6dsQaNd9L0MDri
         Y6I66FslmSZZu6lJ2N+SkzMQlW7SZsDnxItSI84atsEZeNB8dvFN4BiORJxrpEOoIeqi
         8ZZ38wQ451tuphwLK9S1MEyqudaH9Kb+RBkh/GeWDc7XGEnppQ6YO+0itOTK6IBqvolw
         b2yphJPgt3PYMzwXxMdtRNmy1+cBULTk0tOUd3m/wnbkaZ5Ad9HUdscPElqm6FNEH09b
         RFDg==
X-Gm-Message-State: AOAM533K6v89HKR8j3U2K+azMH2XXSS6dNybpavHGWKzFhMcCdFZ4Kep
        ahs91OS/Qiafo6HABaU5IMeaCt8Uu5edcQ==
X-Google-Smtp-Source: ABdhPJwoAl10TMjWrTV1RbZ9nm3AS1zWcIyOrD1vm80PjYSDoijFVwRhsGhObUGj1wgZdKibixAYqw==
X-Received: by 2002:a05:6e02:893:: with SMTP id z19mr311283ils.224.1632753759720;
        Mon, 27 Sep 2021 07:42:39 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id h202sm8756800iof.6.2021.09.27.07.42.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 07:42:39 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id h129so23166474iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:42:39 -0700 (PDT)
X-Received: by 2002:a6b:f915:: with SMTP id j21mr81319iog.98.1632753758718;
 Mon, 27 Sep 2021 07:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210927154422.605920fd@canb.auug.org.au>
In-Reply-To: <20210927154422.605920fd@canb.auug.org.au>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Sep 2021 07:42:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VrkmTDA-zLFW=1f1RAAVB_P=kJDQtAx+tng6+ZkhkCSA@mail.gmail.com>
Message-ID: <CAD=FV=VrkmTDA-zLFW=1f1RAAVB_P=kJDQtAx+tng6+ZkhkCSA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 26, 2021 at 10:44 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (htmldocs)
> produced these warnings:
>
> include/drm/drm_edid.h:530: warning: Function parameter or member 'vend_chr_1' not described in 'drm_edid_encode_panel_id'
> include/drm/drm_edid.h:530: warning: Excess function parameter 'vend_chr_3' description in 'drm_edid_encode_panel_id'
>
>
> Introduced by commit
>
>   7d1be0a09fa6 ("drm/edid: Fix EDID quirk compile error on older compilers")

Thanks for the report! Fix posted.

https://lore.kernel.org/r/20210927074104.1.Ibf22f2a0b75287a5d636c0570c11498648bf61c6@changeid
