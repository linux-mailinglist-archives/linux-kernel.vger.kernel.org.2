Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17023AF522
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhFUSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:34:38 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44568 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhFUSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:34:36 -0400
Received: by mail-qt1-f181.google.com with SMTP id d9so14156336qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCRbv/aRMV+P2V5s5m5E9cP0bjS6RIc5PvhtpVuozDQ=;
        b=jDuTSGCdaf/KoyZaha/d583u2+7aF1VmYyctjX4dcOxEeKXfxHbcKdfVpOcu1CXR1+
         d7F29x4eMGRgDU1ww15FcklPBejriGMOGlsYsD20MAuLejuRqVN+ZIh9jDqLkNWG9NMr
         1rvuW0KYjive2XDrJ+2VDfSW+6/umeIp9LbLrUTHJakeq/w54jaqZf519052t8j1cT6U
         Z4uC570AS3qac9KzFxNLaIm86ALuC16/91V13BwRbZtdC1O0Nflek730Kx8pbbLc10wG
         nw04S1yUfuBpZgxV3/xRJknhONhHC0a9a04McXZNStKv498gkMV1YBq+KhHBvxD/Y4VE
         uPQw==
X-Gm-Message-State: AOAM5332KnGiV7LkIKBEsblvik77sWcKIpoX04wZJxbrWweuDdyQdNuj
        AorXz+ovjVyInBV/fzxW7sA=
X-Google-Smtp-Source: ABdhPJwxZOFCOLnryDADPR+5R5lP6cYXxO3FT1SSZwaz3lHtyXnTcWqMQfsk6n9HCJZsh3vxq6ui6w==
X-Received: by 2002:ac8:5b0e:: with SMTP id m14mr25031276qtw.357.1624300341197;
        Mon, 21 Jun 2021 11:32:21 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.162.103])
        by smtp.gmail.com with ESMTPSA id v12sm5902780qkv.48.2021.06.21.11.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 11:32:20 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: api: remove kobj_to_dev.cocci script
To:     Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Julia Lawall <Julia.Lawall@inria.fr>
References: <20210621174808.1489111-1-kbusch@kernel.org>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <cc3b2db6-70fd-0bb2-d083-f87f9a35e9a7@linux.com>
Date:   Mon, 21 Jun 2021 21:32:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621174808.1489111-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/21 8:48 PM, Keith Busch wrote:
> Using kobj_to_dev() instead of container_of() is not universally
> accepted among maintainers as an improvement. The warning leads to
> repeated patch submissions that won't be accepted. Remove the script.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Denis Efremov <efremov@linux.com>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Acked-by: Denis Efremov <efremov@linux.com>

> ---
>  scripts/coccinelle/api/kobj_to_dev.cocci | 45 ------------------------
>  1 file changed, 45 deletions(-)
>  delete mode 100644 scripts/coccinelle/api/kobj_to_dev.cocci
> 
> diff --git a/scripts/coccinelle/api/kobj_to_dev.cocci b/scripts/coccinelle/api/kobj_to_dev.cocci
> deleted file mode 100644
> index cd5d31c6fe76..000000000000
> --- a/scripts/coccinelle/api/kobj_to_dev.cocci
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -///
> -/// Use kobj_to_dev() instead of container_of()
> -///
> -// Confidence: High
> -// Copyright: (C) 2020 Denis Efremov ISPRAS
> -// Options: --no-includes --include-headers
> -//
> -// Keywords: kobj_to_dev, container_of
> -//
> -
> -virtual context
> -virtual report
> -virtual org
> -virtual patch
> -
> -
> -@r depends on !patch@
> -expression ptr;
> -symbol kobj;
> -position p;
> -@@
> -
> -* container_of(ptr, struct device, kobj)@p
> -
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- container_of(ptr, struct device, kobj)
> -+ kobj_to_dev(ptr)
> -
> -
> -@script:python depends on report@
> -p << r.p;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING opportunity for kobj_to_dev()")
> -
> -@script:python depends on org@
> -p << r.p;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING opportunity for kobj_to_dev()")
> 
