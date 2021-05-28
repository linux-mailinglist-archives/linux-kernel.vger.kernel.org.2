Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA896393BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 05:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhE1DMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 23:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhE1DMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 23:12:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6044FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 20:11:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o5so3183663edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 20:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95ovB6mTl7unMYoP9NBE1G6j4ilgAKOEVr/KalCHM70=;
        b=ftL2S4RcCxB8zP1xz37/HlN8LOJqNtdf+TWIE/PzfqqY/v8OFLsK4yuPwRXYeTJu+t
         YfKeqQfPqGzkxg+x3ORJ6KZR7mjoMCpZhr4pjTxucOHmIO2IaZ9+7l9eOdLsnquZBalu
         rXoEI0R8WJR1BVHYYENxcXqE5ur6nFyk03THB6WO5VBpl61ivQfnd2R3j7VvHA/Ze52F
         vm8HW3GAovh8pzdPhKgH2ESLp1f3guKR3400RuV8PL+scP1EALjBukwSNs4e966nIPhI
         Dh0Z5znqILCuzN9qUoNGeCyk4+EN22QRsNAfFYU3XYy/8zWT3u9nlCFbId3bpEZSBrJY
         +AHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95ovB6mTl7unMYoP9NBE1G6j4ilgAKOEVr/KalCHM70=;
        b=allX4HAEaNogVH7EW3pzuGi2AxuspTnl9VcQ1kWY/Chj+bvV3Hc5g0gxTPg4DRi2Cq
         6E1gMK3uHx52FcQBbMrFP4qfFK39o26O7haE310keXKYW59HQ3+jFj2/Tla/duDLcaDj
         vo9fYITa3idSN7blf2MGHqWF8glKGJLCvZYKPUq+9O4yexvmUtnSMGQIzQ15d3r2uus6
         0rWEeOwdM76Qm1UA0Wyt7q3w9+ePhOPnUA1qaC2UW9qoO5YqCQBATuaLbcbiwQTbTW5h
         ntFRwIKXlxeJ5fQMkooDTh0nnedoc5+6okZxfCX4cZdmfCbYyMYKkDp4sjHhYDIHJls0
         MFjw==
X-Gm-Message-State: AOAM531zZr0tj9vnTLqYfCWXRMKzwgS5ZrmDCWwsSYXk9+iC65iCYW90
        RLM42qBPKxPOLtMG+3mujI83SkHsI29Vb1XpK8XE
X-Google-Smtp-Source: ABdhPJyH4BzfWPIE7jZQJvXQcS6awX2OGahW6eCLQJo3LGQSsV7ghk8tANbxW7hsA9utyUgEbjmSjrX+ariNFOwxSQg=
X-Received: by 2002:a05:6402:128d:: with SMTP id w13mr7465577edv.253.1622171459983;
 Thu, 27 May 2021 20:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210527073643.123-1-xieyongji@bytedance.com> <20210527110730.7a5cc468@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20210527110730.7a5cc468@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 28 May 2021 11:10:49 +0800
Message-ID: <CACycT3tHi8zHJZu+OPVFs3Bk-M6sUx-fQz6aJ+hGSHLWd2Rh8w@mail.gmail.com>
Subject: Re: Re: [PATCH v2] virtio-net: Add validation for used length
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 2:07 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 27 May 2021 15:36:43 +0800 Xie Yongji wrote:
> > This adds validation for used length (might come
> > from an untrusted device) to avoid data corruption
> > or loss.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
> This does not apply to net nor net-next.

Will send v3. Thanks for the reminder.

Thanks,
Yongji
