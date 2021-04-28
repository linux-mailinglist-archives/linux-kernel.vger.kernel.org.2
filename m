Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6A36E182
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 00:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhD1WXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhD1WXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:23:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FC4C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:22:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2so8988719lft.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rY2O6I8V9olhtWB9b4/RtsHeRlI9151ci1isDXaebA=;
        b=D+vRDauZOJdt3mAK066Dxx+uj5KyRs+qmiKOMPZC9S/2G5C+tru2w9J4y2E8JNeasO
         +5HA2gsch9GyiZ783mgiJPhJ7Fh4Qwyh/TT5QHc/F5NDfPzNCp3R615E/jBxQxl0/kHd
         NxZkr4cC8HiIq4i8kmhALYx9My1iGo3NNacdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rY2O6I8V9olhtWB9b4/RtsHeRlI9151ci1isDXaebA=;
        b=ucfsNmd61tLn4ZpkdYBaI04AcRsroMnjd/rsHRbKho+PwYgTHCdSTAqUH6z7AyC5SF
         vGmuV02+bu3zzWqGDc7+FEYAbb84LjosCm/DG5NRgSWRufG5NipKtoXo1s+VC4pkuQvi
         pdeNUGgJ0JxHAd81W/GUNVXMwySh70oGwcopqaZprXadlLchWLiJatbuNvpc8WFA8wgC
         AEzp3FlXljkRrcuqA5B1pscjpt8cgh7bJPyvkWYpoFwcO769JO3htYOJ5jVgOQrR7qTk
         DKmmHN1XgWCrCxDalUT07H+WxThT6EsIjZ1kw5v33qrYbRlIFGIFgz5YaPJNxDRvvQgi
         eVMQ==
X-Gm-Message-State: AOAM530u6IZZuffOXlh7MQgYkTgdj7UFS76JnBkUyCnxiN2y9CgRO4Y6
        TJcqapUUH8k8L4VPoxcAfhW7Rzg/xI3Q6Yby
X-Google-Smtp-Source: ABdhPJyXDmhADgZcAB9npKu9b8RgzAL9yRifRFnjL2v5m58oQUnrLFaQDoSVWW2N2uQGywnMXWbtLg==
X-Received: by 2002:a19:5207:: with SMTP id m7mr22520458lfb.611.1619648535199;
        Wed, 28 Apr 2021 15:22:15 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id r16sm213570ljk.72.2021.04.28.15.22.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 15:22:14 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 4so41813596lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:22:13 -0700 (PDT)
X-Received: by 2002:ac2:5f97:: with SMTP id r23mr2129654lfe.377.1619648533751;
 Wed, 28 Apr 2021 15:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txMo5f9QvPqdzt8g3CmUpyDFf2Q_0XS4V1FyjHX8WQPRA@mail.gmail.com>
In-Reply-To: <CAPM=9txMo5f9QvPqdzt8g3CmUpyDFf2Q_0XS4V1FyjHX8WQPRA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Apr 2021 15:21:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3x4Q4pCkYe7__OAnvOyPqdZLN5ha0z4U035FwT5G57w@mail.gmail.com>
Message-ID: <CAHk-=wh3x4Q4pCkYe7__OAnvOyPqdZLN5ha0z4U035FwT5G57w@mail.gmail.com>
Subject: Re: [git pull] drm for 5.13-rc1
To:     Dave Airlie <airlied@gmail.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Sun peng Li <Sunpeng.Li@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 8:32 PM Dave Airlie <airlied@gmail.com> wrote:
>
> This is the main drm pull request for 5.13. The usual lots of work all
> over the place. [...]
>
> Mikita Lipski:
>       drm/amd/display: Add MST capability to trigger_hotplug interface

Hmm. I've already merged this, but my clang build shows that this looks buggy:

drivers/gpu/drm/amd/amdgpu/amdgpu_dm/amdgpu_dm_debugfs.c:3015:53:
warning: address of 'aconnector->mst_port->mst_mgr' will always
evaluate to 'true' [-Wpointer-bool-conversion]
                        if (!(aconnector->port &&
&aconnector->mst_port->mst_mgr))
                                               ~~  ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~

and yeah, checking for the address of a member of a structure benign
NULL doesn't really work.

I'm assuming the '&' is just a left-over cut-and-paste error or something.

Please fix after reviewing (I'm not going to blindly just remove the
'&' just to silence the warning, since I don't know the code).

                Linus
