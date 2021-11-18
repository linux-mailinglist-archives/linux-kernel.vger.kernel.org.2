Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4AD455EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhKRO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:56:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229631AbhKRO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637247189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktZwmNj2i6HRghsgzsPdqkJk4QpYNvRhiEpD3DouXpc=;
        b=TvXzHUGo14MPME6da1vCoaZ7+VD8KP2gSj5pdmOKJLM5Z8FBiyylHsce4DigTxoAjlbKMj
        U73qeXX+XfsIoff8bw/+xhgR1lpT2sp6kRpUed6+UTZEwQ+rHH3bBKwictLVpHTrbBQV3B
        eSSG85PPGWRfvplJm0thnGABFzHvfw4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-qDaTozW5OCyYe0_PGtG46A-1; Thu, 18 Nov 2021 09:53:08 -0500
X-MC-Unique: qDaTozW5OCyYe0_PGtG46A-1
Received: by mail-qk1-f197.google.com with SMTP id h8-20020a05620a284800b0045ec745583cso5024054qkp.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ktZwmNj2i6HRghsgzsPdqkJk4QpYNvRhiEpD3DouXpc=;
        b=p/KgHJ65kdLz+3cmhdqHBQORkx5/1v4BghOyBGaKdaV56rIVC99g+NB0senhwXgvxs
         ZZRJXz0v66repJzJ7se0V2PnfOp8IfHhQIbBYSAeBcg+PQml8cGPJ+4uvcqoZ+jzND8s
         tQ85YlYiUY+JWwZ+J9ndWwsCygtgp64cui3ojN0jjPOBBYn2FH8z+TkAO4OGPsbj6iWL
         kY6eSbuJMDEcBP5AotrOEtFU/3xAzAxQ25t1QqOLjCnu5iBI5DHWNb6lNRJ4lXGza0k1
         FhuKNkFmzZRFae7gDTObV3DYFR7En/ArUT7ebnk5p1E/58tqlNx+5h/7fp0MyCSyaltP
         FDUw==
X-Gm-Message-State: AOAM531MpXa9/ZJKtrrXKTgIokf+XC7nirMULu+Vmx+s4QAeiKh2lSxr
        s50FK45JUQPHkdy21XN3VelDsuLPyzitymc+9XVeus2FEoqeWaVoGI5hhhkHUYqcqhihe3Jt4hn
        RgtFVfXTHFPqrwsYoxj4McuAOaOEkcem96UR20DXI
X-Received: by 2002:a05:620a:2403:: with SMTP id d3mr21281686qkn.281.1637247188137;
        Thu, 18 Nov 2021 06:53:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSc+hBdpB8rrN3UkT8yniJtEKjtj0Ij4dD3He2By/RfQJkikWJixdi13MzE6tEqilPyDs+LXKP7bNIxMaR/4o=
X-Received: by 2002:a05:620a:2403:: with SMTP id d3mr21281669qkn.281.1637247187998;
 Thu, 18 Nov 2021 06:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20211118082355.983825-1-geert@linux-m68k.org>
In-Reply-To: <20211118082355.983825-1-geert@linux-m68k.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 18 Nov 2021 09:52:57 -0500
Message-ID: <CAK-6q+gQCzJeV5VbCJUbg1dt=4nPvgBAOP5cPmLchmnro1pQ_A@mail.gmail.com>
Subject: Re: [PATCH] fs: dlm: Protect IPV6 field access by CONFIG_IPV6
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        "Reported-by : Randy Dunlap" <rdunlap@infradead.org>,
        cluster-devel@redhat.com,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 18, 2021 at 3:26 AM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> If CONFIG_IPV6=3Dn:
>
>     In file included from fs/dlm/lowcomms.c:46:
>     fs/dlm/lowcomms.c: In function =E2=80=98lowcomms_error_report=E2=80=
=99:
>     ./include/net/sock.h:386:34: error: =E2=80=98struct sock_common=E2=80=
=99 has no member named =E2=80=98skc_v6_daddr=E2=80=99; did you mean =E2=80=
=98skc_daddr=E2=80=99?
>       386 | #define sk_v6_daddr  __sk_common.skc_v6_daddr
>           |                                  ^~~~~~~~~~~~
>     ./include/linux/printk.h:422:19: note: in expansion of macro =E2=80=
=98sk_v6_daddr=E2=80=99
>       422 |   _p_func(_fmt, ##__VA_ARGS__);    \
>           |                   ^~~~~~~~~~~
>     ./include/linux/printk.h:450:26: note: in expansion of macro =E2=80=
=98printk_index_wrap=E2=80=99
>       450 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__=
VA_ARGS__)
>           |                          ^~~~~~~~~~~~~~~~~
>     ./include/linux/printk.h:644:3: note: in expansion of macro =E2=80=98=
printk=E2=80=99
>       644 |   printk(fmt, ##__VA_ARGS__);    \
>           |   ^~~~~~
>     fs/dlm/lowcomms.c:612:3: note: in expansion of macro =E2=80=98printk_=
ratelimited=E2=80=99
>       612 |   printk_ratelimited(KERN_ERR "dlm: node %d: socket error "
>           |   ^~~~~~~~~~~~~~~~~~
>
> Fix this by protecting the code that accesses IPV6-only fields by a
> check for CONFIG_IPV6.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 4c3d90570bcc2b33 ("fs: dlm: don't call kernel_getpeername() in err=
or_report()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Thanks, but the issue has already been fixed in the same way [0].

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/=
commit/?h=3Dnext&id=3D1b9beda83e27a0c2cd75d1cb743c297c7b36c844

