Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF06333F0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhCQNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230044AbhCQNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615986289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5K1eWFevd/HHcWFLKscE1HUL+tCoTqGMwfzyUYEhIo=;
        b=CpGI4p3jb4V68Hg00Jd8A4P1ftZRtMraRMZXmYCU9AD/nlxL6q2gwe+zqV8Nr0qrd1FgFH
        HM1mFFhsykTERImS+6wqm09gKJtBk1XShiQd60ZrvG6qjHuwe7f5e3E8h274e3UVADJoPE
        hLLc7pYz6r4SHYwjee8ON0MzZPss+Mw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-CsXvmVNyOiuw3eVNzSerpg-1; Wed, 17 Mar 2021 09:04:48 -0400
X-MC-Unique: CsXvmVNyOiuw3eVNzSerpg-1
Received: by mail-ed1-f69.google.com with SMTP id o24so19270123edt.15
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 06:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h5K1eWFevd/HHcWFLKscE1HUL+tCoTqGMwfzyUYEhIo=;
        b=ii1bshVIxvZQrkJbT6mo3h/SEtNmiGGZOXhCXVhHDhNCosuUW9F2pLeizzWkPKbnp0
         S/8NJ2XVum1tZ4qgrssi/+qHFZbwVvjZyrIPUE5omOajMgeQ354Bc5TaHogGxFpw8pii
         rSjkRBy79J7mRxxOeniTbFpwJfgDUiu7pMygkWY6kAxSVcezRrJk1PT9J9jYErTgtUpS
         hq9cHHXxN/W9udW7CvZVHNAKtlaHDsM9qm94em5Si+5Tugtvx3jZpmTYRgeUn7TR4dEw
         LkDeTAHrrEGvEXzUBuTmYLHUYl5qxEJlautGePwDK33NB0oo9y/nCjO5+Z68Uyd+i7in
         pcQQ==
X-Gm-Message-State: AOAM530xRqh+0wi+qia1pDowCmY5amS6cF0JXTIFypg0LWikKwUZqwNm
        PMUwqgLn2DarXMDHSnXbtyVt9Ii7AbXRSvz8pFHopWX1hp9v32NuRn0Rb5D4y6dvPl1hTyRxiJK
        ciZtsMj4T5/wqlNh8KXyF7rr2
X-Received: by 2002:aa7:d98b:: with SMTP id u11mr42842487eds.352.1615986283543;
        Wed, 17 Mar 2021 06:04:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyDhSRwms9eliBndoHdtnij7qZI8LvV0vW97nB6OL4IrtYBHURFzssnERHOda1/sbEJA5eYQ==
X-Received: by 2002:aa7:d98b:: with SMTP id u11mr42842187eds.352.1615986280598;
        Wed, 17 Mar 2021 06:04:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x1sm1426421eji.8.2021.03.17.06.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:04:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 73A53181F55; Wed, 17 Mar 2021 14:04:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, ast@kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] libbpf: use SOCK_CLOEXEC when opening the
 netlink socket
In-Reply-To: <20210317115857.6536-1-memxor@gmail.com>
References: <20210317115857.6536-1-memxor@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 17 Mar 2021 14:04:38 +0100
Message-ID: <87lfamc4nt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Otherwise, there exists a small window between the opening and closing
> of the socket fd where it may leak into processes launched by some other
> thread.
>
> Fixes: 949abbe88436 ("libbpf: add function to setup XDP")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

