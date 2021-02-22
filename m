Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8519B322259
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhBVWr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhBVWrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:47:06 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E6AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:46:26 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id 62so4898763uar.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2HpjzAoLzLCmlgkDfl/tSuUlKCcUXEeVTAgdZrf5xA=;
        b=K6loj0eyjFQktbWgQSlaqcz0cJ9HJQxnJHRO8jplLVCX/ibIdtI1yYvK8qZCHrMrRX
         kRlgFRetRZq4pEyJDY2VsRofVyaoXoJz7A19lTEuN5Yq0/0KFbUdCyVbgAp+Z5mYSbGK
         +ficRGKmQKGqj/vV+pFO1qOzMLwTbHTjFV3h4NwETuXjJwg1jZTQWuGHZbTJrel8XJVG
         v7naLAOmbfnyysXbaIjA+FmFYj78IEWyoRE1zWWLmtQQ3ouHyz/pAf23+DEXSPR1vcS5
         Wp2ATsPT9VLnn6FP3SgHwFF/+kCcU76VXAqal04fAzLnz5rXZr2e0oJYAyN7xs4tSbL+
         ujuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2HpjzAoLzLCmlgkDfl/tSuUlKCcUXEeVTAgdZrf5xA=;
        b=j+QtYmiD+qRBPfLpuE3wMsrVtJH1ptYqzLfRRN7qdbYG9gA4RawU891hA6YcBjgMhf
         6F3ZSUa8LG/O/k8drXtvTLShgdom1cAqkFSZko8HhThvgRD1ZodmLWh3fvF+dMsqj5jv
         UBJXQL2uZLFN0WWnvnPqqosgyQYJ/RdyIyJId+YqcavkhxTR0be8NoivmS6bcmVQ5m3X
         NRx0B9CtYpplvoW5/ktzDR4EIjPcCmKpk2E2cemtU5r9aTUVBKjSHX2ifJJjnQDOiTbE
         vGJoD/KAL6zKGMCFkujseyZfIaK+Zw7BJGemIC3e+R0077ORHpSxEG+lr0tApzTTKtBt
         KLSg==
X-Gm-Message-State: AOAM532J7LqYffjc5JwL3nfrKAzRnpmborVGr3XLanvFEsTp0+kvsPex
        1uHI0rWM4gtgSoRUhZmo6JGyamkpp1Habo263m49/Q==
X-Google-Smtp-Source: ABdhPJwSkGW+oV9LW436LGwuZxz9jgcyYsjgp3ZlJ4etIku1PAyDjKKkaa7dO7iRZYFD+Y4XSA+IPCQcUBPBsvC1yio=
X-Received: by 2002:ab0:6ecf:: with SMTP id c15mr16126581uav.52.1614033985087;
 Mon, 22 Feb 2021 14:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20210222072217.15633-1-jindong.yue@nxp.com>
In-Reply-To: <20210222072217.15633-1-jindong.yue@nxp.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 22 Feb 2021 14:46:14 -0800
Message-ID: <CABCJKudwajnmHAEC1XAH=pouCoOXq7q6NmpLST5pba8ejU6FtA@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: core: Remove casting to rproc_handle_resource_t
To:     Jindong Yue <jindong.yue@nxp.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 21, 2021 at 11:18 PM Jindong Yue <jindong.yue@nxp.com> wrote:
>
> There are four different callback functions that are used for the
> rproc_handle_resource_t callback that all have different second
> parameter types.
>
> rproc_handle_vdev -> struct fw_rsc_vdev
> rproc_handle_trace -> struct fw_rsc_trace
> rproc_handle_devmem -> struct fw_rsc_devmem
> rproc_handle_carveout -> struct fw_rsc_carveout
>
> These callbacks are cast to rproc_handle_resource_t so that there is no
> error about incompatible pointer types. Unfortunately, this is a control
> flow integrity violation, which verifies that the callback function's
> types match the prototypes exactly before jumping.

Thank you for sending the patch! It might be worth noting that Clang's
Control-Flow Integrity checking is currently used only in Android
kernels, so while the type mismatches are real and should be fixed,
they don't result in runtime errors without this feature.

> To fix this, change the second parameter of all functions to void * and
> use a local variable with the correct type so that everything works
> properly. With this, we can remove casting to rproc_handle_resource_t
> for these functions.
>
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

This looks correct to me. Please feel free to add:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
