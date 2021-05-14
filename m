Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ADB3805C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhENJCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:02:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49121 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhENJCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:02:52 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1wdd-1lWuzd2Wxl-012KIx; Fri, 14 May 2021 11:01:40 +0200
Received: by mail-wr1-f46.google.com with SMTP id q5so9880073wrs.4;
        Fri, 14 May 2021 02:01:40 -0700 (PDT)
X-Gm-Message-State: AOAM531WJ6ocJGOWRd6zQP2eLShEJPKrCGBfIKcIL0zRCJjAcBvZo7eZ
        jSPnw/J5uUtkjXqhWDIXgtft+QWwfFnzeJ/Rx2M=
X-Google-Smtp-Source: ABdhPJxv8VHGNOfjV9RrpHv39iyVnm5Pe9Y1SE1w04mZzpcZsc9bQBxbeEAkxeuQgpaiiu9clQ99pqFXwi1H5Br2ZIE=
X-Received: by 2002:adf:fe04:: with SMTP id n4mr433994wrr.361.1620982900203;
 Fri, 14 May 2021 02:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com> <YJ42MEgwDZrAEQLl@kroah.com>
In-Reply-To: <YJ42MEgwDZrAEQLl@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 May 2021 11:00:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pcBHfrwu9fHHRWim5WgQuCqpROpMM83yCCpjjwu1FJQ@mail.gmail.com>
Message-ID: <CAK8P3a0pcBHfrwu9fHHRWim5WgQuCqpROpMM83yCCpjjwu1FJQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TZYJvnLo3oPdqLhaYe7eUU7lGFrSxHlgB1OmPXFlYg8wHxIiotb
 8uXKIWvggNw+WY2MkYq0a5G7HNpbKf2HDoEWsFCcnHs8ZwVKQCcKnINH+M0xq06W6X8z/S7
 38UTpvlDnza4ljTo1ODuFKgjmRPbY77pEjbCDAxoco8WwuzdXplUeE0J5JNaXmZRueAf3yE
 oDQH95zL0q/kRdro1XDug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mlSdnVNAovA=:GWpmC+mYR8tjjhuCD9Jzyr
 CTi1c376xdcaQ7EAiJ2tzTXJAUycnPJrQ1sCqMWSIrq8kFqBg0uw5mBVAzQNhygQ9XyJhr0sn
 xqF7KKsttpMmZ+ppoIBbGXriifvpydaNLNn/Ab2Xgy9qAdEukhwHTZe43UNiVg+JXUCWoq4Dm
 f82rAf9DmDvrbP9YJR3or+85wYCzJI+UwCz4F5ew29nTHGWV2xLqZDqOrDjEvD5RRChZ74l6d
 A9/KPDYD6exSCuh2pp02FTl02KPrOPS6M7jZGtBMnoeuyCzPCg4/rZheJUw+ajJQRNDzb2+MR
 bq2RxaHl1C9RqD8fISMxAppuhc59jDtrxsenKk/T+ZdKCBYhuCn7X04o1kjDt56LNbpY+H1LJ
 SRtQFowy2A2YDfB5lqhK+frWt6i7uzlQlIE3GvPXSUcmWTM0Et1hsJpAmnZq/MDAoEUR7tLHJ
 qg5UuxlcHgFrX3Vn/W8G81yZ1sEKdPryKjiJ0kOy6HuJzH4tzv/SDuZwuD2UJjbUl1KEVifdI
 DW/cPQbIqxXq9DZJQ/xm0k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, May 13, 2021 at 01:00:26PM +0200, Maciej Kwapulinski wrote:
> > Dear kernel maintainers,
> >
> > This submission is a kernel driver to support Intel(R) Gaussian & Neural
> > Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor
> > available on multiple Intel platforms. AI developers and users can offload
> > continuous inference workloads to an Intel(R) GNA device in order to free
> > processor resources and save power. Noise reduction and speech recognition
> > are the examples of the workloads Intel(R) GNA deals with while its usage
> > is not limited to the two.
>
> How does this compare with the "nnpi" driver being proposed here:
>         https://lore.kernel.org/r/20210513085725.45528-1-guy.zadicario@intel.com
>
> Please work with those developers to share code and userspace api and
> tools.  Having the community review two totally different apis and
> drivers for the same type of functionality from the same company is
> totally wasteful of our time and energy.

Agreed, but I think we should go further than this and work towards a
subsystem across companies for machine learning and neural networks
accelerators for both inferencing and training.

We have support for Intel habanalabs hardware in drivers/misc, and there are
countless hardware solutions out of tree that would hopefully go the same
way with an upstream submission and open source user space, including

- Intel/Mobileye EyeQ
- Intel/Movidius Keembay
- Nvidia NVDLA
- Gyrfalcon Lightspeeur
- Apple Neural Engine
- Google TPU
- Arm Ethos

plus many more that are somewhat less likely to gain fully open source
driver stacks.

       Arnd
