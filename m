Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4595A39AABA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFCTOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:14:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9220CC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 12:12:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f30so10475734lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EDxCagl07bOh/Nv8oABAKO17kN+L9A+RY/dcpJKFLM=;
        b=UTljGEGQNYuxNXIn0v7XzxieUWCtnIsxzkRCecivfei0dzW5YoDgn0l5XlRffuAtRp
         9lRSLYrp3aHu78VwRpo49Xzw5AfLWYiO+J5j4JygA2mmEuyDFb9pNuPPxy5EAwi8/b+z
         1pN+oUWFghkmkRW6aHl9ejWgOUmra/8PfgAXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EDxCagl07bOh/Nv8oABAKO17kN+L9A+RY/dcpJKFLM=;
        b=Z3iPbI4nnYv+SxgoVAUGqL/KpBmufu0wjA6nIJQdjFDsklytLk+3HDnbiOBw13PVYv
         FHRmq+UC4DNKDqz/WH17G/qf2qTfKHhqPoWevYkQ5DqMgQQTA5T/w9CRq23axn2qV8VO
         QNVEfHXjBmRPjSuqHuNWzaia3KSQ+FRw5GSrM5Kxx/2h6lNAoF3HSjYB+M+aX++qz8Si
         ZiP/gxO/YnIcj1aPYsUUWu74pZqXrqcbeYRo5QnmMpbR/e+H/YVTSMHqW5/+0rpXVnAE
         cri2JKfCRfbKJWlDn1ek5qlGGPX+dh9HOJqscbZ/iOk7sMnRiMrj+Mr/qnmFvxLP7jaK
         VT6Q==
X-Gm-Message-State: AOAM53254e0q1xE8QqlVBiZ0Qc+IKGZKCAhwyITNCGLI2AKoBUDIg2zI
        54L9GsGlit9PGhH+fRKuuhXTyi5ky8/XYkTo
X-Google-Smtp-Source: ABdhPJzUe6g9R9OXwZjo4+0Xgn3mvZn62GZVjbvRIBYMkIT/YhkbXEqYugoA/jrE8DwE/TqxpxhIAA==
X-Received: by 2002:ac2:5631:: with SMTP id b17mr264397lff.515.1622747550747;
        Thu, 03 Jun 2021 12:12:30 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c7sm398492lfv.27.2021.06.03.12.12.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:12:30 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id i9so10392505lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 12:12:30 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr260545lfc.201.1622747549926;
 Thu, 03 Jun 2021 12:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
 <1622589753-9206-3-git-send-email-mlin@kernel.org> <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
 <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org> <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
 <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com> <alpine.LSU.2.11.2106031142250.11088@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106031142250.11088@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Jun 2021 12:12:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
Message-ID: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
To:     Hugh Dickins <hughd@google.com>
Cc:     Ming Lin <mlin@kernel.org>, Simon Ser <contact@emersion.fr>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 12:07 PM Hugh Dickins <hughd@google.com> wrote:
>
> But the point that we've arrived at, that I'm actually now fairly
> happy with, is do *not* permit MAP_NOSIGBUS on MAP_SHARED mappings.

Yeah, if that's sufficient, then that original patch should just work as-is.

But there was some reason why people didn't like that patch
originally, and I think it was literally about how it only worked on
private mappings (the "we don't have a flag for it in the vm_flags"
part was just a small detail.

I guess that objection ended up changing over time.

            Linus
