Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915FC407EA9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhILQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 12:39:06 -0400
Received: from mail-4317.protonmail.ch ([185.70.43.17]:49223 "EHLO
        mail-4317.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhILQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 12:39:02 -0400
Date:   Sun, 12 Sep 2021 16:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1631464666;
        bh=iWrsRXODT54fDjqbomuMW+tTamZc86GMmNWS6hNNFB8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=O/hynjvK8++aD+Cgq1/CvOwTKI0hr91VGbBx3avDCjd84t91P9UnNaqQIPOoAEICM
         xFi7eNm13Vh6aCSM2JrhLTZ50PjBjI96AFC8BAf4CvxvPKNaUdYg7PTrM/JC7+iZ3D
         DqRzpSD1x31vPa0Y9o8DUlm6OzfLc+pVTwE4R4KpS0uEWzhN4oyLeeEJps5qqgru2v
         6PsH9HVq9BhVzkVoPKjBsTG9Nt5tkDApBLnSYFQk2cwVdwtFOFNQ8Tkfq3GQUkcECl
         flMewAJ1ylCoutOibTmhIqjHaLo7ZN8CsMfQDxf8gMONlkdDs6XgSAvtMOOzaT89f9
         PKLsK17qLfbGg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Oded Gabbay <ogabbay@kernel.org>, mzuckerman@habana.ai,
        dsinger@habana.ai, Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: Accelerator drivers going forward (was Re: Habanalabs Open-Source TPC LLVM compiler and SynapseAI Core library)
Message-ID: <acTm3IX-o1RL5nSrZMIEFg_B0T1ENN1Q7iAom58GH0pfJpVTNbghLwqKrLPDzyCjFKVsLmqmDy1PXrytJrXROTKs_ssjbf17oByM0UKVzIE=@emersion.fr>
In-Reply-To: <YT4GxO7ab+s0nbze@kroah.com>
References: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com> <YTsQJ753sm701R/n@kroah.com> <CAKMK7uFLBmdHphtnEa1nyAGUHdcP1KgmaK+vtV_GOU6wZZAOxg@mail.gmail.com> <CAKMK7uFj-m4y+N-q8uoNasJuksgDj-oRK3K=SjoyKMQL=QCENw@mail.gmail.com> <YT4GxO7ab+s0nbze@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > - move drivers/misc/habanalabs under drivers/gpu/habanalabs and
> > > review/discussions on dri-devel
>
> Wait, why move into gpu?  Are we going to do that for all hardware
> accelerators that we currently have in the kernel tree?
>
> These things are not GPUs in the sense of them being "do some work and
> write out to a screen", which is what I would associate with a GPU (G
> does stand for "Graphical", right?)
>
> Yes, GPUs can do things that some accelerators can do, but they can do
> things that accelerators can not do, and the other way around as well.
> I doubt you want all of the existing gpu drivers to be only treated as
> an "accelerator driver" now, as where would the logic that has to happen
> to get the bits out to a screen live?

This seems like a description of the "display" part of the drivers, driven
by KMS. There are many chips which can't do the "display" part, only the
"render" part. Their drivers are living in drivers/gpu/ as well.
