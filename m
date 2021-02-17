Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC1931DF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhBQSWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhBQSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:22:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C443C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 10:21:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s16so3939392plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 10:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=gkAfK7E07XeGQ1PNMbY/9Hk5bNLDJddDOnTapY6pVFA=;
        b=T0FmcWi38baCUO7Y6rC49Rk883DdZleKu/1MafQxg0rXQEfOCnCPGqZDQB2HxENpLv
         31esPwVTNbIZeg7eQSIeU/9DIgMOwDCacuvQJQlI2MSX2q37ZV3LZCm5X3G1uKK7sKBZ
         EqvSisMZdysrBD3FGEXd13T/eYFePMB0E2NnmFJcRKtHEKeNOmMc38AlX3/XAxxMd+lc
         2VS8TCKXwkREFX5xf3Tt27ZnMufW/cxgpm8dQn96H4YevMIc3mKMg92cDucmqrIqeTRa
         +KAjR+O+JFU2CTxxJcy5YLK5ABBwBP2OaP/KIwYyg9c9wGI4VqkFXG5VhSzmuD/j3Mew
         UC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=gkAfK7E07XeGQ1PNMbY/9Hk5bNLDJddDOnTapY6pVFA=;
        b=fRjDG/DBJAeBlxHgw0A9/U5GNUDNUU3SohwoMK+GLDJemlgyKEUhn0Ms7S9xcapC9Z
         WAYeIk7UiO1fIbiNRlvPYAjvJDSmdjx2x9WUgnADW/+co4m0H6pyO4CKkmUf+E7OZ3JG
         81jKIn55xs92Zeqx6g2Uk/vyBrXd0TNZ3h7WGnzGTWIZU3DiD2Agd2xYKWF6PEtHZPfn
         gCI2Nere5W8kmRCj61OwiFJkogfXUUEMgo0lZeTi6iuBGOzsEtC+CQ048e1DDkoteAdD
         8yX7U4z2tEGjY+sfuIHbzQArPEqhkjyRDyjRhCxDBg7qvt0jcLER5Lhnj0KI6u/IUS2T
         F+aA==
X-Gm-Message-State: AOAM531jGhc+ia9ZaVBHBudoBjqiAdhO1Y3ydaCcAN6hJsQSipgCJzZw
        dpIK+h6MznZ2WMvKNNqpHAj35g==
X-Google-Smtp-Source: ABdhPJxbKfTXL0cn3O2ig6qmqTKxwwvhE2sFQ7KOMTnPrq4k3fT3DpouFM2qV7Bqyti7e9InFwPh2Q==
X-Received: by 2002:a17:902:6b43:b029:df:fb48:aecf with SMTP id g3-20020a1709026b43b02900dffb48aecfmr191625plt.67.1613586105749;
        Wed, 17 Feb 2021 10:21:45 -0800 (PST)
Received: from [2620:15c:17:3:65b9:f653:9bf9:9648] ([2620:15c:17:3:65b9:f653:9bf9:9648])
        by smtp.gmail.com with ESMTPSA id b3sm3183272pfo.148.2021.02.17.10.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 10:21:44 -0800 (PST)
Date:   Wed, 17 Feb 2021 10:21:43 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Yafang Shao <laoar.shao@gmail.com>
cc:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm, slub: don't combine pr_err with INFO
In-Reply-To: <20210215155141.47432-3-laoar.shao@gmail.com>
Message-ID: <e5289046-1dc-e90-56d0-30dd63da93a@google.com>
References: <20210215155141.47432-1-laoar.shao@gmail.com> <20210215155141.47432-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021, Yafang Shao wrote:

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
