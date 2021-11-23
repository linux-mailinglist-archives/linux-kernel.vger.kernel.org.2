Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17EB45AB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbhKWScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhKWScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:32:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:28:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so51496449eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMCJQxM2oix6FpySP7rhz9hhue+oHdiqlysm5h2INxs=;
        b=VgaWT7hwV1h3mxYGeSD+Dm5xER97/+ZM+rLzOR1PQT+xdQcYlxVvGe6Gl9m8tgc+qE
         8rdkknq3fMRzuzfMHwAs1QHw61tBnj/KrJ6pV+jQU/rvA84rDDY+UDiWlD1mfe8C10Hl
         COsz11erqMrRYEOgh85R5TptMltPlG0OuzAXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMCJQxM2oix6FpySP7rhz9hhue+oHdiqlysm5h2INxs=;
        b=PZWrix2HB3QB8juQB556TVlO3X89OeBK8NNwbUWStg2e+46t6KujWH3PsSflaFQgVd
         f6N4oAaZ8SHyvdcuv7oy56mdtJuEegkI1Ealrnsb/0z8OScgOXPm4Dauq1dCGkCiJaxi
         35g/bdy9qIYCWR5oQvMJOoI9qT0pVqTDM/+h176BXeS/a16jietfp/YBfmGy+XlVFC2I
         Nxiq/wQ7pHFVXY6b9OOwR6sjXDSeFmPKIc/LgAABGoH70e83EAzWR0GSdxlbwXuckWRT
         iROfYz+ZjweAenhGXwgg6RjlVFxwd5yog7MCb717olcL7T3XLksjGQpI1aLTqUF0KUze
         my/w==
X-Gm-Message-State: AOAM5328nwLJfkEkCMO/sBGV2hgy3a/FXlZpm+lAUvRD4TDrMmdSCbYI
        STyOOBeNczAyaMxunZjWM66djIXkuMQ6+QURdYpS+Q==
X-Google-Smtp-Source: ABdhPJzDJLPcnE5dfrkHvTkcnpgu6LERpjiBt9kEpBtn0Swock4JIPxciWIkGTHn1Jy3Hokv5AcC69tHqW3yA/Om2Vo=
X-Received: by 2002:a17:906:4e42:: with SMTP id g2mr10498517ejw.230.1637692137526;
 Tue, 23 Nov 2021 10:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20211115165428.722074685@linuxfoundation.org> <20211115165430.669780058@linuxfoundation.org>
In-Reply-To: <20211115165430.669780058@linuxfoundation.org>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 23 Nov 2021 12:28:46 -0600
Message-ID: <CAFxkdAqahwaN0u6u34d4CrMW7rYL=6TpWk1CcOn+uGQdEgkuTQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 056/917] fuse: fix page stealing
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Frank Dinoff <fdinoff@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 7:04 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> commit 712a951025c0667ff00b25afc360f74e639dfabe upstream.
>
> It is possible to trigger a crash by splicing anon pipe bufs to the fuse
> device.
>
> The reason for this is that anon_pipe_buf_release() will reuse buf->page if
> the refcount is 1, but that page might have already been stolen and its
> flags modified (e.g. PG_lru added).
>
> This happens in the unlikely case of fuse_dev_splice_write() getting around
> to calling pipe_buf_release() after a page has been stolen, added to the
> page cache and removed from the page cache.
>
> Fix by calling pipe_buf_release() right after the page was inserted into
> the page cache.  In this case the page has an elevated refcount so any
> release function will know that the page isn't reusable.
>
> Reported-by: Frank Dinoff <fdinoff@google.com>
> Link: https://lore.kernel.org/r/CAAmZXrsGg2xsP1CK+cbuEMumtrqdvD-NKnWzhNcvn71RV3c1yw@mail.gmail.com/
> Fixes: dd3bb14f44a6 ("fuse: support splice() writing to fuse device")
> Cc: <stable@vger.kernel.org> # v2.6.35
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It appears this patch causes a rather serious regression in flatpacks
using portals to access files.  Reverting this patch restores expected
behavior. I have asked users in the Fedora bug to test with 5.16-rc2
to see if we are just missing a dependent patch in stable, or if this
is broken there as well, but no response yet.:

https://bugzilla.redhat.com/show_bug.cgi?id=2025285
https://github.com/flatpak/flatpak/issues/4595

Justin


Justin
