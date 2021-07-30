Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BDE3DB023
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 02:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhG3AHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 20:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhG3AHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:07:17 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE52C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 17:07:12 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o12so4509362vst.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+xYEU7GGmWpZRCP0v/62bsuQOHLx/NQBjwr1YpFdkM=;
        b=drIAYW+zXFJ+cbbCXFBGz0LWySE6GoP8M/FmnV8wYBubfbEXrQBU7SR9pmjYeGISrf
         xPoprO6u0MS59ubngZDL0/Go9vBy7rLhQZrt6OmuYLMp7olW7fW2yXKZDJMXu1uIfFFm
         R6sQ0cnJhb7jXY2xOm6yGgd1FCPYRh04qE60c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+xYEU7GGmWpZRCP0v/62bsuQOHLx/NQBjwr1YpFdkM=;
        b=BvjL8JLecdWdoVTAxkM5rhtxwdq3w/5oNqi/Qsn+oM5RnsvFvlBOzb3amcisOY76/B
         3WAEDT3/w+6xCS94b+zR4fxoZE3OzIgHgV61NGkZVDrctJQuR14TEl1SbvrP/rq4/VGi
         UzHTbUKi+fnToKuCuhxLPWdqKa8x7C57nee3TZaTeVcH/mYh3yAMu8UcbQmHAZ/JInvT
         uCo4naJ6pm2yUJhglQqiEdpVy+AAwlmcBXED4p22YOa+ZGnjsz37fjUw+crEKd+5rUjL
         BHBAN3ruymUXgxzPivCm+Qq0Id/wf5hz4qmehcaT5XEHWa5/WnPwc9lppKLfaf9+FIb5
         AO9A==
X-Gm-Message-State: AOAM532ZT2O9iDkWkp5uczG6oAVfmIBDlwsitgAiV0fn4tlNNuKdram8
        zMuZpVsldFZzYYh5qJ6A983lwh7GRI36Gg==
X-Google-Smtp-Source: ABdhPJz4nmZ9y/z59N3DGHlSDwLZhlFM9ARiBqxd/IVBcYZGvOGsiA+ANJtQFnFWz/uAu95X5TXgXg==
X-Received: by 2002:a05:6102:38d2:: with SMTP id k18mr3825679vst.39.1627603631665;
        Thu, 29 Jul 2021 17:07:11 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id g70sm751vkf.24.2021.07.29.17.07.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 17:07:11 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id w11so3261141uar.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 17:07:10 -0700 (PDT)
X-Received: by 2002:a9f:238b:: with SMTP id 11mr7438420uao.91.1627603630500;
 Thu, 29 Jul 2021 17:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627468308.git.robin.murphy@arm.com> <CAD=FV=U5a=aj5NPOGywVoEGQLuza9T6RhBhw9NT2AT2qxaKzYw@mail.gmail.com>
In-Reply-To: <CAD=FV=U5a=aj5NPOGywVoEGQLuza9T6RhBhw9NT2AT2qxaKzYw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Jul 2021 17:06:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xek6_Qp7U=PrvGgVTQ9BqDwN34QVKAhgrMVCh=PjvBqg@mail.gmail.com>
Message-ID: <CAD=FV=Xek6_Qp7U=PrvGgVTQ9BqDwN34QVKAhgrMVCh=PjvBqg@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        suravee.suthikulpanit@amd.com, Lu Baolu <baolu.lu@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yong Wu <yong.wu@mediatek.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 29, 2021 at 3:33 PM Doug Anderson <dianders@chromium.org> wrote:
>
> I was definitely getting some inconsistencies in my tests where the
> eMMC speeds were getting into a bad state, but I don't believe it's
> related to your patch series.

I think this was just me being an idiot. I forgot that I'd been
running with KASAN, so that explains why my speeds were so much slower
than usual and probably also explains how it could get in a bad state
(I guess it also explains why sugov was eating up 30% of my CPU time
since that went away too!). No mystery here aside from why it took me
this long to realize it.

I'm now getting ~213 MB/s without forcing it to lazy and ~261 MB/s
with forcing it to lazy through sysfs (and without any other cpufreq
hacks).

-Doug
