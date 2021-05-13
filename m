Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED37F37F6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhEMLWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhEMLW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:22:26 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FD0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:21:15 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id z1so13579999qvo.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jX3Kmh4yazJbjQCzUZL0b86dPSP8ifVWbzi7ZpZFe0=;
        b=U/7+XkMNdb75WNs1fdZszy0U7zT/cgS49J5rAAoqk+kxZ9LZSMLQfHUXvnpydpkVzW
         nQr1/3ElzupO24PvPi2m8lw/pXG0EHr+ZAoQA5lsiwMBd19g7L3ivj+7cy69MQFlpy7I
         83q5wwZ/Zw71MMTML42MUNwigRuqfZB2umCZyrGn8fahBscWrrAz6qpNRQDt0f/JXIPS
         h2qMJt/Dtfb8VAxZfMjICcKVkgaezXwkon3XSQLIMx1sIFb6+ADflgqZI56f2phLDMqY
         PPvVISin97apEtjQMKGa4qZhRGRLSd67j3RGKA5iMgV7zUrCEJaNs3dp5fJd7DEtFVeo
         QB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jX3Kmh4yazJbjQCzUZL0b86dPSP8ifVWbzi7ZpZFe0=;
        b=g7bXTlbg/Ntcf40cAoBd4hZynntCipnpNh0jCp5AsnBzx4Q14RCgYYDqkjQitaK78m
         /DFxJeCmExGPwqgrHv1C5cGR7prUDrixCLX2DmvuSUiIOfscaFoVQxlGJoOWcY7WxAKh
         wrJIkTnrislPZpXZVrQsg/GK1IZAe9kiCKMqox+NhqGVe1FyaaFbR3yPXJBem5yBQL6H
         7uff+4bpBkZGV2asqyJLjAM6YtXlcFFdq6ytW4aHvgVSXIrHTQzcQWLrppbDYGV8cdAP
         HD2ol8il/ZYoEmp6ftwFGEwGDd0BjonZcdl9KR1rNRgAA91f+CISJdx2W2hGvbVwAKhw
         ilIQ==
X-Gm-Message-State: AOAM532vNMyURO0+suG/zwS4ruhrCuZg9O5iBBbp3r0NuMqMdPQqwXXH
        /gQwVLRGvgoGBZWlvAUj9ilt9UKwyt4sEMyQvcfNtw==
X-Google-Smtp-Source: ABdhPJyNpFsIPZGbVUc0fftbEOab8/jtF6hQp+DVzULan09PSTXV/RQ3lttMSy39CQsk5hhoTXYDbZe7EQO/RUrhH5g=
X-Received: by 2002:ad4:5766:: with SMTP id r6mr1529041qvx.23.1620904874369;
 Thu, 13 May 2021 04:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <202105131720.yP4kfiAi-lkp@intel.com> <YJ0KAM0hQev1AmWe@elver.google.com>
In-Reply-To: <YJ0KAM0hQev1AmWe@elver.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 13 May 2021 13:20:37 +0200
Message-ID: <CAG_fn=XDfb9dZSBm0N2xTgBb4B6H0tBuKxiTmF+4cy5rC_L0gA@mail.gmail.com>
Subject: Re: [PATCH] fix for "printk: introduce dump_stack_lvl()"
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 1:14 PM Marco Elver <elver@google.com> wrote:
>
> Add missing dump_stack_lvl() stub if CONFIG_PRINTK=n.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
