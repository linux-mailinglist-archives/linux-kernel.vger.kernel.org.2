Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1DA43D03C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhJ0SEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbhJ0SET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:04:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C075FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:01:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w12so13647784edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ayrc4b4CjZHlhGqZv1g+czx49ulJNIt8np7kCe/T/Kk=;
        b=MmJiB4MjhKwy+8Q6Tg3Awy8evjunVv4Epi0KdYNbuQwNk3Mw4a1E8rGwbytzWYzuyb
         mQKvWdt+4JNZ4Dg4Ka38/SW5VZDy0c+jTzwkcChpD+HoxTGC1VtdLQCC5ygMrO1MLHgI
         14YeYP/s0sD3ikSPi9IyohZGva4ek03QleVHFCrW2+E+FSD2rQHxFUbNecI9Cxc5NKvQ
         ABOaP6LeVS5e/B3qVd28pZFA0rc5duD28a909n/ksHmmgd3lVGPnRTK5GI4O3dqm83Zy
         7Bqp4oOibSogORibwHEg4E+wcayvF++78gvcaFxOcpDx6Ux/wNsjrGJqJUZIxCrkmYex
         HOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ayrc4b4CjZHlhGqZv1g+czx49ulJNIt8np7kCe/T/Kk=;
        b=EJYCzqCpL0DOga5uFdBAR0c9+id6O9/+fYdkkaKep78/z1eDRugLtybKeZnqjpP3EK
         6OcZJvCDpuyZPAp+KC+pdPTVN70kur2l+4wV2RfxhncuMJXYc5cZhD0iEssxQJZCuYgB
         KQjZ5jAcmJU+xP4VjAGHpkAHyJgUOppSvZ7fgcoHWDQ8irflvi3gf5jO/3drNtG9fU/M
         rFytXye0WXLuMphIly5DgFasofvChjQ1POkJ7Yzk6EA2bwJGfnZ3m5MGaqo44Vjh5msR
         58o9hxJp5D1vr723p2YAQOZU+mkyrzkm/6i1E8w2++oiNTr1ELVx433FgIYnqROYQZN/
         Rniw==
X-Gm-Message-State: AOAM533fe1g0alvSa7d9D2yqIAy+X4sVmStam62T7lpgExuSfr6URX4v
        PllDYq53P+Gy5PMyvffahIPofyQKnfIw0xvkBS+Nag==
X-Google-Smtp-Source: ABdhPJwO+TO2EGpnZYyktkP/LaAYGK7IdpC1ddnV5AIne2uExN8giJDYSLduKVtH3y65R7glrbK9rl1BQ4mZKwaeBvo=
X-Received: by 2002:a17:907:608a:: with SMTP id ht10mr13962849ejc.89.1635357710454;
 Wed, 27 Oct 2021 11:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211026195545.3951306-1-mathieu.poirier@linaro.org>
 <YXj2trHe8XA0QtFO@kroah.com> <CANLsYkwcUbV-kX3yZt6K0rK9PBUpkW=fp2_Y5Bd3+fCgxZr4EA@mail.gmail.com>
 <YXmPNNig91Pay9U5@kroah.com>
In-Reply-To: <YXmPNNig91Pay9U5@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 27 Oct 2021 12:01:37 -0600
Message-ID: <CANLsYkxNYuq0F8GAJeUsftwQyPgiqJbK=O3Ue=QBrKH48eHrAw@mail.gmail.com>
Subject: Re: [GIT PULL v2] Coresight changes for v5.16
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 at 11:41, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 27, 2021 at 11:32:43AM -0600, Mathieu Poirier wrote:
> > On Wed, 27 Oct 2021 at 00:50, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Oct 26, 2021 at 01:55:45PM -0600, Mathieu Poirier wrote:
> > > > The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:
> > > >
> > > >   Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.16
> > >
> > > Better but I get the following errors when my scripts try to merge them.
> > > Note, the linux-next scripts will give you the same complaint, so this
> > > isn't a new thing:
> >
> > Can you point me to the linux-next script you are referring to above?
> > Usually when that happens I get an email but this time I didn't get
> > anything.
>
> Is this tree/branch in linux-next now?  If so, you should have gotten an
> email.

Definitely: https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=next

>
> My scripts were sent to the workflow mailing list a year or so ago, I
> can dig them up if needed.
>

Thanks - I'll look it up.
