Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750C534D871
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhC2Tm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhC2TmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:42:17 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA14C061574;
        Mon, 29 Mar 2021 12:42:17 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id j198so14906659ybj.11;
        Mon, 29 Mar 2021 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIECJytiCU7qAcHzdgKawGqcbiQBVmwPenxMi9Y0mq8=;
        b=LTVCWNH6DMxy5QGYh/zMNc3shEIwRMqQN8lK7SafCMYeTGYuJH4OKHyifBHObEMcZt
         Yfnv0Gnltc+gzzpifNyVo9V0KZCE2LSqLkjnrgyc4b1MS6QeSaTc2D8jOHUEE67ao6uG
         hU8aVui2mZZaGVkKMiv3qywkBh3bkuVxLVgEdn8qn3raP75DIwCxalNsR296ERk5C8XM
         IMg2fsp+goD+HoaAIDnhjIhB5Rnx3FWdOlW9yhN19LlNknfMIMA0DOV0kKsZQe9JDLN2
         +Dvfe5s+D20pZfuYGDy6PUhjSHptHBfRh3fxAKQZgM5eFh9OTpNegERUplV67fZaFyHN
         0/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIECJytiCU7qAcHzdgKawGqcbiQBVmwPenxMi9Y0mq8=;
        b=NhkLnXtJbFmU6NSwhcip0sgChj5I30VagWt+D9am/mCgKRCb8ATXejQF3GTjx+rzry
         9AG8xksAJZwT4L+ynNLQg/jwSMJ10bXoPB87mr0HCoMYedjYIyqh+7eiSiRuQT523zFE
         Ed9PHH5dgc5GfLRi4O4RnQx7eJ3skprpCsgQvpgKso6o6P97my4gngRPvY+kg/7BGb+j
         v0BBgjTk78cljk2vjOosy1NC76CjgzffXAT1WCFRtRYWg4pTazRPGqgdosIdjk1dJgws
         xSLqZEEZYb/GjyCsW3p0QRawcumHGK9Prw4R8M0lbPOsZByfWjTknA/hCdizGL2GuxmB
         4WCg==
X-Gm-Message-State: AOAM532fbNWqkJtNh3PrQH6EEOEYjJVg52ULwdiVp/lq9xOiyQ+8/lDY
        2cb+37v3CTXCQq6gxXIfL8rl+3zNSlciosYNE6I=
X-Google-Smtp-Source: ABdhPJz2wLJ5YBHRxsLtDRMXXZhvW5ekdRV5pA0Ucc7DFj9W3UiYbeh+eQEAgMv2MPr5YVKKyK8NglvOOTJRsKPOx3I=
X-Received: by 2002:a25:ae4e:: with SMTP id g14mr40115679ybe.26.1617046936663;
 Mon, 29 Mar 2021 12:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210325184615.08526aed@coco.lan> <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net> <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net> <20210325221437.GA1719932@casper.infradead.org>
 <87wntux3w7.fsf@meer.lwn.net> <20210329144204.GF351017@casper.infradead.org> <87czvhrbyh.fsf@meer.lwn.net>
In-Reply-To: <87czvhrbyh.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 29 Mar 2021 21:42:05 +0200
Message-ID: <CANiq72mO8NFNhoCZ3tX9sQBj1NwOt-_nXnjiveT0fYc_79U9BA@mail.gmail.com>
Subject: Re: kerneldoc and rust (was [PATCH] kernel-doc: better handle '::' sequences)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 9:34 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> If we're going to talk about incorporating Rust into the doc system, we
> should probably include some Rust folks - thus, I'm adding Miguel.

Thanks a lot Jonathan for the Cc!

I will read and answer the other emails.

Cheers,
Miguel
