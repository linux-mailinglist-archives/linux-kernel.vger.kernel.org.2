Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDA63B1619
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWIqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhFWIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:46:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:43:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d12so1164984pgd.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=fiXde7QGThVEs2a8eG5Wa5SsrtC/F65ZLJeyMwx8LmY=;
        b=K5s/NYBJfsvY+JWKJXyrcfyKBQBipZp9xRPirB1hYZk+r56FgiUMJa7jXJV6/YqVFl
         NiTQZX4WNJjZSMX6OXhYExYKaB9qHgQfnUGTER1hys/3sTf9LPK3wixcYFsgRsVdeAms
         X9zWNWa9jDVe/nxESpuJrOaEmRz0qeU+K+TEuaSJU+AiUngwTvkcTAGO8IoD+YBhG8B4
         n3ZC5d8cIQedaEIDxbgoZtGejAsBSikif3ej85VSkhru0vaR4xA0mgrZ6sxWKx20BOke
         q9BfeUxKgcHJtIKBEbC5UnUpXljjF4QYQJEt6UKwE6AK91wrXSgls2VpYaISOHQrCBna
         32Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=fiXde7QGThVEs2a8eG5Wa5SsrtC/F65ZLJeyMwx8LmY=;
        b=tIMd+YDNwDknVBUKpkP/JPXsEZ+uuFk3Eo4Pxh7jRY17f232GaebeL+oIg9pg+RITD
         2/BUc8SFW6wGa0Qrm3oOQFFSBE0QD2pxhUXneSjfqdbRJ7oDjrWDg54BxNZL/OT0Tgzi
         5WQ1PSUczOlepoygbz4YDd4zwERBjkA1pJFDIo6JQ6wpAGqMAAuml5Uf5H7I5vslKlYw
         HRACpVUCc/MQVg039IGMkV5ijqf1ZJAjYevaqExXETudHaGn9o7vtrSSO/3j1FyKzt9v
         lU5q7UgNMSFYS5KWKkwJqFA21VMjx8aJ2I+rayU896iPVSPYe/5f1ZnxJ6NoPoyyjCO+
         bz9w==
X-Gm-Message-State: AOAM530SHIPM0diRteh6pEBum2Xfw+1wyAqLJPFXx0PaL55+I+0Hpiuz
        xM0xGM28ohtNkk6NCV4NC1c=
X-Google-Smtp-Source: ABdhPJwri9bvkZh/Vk++3f7qfMxAJnpdM3lIGQ6yk4NbItk2KLEpqXQj8O6OhfIoLNH7F8bbX8tYnQ==
X-Received: by 2002:a62:d408:0:b029:305:d371:b547 with SMTP id a8-20020a62d4080000b0290305d371b547mr5729193pfh.52.1624437836527;
        Wed, 23 Jun 2021 01:43:56 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id nr20sm4540919pjb.46.2021.06.23.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 01:43:56 -0700 (PDT)
Date:   Wed, 23 Jun 2021 18:43:50 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
To:     Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210622225030.478384-1-aquini@redhat.com>
In-Reply-To: <20210622225030.478384-1-aquini@redhat.com>
MIME-Version: 1.0
Message-Id: <1624437661.tyds6vli52.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Rafael Aquini's message of June 23, 2021 8:50 am:
> On non-preemptible kernel builds the watchdog can complain
> about soft lockups when vfree() is called against large
> vmalloc areas:
>=20
> [  210.851798] kvmalloc-test: vmalloc(2199023255552) succeeded

This is vfreeing()ing 2TB of memory? Maybe not too realistic but
I guess it doesn't hurt to add.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

> [  238.654842] watchdog: BUG: soft lockup - CPU#181 stuck for 26s! [rmmod=
:5203]
> [  238.662716] Modules linked in: kvmalloc_test(OE-) ...
> [  238.772671] CPU: 181 PID: 5203 Comm: rmmod Tainted: G S         OE    =
 5.13.0-rc7+ #1
> [  238.781413] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYXC=
RB1.86B.0553.D01.1809190614 09/19/2018
> [  238.792383] RIP: 0010:free_unref_page+0x52/0x60
> [  238.797447] Code: 48 c1 fd 06 48 89 ee e8 9c d0 ff ff 84 c0 74 19 9c 4=
1 5c fa 48 89 ee 48 89 df e8 b9 ea ff ff 41 f7 c4 00 02 00 00 74 01 fb 5b <=
5d> 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 29 77
> [  238.818406] RSP: 0018:ffffb4d87868fe98 EFLAGS: 00000206
> [  238.824236] RAX: 0000000000000000 RBX: 000000001da0c945 RCX: ffffb4d87=
868fe40
> [  238.832200] RDX: ffffd79d3beed108 RSI: ffffd7998501dc08 RDI: ffff9c6fb=
ffd7010
> [  238.840166] RBP: 000000000d518cbd R08: ffffd7998501dc08 R09: 000000000=
0000001
> [  238.848131] R10: 0000000000000000 R11: ffffd79d3beee088 R12: 000000000=
0000202
> [  238.856095] R13: ffff9e5be3eceec0 R14: 0000000000000000 R15: 000000000=
0000000
> [  238.864059] FS:  00007fe082c2d740(0000) GS:ffff9f4c69b40000(0000) knlG=
S:0000000000000000
> [  238.873089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  238.879503] CR2: 000055a000611128 CR3: 000000f6094f6006 CR4: 000000000=
07706e0
> [  238.887467] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  238.895433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  238.903397] PKRU: 55555554
> [  238.906417] Call Trace:
> [  238.909149]  __vunmap+0x17c/0x220
> [  238.912851]  __x64_sys_delete_module+0x13a/0x250
> [  238.918008]  ? syscall_trace_enter.isra.20+0x13c/0x1b0
> [  238.923746]  do_syscall_64+0x39/0x80
> [  238.927740]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>=20
> Like in other range zapping routines that iterate over
> a large list, lets just add cond_resched() within __vunmap()'s
> page-releasing loop in order to avoid the watchdog splats.
>=20
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a13ac524f6ff..cd4b23d65748 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2564,6 +2564,7 @@ static void __vunmap(const void *addr, int dealloca=
te_pages)
> =20
>  			BUG_ON(!page);
>  			__free_pages(page, page_order);
> +			cond_resched();
>  		}
>  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
> =20
> --=20
> 2.26.3
>=20
>=20
>=20
