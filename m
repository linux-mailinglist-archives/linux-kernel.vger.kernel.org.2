Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8B230B54B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhBBCfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBBCfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:35:10 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE225C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 18:34:29 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id t17so13977825qtq.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 18:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjpJNs0J12vp1IhfE1UDS+GBxWHaPxs/MJ4w9Q0NI04=;
        b=JvYNweR+f9nFJL+a49zw+w4LD5s+2syVVDuDOHSRvHkCHLFGIMyYDWbWkf5fbjU2CO
         wsls7x8LXSclZD+BZvmtobTH1BqmGUi02ejI7YhnV0jzjab/WhL2Wc+46Ia9ErE3hcGm
         h5DSgwfoPk5/9z4d8cxR10/1pnkrNVMzFwWJYl89cd6SzB4Xo82Q75u4PRoTavfDgQer
         16MJPawwfwF7XrmzeUghiNv+55Mf7pxjxvMyo3gDGPbrny0dU03ARtxudtzPRooYuY6B
         +lFE6zioMVtYH9ceA89q2cuDcIUQJVuzDaKHeE8ILjAxQoIQODLZh80gOJWZoj/tDqjl
         +6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjpJNs0J12vp1IhfE1UDS+GBxWHaPxs/MJ4w9Q0NI04=;
        b=EWDUXRm1jy+uPiQdGgW1Z00javdruaqpsGSpLKwc6UfMam9gOVo39XI7lB2Vocm7aO
         BfrzNkY470LhqDh6h60nwguTAHhvuyI+dF1LLoT/eJL1KMx4UM8MzBu0gy5qyO4RfUix
         W4l0ByZbqVh3FuaEGPeZ7tHLIfehS31zTFp3YnHjvpxRWlHAQCTJhEv8uusC48f0tD92
         2weKsYQNW7kUNW97QOJ7u/zlve2d5kJGG/QC7Fb68qb28csl6/VhwsqeKGZFHWXljfs6
         Hp1mRT9zrnne1Dmw4IYLXhasPSfrdFxjJNGAXGj+/IbkE3Vwdxoa4aKq0j53nJjlt4Mw
         jrZQ==
X-Gm-Message-State: AOAM533k/EYeTU/mYA+Y6yoLdO+0oUs6CFfGFYZbU42RvOhYGcDthalw
        7LW+jIzHhEuVyL0azgL60WSobxr++MnOOEugfUW1rMHz72pz9A==
X-Google-Smtp-Source: ABdhPJyefunSNBjc33jM0hiZCz2tsvHkqwoJ3p0w2/HJkrB9lJcKW/qY+D7/0W5nvugdLhtFGClyj3y0HT/DvJN4uz4=
X-Received: by 2002:ac8:b0e:: with SMTP id e14mr17833369qti.360.1612233269172;
 Mon, 01 Feb 2021 18:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20210128112714.16324-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20210128112714.16324-1-tangbin@cmss.chinamobile.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 2 Feb 2021 10:34:17 +0800
Message-ID: <CAA+D8AN-E7HDHLOO_rnu3spwNS5GczPDMAsM+A3J66Zfhd6G-Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Utilize the defined parameter to clear code
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Mark Brown <broonie@kernel.org>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 7:28 PM Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
> Utilize the defined parameter 'dev' to make the code cleaner.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
