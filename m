Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662753A8F66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFPDcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFPDcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:32:32 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16475C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:30:26 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso1068942otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i86DmE+FsyrX62awkaAfzqwF7YB8JnFdUJaPY+I8i5I=;
        b=Qfat5UX9GV6c1Wcj/DNLp0BklvW/aL4PZmlQGmMT8PBMP3705UmFoBLCfCrelJbc4y
         moGxOAKoAQcQax47jPSfd5Rv3vKiemgt/Li6txlGUBX06uIYw/pA+1QB+psYJLstFFPS
         BRo7zqKLNQFn2V8xlKnTiRgCbLFNFCSH2PjyF2oT5v1rt3mhT0O7wdaLzuMqVd76fiP8
         KezhGLs4e8NeKHF+o5VhG8nXGGxVA4LmxO21N9FPJgk/z2zw/DuuC/Yq3yfUGAkZ6yHF
         l5vyY3pioS41p6KtwHqJDUlK3ZWKWG+Bi3Agri8YqthjQmMIocqPgsQQNMan6Hrg+dY6
         hspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i86DmE+FsyrX62awkaAfzqwF7YB8JnFdUJaPY+I8i5I=;
        b=AF/RRs3CmzwPykRIFNOz4+8sJUTar3kRV5jDL9pOOVlfLHzSPOq08H1P0oz5sIkKfo
         B8GbXxP7K59XZEAmT/68zdNPZYLQfPj3IMGXnAKZXOPJzFEeE97OT//9oVei9NU8EIKr
         ez5i5nvW8xoQ4dGkiCZon/8E9LTb+9JQnC0xVXrP6DBQmgLLwVg+ydOWYzA+k/O+YqJr
         dsSAQ1KFp1lKpLXuL4v5/vl9PruK8csfN4gHE0hXGQN3JpycFwRXnlotLAkqFUkvsHzo
         YsZGnsUu9SXdQYCKhjqJs9Mbyt9QtieLqns3Peq2UTIepo7+CGvABYsGtkP0cuV6bb49
         t+ww==
X-Gm-Message-State: AOAM531Gv7POHbMeAW0WFN2R3+LrRziJcYqaIa+D3vMLwHZB5Jao2tIv
        5/N0vzUDWicsOtXzLCK77EwxOg==
X-Google-Smtp-Source: ABdhPJxhs/9jElwXtk+L4DLc2u6ZKRZCiYLWJIWb/AnDz3/Z91d0jV126dADdblLKuA65fRJfmQaAA==
X-Received: by 2002:a05:6830:22e9:: with SMTP id t9mr2019636otc.327.1623814225341;
        Tue, 15 Jun 2021 20:30:25 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q6sm247309oth.10.2021.06.15.20.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 20:30:24 -0700 (PDT)
Date:   Tue, 15 Jun 2021 22:30:22 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex Benn?e <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <YMlwTiN4Y9bK3M4Q@yoga>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Jun 15:46 CDT 2021, Linus Walleij wrote:
[..]
> Yet another usecase would be to jit this with remoteproc/rpmsg
> and let a specific signal processor or real-time executive on
> another CPU with a few GPIOs around present these to
> Linux using this mechanism. Well that would certainly interest
> Bjorn and other rpmsg stakeholders, so they should have
> a look so that this provides what they need they day they
> need it. (CCed Bjorn and also Google who may want this for
> their Android emulators.)
> 

Right, your typical Qualcomm platform has a dedicated sensor subsystem,
with some CPU core with dedicated I2C controllers and GPIOs for
processing sensor input while the rest of the SoC is in deep sleep.

Combined with the virtio-i2c effort this could provide an alternative by
simply tunneling the busses and GPIOs into Linux and use standard iio
drivers, for cases where this suits your product requirements better.


And I've seen similar interest from others in the community as well.

Regards,
Bjorn
