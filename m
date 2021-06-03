Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6921939AAC7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFCTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFCTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:17:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9AC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 12:15:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f11so10429668lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CRsT8crQOoq4KK7EHvJ7QQM+oKI52My1kzGYaLGrfI=;
        b=R8VDVRcPoGt4k3cTxV+3sOakxWxFIWv9QitfEwkiZuFc+TePCnjK5n4i0LW5CY7vBE
         13FlE07lfLUcNnJ843cb2LCV/zg8vLt0u8cwi/gVWfImNpe1FxwNQ+MJ/WaTmrDjfj+J
         vXkTFwqZubZn2FR3ewqOSGR+9hjtemq0rhKHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CRsT8crQOoq4KK7EHvJ7QQM+oKI52My1kzGYaLGrfI=;
        b=nA/PdoBCMhd+V8HSaqTkLohB6M3b0HZbJkAYR4EkkDXdZZIBVhdlcrlHDmAIXhDAUV
         TdchbbNYn6dUw153PpuXIYFZwYolxr+O0BXbti3nwwqeGBaLr7h8TQW5XQ25tOD2ser9
         lxmg/6Vz50khdw/zgRtjctL7oQ8OD5Z1U79R8JKFIIqv5YlcFRgQAGQKGXIDIL7Me4up
         FMRboLQouh0IbnwiMLUimmntWvQnC4d1sh7W8/pIkGJbnjH4O7fQxM8TTdlm1yGeTwz9
         la9Y8pCtL0gs336cArwMC2hoFNIo913kNo2UlLMBWtU3XmwawEOjBMul1dl+cl+aNKmt
         6tYw==
X-Gm-Message-State: AOAM53128osIpo+HLjgiplJV7h5uWiocLLhT+XjGfnwuFJSFqu86fkKO
        BHa7/weBkNkMW60dXARQuxWPpkLKUezmBKYz
X-Google-Smtp-Source: ABdhPJyfeY0y2ZFAS0Wqb2NkLhii7d1ig1QzgkQVQn7dvwbZ3vMdFu1+nlQSbzCb1lSGmdFE3ZI1Ew==
X-Received: by 2002:a05:6512:2209:: with SMTP id h9mr294519lfu.474.1622747756300;
        Thu, 03 Jun 2021 12:15:56 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id x1sm429754lfq.240.2021.06.03.12.15.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:15:55 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id c11so8506890ljd.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 12:15:55 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr626097lja.48.1622747755672;
 Thu, 03 Jun 2021 12:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
 <1622589753-9206-3-git-send-email-mlin@kernel.org> <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
 <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org> <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
 <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com>
 <alpine.LSU.2.11.2106031142250.11088@eggly.anvils> <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
In-Reply-To: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Jun 2021 12:15:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_r837DdEepGAA+jCz27Oqc5hxgYEJo9OoWrnKRhfz5g@mail.gmail.com>
Message-ID: <CAHk-=wg_r837DdEepGAA+jCz27Oqc5hxgYEJo9OoWrnKRhfz5g@mail.gmail.com>
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

On Thu, Jun 3, 2021 at 12:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, if that's sufficient, then that original patch should just work as-is.

To clarify: it obviously needs the VM_xyz flags things, but the
VM_SHARED check in do_anonymous_page() is fine, and the whole issue
with VM_MAYWRITE is entirely moot.

MAP_PRIVATE works fine with zero pages even when writable - they get
COW'ed properly, of course.

               Linus
