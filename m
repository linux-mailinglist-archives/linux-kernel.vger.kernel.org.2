Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A723F7AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbhHYQfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:35:51 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:44596 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbhHYQfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:35:50 -0400
Received: by mail-ua1-f45.google.com with SMTP id x6so52128uai.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83OVBCnfk7sBlKxb4S0hG/dKOkZ6Z4IHGlU5t4vNnnE=;
        b=rONDX2yZ7YBUzQ1teK6PPN4k4gNm4vjafa4H8GSpUYVdFAKRfEgfm82hmymzZnRZ8Z
         HmFtX34J4V6EF7+ovj/aqqqZ9o3DLuTW47TtIWilT8asGj+7B3Dyy2yvRZwVoW2UTO/t
         7ZsFrzu2yXS4DVSVPQCgv9op8CoQ3E++a27GbKvKHC1ybQQ/PgpfIZHed7+TUImQwx9/
         gk70UFbtR0ztfeQwH3m4ACni7IQW+l8y7SYquOI7EWPIenHJ0qwblmsNIK9YecOf9ZmI
         bFecOKG22EqmI5L8N6GxJlz5XITig9rUNduu/zKzVuwOyYLjnvge0j/XQZvh06f7igk2
         etag==
X-Gm-Message-State: AOAM5303AInyRFbrDWy5ZCWAC6vDkNHq1pkozcCWZPbF8UK05+H+N1cq
        CKb5MI+Ep9b3r5skDOKZQjyIgQehzk3icE+rbUU=
X-Google-Smtp-Source: ABdhPJy5clPFNXhJoMuRuH6RJrg+novCLmNYnU787rBDzoCnquhEvfHnTLpAx4/T/rrqnrzIidoYgAHXTqLIqzBFirU=
X-Received: by 2002:a9f:35aa:: with SMTP id t39mr3004251uad.89.1629909304332;
 Wed, 25 Aug 2021 09:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <a52baa8b-6743-7570-aaa6-411b5b13c8aa@labbott.name>
In-Reply-To: <a52baa8b-6743-7570-aaa6-411b5b13c8aa@labbott.name>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Aug 2021 18:34:53 +0200
Message-ID: <CAMuHMdXMbuFww73q3QgdroEYmWXe00rKsbd9pCgYd2zsuc06FQ@mail.gmail.com>
Subject: Re: Linux Foundation Technical Advisory Board election: call for nominees
To:     Laura Abbott <laura@labbott.name>
Cc:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Wed, Aug 25, 2021 at 4:27 PM Laura Abbott <laura@labbott.name> wrote:
> Over the last year, matters tended to by the TAB include proposals for
> developer workflow improvement, overseeing the Linux Plumbers
> Conference, supporting the review of the University of Minnesota
> patches and more.  Minutes from TAB meetings can be found here:
>
>      https://git.kernel.org/pub/scm/docs/tab/tab.git/tree/minutes

It seems there are no minutes more recent than October 2020?
Are they just missing, or were there no meetings?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
