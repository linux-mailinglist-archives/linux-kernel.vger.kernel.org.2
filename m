Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98738C72B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhEUMzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbhEUMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:54:21 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799CC06134F
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:52:08 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id n1so8829725vsr.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0bcwMa3PXE6BxBVKmr7yJhO3MpudMurDafu1kpNh8o=;
        b=egbbFhgbpZilJQP2aMecSiEeWjHfKV1nE/juvi4hnZl1Si+xJsytEUN8Vq0BBuhhQl
         mPJ9wt6fa38LLItKxFiLWEVBxPGc5+81u3RLfBZ3Tb3/kj6NTcAuaHcgJFk/f+Ha97wR
         K7P6QP+r2fsm8Jtw76LQ5gTjF+elCuvYTal0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0bcwMa3PXE6BxBVKmr7yJhO3MpudMurDafu1kpNh8o=;
        b=nz3Zhtr97Ws0kq1nPW58Pi0vbUwj10UtNmEfnh/zLgORYQYUBbzpnwXjaHPMFZbtSh
         Fg7zeKcMRAcvQCv3w368KcK9hv+lOI/znsd73O5o7o+pfVFAmBfy44dwBHNxbJgHQtif
         Ckxe4cno19zSxfGgObZ7yNJxdWqr4gHSKp7yNix+oRNrTD/CRZ5ti9B0M4cv9W4H0tAd
         bgLnSVH9pZylxMhRwQo3GVnN3t0okhutiklMF8cHqAwk92IfJnp7JePcFlh0tAs3AB5L
         j5wb8HxEA3b4Aisne8mbe+0Z61czcPZeOrp4135T4egS1z5S+yCp2sXhHoUva0Ei+k0x
         t1vQ==
X-Gm-Message-State: AOAM531oXBhUI01nvH+2OJX4qXza6XON/AFbGOocSzFljVALCi3Jwqe4
        vmDpNlsLo9fvsN+bwds3pTdAlY1kWPfpJGUwwGCP+w==
X-Google-Smtp-Source: ABdhPJxU0pW7Uhz6WcVvZjuacmVeklxRBiZXZr+5W12DcHtWDJ3NDWg/omTWvlSaYYcMZqIEoCKTvpQnIaZaM7Jg7SA=
X-Received: by 2002:a67:68c5:: with SMTP id d188mr10309413vsc.0.1621601527453;
 Fri, 21 May 2021 05:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-6-groug@kaod.org>
 <20210521120840.4658d42c@bahia.lan>
In-Reply-To: <20210521120840.4658d42c@bahia.lan>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 May 2021 14:51:56 +0200
Message-ID: <CAJfpegtgPMw-MwWEJVt_=jc76032FShFon0xXUNyWb=zJBypbg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] virtiofs: propagate sync() to file server
To:     Greg Kurz <groug@kaod.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Robert Krawitz <rlk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 at 12:09, Greg Kurz <groug@kaod.org> wrote:

> If it looks good to you, maybe you can just merge it and
> I'll re-post the fixes separately ?

Looks good, applied.

Thanks,
Miklos
