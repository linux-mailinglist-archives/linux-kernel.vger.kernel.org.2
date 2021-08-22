Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C92C3F3EBC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhHVIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 04:55:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412CEC061575;
        Sun, 22 Aug 2021 01:54:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t1so13716853pgv.3;
        Sun, 22 Aug 2021 01:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvNMyE85L3cDE7yFVWP+Yu8ahoocUDdS5XBLBbQKoCQ=;
        b=gC1xasEG1/rELLocg8RMv19imcQavXuz2w4Q4dovD6R45I71J/gnu37Jiea+WcOspu
         zmk1PKFEsOAvHQd1j+Dlrth8IxSrQfsi2ZY2hakNwR3nV6PRptNgHIdhhzyROMV5o+qz
         IIpS9L/QdcpM+JIZcf2m2O2vE//1D5SA8xWe9bfqGrJYtkGgGriy/vNKXSFWkJWjgMHv
         0VOFE4lMnGgcUvhW8UvcddRmakEE6vL6Vkrv7BroQ5PQ0sogzETpoAs6Z37AiUvI4vyc
         g2upKErKYajTg7f4yVElkMq5ZGOfBVvKRruE9r6IGBZG53EiadAqHU9X3jL9O9VRJhO0
         fhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvNMyE85L3cDE7yFVWP+Yu8ahoocUDdS5XBLBbQKoCQ=;
        b=M+mKCsZsH7WQEpY2t5hYWTxRloG2ZujPnidNE5Qppkzhb2PTle0fMW0V2UchgYm7ZM
         ZvsKEVhULQHmHJrwuAbD8/wUrqt2aPxNwsCpf0wz3xwbsZjKZOKDe1dlh0MXsT0+6AGX
         nYod8hJN5Eh7JpkPN0oovLIbRTDitoZoI+pwEBm4dAVtarzfda7A/y8aWuTW4+S17kjJ
         eDPOzaoZaOzwRi0mYDXqmGR/YvSArzPl/PgNYhjVb8GDpn33AOlWx/+GzlcpxQpUtylA
         XJP2OTMlvvUXy7ytGveU/wkVJrhmhu96z0rG49yzrQ4Cl1ig6767tRGDuD6NzYb4jGHo
         pFug==
X-Gm-Message-State: AOAM530ceNrN1DmQnSrm6aaJehDm4d9R/OtzZoX2lkJK0wyJOdBgmo3B
        XVU231Ys/uHub7+GZhnhlE4z9O/W55H7uE0s5B9RO1/N3u9jkA==
X-Google-Smtp-Source: ABdhPJxXZYaf0MP8eUkEc9RRkDexoXasf59iFPwXlnPExtDeMYXSjG7MvEsyUSTDaduzSB5kjnyLvSXs6honZsxxlUk=
X-Received: by 2002:a65:63d6:: with SMTP id n22mr24791208pgv.74.1629622462652;
 Sun, 22 Aug 2021 01:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <6abd83d11f1daa3094f82e92843e8279f302e349.camel@perches.com>
 <CAHp75Vdh2CP9n0FrU+6nkmzVWKoKD6RN-RGv7Z+UD_KUoFXPfw@mail.gmail.com> <12a41a13f8d03a16c3d5c20710a901c090b7d244.camel@perches.com>
In-Reply-To: <12a41a13f8d03a16c3d5c20710a901c090b7d244.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Aug 2021 11:53:46 +0300
Message-ID: <CAHp75Vdyms1O+GLFDNn+P0CswbCnk8=XR4t2OBex8i-KuuD9Pg@mail.gmail.com>
Subject: Re: [PATCH] vsprintf and docs: Add X to %ph for upper case output
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 11:45 AM Joe Perches <joe@perches.com> wrote:
> On Sun, 2021-08-22 at 11:31 +0300, Andy Shevchenko wrote:
> > On Sun, Aug 22, 2021 at 6:00 AM Joe Perches <joe@perches.com> wrote:
> > >
> > > Uppercase hex output of small char arrays is moderately frequently used.
> > > Add a mechanism to support the %*ph output as uppercase using 'X'.
> >
> > Besides the fact of existing hex_asc_upper_*(), what ABI (!) uses
> > this? If none, I dunno we need this.
> > And show at least a few users where we gain something after conversion.
> >
>
> There are at least a few uses that could be converted.

Provide a series then!

...

> +       return snprintf(buf, 16 * 2 + 2, "%16phNX\n", sn);

> +       return scnprintf(buffer, PAGE_SIZE, "%16phNX\n", unique_id);

I think you need to convert to sysfs_emit() in both cases.

-- 
With Best Regards,
Andy Shevchenko
