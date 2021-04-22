Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8936879D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbhDVUDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbhDVUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:03:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7343BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:03:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lt13so13048555pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PquUgnAHmzPPEM2hTMuE5X7Or48hZxa0Iq7nE5kZVAs=;
        b=AVQrLhmn18k7xc+K7EYwaEQdFLa3btb1xFBVHxS7g8oiqJ+iocAPRpYPHg5F2hFb8F
         fdal1gYwrnAHspZmUgT68PGGRbp7l/rTHHTVhDlx4z9BF5fOl47/nU0LmPzLjSQuGiVV
         Vdz5xc3eAgJELCuAkHZnlr3iVVwCxV/dDxFJTS6cF95ieSkIxvX7QKKjARrI9jtgGyt3
         Krp7KaakqgpURkJLChowc+Hsq/hCwTb3+UXDCgQcauituJaSPsW+YPTInyR0T4DjlyJI
         d2lqDWABMHzMNPP3CCDtG2oghR7pKrRWt7Sw0foJTlx7vazYheX4tTtTKPuD408mpxPr
         vhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PquUgnAHmzPPEM2hTMuE5X7Or48hZxa0Iq7nE5kZVAs=;
        b=L1mv3LIzro/pCDIQggqv7sQdtYipCo71ud6CHUgzvC421X7WJZSrp7EPJt3QN3l696
         sjvLkVgp1T2jEzr89F/+I4jwVq+rjgZcefCWDClliDYuf9HkV3jNmT/2QQ7DD6iyU563
         cWYPcnOvib2NidAUUk38QkBtvnIFk1fywfi7rzroWZWRClGd+v3vfAIc5OhRRt73K1Bg
         OHb6+uFyJEr6lVFSNF/+sHP5ju8S/aAN02O3bl3Wc6XlFMa0pbeF4LSgpkKzdcLjKxpb
         wt3vICvl0k7ZhYTYvkKywgMViNdnjyh/0sSRXtYljajtWxS1lXvUdFVYJBcwMBVpRQeU
         SwLg==
X-Gm-Message-State: AOAM5334kLjtq+uTxaXcQCKFeNbeLAwm15SAkxu0Xf0JD9LE2vLZ0+Y2
        ynIH9Ijvw8io8tTTTCS6H+9Hcz4zM8Ofl5v2Hgeu5Q==
X-Google-Smtp-Source: ABdhPJzUKUFs1pX8iuh6hcmAcZecFWy1IkjZKdFpyI/qO54h34Q91x1E2fjAgDSfsp2Hul6tHHaZn4XvRi0LRmQbwtQ=
X-Received: by 2002:a17:902:7892:b029:ea:b8a9:6190 with SMTP id
 q18-20020a1709027892b02900eab8a96190mr207069pll.80.1619121786805; Thu, 22 Apr
 2021 13:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210421183210.2557462-1-dlatypov@google.com>
In-Reply-To: <20210421183210.2557462-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 22 Apr 2021 13:02:55 -0700
Message-ID: <CAFd5g47P4atPPV5C0iBFV8kZm1vUgzST-ghLMm4nq2Qc-=C9Ow@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:32 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Add in:
> * kunit_kmalloc_array() and wire up kunit_kmalloc() to be a special
> case of it.
> * kunit_kcalloc() for symmetry with kunit_kzalloc()
>
> This should using KUnit more natural by making it more similar to the
> existing *alloc() APIs.
>
> And while we shouldn't necessarily be writing unit tests where overflow
> should be a concern, it can't hurt to be safe.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Aside from the copy and paste issue that David already pointed out, LGTM.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
