Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A601373085
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhEDTNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhEDTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:13:26 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE80C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:12:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d21so7749373oic.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPDeFE2c5Z76UvfNrVUjfTjEKbAvB781/8qEcRhYZ1A=;
        b=m7JXTIDzCRbD7Q0oeh8pOdJ5IV8K1Iq6vnxUIO2HTHoH8Grv+ZS8GntIPA+88v8FkJ
         qgn/EEMFJdPXK7sdH89yo6MHyHis/YtR62DpdPytSG6DXdd4lCLrJPhivSf8FFRDisG6
         95vg7J+aA8RPYLRbaICbd+62mjAVbK2+p6/OxyCPxXdfaRCAzi0JPUDW34+yii56dmj6
         QphCg8AnPHGX+LQnfGcDHXM7oOAA56UnDRC9BshzzVAwvy7WjFzikBYjuVUrJXHYZlLr
         wWYEJIGyY9hTRPVzM759mZ/9mt/z6zVeXhes4qEH6Wj+9o3oEkkIysdREvnCirpvQhv0
         pFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPDeFE2c5Z76UvfNrVUjfTjEKbAvB781/8qEcRhYZ1A=;
        b=pvBjglAIpxrQRaf/OQZzncjr1oM6/tdGeXbmJiGPfgy+hZVcg1RuK1jfoCWc/Hr11/
         gtRP8vmg2MeJstx3guQxj6aFZm1C1axkkvzvEcWEDkhgXRmWMZIYqxoVBO7bua94jtlA
         KRmu7HewjxgqwgC7aIbXoiENn/vujtDpbJS91mnbjpN+0DU3IEH8iv8NEktcjLfclSjr
         AaZjWxGCOQJr8Ipzf3qmQ0M9Asmzn2sDY/d5Ps6w6ceKDmgSYxIHAnFtzpBqOaEqMXz4
         I9+hi8Ow0LnGw5A97PMULY+qCQefnDKmX/kkvct8SgkE/hy0TpjM5ZGpWgr7zK+8vxU5
         dzxg==
X-Gm-Message-State: AOAM5307iEit1tRlZnFMw8YhP24wzs04dGMPit8bbzxfukyPozZe/T73
        QmPYm3DfhFYJ32GMlz08VmILJ0wzL94WGsj5r5U=
X-Google-Smtp-Source: ABdhPJwHSTqjMM40PaZIK54FPHCHCVkrKAa7q6CSOKlSwlSvjS557Wz7M3OFOc+h6Q3dlx1eNVXDCCkVgaTOyRChhsI=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr13095451oii.123.1620155549069;
 Tue, 04 May 2021 12:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210503050608.2158996-1-keescook@chromium.org>
In-Reply-To: <20210503050608.2158996-1-keescook@chromium.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 4 May 2021 15:12:17 -0400
Message-ID: <CADnq5_OtqZ5KPQsd=sOniOGEhTJTjyKm2KoLdbwG_MWORp31pA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/radeon: Fix off-by-one power_state index heap overwrite
To:     Kees Cook <keescook@chromium.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "Erhard F." <erhard_f@mailbox.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 1:06 AM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> This is an attempt at fixing a bug[1] uncovered by the relocation of
> the slab freelist pointer offset, as well as some related clean-ups.
>
> I don't have hardware to do runtime testing, but it builds. ;)
>
> -Kees
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=211537
>
> Kees Cook (2):
>   drm/radeon: Fix off-by-one power_state index heap overwrite
>   drm/radeon: Avoid power table parsing memory leaks

Applied.  Thanks!

Alex

>
>  drivers/gpu/drm/radeon/radeon_atombios.c | 26 ++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
