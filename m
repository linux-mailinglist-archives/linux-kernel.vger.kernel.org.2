Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2963D825B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhG0WRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhG0WRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:17:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93CC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 15:17:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so1472129pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P1d9rZ1oYibIdHcSFP8OH769BC+V4C1W5//f6yOaEyc=;
        b=LS83kkwUb+IGU887vVihaCeocobOMswJ2zbDSo6QbCumBxka3rMnfNk+UDoOV8j0Fz
         rDizPV7rSAr8ulto+OqWlJAfPYqDS9RojyXNAl+SLClg1PnZPRf4naI7UTLphMmoH8XL
         0hNNzCgG8/144+auWDESC0+3ZidmvcWYpVIRnOUa8uw9lsZ4U1VFY8zWURolgT7gLQfG
         Dfby7F6+/rtTQxjFn6LsqsX7pohOvUEmLY6R5snTwFdZsrVCTiPoN6GL0v1G0E2KVw+s
         zbFZZmo8CQwCKf0eIQgmmpV58+A+TIKMUlLJb7BiqjY8WGJypNUfgG4TK3H3lmTEaU6p
         Q/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P1d9rZ1oYibIdHcSFP8OH769BC+V4C1W5//f6yOaEyc=;
        b=lhTaaNn7jfzC/6I8GqhEDwaZP4TfBxFK7LqOLpWsy/NXGHpkPxspdTmuRP+YeHAt7b
         /dioAgvQjyI/Z3LHFodJqDt0hfwUNZjBjjXER1yuqi65g+y/q825xCw3t3QxmVqI+vG1
         hO1dDs9geiqvVX8x1U1x0Zt5FZjNWrsQzRBGE/2q52Qbo8AIewzH694thATgflkhOskl
         Nik6snS11CAB1s4T6k9dKHLc4+3f0E5cmvJgqNiAUVex1yWbVcBMVX7PXleVSTCx/TOp
         nW8bOaM3E2kdvIEH8/RDuof7BpCzLRmo/XSaCoQQ4d3LKw/pqx4CZCr8yNPbOoIlwN9L
         lZPg==
X-Gm-Message-State: AOAM531ZKfRLG5fLfAd++ox24ZLZmL7KqHnKE2fHp/3SSJusaZjlZiZo
        cFyZU3bTe14Kv+7BM+dB/aU=
X-Google-Smtp-Source: ABdhPJxWFhl0R6uivd9of6xzOQF30aYFleE1PTX+ZKeuyZQxGt0wy/4WWKx3OrVQGfKlyRcpzUwOJw==
X-Received: by 2002:a65:4286:: with SMTP id j6mr26146974pgp.10.1627424220879;
        Tue, 27 Jul 2021 15:17:00 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id y139sm4752532pfb.107.2021.07.27.15.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 15:17:00 -0700 (PDT)
Date:   Wed, 28 Jul 2021 06:16:56 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: stacktrace: fix dump_backtrace/walk_stackframe
 with NULL task
Message-ID: <20210727221656.wq3ponbzhvftfxc5@mail.google.com>
References: <20210627092659.46193-1-changbin.du@gmail.com>
 <20210628134404.4c470112@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628134404.4c470112@xhacker.debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 01:44:04PM +0800, Jisheng Zhang wrote:
> On Sun, 27 Jun 2021 17:26:59 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> 
> > 
> > 
> > Some places try to show backtrace with NULL task, and expect the task is
> > 'current'. For example, dump_stack()->show_stack(NULL,...). So the
> > stacktrace code should take care of this case.
> 
> I fixed this issue one week ago:
> 
> http://lists.infradead.org/pipermail/linux-riscv/2021-June/007258.html

I still see this issue on mainline. Is your fix merged? Thanks!


-- 
Cheers,
Changbin Du
