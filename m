Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FE3B6970
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhF1UGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbhF1UGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:06:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26420C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:03:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n11so5719562pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAWuikIHuzv+BXmOwJRKib9PQUJFOjgkmKn9FbpyuzU=;
        b=rgdOu2AR9V328GiMlQnErYgYIckoGTJ7mCqMZHQzfWpJSZZ/E3zAYX1Zpk1UIbQMug
         us8tk8Uj72DW/G7aWm0uvDlh7mCNP5J9jSfn/iBoBrhM5LDiHqQyqruVY5mvxk4ZT7kl
         jY28piDx6EUlRD1Z782N/zXQ/ZN1alXejf5yP3Hxdk/+Td11FJ+jGMoF8JsGPw4e96+b
         9UZYxpbqzTuPKNityp687gFqYJNSdSf9/v84F51u0SH3qOmNoSTNsBQHh0WkNeqGTjFq
         JTvCv50e94UC+TnmK5Uq6+feEVHO9LQOz2lX5OibHrYXYPI55hthu1dBb0GTTHZvEsYE
         /usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAWuikIHuzv+BXmOwJRKib9PQUJFOjgkmKn9FbpyuzU=;
        b=N9TnHL72je0Fgz69hG3Gv6A5Aa+hLSDRAmbW8wXMOzjnQP+zFUOq8C6X6m9vkaDqL0
         tH3wmWICdd09o6U8RvCe2pxewUSf2FjmJtwdkeS2Yq6n9ZNJzf7G3g0Amr29n6dUD5l7
         s+xVoP2Y9y0SYCz3VwDeXELbaZkZOmFLNcGzzG4KO6kuSG1NlNLdA81rK2tWlKHj4agr
         NnOG+zBCR+CKy0uF9HhQJRfW6yyr68YGmS2SYwEcGF0AkBGfQeCfKAESo9jMYJGNf6cT
         uCASV5kcNi6bUweuMG6HOxLHAY69loaV8c3TFxIDBxUGsLZwZemLW0Lyg0ijarle/cAW
         xG2Q==
X-Gm-Message-State: AOAM530A8qRBztbROcn2QeyvvDFfD2vjf4jEJ3jbvq1k5PI4ViCedrH6
        Nk+NRuGsDy1/4iC4rTEsyDM7O/P8N9SZW5z/nRTWOw==
X-Google-Smtp-Source: ABdhPJzui40i4XtrMXZqeWOZSRSr1w1ZjjG7SBl7I97neYOsFdLY8f4yY9APoHkrGTrobdIJG4wu3YVGNdnJmtGpU6A=
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr39877768pjh.217.1624910616389;
 Mon, 28 Jun 2021 13:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210623190919.956814-1-dlatypov@google.com>
In-Reply-To: <20210623190919.956814-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Jun 2021 13:03:25 -0700
Message-ID: <CAFd5g44BfjEiMUesKaTRpjmKTyMSaOKdg+i2mx8koP5hxXtLcg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: remove unnecessary "annotations" import
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 12:09 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The import was working around the fact "tuple[T]" was used instead of
> typing.Tuple[T].
>
> Convert it to use type.Tuple to be consistent with how the rest of the
> code is anotated.

nit: s/anotated/annotated

>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
