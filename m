Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F99326424
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBZOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhBZOgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:36:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD65764EDB;
        Fri, 26 Feb 2021 14:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614350137;
        bh=7Q5YSSyWvZlb8YOjfo3KFfirCkHhDHuR0+GAQ4CSwbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NHOXrNdgDF2voWjHb0k1T9BR590bhpwBW3jSQ/dqLG3vH1w6+T+v64IlcGOJ5X96h
         J43aMk+wpy1L5fRN3gjfdek9UJQuIYWhKY3DDBpBO89cRs94U66C2byGI+ln19Ve85
         dE9SqdCensk6MNqFQ3m7NUUw4QVXLMrumIktgFZ1mLoNPV1qfxta0yZVJG+twpnsx1
         9NqYSd8rtsng8H7CjAKa61PNaZEIjq4YaIoIJuffefP/5RxtA9VqL9XM35J/msk+r2
         G6o6k1NAOd7f8oPLfWwWFe+xlhtOPcB1CowVz3t4L2FYv7ZvW0HEdZyftMJ7VUPMhG
         EKb3QQMhFnfDg==
Received: by mail-oo1-f48.google.com with SMTP id e17so2218478oow.4;
        Fri, 26 Feb 2021 06:35:37 -0800 (PST)
X-Gm-Message-State: AOAM533UAhmRVtAPR74YrxatYN+kLoF6+NMPEVU8XqC+f24+gIjJrFWS
        Po65dN4qcGbGs7XbK3tfiM5wwXs7WS9AS7cFQWw=
X-Google-Smtp-Source: ABdhPJxZGg2YGR/zkHxqO3K1tre6ZEsBdiOU+Tgtf23gLBabVr1WWxnuAgW6aRA3lAgOOzjq2lU72rnK4gS9aPvi/dc=
X-Received: by 2002:a4a:8ed2:: with SMTP id c18mr2499032ool.66.1614350136914;
 Fri, 26 Feb 2021 06:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 15:35:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2=nZ3bbeguXjbFrhz0nWeUOcLM7mRudhPDrcb+jZ4VvQ@mail.gmail.com>
Message-ID: <CAK8P3a2=nZ3bbeguXjbFrhz0nWeUOcLM7mRudhPDrcb+jZ4VvQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] add ripple counter dt binding and driver
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 3:14 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

>
> So I'm thinking that the proper way to handle this is to be able to
> represent that ripple counter as a clock consumer in DT and have a
> driver do the clk_prepare_enable(), even if that driver doesn't and
> can't do anything else. But I'm certainly open to other suggestions.

How about adding support for the optional clock to the gpio_wdt driver,
would that work?

      Arnd
