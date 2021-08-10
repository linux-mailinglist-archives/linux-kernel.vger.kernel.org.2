Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1B3E85A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhHJVuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhHJVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:50:03 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD20C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:49:40 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id e13-20020a9d63cd0000b02904fa42f9d275so891212otl.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+HYiu1hW88Bpj8WftJ5CqOz/LeBLWxJEO+HNgAITcxU=;
        b=f/xWfkbKitmRmGG+Ekhc7MQBa3QgQs/6Zk8sKw0qdYl62Xwpi3CX4mYHsahRMBxy5f
         Ik1Q9sJy77ceI/3yp+qhALsMcAcLPD3NleInGIoO8w0rtylP7FsxDgC5kWN4LrhjNToV
         HGyfInuryvPdOPn/iUR7AO21+najA4fciE/lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+HYiu1hW88Bpj8WftJ5CqOz/LeBLWxJEO+HNgAITcxU=;
        b=YIjnNTJHZjOwnhBuDz1W/1pMrzSVY9NhZ1/zNbMJK/bVA0X1PjsFnPvIrGkrAO7dk5
         UOkdSYca5OapckxrFuwA1L+vvVheQY36tWYBSRLEVOJyvaz//BOTQ3Q45wMNoudfFbfB
         C8vjNk8Q5s0S1L9NNAJCdsiG5/miyVVgTMitTxqHvBsMyV5HFf6G8BwMk8zviOkg2bdp
         zevvJpQOps7y0IJPdBoXurRgNkIz860y0dmc+43h9dl+b0q7w2szLpNPx3D/RuT9lbNQ
         sbYy1g5q1+3+PaHo6ZFUAQmHXNTZhMdZ+XQLM4watwkZ+nNiTPPC/C+F8wEAXyf/7mJ6
         zEBQ==
X-Gm-Message-State: AOAM532FpiNXIhbgoU1lNXWn65LfPQpXMkEcnqECdN4UjVrBg/Pcig0n
        ssOKmdlyYX3Fky0pQYNGx1V9hSf8c6UPu77hbJ32BQ==
X-Google-Smtp-Source: ABdhPJwWB0tX5GDFBeHZ1LiAt30TiVNcHXV5DfsWQz9Zp1GM9/8CHg1+g2E6eAgybkGTqrk8/i3G9uSY7xs2fWzT30k=
X-Received: by 2002:a05:6830:44a7:: with SMTP id r39mr22563794otv.25.1628632179611;
 Tue, 10 Aug 2021 14:49:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 14:49:39 -0700
MIME-Version: 1.0
In-Reply-To: <1628196295-7382-1-git-send-email-khsieh@codeaurora.org>
References: <1628196295-7382-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 14:49:39 -0700
Message-ID: <CAE-0n506f7yb3g7bGj0Xk43qL1Xw2Qzo5nRw76sdAYZz3NhO9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] add fixes to pass DP Link Layer compliance test cases
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-08-05 13:44:49)
> add fixes to pass DP Link Layer compliance test cases
>
> Kuogee Hsieh (6):
>   drm/msm/dp: use dp_ctrl_off_link_stream during PHY compliance test run
>   drm/msm/dp: reduce link rate if failed at link training 1
>   drm/msm/dp: reset aux controller after dp_aux_cmd_fifo_tx() failed.
>   drm/msm/dp: replug event is converted into an unplug followed by an
>     plug events
>   drm/msm/dp: return correct edid checksum after corrupted edid checksum
>     read
>   drm/msm/dp: do not end dp link training until video is ready

I'm still able to use my Apple dongle with these patches so

Tested-by: Stephen Boyd <swboyd@chromium.org>
