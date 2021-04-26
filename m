Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD036B8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhDZSTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhDZSTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:19:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E716C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:19:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s9so7314560ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fj9vMd+buFku6gAKT/mPMkFnjXdzojSDejPQup/S60=;
        b=Q01kOhUGWWIKHSVb/Zmh7lArlQYPc2ZrxW136Xdk0xLgCmuKsigWhmNvvDMqT65qWy
         e9ITGeuPpHw69XYPQQcDHkqr06DiQicWPqFFYOIzn5mTzjm2rCYlRZxNsv4X9Bj9Flc3
         EdcMBIO6JHLIZbaK906r4a/KKC399U9peqTfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fj9vMd+buFku6gAKT/mPMkFnjXdzojSDejPQup/S60=;
        b=dmeUFCZ+rwyEketXj0xOomE5D052k/GwdC63Z7VtajT9wpx/8MO2+DG5/1JbLK+Wnh
         wMqoqcfJXWrqs/NRrugVCqRPZnCxlS6skPjoMSlQcpvJ3zBBcspScUKwBabIPtyDxqN4
         XaSiwFPnVAlpWCHOk4irSzdC1uuni1xFim1WK3GbpotEgdvO/l3MGNmYcjHX2SocJCpg
         suhPPDCJq7v50FlbrRtOygw/vFVLLanM3vtw7+spwiAvYfYl7P3e8Wmt8BJ/7svu7Oi+
         g3A+hhqM2W61BVjXAbHEEZjwzC5e2XWYSl7A7U8+R6utLHEAbEnXVpwWWyghNsI4Ce6q
         p9zg==
X-Gm-Message-State: AOAM5300GvYrSVF85SwxN5MYwSUqed0o+eZqMHb8iMhWZqjuRW993auT
        /b/h9oJguGYfspcX4pYDqp/aazNHhRIU8I6V
X-Google-Smtp-Source: ABdhPJwj6TVk/wUaIOJiuN6/reAhOvEZDyJ10bubr364KKe9TazuJ0vyBt+8hCF0f6orn0E7mh06GQ==
X-Received: by 2002:a2e:8e35:: with SMTP id r21mr14043925ljk.35.1619461147845;
        Mon, 26 Apr 2021 11:19:07 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k16sm1473140lfu.214.2021.04.26.11.19.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 11:19:06 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x20so59392238lfu.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:19:06 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr13314098lfu.201.1619461146259;
 Mon, 26 Apr 2021 11:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <YIa2ErYuJyCfSkS+@kroah.com> <20210427002648.22459fa7@elm.ozlabs.ibm.com>
 <YIbYI2825E4Z2b/3@kroah.com>
In-Reply-To: <YIbYI2825E4Z2b/3@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Apr 2021 11:18:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWLrNQeV20DiCnJVQpfKFkbtC+8=rAqt-wyBFMrHToEw@mail.gmail.com>
Message-ID: <CAHk-=wgWLrNQeV20DiCnJVQpfKFkbtC+8=rAqt-wyBFMrHToEw@mail.gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver updates for 5.13-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 8:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Yeah, merge issues with other trees are hard to resolve in the single
> tree here, not much I can just yet, have to wait for them to hit Linus's
> tree.

It's generally a good idea to mention these things if you know about
them, just in case the other tree had come in in the meantime and I
had merged it first.

That didn't happen this time, and I do generally catch these things
anyway as long as they at least trigger problems for my usual x86-64
allmodconfig builds (but not everything does trigger that).

              Linus
