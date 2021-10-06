Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A659D4249AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhJFW37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJFW35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:29:57 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487CEC061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:28:05 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e144so4587436iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VI72+rQQH950OkSQA66NIQXwWicvtVqAwf2xJMPB6lM=;
        b=fxHYOaNVrsUChcGOTJdXMhCykDCTOyS1Aq6lNkx/fLSTsg29afZshjsuobE/hRb1me
         aOfGx4wiRWv/YGtwGYvorqk9t4vLAu9oNu5Zd6R2V+JkKsPAN/3etLL/wayLjrLo70Hk
         vM8A1NyzRE3JtFvJe4HMsaN7cZGdtYRONB/mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VI72+rQQH950OkSQA66NIQXwWicvtVqAwf2xJMPB6lM=;
        b=sY2I+CXKCmMIcwfOqSXYrKMn/ulHaDV/VuORzRZu9Yq3OgeFQnXPdoLzx/29hQ5cy/
         JLUb/Eoj/fRIKXmCtszntIMJb7/iwgFiuqaFuUHItpimN3GYv2vPCR5vKF/+lbwcgYZE
         qGZSKLUSCBqw2vPd9hNpnaXBdxi1Pw3l42I2FVQADrP1xp1On3f1G04u4ZMavrfQ+K/A
         zkg2vvyk5XZf4aCkUflg8OKoR5itp/RL+A3cTgh5dgpiIO8+sAEO2blYdGOcBoW0GF5X
         vZvMRa6+XbEVglDgqQsL5MaWMagjWAUrkuGtCWIcC1EAOzfRJZZSrHZ6xClaTB6Tr3kX
         E/Bw==
X-Gm-Message-State: AOAM531vg1oQPluJJ3IVGuuePxnyE4GzlJp47wwqg4X9QiHzFYOnyR8r
        kF2jXMXAysiyxsmUc5PVnBM/3Rosh8mCJw==
X-Google-Smtp-Source: ABdhPJzJloBoNr4s0MBNOoEwFlilum4jIIqexeJloGzcF5dhYg+Gh8xZUrJTIto9rKe12EchiDodgw==
X-Received: by 2002:a02:ac0e:: with SMTP id a14mr226043jao.11.1633559284489;
        Wed, 06 Oct 2021 15:28:04 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id t1sm7088732ilj.64.2021.10.06.15.28.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 15:28:04 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id n71so4632754iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:28:03 -0700 (PDT)
X-Received: by 2002:a5e:d618:: with SMTP id w24mr685194iom.178.1633559283343;
 Wed, 06 Oct 2021 15:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211001112522.2839602-1-ribalda@chromium.org>
 <20211001112522.2839602-2-ribalda@chromium.org> <YV4blXBkmYhCXxKG@paasikivi.fi.intel.com>
In-Reply-To: <YV4blXBkmYhCXxKG@paasikivi.fi.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 7 Oct 2021 00:27:52 +0200
X-Gmail-Original-Message-ID: <CANiDSCtHKOAmC3=vmyz0Ky2ZJ5Xg4rfwoetSc+=XXt2msE2KPg@mail.gmail.com>
Message-ID: <CANiDSCtHKOAmC3=vmyz0Ky2ZJ5Xg4rfwoetSc+=XXt2msE2KPg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] media: ipu3-cio2 Check num_planes and sizes in queue_setup
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari

Thanks for your review :)

On Wed, 6 Oct 2021 at 23:56, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Fri, Oct 01, 2021 at 11:25:15AM +0000, Ricardo Ribalda wrote:
> > If num_planes is different than zero num_planes and sizes must be
> > checked to support the format.
> >
> > Fix the following v4l2-compliance error:
> >
> > Buffer ioctls (Input 0):
> >     fail: v4l2-test-buffers.cpp(717): q.create_bufs(node, 1, &fmt) != EINVAL
> >   test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL
> >
> > Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I attempted to apply the set to my tree but it doesn't seem to.
>
> Do you happen to have extra patches in your tree?


I think that I was on top of Linus.
I just rebased it on top of yours and resend it as v4

Thanks!


>
> I just pushed mine to the master branch here:
>
>         https://git.linuxtv.org/sailus/media_tree.git/
>
> --
> Sakari Ailus



--
Ricardo Ribalda
