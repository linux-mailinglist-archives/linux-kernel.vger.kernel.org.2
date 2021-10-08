Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8E5427418
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 01:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbhJHXVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 19:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhJHXVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 19:21:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEA7C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 16:19:25 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so13473248otv.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 16:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x738ufZ26qwkomPQn+MfcJAOvsbxWorDBI+ovCJWAwQ=;
        b=Q9QQAxS64wz/rk0hjJJp3RwiQQhf4XHpzAcJec/2dyG0OiD3EyShl6WQuS9Gj4WrXs
         vLgfkhdQmchuR7yrGpntQrB+2ZPkof/7+DkIdy84Ny9kxgMZxdQPDw4o00YmDBYu4e7l
         qKgst6bpVxYBnb/sDf7S/4xZFcCEzTGWgMk5IrLnKqnxzx9KTMH08xZY8FZIO0Gc+gTl
         /qlYlv5Lvdrkq49dxuIdItdBzg4qTW7glw4U8FASrxAjLk8pijAONeL9u0mmBCqn3zxb
         J8UfFnmpM84XTCCvBiik1XtBFydG8rwAERohf0dVsJKi7xsM9AvZHudi0Zt3hrr37Pvn
         kbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x738ufZ26qwkomPQn+MfcJAOvsbxWorDBI+ovCJWAwQ=;
        b=JHFAuyDwfp2NV35MSx5hA/ofUW2Vo6/fK/h9IOEGu/zsr3I+uaNOnvWzM1/nyxXNax
         xLTD8fCr3OvNwsznXoHmIM2IY64n5En1i5fjz7SDPsMKixdEqw3SMgSXcgp6xFyTxGuG
         9Pk3qAFGZ4x/RuZa2FwHBgvQ7A0KuFTq9WZO3K4/dd61CUnNJYnvjLW7zUfNjvkppWlv
         EaIWctAh5t43KbxBvZ8YAj7CNOv0kaaXDw76huCqdYo3mYsZ0ecRMyeGaxpke6eTRd0e
         Sv1InQWnn/rgSk+cxeahb9oKK2hQFn33yKDucxLM67T1HDEKfd3Tv5hmGHZg+XQ/bMdu
         zJXA==
X-Gm-Message-State: AOAM531kz3nZWI/q+v6r8VYuxSFIuuXEgmtnnLiJYVyv4HOU/q0NK6LA
        9VbSylqFyjTbqoEXtlJ+ySE1Jg==
X-Google-Smtp-Source: ABdhPJxY3pRS9QcITX6jzHIIwjpjFrwSORH5JXMYWCXknB5wISu9iN0QhmvY3K1bSk/MpqHp/n6gpg==
X-Received: by 2002:a05:6830:2a0c:: with SMTP id y12mr5549935otu.377.1633735164504;
        Fri, 08 Oct 2021 16:19:24 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id h17sm140754oog.17.2021.10.08.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 16:19:24 -0700 (PDT)
Date:   Fri, 8 Oct 2021 16:21:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 0/4] Restructure the rpmsg char to decorrelate the
 control part.
Message-ID: <YWDSXu/MDOwOLDg0@ripper>
References: <20210712123752.10449-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712123752.10449-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12 Jul 05:37 PDT 2021, Arnaud Pouliquen wrote:

> Main update from V4 [1] 
>  - complete commit messages with Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>  - rebased on kernel V.14-rc1.
> 
> This series can be applied and tested on "Linux 5.14-rc1"(e73f0f0ee754) branch
> 
> Series description:
> This series is the second step in the division of the series [2]: 
> "Introducing a Generic IOCTL Interface for RPMsg Channel Management".
> 
> The purpose of this patchset is to split the code related to the control
> and the endpoint. The code related to the control part is moved in the rpmsg_ctrl.c.

I'm not convinced about the merits for this refactoring, you're creating
yet another kernel module which is fairly tightly coupled with
the rpmsg_char kernel module and the only case I can see where this
would be useful is if you want to be able to create reach
RPMSG_CREATE_DEV_IOCTL and RPMSG_DESTROY_EPT_IOCTL without having to
include the rpmsg_char part in your kernel.

> This split is an intermediate step to extend the controls to allow user applications to
> instantiate rpmsg devices.
>     

Can you give a concrete example of when this would be used?

Per our previous discussions I believe you intend to use this to bind
your rpmsg_tty driver to arbitrary channels in runtime, which to me
sounds like you're reinventing the bind/unbind sysfs attrs.

Regards,
Bjorn

> Notice that this patchset does not modify the behavior for using the RPMSG_CREATE_EPT_IOCTL
> and RPMSG_DESTROY_EPT_IOCTL controls.
>   
> The next step should be to add the capability to:
> - instantiate rpmsg_chrdev from the remote side (NS announcement),
> - instantiate rpmsg_chrdev from local user application by introducing the
>   IOCTLs RPMSG_CREATE_DEV_IOCTL and RPMSG_DESTROY_DEV_IOCTL to instantiate the rpmsg devices,
> - send a NS announcement to the remote side on rpmsg_chrdev local instantiation.
> 
> [1]: https://patchwork.kernel.org/project/linux-remoteproc/list/?series=483793
> [2]: https://patchwork.kernel.org/project/linux-remoteproc/list/?series=435523
> 
> Arnaud Pouliquen (4):
>   rpmsg: char: Remove useless include
>   rpmsg: char: Export eptdev create an destroy functions
>   rpmsg: Move the rpmsg control device from rpmsg_char to rpmsg_ctrl
>   rpmsg: Update rpmsg_chrdev_register_device function
> 
>  drivers/rpmsg/Kconfig             |   9 ++
>  drivers/rpmsg/Makefile            |   1 +
>  drivers/rpmsg/qcom_glink_native.c |   2 +-
>  drivers/rpmsg/qcom_smd.c          |   2 +-
>  drivers/rpmsg/rpmsg_char.c        | 184 ++-----------------------
>  drivers/rpmsg/rpmsg_char.h        |  51 +++++++
>  drivers/rpmsg/rpmsg_ctrl.c        | 215 ++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h    |   8 +-
>  drivers/rpmsg/virtio_rpmsg_bus.c  |   2 +-
>  9 files changed, 293 insertions(+), 181 deletions(-)
>  create mode 100644 drivers/rpmsg/rpmsg_char.h
>  create mode 100644 drivers/rpmsg/rpmsg_ctrl.c
> 
> -- 
> 2.17.1
> 
