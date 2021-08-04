Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EA33E0355
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbhHDOdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhHDOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:32:10 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00969C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 07:31:24 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r1so1846518iln.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArPyR0cCoAxuI9e4sD/Wh51Ldx6h8E3MWwQUW8SaObk=;
        b=LNOjU4eYHVG/OAkMvEMLp1SWmVxQYnnAUDh1hZTMn+UdjxREoD3BDl/JNp2JQqMcTz
         IliK4YhV6iQAUPqCY5oWPPhOBQEHq/+O9V3Z9QCcZ7GmQcoWzbv7ObL2QFz7LtLNEpWI
         nw/XSyTdsZdoj0uVNoPitK3HBqERPm7Owq6r3l4GfzEmJvtYPmReTrtN5NYxOnAogDKc
         kidXZE4bBAjhlEdLnZWTzjHKfkh0reVCxo1G/XnDkLxQW1Rj4vsnSnznhRYwRbpI96u5
         E+2i5ztoJLIau8P66CQ9Trhlto8120t0dxeZfzJVS3b7U9+3ho5CLh07lrqhhvlHCTGA
         TXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArPyR0cCoAxuI9e4sD/Wh51Ldx6h8E3MWwQUW8SaObk=;
        b=nRSSdslhz5gF7mCGo22GYLGejBtEdNTV+aeS+ceXt2vpdCxFgnIlvT6+3eUYgYN6VF
         7O7pTw0CupPCHMG4CcQyHzIE7ijbgBsVd2JhU8PWFLtFGRBIl2xJEn3DUKTH80PT/2Pc
         kywyCfv8hzprJCQ72D/mUUzBQjFh44XuRp/MiDU62gmDky5A4WXC2sL4exh8qVAsYtZb
         77Yz9cofkJkfmKKf00kBhRwHH6fqpKZqjWD3L9PeqOIK7JzkUiyTQ53yahHgcei1oBbv
         3jC2i43fpe4oCVe2lP410DthOPGOJ3+/Y3mfWPQHeHfcdEuJ5cte+VE1s1+RzjRrS/FU
         18xQ==
X-Gm-Message-State: AOAM5330qJSXD8mrf/S42B+5m0PCMlzZ6SUt2T296JRH6wSsiMvs++38
        jp+b8ojv3nAkvZvaAJsidkd0p6ySjRTcjRYs+xQBUA==
X-Google-Smtp-Source: ABdhPJycmN+PxuH8ZW/WWqujOz75VX1L1PHN4GOjYU+NOKvpSTC25Z4rlJF1LbQfWzDUHgfobfssDz9DlrReCTWCRYg=
X-Received: by 2002:a92:cb4d:: with SMTP id f13mr343ilq.57.1628087484395; Wed,
 04 Aug 2021 07:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210719111737.47891-1-liuqi115@huawei.com> <41661d60-d8ef-9d50-57eb-8964c6f6eef8@huawei.com>
In-Reply-To: <41661d60-d8ef-9d50-57eb-8964c6f6eef8@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 4 Aug 2021 08:31:13 -0600
Message-ID: <CANLsYky2+D8cwquyX3iXgJtu6vND0gZZBtCL_vBobJ8pBwwvfA@mail.gmail.com>
Subject: Re: [PATCH 0/2] coresight: ultrasoc: Add support for System Memory
 Buffer device
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021 at 02:05, liuqi (BA) <liuqi115@huawei.com> wrote:
>
> Gentle ping...
> Hi Mathieu and Suzuki, can you have a look at this patchset? thanks.
>

On August 2nd I got back to you privately saying I won't be able to
review this patchset before the last week of August or the first week
of September.  Pinging me again on it won't change that reality.

> On 2021/7/19 19:17, Qi Liu wrote:
> > This patchset add support for SMB(System Memory Buffer) device, SMB
> > obtains CPU instructions from Coresight ETM device and stores these
> > messages in system memory.
> > SMB is developed by Ultrasoc technology, which is acquired by Siemens,
> > and we still use "Ultrasoc" to name document and driver.
> >
> > Change since RFC:
> > - Move ultrasoc driver to drivers/hwtracing/coresight.
> > - Remove ultrasoc-axi-com.c, as AXI-COM doesn't need to be configured in
> >    basic tracing function.
> > - Remove ultrasoc.c as SMB does not need to register with the ultrasoc core.
> > - Address the comments from Mathieu and Suzuki.
> > - Link: https://lists.linaro.org/pipermail/coresight/2021-June/006535.html
> >
> > Qi Liu (2):
> >    Documentation: tracing: Documentation for ultrasoc SMB drivers
> >    coresight: ultrasoc: Add System Memory Buffer driver
> >
> >   .../trace/coresight/ultrasoc-trace.rst        | 193 +++++
> >   MAINTAINERS                                   |   7 +
> >   drivers/hwtracing/coresight/Kconfig           |   3 +
> >   drivers/hwtracing/coresight/Makefile          |   2 +
> >   drivers/hwtracing/coresight/ultrasoc/Kconfig  |  12 +
> >   drivers/hwtracing/coresight/ultrasoc/Makefile |   6 +
> >   .../coresight/ultrasoc/ultrasoc-smb.c         | 722 ++++++++++++++++++
> >   .../coresight/ultrasoc/ultrasoc-smb.h         | 142 ++++
> >   8 files changed, 1087 insertions(+)
> >   create mode 100644 Documentation/trace/coresight/ultrasoc-trace.rst
> >   create mode 100644 drivers/hwtracing/coresight/ultrasoc/Kconfig
> >   create mode 100644 drivers/hwtracing/coresight/ultrasoc/Makefile
> >   create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.c
> >   create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.h
> >
>
