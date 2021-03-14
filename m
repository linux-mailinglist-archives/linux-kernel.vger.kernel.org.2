Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9439A33A8A0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhCNWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhCNWnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:43:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0CAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:43:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x29so19356427pgk.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=NpJ5kbIJjQCacJL3hSiTSKNPFpH043fpemq8fFOnZ6w=;
        b=MQ9nbVntaqEMbmMnF3FGzwVXEknd/LTi8NkumuUuKWEKiYIt+ntBAjRIzh1e+NbY/E
         /PuS2ZB7yQL1i/iPGiRC1y3IVuRDSNW5Usd4TKEdtua8hXeCDO+k9kHpCE4ZR8H6q6dm
         nSDPd+Um0DeM/CjZxe5c83dKLURlT0kS7BD2epd0g8T3dLSzN9bz76DMXY0dDGZfVC1C
         F/laTfp877Is7tPtL7bmZNVf4h/meAhE9s9kR0Jvxyb0IA1icTPAbShPgqX86ItDW0l1
         Vvo1/+7QNYaGgmmcV2MAWTL4EUi+LmeiKV6hQkW9ujnfZv+0Yfqb+yGLYvdibsbyuZe4
         eXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=NpJ5kbIJjQCacJL3hSiTSKNPFpH043fpemq8fFOnZ6w=;
        b=DLEKbGrPGHXZFquw2sX5XU5eRv1sNw53aDdflsJMg962td+DY/wQRAvE5jQd7HTQoz
         MhMqZzJau1gL9nd2RaYUayNZd2bPiZjzTY8kZNRJ7WbkvxYlwGtz37Ii5V/si16G2kMu
         07/fuMlAK/1tGiQ1K2+CzUi9Q6T+fOx8+EhEL5gP5UlsCINqOY7ObE9/rSZM64z5MrHZ
         UvHy1Pmu6wZ9FKQ7vNafuKz9DVWLiObfAMF3u0YgjkoDSbuuldsC0qgnAp/f8E2aR8K3
         La8sjSbPGFA+RIVo4nujHiAw5+cQC3NdALOaG3VTilh2ZrUT0akNqfs4EX+NwV2UPwjD
         bO1g==
X-Gm-Message-State: AOAM531aonzpYTAdt3sw4uukK6UtKB/3ebRSd+q/SUqp9NBXrhLXuO+b
        CSwA6XxgyoP083zoMxK5g/NmrQ==
X-Google-Smtp-Source: ABdhPJy4qozN/WipcWxUXVdta1kSYtlep0iEx4KHOWWsDYuJ/fWQV7Lxu80EJPqEEu1pDYwSYhNf/w==
X-Received: by 2002:a63:e942:: with SMTP id q2mr20763230pgj.217.1615761782846;
        Sun, 14 Mar 2021 15:43:02 -0700 (PDT)
Received: from [2620:15c:17:3:31d4:7e7d:6be6:636f] ([2620:15c:17:3:31d4:7e7d:6be6:636f])
        by smtp.gmail.com with ESMTPSA id mm12sm8506569pjb.49.2021.03.14.15.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:43:01 -0700 (PDT)
Date:   Sun, 14 Mar 2021 15:43:01 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yafang Shao <laoar.shao@gmail.com>
cc:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v6 2/3] mm, slub: don't combine pr_err with INFO
In-Reply-To: <20210314083717.96380-3-laoar.shao@gmail.com>
Message-ID: <fa6cf953-3b63-a2f9-2e6a-441b6763e7c@google.com>
References: <20210314083717.96380-1-laoar.shao@gmail.com> <20210314083717.96380-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2021, Yafang Shao wrote:

> It is strange to combine "pr_err" with "INFO", so let's remove the
> prefix completely.
> This patch is motivated by David's comment[1].
> 
> - before the patch
> [ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)
> 
> - after the patch
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> [1]. https://lore.kernel.org/linux-mm/b9c0f2b6-e9b0-0c36-ebdd-2bc684c5a762@redhat.com/#t
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>

Acked-by: David Rientjes <rientjes@google.com>
