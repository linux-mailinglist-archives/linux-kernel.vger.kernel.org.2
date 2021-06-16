Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D683A8E85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhFPBrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhFPBra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:47:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74477C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:45:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so3002217pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WiRCci0E3CBaTJSov8aP3aMirNDwvb95s8pJiMPbiLE=;
        b=wmQs8AlTFSXTCSysIARXEbA1F8qYDvxC/JZv9qRhUh+lThq4r3wrJRyXk8ugI38H86
         y0k+4ZB8zYKxutk1/McQ5pKFtXVdJueMYp/JakTazJjxEZADr3Wj8VcM1IHHygxxbqIW
         U9MePSdU1qpFSA98aNOtDswKC5P87uim45JLZPLaRvrxhjK0Sentrc+0CKxTk7uLKPrh
         49gkCG6Ee+woCarfrV7WwoUITP4+6Sfgmk14OUsutuFFamAOYvspOTdONtIxue2ILu3B
         aqOuEE+VXZLp0m1wTmZAel7OfkYiJfNuj6amtpSqZCemIEGWt8D97Xx/f4hs7wNgDLdm
         HBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WiRCci0E3CBaTJSov8aP3aMirNDwvb95s8pJiMPbiLE=;
        b=JhScWCcjI8xGoxsnGuHaiMjA+90ODNdPpBy1f5pOvuo+sJAUlfsVb6oKvH/ON3XfkI
         1gfEcR5p7/2W8dYmoa/z34y62onWl+5hWGMkc+uLVTWJw8d4YcPOpDwcdNRKfhCmFowR
         RObt1wmTPDYQQ4QbxG4ZAV+TI95tFEvOflIbkg47mpvxQE4lrpLTDQDwDovAf0WUUDy4
         ZXHgV0WacT/rfJW/rTT02xP7vTzoDQqSYSMnYOkZnLPqhKgqSZqHsaRxRMCkgacG/LNk
         AE6qy8/MCO/a+q0WlDQZie9ocsPFJAitJwEvAwJ7iXNxaxWOAMIvXRu3Kr/7bmQAY0v2
         O8eQ==
X-Gm-Message-State: AOAM532/WVulH5mlPfoleFAvohsZKYUP5gcg/v36j6mSw/lwiZLYMGHZ
        SMGtZsfAEKyOX3W3uVzsrvGNsw==
X-Google-Smtp-Source: ABdhPJx12mo0fmVKv0fY6g/xDgXHcWqG9HH/gLqDFpEh659OuHf2dlOFn7d4rv5WRJXC1HgIs7MVYA==
X-Received: by 2002:a17:90b:46c3:: with SMTP id jx3mr2257792pjb.206.1623807923967;
        Tue, 15 Jun 2021 18:45:23 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id h8sm350000pfn.0.2021.06.15.18.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 18:45:22 -0700 (PDT)
Date:   Wed, 16 Jun 2021 07:15:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210616014520.dkkbdamgelptl3un@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
 <CAMuHMdVL4VH09ixPcpqqokNJeYd68Th2Y6Lz4PZTF7h06OOBGw@mail.gmail.com>
 <20210615111551.7tcz7teqp4olhodf@vireshk-i7>
 <CACRpkdbyybnxP9p3Jh2TbJMhK+kfLyed-YyrZq9JbOqu1csmww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbyybnxP9p3Jh2TbJMhK+kfLyed-YyrZq9JbOqu1csmww@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-21, 22:03, Linus Walleij wrote:
> On Tue, Jun 15, 2021 at 1:15 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > I am now wondering how interrupts can be made to work here. Do you
> > have anything in mind for that ?
> 
> The aggregator does not aggregate interrupts only lines for now.
> 
> > GPIO sysfs already supports interrupts, (...)
> 
> I hope that doesn't make you tempted to use sysfs to get interrupts,
> those are awful, they use sysfs_notify_dirent() which means that
> if two IRQs happen in  fast succession you will miss one of them
> and think it was only one.
> 
> The GPIO character device supports low latency events forwarding
> interrupts to userspace including QEMU & similar, timestamps the
> events as close in time as possible to when they actually happen
> (which is necessary for any kind of industrial control) and will never
> miss an event if the hardware can register it. See:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/gpio/gpio-event-mon.c

The current version of backend (I am working on) will be Linux
userspace based, so I would be required to get an interrupt there.

I was planning to use /dev/gpiochipN only for now and not a sysfs
file, so yes it should be fine.

-- 
viresh
