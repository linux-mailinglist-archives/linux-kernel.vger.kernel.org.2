Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC063B18DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFWL32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFWL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:29:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9DC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:27:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f30so3559363lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UWr5bBdzre6zz0XMKZOGH1iTjAFUl0PtpeleXTfI3Xk=;
        b=qAIu1qD4S0I+cth0RweLmSX0Bse2NaMmHfSlyVrjBAQleGDbUcw6falwFJq57HdSYJ
         OeyJuYhSJummHyKV6WkMnlSJWv6C0XNHB94K8Lfe1ElcnM8g3e719edBHh55sfNWwTzg
         I/cMfyBwIAs1lktX5wJLAOwR+QxbQxrMYzpW7wAaNNdcah+xtdoaNanPcTXcg5uHzIoW
         r7AhySM1h3K9ySSdkBM4/rcSRVuszVFWnd5zRvMEsjhB5b8ptZBxCOSQvs4fK1VZ0KhY
         ukUDi8JhZLaTxp1s1i03s3njCOddQc1B1syf1Nv11Y5Zu8Ob04ja9JcgkY8UpIk3xuu8
         AE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWr5bBdzre6zz0XMKZOGH1iTjAFUl0PtpeleXTfI3Xk=;
        b=ZTe5L6jQruFp/de+yv0Ij0ZtamB+GaTxk8gNy7BG0dWVPiCrcZPjjIksQmmWedC+BM
         Fm216IiRR76Ut1JsHdHJDezvw933FRy8ouhMofKg0UgMQSLndS+HeuSTaFOwJCKDzy6x
         nFcB09vPDlivcVuY3MURrtuPz7ZNHJYfWjDoWvqe0C2cooO6sVdqWFpxTcphGPJrjKA9
         CZIZb5g7/i7TGVlh9dkRlPa3KkOKahLtDYs393U9/MigkTt1Ni3DCxAGkRMX2T+yYjIy
         mjbaqV2NQnVw2ke/LBYudrkhbGfbdkQNrJ6vnR5gVZApKGHsJla9MLBsP5JfyfU2sUKO
         23uQ==
X-Gm-Message-State: AOAM532I3SpKICDmNPofJsjSuhpOaopXUvElnSx87eiBA/A36NEOjsKz
        tKyVWiKeqPG2FrcFXjFQI/s=
X-Google-Smtp-Source: ABdhPJxp7DJyqYd59MyfSejJoNoBRKlU8/OCPghwEvO5PIZ6Y/2nsF2LvVuARAL+idkBd3i/thYJVg==
X-Received: by 2002:ac2:5feb:: with SMTP id s11mr6685710lfg.591.1624447627153;
        Wed, 23 Jun 2021 04:27:07 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id br18sm1002444lfb.120.2021.06.23.04.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:27:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 23 Jun 2021 13:27:04 +0200
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
Message-ID: <20210623112704.GA1911@pc638.lan>
References: <20210622225030.478384-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622225030.478384-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On non-preemptible kernel builds the watchdog can complain
> about soft lockups when vfree() is called against large
> vmalloc areas:
> 
> [  210.851798] kvmalloc-test: vmalloc(2199023255552) succeeded
> [  238.654842] watchdog: BUG: soft lockup - CPU#181 stuck for 26s! [rmmod:5203]
> [  238.662716] Modules linked in: kvmalloc_test(OE-) ...
> [  238.772671] CPU: 181 PID: 5203 Comm: rmmod Tainted: G S         OE     5.13.0-rc7+ #1
> [  238.781413] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYXCRB1.86B.0553.D01.1809190614 09/19/2018
> [  238.792383] RIP: 0010:free_unref_page+0x52/0x60
> [  238.797447] Code: 48 c1 fd 06 48 89 ee e8 9c d0 ff ff 84 c0 74 19 9c 41 5c fa 48 89 ee 48 89 df e8 b9 ea ff ff 41 f7 c4 00 02 00 00 74 01 fb 5b <5d> 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 29 77
> [  238.818406] RSP: 0018:ffffb4d87868fe98 EFLAGS: 00000206
> [  238.824236] RAX: 0000000000000000 RBX: 000000001da0c945 RCX: ffffb4d87868fe40
> [  238.832200] RDX: ffffd79d3beed108 RSI: ffffd7998501dc08 RDI: ffff9c6fbffd7010
> [  238.840166] RBP: 000000000d518cbd R08: ffffd7998501dc08 R09: 0000000000000001
> [  238.848131] R10: 0000000000000000 R11: ffffd79d3beee088 R12: 0000000000000202
> [  238.856095] R13: ffff9e5be3eceec0 R14: 0000000000000000 R15: 0000000000000000
> [  238.864059] FS:  00007fe082c2d740(0000) GS:ffff9f4c69b40000(0000) knlGS:0000000000000000
> [  238.873089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  238.879503] CR2: 000055a000611128 CR3: 000000f6094f6006 CR4: 00000000007706e0
> [  238.887467] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  238.895433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  238.903397] PKRU: 55555554
> [  238.906417] Call Trace:
> [  238.909149]  __vunmap+0x17c/0x220
> [  238.912851]  __x64_sys_delete_module+0x13a/0x250
> [  238.918008]  ? syscall_trace_enter.isra.20+0x13c/0x1b0
> [  238.923746]  do_syscall_64+0x39/0x80
> [  238.927740]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Like in other range zapping routines that iterate over
> a large list, lets just add cond_resched() within __vunmap()'s
> page-releasing loop in order to avoid the watchdog splats.
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a13ac524f6ff..cd4b23d65748 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2564,6 +2564,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  
>  			BUG_ON(!page);
>  			__free_pages(page, page_order);
> +			cond_resched();
>  		}
>  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
>  
> -- 
> 2.26.3
> 
I have a question about a test case you run to trigger such soft lockup.

Is that test_vmalloc.sh test-suite or something local? Do you use a huge
vmalloc mappings so high-order pages are used?

Thanks!

--
Vlad Rezki
