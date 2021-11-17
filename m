Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D582455154
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbhKQX7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhKQX7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:59:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F61DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:56:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l25so2114148eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWnFI7xMunJXtYruzgWcAa9iAQiJ7OsPSH6QXO/CtU4=;
        b=OQI2q46Lp4GqTHRqt+KyClJ5MB+HeDG6T3Xqtq33QiXxoBAQp68mIMlj0FEhOLRvp/
         Z2UxkMWedJ/2jMVGsty1OxtzG8w9BhibPrcpBAo0xUzcnXpDlA7ARYRpx2ZFY8kA3E2O
         7Vn4GpRI1OkA8Yi+5AGWSqStni1vzLHzNBJ3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWnFI7xMunJXtYruzgWcAa9iAQiJ7OsPSH6QXO/CtU4=;
        b=H8qAFjx9xYndI8+ei6RowK5HCe3L0/zv4+hsSYoJJ4b/zDRd4XKP9QQjeDUydiMRNl
         J7y1nR8eU1UDKtgVUtHBBJqTF2ZL0+7j1fz67FTE8ZCigHQTTSgIvOsnGxmyJOJNaxCC
         KXyaJAGyGrd1WKa0qMRDGipXeuDfXxfvykGm1jdo65+GUsz4wEAI7TTJxrSBWYYG/P38
         pVDVSDBKb2B3d5k/qCCMgTiZDn4c7vX9wiAyMl4LBYW14W+LqxWZobYVz4QpAQTHtemJ
         GQEaLW8JEYkd8hwyMgOzgZ9/ziii14UUaroElHG8d0SkqQrMczWekCA333vk02zIgCmS
         fAfQ==
X-Gm-Message-State: AOAM53344Y1YmgJ1aq9L1EVWqRkYHWwyFkkITPww0wNuB5UP2Moz7jUB
        WNIRhupU4mJ1iUjoUEjylv+WfKYCIYUpYqxS
X-Google-Smtp-Source: ABdhPJy+YECs1DPbanGsAze/8GvsZOysmaTwD1y0/4hi3mKGqmTrbzyHn/svZ28x24wDbLYfA3NLSg==
X-Received: by 2002:a17:906:dc93:: with SMTP id cs19mr27479110ejc.21.1637193368815;
        Wed, 17 Nov 2021 15:56:08 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id ar4sm564454ejc.52.2021.11.17.15.56.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 15:56:08 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso3429109wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:56:08 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr4358090wmc.152.1637193368169;
 Wed, 17 Nov 2021 15:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20211117233656.77861-1-agruenba@redhat.com>
In-Reply-To: <20211117233656.77861-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 15:55:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgx=75CTbsK3NzVhNVihw-P+U2gLekNJW-p-Tm2qc9_nQ@mail.gmail.com>
Message-ID: <CAHk-=wgx=75CTbsK3NzVhNVihw-P+U2gLekNJW-p-Tm2qc9_nQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes for v5.16-rc2
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 3:37 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> We have a choice here between the proper fix in iomap_write_iter and
> generic_perform_write and this patch, which is just a workaround.  I've tried
> to get your feedback on this before:

Well, you did get Catalin's feedback, and I didn't have any strong
opinions on it, so..

I do think that iomap_write_iter() should be fixed, but I also agree
with your "by now too late", so I've pulled your gfs2 workaround.

          Linus
