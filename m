Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10433F969
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhCQTfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhCQTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:34:55 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836FEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:34:55 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so2914736ota.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLJFoBGKOe7vF7102iLQqdVbnd2dgxb55puMEOQ7yo4=;
        b=lANykiriyprqUG6IZx/sz5t20mOCslyWOj5S/1sID7upZZPneaoSKmEL8irKQ8cZxr
         Nk2WSyi8idpXM6HeUF6zAw6Kv93y92cwHdMS+He1qA/kW0yPBsPV6ZzSfham7TCyYqZn
         vo5HBtIb7JGm2TB2yDnT65rBM/bNnbpaPhKepfaLksUyBW7thXxqzvR368+L05FdcGz6
         ArveoJpYIAO3LzR2OjXaropjKUEsx1nk+de9w/oW2pEzaF6Tx1J/OVThf0a50MAWWNBu
         pQmZKyZREScDPgkzzpUZgdZnTmWz6nWkS3JP8s8l+tI1Bt5hDfmZ3zKI3/lUFvLk9Ik/
         RRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLJFoBGKOe7vF7102iLQqdVbnd2dgxb55puMEOQ7yo4=;
        b=p5EyjjGnk/sdPmHhAoKms+iqanp6JRQVdB44CVsO9pi7viATbXlvEcbx+ARbmOSt1l
         +elF48+/0mG14mTxteE2HpHwFOqjykaOtO4PIfyMMiufCWGOhO6FbCN887Vn4YBoZqbi
         673i/AuBzNpYqXd9g6jnp+O2PVBVGD0RB/o7TaU6+aXDXA9WiXe6Ub06eKjGZLCXUQfH
         mdTFsLWDQnGcO3hVH9xBMr4LO0cGBKf90nBkd/kRasKFEccM0BtuA/K6pesDBz3pofDr
         C4zVnYH+jBHvN/+gZBlmzPasnWR1DNanR5XOLKKNUrzffXB6jbgIOdZzTNWD/KeQdgMx
         0qAQ==
X-Gm-Message-State: AOAM532iy/mYjIAN7yzOgVVYVC0IrKhsu4qbzdUlBgwlg/8I5l1uuAlM
        exIoMLIVPqDM70P/1RWzsvSOnJxFOl9VjTqoTxjB5vhDhIc=
X-Google-Smtp-Source: ABdhPJyI0XyJZmtVpY5eij5WlOzOAtHIHgbIGlY+kHddGp6JzIyebN73C7MeABwLMQLu3jaXbGS287ES8SH5qGSIJZM=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr4614891otg.17.1616009694737;
 Wed, 17 Mar 2021 12:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210305194206.3165917-1-elver@google.com> <YEX15gn0lfDpc1dw@alley>
In-Reply-To: <YEX15gn0lfDpc1dw@alley>
From:   Marco Elver <elver@google.com>
Date:   Wed, 17 Mar 2021 20:34:43 +0100
Message-ID: <CANpmjNMYoQ-xE9HY+DH+wO3BSGsuOjCxffchzUhuxWk4zhf3Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/vsprintf: do not show no_hash_pointers message
 multiple times
To:     Petr Mladek <pmladek@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 at 11:01, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2021-03-05 20:42:05, Marco Elver wrote:
> > Do not show no_hash_pointers message multiple times if the option was
> > passed more than once (e.g. via generated command line).
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Could you pick up this patch only?
I think there's still controversy around how to best proceed with
reducing space and we should drop patch 2/2 for now.

If you'd like me to re-send this standalone I can do so as well.

Thanks,
-- Marco
