Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04250308143
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhA1WnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhA1Wmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:42:46 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0016C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:42:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s15so4166903plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=McnjkaGHWATkV0jPqlQmUTtHB9iU9HWTeU2cSJwi84A=;
        b=tQPKEFMnJZmCXBduEudkWaX83ib2TiRf3Igob8OXDg6VXJKWGl1566ydrjoxk2FPsQ
         Y8u6I76f8SGO9HQjZ8shICMC/Bk51eDzHiJ9TVaBDDhmoA61ocrnFNf9FTIr/VTQT5ad
         1DAdZ0LLwG43UOaY0UCeKpRfKRc62wIvm8o92IObiNQoMb7lZx/rWppnmSXg1TCXg9RS
         yHFDoXveC3AbILPsapop9hfB/6FZSLT8rXLKL29vZa59O3nW/fn01jZxw2yfqnYYy+ZM
         hYLyY8b7jjDwEpzL8nWabPv5B9ApTRYiHt4nT4pfU5QeioNduv9y7MZm8GTJul6D/s+J
         Pb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=McnjkaGHWATkV0jPqlQmUTtHB9iU9HWTeU2cSJwi84A=;
        b=rZ3wbIFqhZyld9MH3nm1X7wKaDeAf8T4ihUQcsbxZjRPn+3FURIQlcRXM7IrRKN4nk
         W10D2sJJaiwzgNsjAfo9xV62PSUT/C/t/jolWpmEPxH0vaRnTYf2u+r2G0ENZg2t6hRv
         qYlHZhm+tVbCwiE2eceGHQ/Fn3WvjNm4AkWCiWASgrymeLO6PGOTh4IFT9qbZc0ICzuk
         +tRDDHmPmCrloqKtQ9F+Cot2C/bBh27Br1KgXyKjOTjEtRp4BwSnOEVXrJl3DtraSXDP
         71YUwTnjXS14otJpw4VOcXiWX4e+2HfHm0onnCUM0qR40If0dNVOJQELArEnXW2VeNbT
         94Zg==
X-Gm-Message-State: AOAM532nE1yXIr0Dl2xJmi8C2aUYXPuWDpWVjikVFNcxE3Gw8Lbb5j0K
        TbIZtQoYvL6NyDBzIaK09tzCsg==
X-Google-Smtp-Source: ABdhPJxst2cQZT2YMKulIIFrlFl9VtJ7ncb9Gj95d+gXBoZamVjIPiIkLDl6gle204yu0TwwFzs35w==
X-Received: by 2002:a17:902:7783:b029:df:fa69:3a34 with SMTP id o3-20020a1709027783b02900dffa693a34mr1563200pll.21.1611873724125;
        Thu, 28 Jan 2021 14:42:04 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id s1sm5921879pjg.17.2021.01.28.14.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:42:03 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:42:02 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Yafang Shao <laoar.shao@gmail.com>
cc:     david@redhat.com, vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm, slub: use pGp to print page flags
In-Reply-To: <20210128021947.22877-2-laoar.shao@gmail.com>
Message-ID: <5c35e43d-2cc4-13de-845f-bd8d3e6e8f0@google.com>
References: <20210128021947.22877-1-laoar.shao@gmail.com> <20210128021947.22877-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021, Yafang Shao wrote:

> As pGp has been already introduced in printk, we'd better use it to make
> the output human readable.
> 
> Before this change, the output is,
> [ 6155.716018] INFO: Slab 0x000000004027dd4f objects=33 used=3 fp=0x000000008cd1579c flags=0x17ffffc0010200
> 
> While after this change, the output is,
> [ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
