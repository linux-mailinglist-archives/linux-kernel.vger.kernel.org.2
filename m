Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1E53051EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhA0FYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhA0FHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 00:07:40 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB116C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 21:06:59 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p72so629047iod.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 21:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsfi0E/1hcgT86JJVgJBp6A7gRXQnVKva5usCU2Ktzo=;
        b=O6QBYPbwQiVetSB4Xi1LsBfU7cPp8OXRrppK0TDqx9vwqMmALegRN2q1KzgKRsNzNg
         e4udnzqBsn1igFMK7SKKV0F37s9/rCnNTk3SFFNyulHps9TGZARuns5kPFi3g7yJvfkE
         9Hi676khd8CZGWKucoTDFZ/C6xFvkkVn8DaGFHBejdHxFxuwhl12OO092tDzBbMl09bU
         aEZxHVpBsjmTS7QqzOhgC9tTtPR6k4Ucu/gbdLIlFlVxSs2R3Xiv00why5SoED39p2do
         FiIQfKtDyrM5kcPsuoIpKRejtdFds39upl7ON6Wf0BvfMQeL5ooy4fxG6+9gJWob7oyU
         Ezsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsfi0E/1hcgT86JJVgJBp6A7gRXQnVKva5usCU2Ktzo=;
        b=hccq5xh4TwvWo+w2pkuSnvdMM+F1oEuYxQPPtz4KvkYiTIfEVyH8GWsdYR+L12Uliq
         gpd1jWqp4R5iZIkTxmrEvaiQnNyalhCyqHIiCtt91Uo3amjlOKtmr8HnZKCGBPzIZu8a
         oA4bcXJ0tzIxTg1al+rek8q8JlQTnQVApjZ5Emf72MtcG0sjUD58fp7OQ5jb48sbb01w
         bpR3zA8DE1hNwLZGgLYP85avMPPEVXL8Tjif7vq8rNi1O6PZGHrLt3KE3xch9jIQhWQA
         GbkJ1HATN6h/3SRWN9s3VZWQmL2BMgbT4ezf/nWuH2TVtzU2YtLzOcqacu1eQF2RkCWC
         39EA==
X-Gm-Message-State: AOAM533hX4MaxaUjE+oQuOUTupnvUfDvdbXfMkbSK7PwCKZUz3o5P4ks
        qYmRRpMmK+gVnktQWK/AzasX6o47PJtjVlPxdCiH1vjit4s=
X-Google-Smtp-Source: ABdhPJzMNDEe5VbI2YrbgViS0FxJS14KkBCuoi8B+bjaGC/2p+H/9+U1IEJudHUB9NE35og1SvEfnhnSP5IxuHe36Rk=
X-Received: by 2002:a05:6638:138e:: with SMTP id w14mr7496998jad.98.1611724019002;
 Tue, 26 Jan 2021 21:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20210126212730.2097108-1-nathan@kernel.org>
In-Reply-To: <20210126212730.2097108-1-nathan@kernel.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 27 Jan 2021 06:06:48 +0100
Message-ID: <CAKXUXMwErhv-vt1LC6a79yJ2oukDkPa1BnijDXpdwYu1RK3z=A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS/.mailmap: Use my @kernel.org address
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:27 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Use my @kernel.org for all points of contact so that I am always
> accessible.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Congrats, Nathan. You deserve it for all the warning fixes, reports,
maintenance, CI, reviews and much more stuff you are doing.

Lukas
