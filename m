Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DDE450A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 18:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhKOREu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 12:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKOREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:04:34 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85391C061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:01:37 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id l19so17458475ilk.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHYUc1wY+XMa4sqcWEtA/HMvxlAjaod7I7i3bx8oN/U=;
        b=ME3F1CzdIJN0UcKqKbpvONGd5csvj2s7zS3j9uI2pJ8f38CiPlc8nGUTErUKNCyzDW
         +jdwqK+nDQ4osS1zH1q2FzYO5iz+SCXbtmHzN6pwG1aBIgLHi5FnBqfY01Hdc7vIfvrf
         gewh4aE6dk3mvwhfcW+gLqHtAiuDmruJCwHG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHYUc1wY+XMa4sqcWEtA/HMvxlAjaod7I7i3bx8oN/U=;
        b=6s5ERO9BIfLrD6XxxCSrt/rsWC3dZFNnPm4OSVNY90bb9Z5+WhEGAYz2mIqZpleVTm
         JgXmFsk/9ZjqalnCvytcSJ1A8oQVMOM2Fu+9/xo4Jez1uiXF5MrMYotUdNHl7nRtxDsG
         bR+xldprmTeaiOe3FlPVVQyva8QUZfT35k3aQb0ZPu5f8xNKJFKb5hEG3ue0B6nKFmam
         A6QE4QFNh+ruflTHSoohACoVvxjqx/fztWuW8SAfzi8dszEQ2W6ih3GpU5V2X1ERC6Ot
         bGaBZrUGAEAwZP32vZmYJdzaAEy/KjUoD9Uok5aywG0fyfysEPhxwZ1LYxfs+SgUQMoY
         WJdA==
X-Gm-Message-State: AOAM532PKbBCKzXrp/X3S65+hHGh79evYuttO74Yuye/czoSIX3iLyF+
        NWTgrUA7K9qcba++Hm2iCzBMKT4RQ/5ZCg==
X-Google-Smtp-Source: ABdhPJzMAor6SH6yRWzgbYwPTlqpgx2QJRO6sPBus3pb1MQ8SOnk6dz8/GI9oCZmr3U3PkDbmTpxNg==
X-Received: by 2002:a05:6e02:1a81:: with SMTP id k1mr208931ilv.163.1636995696802;
        Mon, 15 Nov 2021 09:01:36 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id k8sm8990758ils.79.2021.11.15.09.01.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 09:01:36 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id x10so22377262ioj.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:01:36 -0800 (PST)
X-Received: by 2002:a6b:d904:: with SMTP id r4mr245251ioc.52.1636995695808;
 Mon, 15 Nov 2021 09:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20211115154201.46579-1-andriy.shevchenko@linux.intel.com> <20211115154201.46579-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211115154201.46579-2-andriy.shevchenko@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 15 Nov 2021 09:01:00 -0800
X-Gmail-Original-Message-ID: <CAE=gft4uiP8fVyE-+KDM_LQBKTwPMOb51JWU7=Jt=ggJV9dSFA@mail.gmail.com>
Message-ID: <CAE=gft4uiP8fVyE-+KDM_LQBKTwPMOb51JWU7=Jt=ggJV9dSFA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] i2c: mux: gpio: Don't dereference fwnode from
 struct device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 7:42 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We have a special helper to get fwnode out of struct device.
> Moreover, dereferencing it directly prevents the fwnode
> modifications in the future.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
