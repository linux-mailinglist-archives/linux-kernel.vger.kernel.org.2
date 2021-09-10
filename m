Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DAC40679B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhIJH2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhIJH2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:28:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A7F2611C2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631258843;
        bh=e/aon/mWpT9jEBV4xXDuCYPMB40JgroeSMyJbNSkjtM=;
        h=From:Date:Subject:To:Cc:From;
        b=qFCWsm2H6z5YEz9OJJn6h/EVXxqIfcc5HEbCv8PkDNHr0g/VjQrvO8cQxYI5Bhgga
         J4j4QUtNX+zrDnkO9juk1GYhmK8xNkxZEm3Pf16qT+DO/dkCriad5nn/9ETIGmHeqo
         5anQ3c/VYoxs+1sGRJhDN/DEzz2QnAVUCmXLZZW8Xh+r8GzSVkk3TTTr43dyoT0Vzu
         C3mACw6loZElwk08A7IP/dFrHs55dAA0mtW3Q1LMA1ifQ6lEuDwANSx1TUlClE4UzQ
         LfAKTwWkbGVCW0r5MAP9TE3fn7D2O1bQh0mJvvq9X3avLeDmLkki2vE6YI15FhgUoS
         8TpesnNSVTjiw==
Received: by mail-ot1-f49.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso1104603otp.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:27:23 -0700 (PDT)
X-Gm-Message-State: AOAM531rYGTcMF4n57CL9COZszytd6Giy1vx8nYdE3MZfQc8cdwy6EES
        1INS5MuxqwJwH/NPaEpjbMo01Ska3lK+hiDa8e4=
X-Google-Smtp-Source: ABdhPJxABlZNR2Ssx5BOaBPiLkvk+4D/rGc5Q7ZwTdFgbscsylqVdwtBM11YWFVwLgRqnk/vBSc0s56XqFN9y+0wze0=
X-Received: by 2002:a05:6830:12d7:: with SMTP id a23mr3433797otq.102.1631258842905;
 Fri, 10 Sep 2021 00:27:22 -0700 (PDT)
MIME-Version: 1.0
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Fri, 10 Sep 2021 10:26:56 +0300
X-Gmail-Original-Message-ID: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
Message-ID: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
Subject: Habanalabs Open-Source TPC LLVM compiler and SynapseAI Core library
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     mzuckerman@habana.ai, dsinger@habana.ai,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Following our conversations a couple of months ago, I'm happy to tell you that
Habanalabs has open-sourced its TPC (Tensor Processing Core) LLVM compiler,
which is a fork of the LLVM open-source project.

The project can be found on Habanalabs GitHub website at:
https://github.com/HabanaAI/tpc_llvm

There is a companion guide on how to write TPC kernels at:
https://docs.habana.ai/en/latest/TPC_User_Guide/TPC_User_Guide.html

The guide details the TPC compute engine's architecture,
how to write TPC kernels using the TPC-C language, etc.

In addition, we have written a reference implementation of the SynapseAI API,
called SynapseAI Core, and released its code under the MIT license to the
open-source community at:
https://github.com/HabanaAI/SynapseAI_Core

SynapseAI Core contains all the necessary building blocks to run Deep Learning
training on Gaudi, although not as optimized as the closed-source library.

The project repository contains a couple of TPC kernels that implement basic
DL operators. These kernels can serve as an example of how to implement more
complex operators.

To work with the Gaudi device, the library calls the Habanalabs kernel driver
uAPI through the already open-source hl-thunk library at:
https://github.com/HabanaAI/hl-thunk

Moreover, the library contains a few tests (and more will follow soon) that
demonstrate how to use the SynapseAI API to run workloads which utilize the
TPC engines on Gaudi devices. We provided a short readme that explains
how to build and run the included tests.

It is important to note we provided all the necessary APIs to connect this
library to any Deep Learning frameworks by writing appropriate backends in
the frameworks and by writing more TPC kernels to implement the different
operators.

Once the driver(s) for the Gaudi NIC ports will be upstreamed, this library
may be used together with IBverbs to perform training on multiple Gaudi devices.

Thanks,
Oded
