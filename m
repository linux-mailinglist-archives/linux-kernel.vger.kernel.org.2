Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D716D3DDA9C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhHBOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbhHBOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:12:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7BBC0611BB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 06:54:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id cb3so9061527ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpJO592WYEixrqXzIZb7goGYROImopIKrr17z7H5HQw=;
        b=GJjETva7Crs3bdP2iIdOdApN+dqvB3575sdJh0Nt8UcqnbGjjAOy25+jjhTZl8Ba6B
         ykMyMBnw+MXexnHgA/YLBz8ogR8UgiKx2rbNMPgLnez9J6KO9E3YxhFUzCw5fCpSvTdx
         nTKi0scpfCrnqi60VuzkU7HbfODJ7ldqdW8et7FC+Ti/ccjqoBmCz3REEZGQYX+gOQ4I
         4nHRZgKDOAPhUPf1aQypNW2z5j1GIUkdcG93fBWCIqfRXOKXndsRoTuUh/zktP5e/YTw
         g1IEvVNlqq4qoTshcXTKTjBxjbn0OISylVGnXWnPCvalG4tzW1Ld+pHz4mERRaqidRhr
         PWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpJO592WYEixrqXzIZb7goGYROImopIKrr17z7H5HQw=;
        b=GXu3TIi4uuEjwqdB8P03ivGnNQaA+XvuZWhFwAD7lSe5R8r0Ucc/3AnFE/UNQm6hIs
         +DsPJSGpsTIpnSE+5/YkU+WuaSfCFDzloKaEB9U3ahFZGDAqGLaYKx72RUR8pxBZO4AW
         x68YhRs7T85tv6EBI6Du9RqheDZtrHCnBOgUxbTHBobhWbSdmx+F/lsA/1JW38K8RqM5
         OQ73NFRkZu01vbC0utpMgFnHH89vm4D++SyvM0OqnjCRsC3igCVR3eiAbadWnuj38Fg6
         /k0X07dkQrvFHC850soqOtIyjkzToxVUiARTDujeuYisdhIvH5KgyB97WjsC/zi/S/Pq
         nTfA==
X-Gm-Message-State: AOAM531WUY963+/VQewV7thFJZEL3qZM0lxDXjq4lElMB2Tt4dinNb5B
        +3cK78RcaqemnfO/yIzG9soR5abSdM/zxjceYvDl
X-Google-Smtp-Source: ABdhPJz40sJlqZEGviQHkm6Qn1c/GD/pz8OCJuU8LwiwWCKf03ePdsNkKAdpoH9hMlUREjbu0ZjfO+uC3SDrk2bUV/U=
X-Received: by 2002:a17:906:4ad9:: with SMTP id u25mr15537798ejt.106.1627912474320;
 Mon, 02 Aug 2021 06:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210730075234.338-1-suhui@zeku.com>
In-Reply-To: <20210730075234.338-1-suhui@zeku.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Aug 2021 09:54:23 -0400
Message-ID: <CAHC9VhRubqCjzv54VSQg5cmAm+G7hBNO=72Eb3-EcbGCtn3_dg@mail.gmail.com>
Subject: Re: [PATCH] kernel/auditsc: remove unused header file
To:     Hui Su <suhui@zeku.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 3:52 AM Hui Su <suhui@zeku.com> wrote:
>
> Since commit c72051d5778a ("audit: use ktime_get_coarse_ts64()
> for time access"), the linux/time.h is unused.
>
> Signed-off-by: Hui Su <suhui@zeku.com>
> ---
>  kernel/auditsc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 8dd73a64f921..33bb6a83baf1 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -57,7 +57,6 @@
>  #include <linux/mqueue.h>
>  #include <linux/audit.h>
>  #include <linux/personality.h>
> -#include <linux/time.h>
>  #include <linux/netlink.h>
>  #include <linux/compiler.h>
>  #include <asm/unistd.h>

At the very least the kernel/auditsc.c file still makes use of the
timespec64 struct which is defined in include/linux/time64.h which is
brought in by include/linux/time.h and *not* by
include/linux/timekeeping.h.  As long as we make use of the timespec64
struct and the definition remains in time64.h let's keep the time.h
include.

-- 
paul moore
www.paul-moore.com
