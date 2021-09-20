Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F52F41168E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhITOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhITOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:16:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAF9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:14:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c21so61509060edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+1mwWxzK4KqPX143QbpAuBXZDwVj/xzhRskL9OvgsI=;
        b=4wd6xFMuLjiLqQAnPS2s8hoBkL9vGmwNlV/Y0ODuU+VWqUrY4jEaw3vzHDW13gkzJ9
         DeNHwp9zzF8fyt5cnxlTH1+d3ewGO3iP+XtkW3vr9xzjlSU5e38FXBx3A+5vo8xrIlcB
         2eg1jrsnsjn91FP7ca0vsHYHnE+4l6l6AySKRif3x5Cs9+pFkCfy7ADLACZrFXmr4ctM
         hGnQ1xrzW1RMdVKdu0DUuFjZswJ+xT0Z8LC2nqh8zkmFl/xlfJ9Wt1+8MQadEaTeWx8D
         lmFl+THd0d58GFedVtD1kA66JSines9gaAYpP7CHBAWQderneilKLEwgaD7fIQeooeYY
         OgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+1mwWxzK4KqPX143QbpAuBXZDwVj/xzhRskL9OvgsI=;
        b=wEt9Tvyf45w+X/vFUHbIEWiE+E+p+L0iwUUpCAFZHyN8/YT4Ez21eLbEfQJBsTJXSM
         RpGpEXKBgmWBKKQC++67nXOCKyPu5mUrlRYG+nDRUdtU103Rpnd9nMStwMg7H58BkjDb
         WyJ0Y1T9LRsNID8qNS6O9pCpLq39oPkxkY2nKfiEB55SjKj5rSJ3c6MLnz/kBTAxCDv+
         XsnOEAPLTV5F/BuDAFdMNlAFoFD+MkVbjmhUaDVXqe0L/Z08LMI0O3RFDCLJsO4H0FO1
         ThGetKJMQNBNdJ8iIZNHrq2NzgenUR/7rOjQNfYuW8Av1gnm9PMbDMrxkOEk59pmq2CX
         ylvw==
X-Gm-Message-State: AOAM5315KuTRjllD8gLGkuMK7pABNq13WMjnWmPH3FcAiKKhMNhctd2Q
        qA9Z18CbuzxkKs/CbGxx8+8vWNNOeH21/kHzf/9cEw==
X-Google-Smtp-Source: ABdhPJyvsPKS0QY3MEdCKvEQgKrTrMJswAzQzJZL0FUD0kOibwdcAyHh6tj0cjLX2srirSQtTI28RQcRU6LEDqsX020=
X-Received: by 2002:a17:906:5586:: with SMTP id y6mr28613764ejp.189.1632147227890;
 Mon, 20 Sep 2021 07:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210920140509.5177-1-brgl@bgdev.pl> <20210920140509.5177-3-brgl@bgdev.pl>
 <20210920140938.GA24424@lst.de>
In-Reply-To: <20210920140938.GA24424@lst.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 20 Sep 2021 16:13:37 +0200
Message-ID: <CAMRc=MfTfgKxgmgEsRxcbGqadsutfFhiTkGFT1bagS7DHXHpLA@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] configfs: use BIT() for internal flags
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jack Winch <sunt.un.morcov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 4:09 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Sep 20, 2021 at 04:05:03PM +0200, Bartosz Golaszewski wrote:
> > For better readability and maintenance: use the BIT() macro for flag
> > definitions.
>
> NAK.  BIT() is the stupidest macro in the kernel and shall not be used
> ever.  And I'm pretty sure we had this discussion a few times.

Yep and the general consensus among the kernel developers still is to
use the BIT() macro. Even for this patch there were three separate
comments from high-profile developers to use BIT().

Also: this really is bikeshedding at this point, given that the core
subject of this series is elsewhere.

Bart
