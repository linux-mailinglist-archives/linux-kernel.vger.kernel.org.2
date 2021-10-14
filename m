Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB50642D764
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhJNKtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNKtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:49:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B578C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:47:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n11so3902318plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDHFPubGokMv610+PS+/OMv3n5xorR0TmYr48ehh8fQ=;
        b=bjDwtXzpCqnuSRQZD6MOVaavAzBjpwMAnFWtZemyDCR5/A9nCz9VyYcMaO+PuwyUB2
         2tMBe1RcEWt5Q03VT9my7r6i2EBdY/5bAlqbKH7PY/2jLvuX2tFXomJGmStjyAq9i6bu
         8JcfH5f5qePcEyBTZgoN65wnmQFirKACUFYTIGeTRf+XUSNoH4GTJ+qDf/As69ADE09P
         Wi5DqwNT7QiiANRIgoWexPCgUXWG6FJUAkuqEKtPyl8aRkeJjfeRONBZvF/9H4egUOm4
         HRpezQZy5paMRwQKhA2Zu/774G3QklrNqWJ9+OdMPfUhucGS9lhOeUdDoOtq5IeyJqIW
         yuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDHFPubGokMv610+PS+/OMv3n5xorR0TmYr48ehh8fQ=;
        b=v/JiJRzL1ajpDCGaxCcsI6jBwWhU1O9gJNnz7rjn6S1vsHbq7cC0Wk7hUBSA0MLLET
         oMX0Z7Ay1IGcfkSyrevNlWf+OwLpYFY1+C32wV05T7AAXTEZla4oqtC1ZsPNp8Kc8daD
         jmJVsTGjkyCUo+pMz1WFcKatsLlkL+SbErK0YVtH+Sd0JFEZoknmZ6iSPSNhV0Gjcv2h
         ulj394mC8XArM8z5jQ1ErV5CjsNK22FSvSphHRwBZvgqoRSfkGBviWfgq5IU9DK/4gcB
         xRKP3atA9WqluZi8ArnLPdswtlsVy3JlLrMTT+vnZoT/c0e7fKGmARga4VCziAGqn6A6
         iy6A==
X-Gm-Message-State: AOAM532gnSN+j4DDjs+U2GLsC9zlX2jkcOm9F5ueVUgSJwo3jEOvho0M
        krpDEiVqEAv5GVCAwA9dAMZGjpawNEZqGU1L4KulOg==
X-Google-Smtp-Source: ABdhPJxwuVgL0hLnQm/+FBBbUWdUYrXi04zMewbUDkI/oq8PjXnSCIfrj6K4/4AjuAL3jlBthIZKDoiJlwAu858FLkU=
X-Received: by 2002:a17:902:6b01:b0:13e:50bb:790f with SMTP id
 o1-20020a1709026b0100b0013e50bb790fmr4251618plk.42.1634208432237; Thu, 14 Oct
 2021 03:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211014093112.3852491-1-fshao@chromium.org>
In-Reply-To: <20211014093112.3852491-1-fshao@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 14 Oct 2021 18:47:01 +0800
Message-ID: <CA+Px+wXWS4hteE-o_uLi8DxgLK3TKkWzGmHGEE02ALzA1GRDoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mailbox: mtk-cmdq: Validate alias_id on probe
To:     Fei Shao <fshao@chromium.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 05:31:10PM +0800, Fei Shao wrote:
> of_alias_get_id() may return -ENODEV which leads to illegal access to
> the cmdq->clocks array.
> Adding a check over alias_id to prevent the unexpected behavior.
>
> Fixes: 85dfdbfc13ea ("mailbox: cmdq: add multi-gce clocks support for
> mt8195")
> Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
