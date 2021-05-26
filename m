Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A19392257
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhEZVvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233790AbhEZVvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622065805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2jDM/TpmfLpzDZ7Dd8kJfaXr/uLu6JzfCGH8PAhY6A=;
        b=htI3YB/aTJlrd299nfRLiek/B2z1u5bsWwAg/L/u4jA+rxjJxkbUFELi++C0aGHoswZe4K
        jALiICGS6EwTnnYHvE/opfN9cFzhC0AoUihjvsGLc2s+ECUi04MFk0MNVVzrPCvuwS0ezD
        u4iXWNMlfoxzVaTyO9LNemRo9BjpRXk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-5lkVHQU2PUe9mTx4XTdMzw-1; Wed, 26 May 2021 17:50:01 -0400
X-MC-Unique: 5lkVHQU2PUe9mTx4XTdMzw-1
Received: by mail-wm1-f72.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso781671wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s2jDM/TpmfLpzDZ7Dd8kJfaXr/uLu6JzfCGH8PAhY6A=;
        b=E+5JDh3YlIJJhHjmyL+glS1tjDJ0d3K77iMIoPx6tOw6KCf4NTshUNy8Ez67/uK7yV
         niXo3Nw+CaPbwdDv/Hrnw0xinHui0fd5cafodq4IV0wLk+smRtGTZOgVcJw43UPTSG5B
         hgdTFLWVxEWbKG3ip7ChinT4q9lnLnphzG/OnSDcVqn0pXfBbF7yG+hOInzD6i1LGnwY
         ZV2PnMNC0dT/o8nw7nzu2jqod8G8FEWe/Pl9LsSkKIB0AjXnybGyJ1Jb70LQvbt3Ko36
         dWfCngbuIGXhTqK8sZo7QNqDbo7QxvLPBQGKFBJAp7GwyW2nldKzHZzaj7Wcm/8Ca5OW
         hFoA==
X-Gm-Message-State: AOAM531Br+9jPkKkhRU4ZJRfZXlSIW+tA+dLmmFLrQMtjlnDJ4V6feoe
        8x4l7SnWYx3jEAKEmTdvls40qO/OR5mzmLnts7xg1fLwMFLFWUSWtHtk5hcWaHs+ydHkQgLIUur
        1ClpE/l+cUQvzeD1bNrmpXdyo
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr85975wrx.320.1622065800500;
        Wed, 26 May 2021 14:50:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX3XLrans83aVeEW49CvKbVeLkqlNa3AgNJRBQ+d+nHfyxrTBw4pmjGbjCUesYgRVfH6dHEg==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr85963wrx.320.1622065800347;
        Wed, 26 May 2021 14:50:00 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id f14sm235371wry.40.2021.05.26.14.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 14:49:59 -0700 (PDT)
Subject: Re: [PATCH] kbuild: quote OBJCOPY var to avoid a pahole call break
 the build
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20210518142302.1046718-1-javierm@redhat.com>
 <CAEf4BzYqA1Upbm75aW-Rs-WCqQ6KRnSje-uTis2fw749_f8tRw@mail.gmail.com>
 <CAK7LNAQZNkdQTtGHmrE0dcbeirBZb1O++A4b2oaAvu6+1Jupbw@mail.gmail.com>
 <CAEf4BzaV0y51EY5JAYZ0dueC2NQihwy+4pTtidSj4KXxGm+fwA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <a5004a7e-14bf-4fb1-beec-9dc19165f2d2@redhat.com>
Date:   Wed, 26 May 2021 23:49:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaV0y51EY5JAYZ0dueC2NQihwy+4pTtidSj4KXxGm+fwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 11:02 PM, Andrii Nakryiko wrote:

[snip]

>>
>> BTW, I see similar code in scripts/link-vmlinux.sh too.
>>
>>      LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${extra_paholeopt} ${1}
>>
>> Is it OK to leave it unquoted?
> 
> You are right, link-vmlinux.sh should be updated accordingly.
>

Good catch. I'll include this in v2 as well.
 
> Javier, can you please send v2 and cc bpf@vger.kernel.org? Thanks!
>

Sure, thanks!
 
Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

