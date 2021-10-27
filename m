Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3214243C354
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhJ0G4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhJ0G4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:56:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81AAC600CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 06:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635317620;
        bh=xepLovygauICQFWAMW206vbB3Tk4AxyUsvkOc7JR6XE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TLTARwnS1cG4gwylQti0I+1AArS82upBMxvzkQqdZPOyUZo+zn6yC0CfAT2s26SSE
         FLOk3JPEMMO75yEjJxHHecUcB6n/DtOwO2LVgZHe0UevbC1pRh/ZHXU92Y0Ucm3Zta
         TH/aLCp43N7D+ON8YU8kk3vhf0tP/L3Nw2jRwesOwneJ+xgMm+M2Sp5es/sA9OuaEV
         XR6UGhluvAekj9OKuDYHDmC07tae3arTp+doyAxf26Zg7puijoVO8OYSuCkw5Gtn1K
         +BZVXgW9p0m/l4rdOVszP7pI+lH1DvIyzyIbon/9e0HNyPVIOlAMlqG/h0CCg6VsE6
         nxsXNqA0dt0+Q==
Received: by mail-yb1-f176.google.com with SMTP id o12so3895968ybk.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:53:40 -0700 (PDT)
X-Gm-Message-State: AOAM533TJKw1FPOA6vWfVP+pFt9nQLeBE6NAMhJDJG0ZSL1pRzo3Dwsp
        bkBFsYAyd1zF13vjkg7FAQSnWLlPY9q/OuQdRnc=
X-Google-Smtp-Source: ABdhPJyybf+pVc2DTqNjWLxq8fur6Hv6aJ8bcIUw0R/nyjAM8h70R7ykThvfW2zZ6mu88KEvWNtda+kS/onZ2YrXcic=
X-Received: by 2002:a25:c341:: with SMTP id t62mr29090306ybf.342.1635317619783;
 Tue, 26 Oct 2021 23:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
 <YTsQJ753sm701R/n@kroah.com>
In-Reply-To: <YTsQJ753sm701R/n@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 27 Oct 2021 09:53:13 +0300
X-Gmail-Original-Message-ID: <CAFCwf10GD2dJMZW0DtFUFOZdXuq-opcEKEhwACbApxybjp2M3A@mail.gmail.com>
Message-ID: <CAFCwf10GD2dJMZW0DtFUFOZdXuq-opcEKEhwACbApxybjp2M3A@mail.gmail.com>
Subject: Re: Habanalabs Open-Source TPC LLVM compiler and SynapseAI Core library
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:58 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 10, 2021 at 10:26:56AM +0300, Oded Gabbay wrote:
> > Hi Greg,
> >
> > Following our conversations a couple of months ago, I'm happy to tell you that
> > Habanalabs has open-sourced its TPC (Tensor Processing Core) LLVM compiler,
> > which is a fork of the LLVM open-source project.
> >
> > The project can be found on Habanalabs GitHub website at:
> > https://github.com/HabanaAI/tpc_llvm
> >
> > There is a companion guide on how to write TPC kernels at:
> > https://docs.habana.ai/en/latest/TPC_User_Guide/TPC_User_Guide.html
>
> That's great news, thanks for pushing for this and releasing it all!
>
> greg k-h

Hi Greg,
I would like to update that yesterday AWS launched new EC2 instances
powered by the Gaudi accelerators. It is now in general availability,
and anyone can launch an instance with those devices.
Therefore, one can now take the upstream driver, hl-thunk, tpc llvm
compiler and SynapseAI core and execute compute kernels on the Gaudi
devices. I have verified this to be working with the driver in kernel
5.15-rc6.

We are still missing the networking parts, but I hope to start
upstreaming them in the next coming months.

Thanks,
Oded
