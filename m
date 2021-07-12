Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2A33C63BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhGLTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhGLTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:30:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E874C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:28:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b26so13113784lfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9CaivgN8Swm+6hjibxNcpNSDmFSrQlwWfO/aJ9YCqw=;
        b=F5HllpvpV5ivEXg8wyNL9x6AViO0UTtoO5SnhAti+BDcXoSJTpXlhvcUl6FpgNia6i
         YrMlbiE/L9wLCnuEMYrETP9X+diDieL+Ncl6p36WWk0hI0tlq9kDzIprkJDXJ0ydWy4o
         bjzEnSO8GDCJEjRAwQyNJ0EOVEXw/37Epps5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9CaivgN8Swm+6hjibxNcpNSDmFSrQlwWfO/aJ9YCqw=;
        b=o0uAs4knay74LSBrx76dPJFdpKqEdQZOpDTo2PQX2ERd4p86AYEel/eb1rfcuZyrMs
         PqZLpkUNJz8pSWu57dhdyOF61lwqCatOL3cOvF0UIw4+TSCMQYN7aowB84tSjwp8VZ0P
         M2aER2wYX+s77KudRaBIw+JSfqUBM7XOYf2oW2xBKnOHfBMAN3QHzynZAeIr+77P0Cv8
         IV/SjEknjcOBm8AxqLeXuF9BacLiGR8+ytZnNXm/MwGnbMb8UnKXnaq5VOC47J9gaDQf
         BR9UqFc5Y22JT4ImUNx7kJEV8iT07ArUWX6c0HTGhC7SFe1yW3yGV0SY5YEKaXqq9gwq
         qt7A==
X-Gm-Message-State: AOAM530v/ZQ1WKauhxO0gpF+7NSBwpRbLqD6eQowFEW3oJKe5rf3i5wH
        fdr35bQ3HZRhu7Zoqe/yL3+wuUbIbKwPKvrqDjc=
X-Google-Smtp-Source: ABdhPJxxrnpzb3CxSh2PfjOz7e96JLPrtmeuC3wiNOPbbcsS/H39JjIlCUHlj36L3a83keM580ms2A==
X-Received: by 2002:a05:6512:3990:: with SMTP id j16mr284880lfu.310.1626118081483;
        Mon, 12 Jul 2021 12:28:01 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m16sm555690lfq.23.2021.07.12.12.28.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:28:01 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id u25so26018485ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:28:00 -0700 (PDT)
X-Received: by 2002:a2e:971a:: with SMTP id r26mr675939lji.220.1626118080788;
 Mon, 12 Jul 2021 12:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
 <20210712015619.GA3547193@roeck-us.net> <20210712041423.GA97217@roeck-us.net>
 <20210712052046.GB8042@lst.de> <0cf6d000-f886-4e99-2e80-78da4ae9367d@roeck-us.net>
 <CAHk-=wjkQb8DzNg-qAWKWFAS-3Uy-4BUYR0ympb_W-Om=TabNg@mail.gmail.com> <20210712192413.GA25425@lst.de>
In-Reply-To: <20210712192413.GA25425@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jul 2021 12:27:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_g=G1-+YnLW5CyWrcg3jy+jpaaGyE4qcst-x9N5fGcg@mail.gmail.com>
Message-ID: <CAHk-=wh_g=G1-+YnLW5CyWrcg3jy+jpaaGyE4qcst-x9N5fGcg@mail.gmail.com>
Subject: Re: Linux 5.14-rc1
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:24 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jul 12, 2021 at 12:03:36PM -0700, Linus Torvalds wrote:
> > Christoph, can I get that as a proper patch with a commit message?
>
> https://lore.kernel.org/linux-scsi/20210712155001.125632-1-hch@lst.de/T/#u

Thanks, applied and pushed out (along with two VM issues that also got
reported since rc1..)

                 Linus
