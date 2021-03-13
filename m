Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187D5339F80
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 18:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhCMRaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 12:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhCMRaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:30:00 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3838EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 09:29:56 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a1so11269096ljp.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 09:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8/ZqRimIZXL8XV0u7uTNkqvk5KPzGIzddjDweiRDXo=;
        b=P9WTtdMNa0CWZ5ayjKe40DAwjZ63NVvaPogV3EnJn/dvHmM4cYJ4Z+O1HlcXBZBzLv
         LuunhEHQRkddviwQqzFjjTKX37ODSxWyoAJTmxIDdcMrqHlQo2a0k9BPUJ4vuPI7m3z1
         uu96WqbE8iS2NrWx9mXxYE41MGyvHjk2/SdFQGv30XL9FZS2v5XoMb5lLa1jf30qIuJM
         gpmZXDF/mhyb0sXIrfl1OuFNnXMcv7+QvhuKzJ6SKvqj3L34KQMfN75MU2mkzhtj4Yes
         qqXF45Uz/S81ENzc9M6CSfB35vDPP8nSgriDLLHDfJMqUZmojTPAzvo+Z75m7rFncFPJ
         m78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8/ZqRimIZXL8XV0u7uTNkqvk5KPzGIzddjDweiRDXo=;
        b=QZADG3BDeww3Yk6bXA0k3PIm4AOF+IceR1bCSDvUy1jSUbfhf+9iQSgToQMHz7YEaO
         NelQdzWXOIY7IOQT+EEcBMe0Bbn/elOtZ8akbMxtOl0v9ydo+QM4PUD5pzMZ2iokXOjL
         BBqd9GdxMBSzc0oVbFroYH40b5/wgdXctLG/2F8jHmRFY6g1I+PSrQqf+kpbTfL3y7Dy
         nZmsKXlQE/FyE+NF2QiMFS3O06HpbcTARli+EuUqo+1NkRQdff0L3YcYcgRORzkneuQb
         w1gWWV8BxPLR9AGwyH8/IaO6i4X/tXlYnQfTgAboqTWMQMelZyP2E762CoS0EIZ0nFaV
         OhAw==
X-Gm-Message-State: AOAM5300+evfmQRo/8d3orJRWKqJbZaBxEb7ZV218X2BQ2Il9v6rkKjD
        AncPgieZ2P3NbP8zRd0O/njtQi6TeIenNuKKVwGiIQ==
X-Google-Smtp-Source: ABdhPJx34Izjf569iB0XLsQokLPZ5x3IE3QYrlffB1k0IJ7CMv6pmigJD1vXTqTcjOvYIqKVe0Nm0voqmtD8PSzNdWk=
X-Received: by 2002:a05:651c:1022:: with SMTP id w2mr5474953ljm.455.1615656594623;
 Sat, 13 Mar 2021 09:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20210313172636.18234-1-namrata.janawade@gmail.com>
In-Reply-To: <20210313172636.18234-1-namrata.janawade@gmail.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Sat, 13 Mar 2021 22:59:43 +0530
Message-ID: <CAAhDqq31B6ZJmmrUeqTD7u9znrCNScc37SBR_4N=DBthu3iajA@mail.gmail.com>
Subject: Re: [PATCH] staging: andriod: ashmem: Declared file operation with
 const keyword
To:     namratajanawade <namrata.janawade@gmail.com>
Cc:     anupamakpatil123@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 10:57 PM namratajanawade
<namrata.janawade@gmail.com> wrote:
>
> Warning found by checkpatch.pl script.

That doesn't tell what you did or why you did it. Please write an
appropriate commit description and resend the patch.

karthik
