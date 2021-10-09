Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE84276EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbhJID0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbhJID0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:26:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B88C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 20:24:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g8so43384643edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZRlkZIYHzl58za9sUnq4fOlO8pVB3H3OBy0aiY0iqw=;
        b=XZF1s2tHpyMwHJkpvi3Wm3uoo0wBTKfHYjYvXxYqbA3AlVRzHdNVT4Tj+Z7OUT5PtA
         yXqfo/f2nlfTw9O/6il2ubiIBy8xQWIZUHsQ+fxqituPD2UuugtFrzXMplXv9nof2HkH
         3G1CGdw9TP0oGI1RrvZbW7CGM03ELaFajceS7nsYn+vXx2WfzO6iTfmE6opBA1QpiJGk
         vmYpe0c5NlFywzyOgtUlP/rmkgODWu1SWu3YwywHV9qBGP4b8gi2oUs0qVrVPfdlRD/A
         TBzjod14ceAoHB0BjC4/FBMmU22oWHU466uWKYiKlQSWDyaZklDkc6ouiGNqwAkgtMbe
         MyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZRlkZIYHzl58za9sUnq4fOlO8pVB3H3OBy0aiY0iqw=;
        b=TLKMntUsOW+PD9ERDIgyOiqWCUNil4xgbZel1ziuFZyJaQO0OnR0/nuVDUDschoUpl
         vbaubMVT/Ntmg5SUCuni+iZ+QIMPzXAaQ28WOgS+FjXau/aFYE0CXEeDjS4yZRF9vHBj
         xgAIvI5sMYvnEPKXA1rKU2hnHmW7+YXAHPCuH/jiNhLSxAmC0iRsSqnIvRSVepxVXhpe
         tjG0NI7+WPGrbPy6iEvWBWAaesNyK3yPQzOqAIb90AhpwzmfbyyPJQZENAXh2ZmjnwXz
         0mZTla54D8bNHuHDVxuKPVUzuNTjCW9iDvwfaerUNwctcfPB8E5BiMJxQWtUYIF/MZ9a
         kDWw==
X-Gm-Message-State: AOAM533f8v7xz1tzXTGNz9o4iIcXcAy2EK7yHJfRbx/ZE3tMaDMh7Pa9
        bqzj55SlTgY8zwhlypGR2ty7wVuveeCrceLtQGq+
X-Google-Smtp-Source: ABdhPJyG2PqyTbN74aP30ZckkjH25mY7f9nlIIcHgynGPXVzG3aBnt4SvoNb+WWer8qY/2E+24r0sr3gDa+bHf7mgIU=
X-Received: by 2002:a05:6402:274b:: with SMTP id z11mr20848615edd.151.1633749885735;
 Fri, 08 Oct 2021 20:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211006202904.30241-1-rdunlap@infradead.org>
In-Reply-To: <20211006202904.30241-1-rdunlap@infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sat, 9 Oct 2021 11:24:35 +0800
Message-ID: <CACycT3umszHAXOf5shB7_fg0WNTon0rLdrMRZtzX=hm7RxfRVQ@mail.gmail.com>
Subject: Re: [PATCH] VDUSE: fix documentation underline warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 4:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix a VDUSE documentation build warning:
>
> Documentation/userspace-api/vduse.rst:21: WARNING: Title underline too short.
>
> Fixes: 7bc7f61897b6 ("Documentation: Add documentation for VDUSE")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/userspace-api/vduse.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
