Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5B1372526
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhEDEgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhEDEgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:36:31 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94764C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 21:35:37 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso7196587otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 21:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=12EeYennVqX2P8FOG2dNNIcrhuVTc1/1jZXtCarHoKM=;
        b=MSPmW8/ZKloKD0QDPiin1h8IqReGKHeqHXMAsiYNU6k3yqy+Tyd86qOIUhBCloDcgQ
         /LA7Rs5mdwb+VyvpdAb25xBsIbQQ9JaXe/e9+dcE3b4+ZERwRX0oSSrK2EW67kWcAWKX
         VajqY9gCYR41BVR/gaGhPObohRvZkgAD8FUaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=12EeYennVqX2P8FOG2dNNIcrhuVTc1/1jZXtCarHoKM=;
        b=rzeQcEuqpTDxQkfTUF9PL2o1lDAOWr2pKVyDtkfn0CGQY8GMKCiHP20uFo6tXz+GHp
         4CyqneScefj0vgVvp4ka3jnXpEAtgKKsZipnpKGgQ2wTODWx6jU816CCY+AFDSmuD/s0
         KlTGpRmUTGYgkH4AAhPR+L5MGQhLSrMyKxDJbhx8oDhvvowqA3ifF9x/pNcY44cWXFJU
         ogNTJxH6A1J9XckpNWctN5QLfjVYzDZKz/ia4CUFejHqABiKWEylTWb3wkWxDzrsx72G
         gDwXYnmyjK1Bx+9acbfBuVm2NYQa6TAdY9Iu9V8JQ8XowLe3L7Z7aR/b6msr/P/lXYzF
         l2lg==
X-Gm-Message-State: AOAM533Um5beW5PEOfvXzVJOdpLSiFauHCmpKwsqHjq89gvNlY/qCOD9
        5Md/tRIrSpV26fSIhYOS4t+VCklmPamN01jyyBKbVA==
X-Google-Smtp-Source: ABdhPJwjtAQf7I6rJSTL2NdHu7gm1KwLrNIZrA2fuZntbiIwPRA8HpdUJT6TpqFrmficTe1/yOI0+5z2M/cw+exheHY=
X-Received: by 2002:a9d:5e19:: with SMTP id d25mr17257855oti.308.1620102937013;
 Mon, 03 May 2021 21:35:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 21:35:36 -0700
MIME-Version: 1.0
In-Reply-To: <1619048258-8717-5-git-send-email-khsieh@codeaurora.org>
References: <1619048258-8717-1-git-send-email-khsieh@codeaurora.org> <1619048258-8717-5-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 3 May 2021 21:35:36 -0700
Message-ID: <CAE-0n519sFBeLsNF8=Ci1y_xfY4dRuPRNHnJ++ZXHgj6Z6LhQA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] drm/msm/dp: dp_link_parse_sink_count() return
 immediately if aux read failed
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-04-21 16:37:38)
> Add checking aux read/write status at both dp_link_parse_sink_count()
> and dp_link_parse_sink_status_filed() to avoid long timeout delay if

s/filed/field/

> dp aux read/write failed at timeout due to cable unplugged.
>
> Changes in V4:
> -- split this patch as stand alone patch
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>

Can this patch come before the one previously? And then some fixes tag
be added? Otherwise looks good to me.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
