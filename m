Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A439F90E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhFHO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:29:14 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:38499 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhFHO3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:29:11 -0400
Received: by mail-io1-f54.google.com with SMTP id b25so22398786iot.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFGcwQ3o2ZyrTCy4xvb08Po9MFGx7mRhjpeSf3SDVVM=;
        b=k2cO8sFl6AawwfKDwjqC7Cwa8kx2f1Of64WDhB/DVwxiJ1rlKaFs+eM+RJvkfpOg3j
         zO1VBpaq9q7wZy6zi9n5ICecHohLlqYxYi6tdhUwnSO+mMOnE5dUKWhUf/nGnCdyitq6
         nDb/ec39txb5V5dV64U8UDFIfQLhBEGS68/GNxKoBskr5cxVfo7fS0INvfFvTKEjLTu9
         A8M4GGzoQWaA74fiRzw6ZdY0rXKziGyRTaVypCM3Od1ST1EL4gReqZqpSQjVZLAxnWNy
         A9hD24P48HoK42afcyIcwpou9e4Xux2L++niw7SqMvjiw4ZLtQoJQrOZdQJzAJ3+YV7R
         jOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFGcwQ3o2ZyrTCy4xvb08Po9MFGx7mRhjpeSf3SDVVM=;
        b=tl0KwA3JU+HTDEZbv4HJ79z4CWQm83/4t0QP1vF5M/Yp83AwDu9zAEdRVoYy4oYik8
         cDFWV2mevbgyBZWfC5GAZj6MDiVp67S0AYuVF9ItZ/CKaqpVwaMict5X1eA8EUqmpMDB
         1ptAa3R0eC+pKk4eAx67rher7oDjBLlIYRb58KUDBA77HIaDFP5wefuLlub449nzvyDs
         4Pp4MGvrK8NgEBkxBI4A8kEWplMw6mLW1VQyGyrducAykumrmVXrQWYbhI4SbAqAfXqv
         60zxUqpiTP8zh0UQcNhLJuxGohkASIIf2N5Gmb5yc2os7/5CaXRGaY7wRvWvnnlJMTLv
         NUwg==
X-Gm-Message-State: AOAM533nUJUTHC7j6mc6KBDk7hoh6x0zg6S5w+F4eLymWsbd7D0ZyRaW
        rbDMdq+ZSSLfhGFehOxfay18UybdI4RqE+Wo4L5z8w==
X-Google-Smtp-Source: ABdhPJxgnBqrzUUM4CgS/RA6oYYN9J2gy7q86i3Sr5vSb0wV/HtQgOPUlNfxKQ/Lnf3/EplJxZ6l4L++E7UQ5N87S94=
X-Received: by 2002:a05:6638:2a1:: with SMTP id d1mr21325888jaq.52.1623162377079;
 Tue, 08 Jun 2021 07:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210607173032.30133-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20210607173032.30133-1-arnaud.pouliquen@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 8 Jun 2021 08:26:05 -0600
Message-ID: <CANLsYkxAXiKTD=KB-45O+V7DAY4dbzd_Q3WdPoDrd=UdFqtw4w@mail.gmail.com>
Subject: Re: [PATCH 0/4] rpmsg: char: introduce the rpmsg-raw channel
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Julien Massot <julien.massot@iot.bzh>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

Between remoteproc/RPMSG and CoreSight, I have 6 patchsets to review
(including some of your work) before getting to this one.  As such it
will take a little while.

Thanks,
Mathieu

On Mon, 7 Jun 2021 at 11:30, Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> Purpose:
>   Allow the remote processor to instantiate a /dev/rpmsgX interface relying on the NS announcement
>   of the "rpmsg-raw" service.
>   This patchet is extracted from  the series [1] with rework to add rpmsg_create_default_ept helper.
>
>
> Aim:
>   There is no generic sysfs interface based on RPMsg that allows a user application to communicate
>   with a remote processor in a simple way.
>   The rpmsg_char dev solves a part of this problem by allowing an endpoint to be created on the
>   local side. But it does not take advantage of the NS announcement mechanism implemented for some
>   backends such as the virtio backend. So it is not possible to probe it from  a remote initiative.
>   Extending the char rpmsg device to support NS announcement makes the rpmsg_char more generic.
>   By announcing a "rpmg-raw" service, the firmware of a remote processor will be able to
>   instantiate a /dev/rpmsgX interface providing to the user application a basic link to communicate
>   with it without any knowledge of the rpmsg protocol.
>
> Implementation details:
>   - Register a rpmsg driver for the rpmsg_char driver, associated to the "rpmsg-raw" channel service.
>   - In case of rpmsg char device instantiated by the rpmsg bus (on NS announcement) manage the
>     channel default endpoint to ensure a stable default endpoint address, for communication with
>     the remote processor.
>
> How to test it:
>   - This series can be applied on git/andersson/remoteproc.git for-next branch (dc0e14fa833b)
>     + the "Restructure the rpmsg char to decorrelate the control part" series[2]
>
> [1] https://patchwork.kernel.org/project/linux-remoteproc/list/?series=475217
> [2] https://patchwork.kernel.org/project/linux-remoteproc/list/?series=483793
>
>
>
> Arnaud Pouliquen (4):
>   rpmsg: Introduce rpmsg_create_default_ept function
>   rpmsg: char: Add possibility to create and reuse default endpoint
>   rpmsg: char: Introduce the "rpmsg-raw" channel
>   rpmsg: char: Return error if user tries to destroy a default endpoint.
>
>  drivers/rpmsg/rpmsg_char.c | 92 +++++++++++++++++++++++++++++++++++---
>  drivers/rpmsg/rpmsg_core.c | 51 +++++++++++++++++++++
>  include/linux/rpmsg.h      | 14 ++++++
>  3 files changed, 151 insertions(+), 6 deletions(-)
>
> --
> 2.17.1
>
