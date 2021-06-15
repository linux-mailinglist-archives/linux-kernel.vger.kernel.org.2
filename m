Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33313A8A34
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhFOUfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFOUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:35:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA71C061767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:33:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id n17so549510ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAGqspBT/BVO7fxnKKhBww/cp3Y1v0OmOJX/fh/iBZ0=;
        b=VOKSEebqgQc+ESVIRcLLX6qvkrm3nZhaMpKPgDfmaMHJAzOGQ+/4byx4ylpBgrSD0Q
         3oPPb7wQ9PFr9xYN4xUVhluSSYfWgR9SK4OnQFzwZ9X5FayZ2JQYPVcJcmqvtMmDQnyk
         asTwAR71y1jPOLSZtM/erovDU2qdYBqSXCP2caH7akHCB3uvWSBeBELyrYO4zV9gVkqt
         Auim3ksxefaJ94xdxVQAXXpA9EA++ndAzoTD7AKbllSX2uEm0HhjCtGrn7FuW5/zSEI1
         oEmdkBN3IJ+WH4z/iCNkgianGBtT9aHVjlkt8nL6fQ0QJ+XIhngsadiDJu4/ZufKW6pK
         nhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAGqspBT/BVO7fxnKKhBww/cp3Y1v0OmOJX/fh/iBZ0=;
        b=DpMy4q8yMGjsflzSaeUGQW4ZHIwtGVIr6IRz9Flu2mdHFaPPQofnnDuayqQYpfTM/5
         74FsEHYbvtAlRxGAlWdGrkVDp+CNrDPXg0UbmJja1Uypp/JoCTREs7Ei/zQq7NGilcw4
         jsqq6b3pie/mJbC43lN9e3Z8yqtqKoOnyf5UxY9VvskoUW7Mex1WZ8GArQ+OzfnqVLoC
         tW7PiwJjfnAE6MXsakOC4J7KYOY2iuA3wQgc5Lxqm5Eh8bO6dk1GlwrDzOgmP7MftCsG
         TEw48JndkGbAhGL1UJiRkxgdHUkoi6aj6Ocj6JsKKHwCr4IKaQSR7PdYfwIImgWzqfrz
         Svdw==
X-Gm-Message-State: AOAM532a1cfN18pxqa7G2/MUsny+5kdxjQlpgWGmGWrcKphbxJwU6QZV
        53/fUF0FZheDs7T+r6ZoMgNtIhQjwSLYn6tbKvRi3g==
X-Google-Smtp-Source: ABdhPJwRMRbrHZFpr5xUuWiithcUfauQrhqtPGwqFOKdLB1xz510cHn4CtJhB/sBrh7v2fdhbvo1XRrFz16y8Ky5m8w=
X-Received: by 2002:a2e:91c3:: with SMTP id u3mr1308234ljg.13.1623789215338;
 Tue, 15 Jun 2021 13:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-8-davidgow@google.com>
In-Reply-To: <20210513193204.816681-8-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:33:23 -0700
Message-ID: <CAFd5g47LZgn8fV2RHVvxPn+_7TOxbh47aa0i6wb9dcY6UKYZLw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] kernel/sysctl-test: Remove some casts which are
 no-longer required
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, several casts in sysctl-test are no longer required.
>
> Remove the unnecessary casts, making the conditions clearer.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
