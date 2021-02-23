Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAD1322FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhBWRdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhBWRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:33:11 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711AAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:32:31 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d15so9774144ioe.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0sCzg+nKVxIuCagcfYdWxuIEnUuuQqfinjAUu5/j1YI=;
        b=HY5ll+63utPg958PzpC+i8JM7QhPmHqigip37BLFjKnX5XT478VILpqKcgs8iYpGFO
         HN0nVkDqRo/rGPNfeQgu0V2baqGLNx0MMVwEzm57EeDqGl44IGdLWB3bk+iMCgIJ3TX4
         5ENjgC8usx5r7M2TZW3Wcvhhjgmqx8vtNAWCL7dgUKiA8r3fXevwPT5TqTLwtQ6If4Da
         f3n7IcZKeAv8+ov6DVC0bC+hJ9DRNIQpRwKdKaC8TfGzlzVG/00fmjamSinRAIf7Cjyh
         s8cQGcDvsm0dGZtxiqedZDalM+PlQpwU4y+LCjVM3JgI855hd2qRJw5Iy+a/gPP25D+c
         aRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sCzg+nKVxIuCagcfYdWxuIEnUuuQqfinjAUu5/j1YI=;
        b=HGHCga+Ntf4gusx3PnTK4eFPdBpVXelefAyQXVwdog7GL19Wb6ruMuARIG0CK08oGW
         Cw0+sUOkN+anZ2RwMlDJTiLjDmFeMLX5sahLRVdVXvUimR0tNM82zKAwlLBv1pRecNtI
         +Tbttc6sRPY65WkOGa7U6gxbLX1tqCaNeYUtY0sgPmwn6/xMMYPOtDNUZoZVn1+eDzQf
         p3RhG1dqRiq55UucJJdU96X0u17FY25gc+qVX0UqJL2oWtJ/Ee4IFF+0jUFtxf4iPNMq
         Mh7qSon1PKehMShEduXIc/D0YGV6aKROBjtMdMwaQCs7HlsI2GMeuyuybaDW6QF/n84p
         xMAA==
X-Gm-Message-State: AOAM532DmVPzGm5sOGbYm5oHqoXr8FweFBBZMqITL8+a4NobWA0Q2q50
        oUYnUaJAZHC324cKcjiopQZKrgiLydahOJoDYfuaKA==
X-Google-Smtp-Source: ABdhPJz2j5az4KiW7kby7Dt0obvVh8ftfw8CWNaHRcOKVpSbWP24TNkLATI8qFyxclmqIDWvy9uIT1N0L2lVfyQ6GMA=
X-Received: by 2002:a05:6638:1390:: with SMTP id w16mr710607jad.83.1614101550799;
 Tue, 23 Feb 2021 09:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20210222072217.15633-1-jindong.yue@nxp.com> <CABCJKudwajnmHAEC1XAH=pouCoOXq7q6NmpLST5pba8ejU6FtA@mail.gmail.com>
 <CANLsYkx0Y_f8tdeioUFrwBRV8M6OtLcSuPDZbgb6noPgrfyjOA@mail.gmail.com> <CABCJKuemAmeaSshvb=B6D1kBt-n_unEx11rwzOZmDxAd+EQ31g@mail.gmail.com>
In-Reply-To: <CABCJKuemAmeaSshvb=B6D1kBt-n_unEx11rwzOZmDxAd+EQ31g@mail.gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 23 Feb 2021 10:32:19 -0700
Message-ID: <CANLsYkz+ZZS-gGL8uK9cR46PreF5to0PRk_nGGmZiNKUkToYdw@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: core: Remove casting to rproc_handle_resource_t
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Jindong Yue <jindong.yue@nxp.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 at 09:49, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Tue, Feb 23, 2021 at 8:41 AM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > On Mon, 22 Feb 2021 at 15:48, Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Hi,
> > >
> > > On Sun, Feb 21, 2021 at 11:18 PM Jindong Yue <jindong.yue@nxp.com> wrote:
> > > >
> > > > There are four different callback functions that are used for the
> > > > rproc_handle_resource_t callback that all have different second
> > > > parameter types.
> > > >
> > > > rproc_handle_vdev -> struct fw_rsc_vdev
> > > > rproc_handle_trace -> struct fw_rsc_trace
> > > > rproc_handle_devmem -> struct fw_rsc_devmem
> > > > rproc_handle_carveout -> struct fw_rsc_carveout
> > > >
> > > > These callbacks are cast to rproc_handle_resource_t so that there is no
> > > > error about incompatible pointer types. Unfortunately, this is a control
> > > > flow integrity violation, which verifies that the callback function's
> > > > types match the prototypes exactly before jumping.
> > >
> > > Thank you for sending the patch! It might be worth noting that Clang's
> > > Control-Flow Integrity checking is currently used only in Android
> > > kernels, so while the type mismatches are real and should be fixed,
> > > they don't result in runtime errors without this feature.
> > >
> > > > To fix this, change the second parameter of all functions to void * and
> > > > use a local variable with the correct type so that everything works
> > > > properly. With this, we can remove casting to rproc_handle_resource_t
> > > > for these functions.
> > > >
> > > > Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> > > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > This looks correct to me. Please feel free to add:
> > >
> > > Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> >
> > Where is the original patch?  I can't find it on the linux-remoteproc
> > and linux-kernel mailing lists.
>
> Looks like it was sent to linux-remoteproc, but I also don't see it in
> lore.kernel.org. Not sure what happened there. Jindong, perhaps it's
> worth resending and including linux-kernel too?

Something definitely happened because I can't find anything from
Jindong on the linux-remoteproc list...  A resend it indeed in order.

>
> Sami
