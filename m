Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7556144E412
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhKLJnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:43:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234898AbhKLJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636710009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ChwqGEU71MP3pmS3G7ZC9yqmE+mk5CmpL7Ob1CpxwBs=;
        b=K7mcknVHjc9p+Wz0WqMcwTGIwINAFGeh4ztwk1Ea1TrXdeYV4DERcZ5/MgVxeW+8b14wpA
        MNV2QSWqjaXMO2WOKX87jCjTjg8Z6dpDDgH4/1ODBB7giRjK/FibORJTmnR/FgerM8ZGnH
        ykZ+9L+AnhWuimm4Pq5f85OxlqOHQu4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-gcdg4wJxMpafu46kWIV-JA-1; Fri, 12 Nov 2021 04:40:08 -0500
X-MC-Unique: gcdg4wJxMpafu46kWIV-JA-1
Received: by mail-ed1-f69.google.com with SMTP id y12-20020a056402270c00b003e28de6e995so7749716edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChwqGEU71MP3pmS3G7ZC9yqmE+mk5CmpL7Ob1CpxwBs=;
        b=k/kTI94BVeByCn1xDV7b5NFYXpaASRCvDNt8Hb7+IvwHMdYeowaG5APgJjrFVBh+FJ
         KqebbO2qeqBDdtDuNZJfqGGTnFJBey/bQApfvrsXLGgQTpB5fsHTeEHRNAnVw9h850xP
         jrdIrFZwdFYI/Wrjo0UIf9zrxAHSWiOCsjCHwzviDuDK+BGm6JobEwV8MwT2kNqGLuy+
         xen8icZh64+8ewPA5Cyekp1B5bjVUVizXLodLxPIkaFR42JbKTfUs1QFbaOoEtf4FNac
         9oinJ21RYsUsPbZdY7AJV7LrupZ07EOVP0ydh7tcIpSJu8aEPPJ1AJ7oRJL5Ph/vGlCZ
         Rv3A==
X-Gm-Message-State: AOAM532uCwzSE30/g6Dkrecs5na67me1bqiHHeTDkI8w49rEyDBVmcrx
        EcwbX0dAGlnVQvpWM+hb9FYmHVsMpWGuDiHl6NibLEuVw6+eVxifWv4FNy80UDs2XTwU+VUPzNo
        bRcVxvOmtUz1awl1KdXJDwD1l4DwoYU+GcKkcPhLZ
X-Received: by 2002:a50:d741:: with SMTP id i1mr7357792edj.37.1636710006979;
        Fri, 12 Nov 2021 01:40:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeg1NEvHBbn632kiGcktiP/iHbgoMjBkpWDIyE8LgbJYWl3t9EL9C71Fq9I/TftxPLG6bqhHKfEWZTro2IicM=
X-Received: by 2002:a50:d741:: with SMTP id i1mr7357756edj.37.1636710006784;
 Fri, 12 Nov 2021 01:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20211108140648.795268-1-javierm@redhat.com> <a8d93a19-c7e6-f651-a1cb-9e2742383c73@suse.de>
 <20211112105641.25a4e1a7@eldfell>
In-Reply-To: <20211112105641.25a4e1a7@eldfell>
From:   Javier Martinez Canillas <javierm@redhat.com>
Date:   Fri, 12 Nov 2021 10:39:56 +0100
Message-ID: <CAFOAJEd6wNDF93Z1Y6-62pnRzth9Fg4+56+jqCe2qmHk-adR1w@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Cleanups for the nomodeset kernel command line
 parameter logic
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pekka,

On 11/12/21 09:56, Pekka Paalanen wrote:

[snip]

>
> Hi,
>
> these ideas make sense to me, so FWIW,
>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>

Thanks.

> There is one nitpick I'd like to ask about:
>
> +bool drm_get_modeset(void)
> +{
> +     return !drm_nomodeset;
> +}
> +EXPORT_SYMBOL(drm_get_modeset);
>
> Doesn't "get" have a special meaning in the kernel land, like "take a
> strong reference on an object and return it"?

That's a very good point.

> As this is just returning bool without changing anything, the usual
> word to use is "is". Since this function is also used at most once per
> driver, which is rarely, it could have a long and descriptive name.
>
> For example:
>
> bool drm_is_modeset_driver_allowed(void);
>

Yeah, naming is hard. Jani also mentioned that he didn't like this
function name, so I don't mind to re-spin the series only for that.

> - "drm" is the namespace
> - "is" implies it is a read-only boolean inspection
> - "modeset" is the feature being checked
> - "driver" implies it is supposed gate driver loading or
>   initialization, rather than modesets after drivers have loaded
> - "allowed" says it is asking about general policy rather than what a
>   driver does
>

I believe that name is more verbose than needed. But don't have a
strong opinion and could use it if others agree.

> Just a bikeshed, I'll leave it to actual kernel devs to say if this
> would be more appropriate or worth it.
>

I think is worth it and better to do it now before the patches land, but
we could wait for others to chime in.

Best regards,
--
Javier Martinez Canillas
Linux Engineering
Red Hat

