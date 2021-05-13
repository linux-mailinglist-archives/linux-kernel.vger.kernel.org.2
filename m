Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F4937F9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhEMOkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234483AbhEMOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620916781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N82rohKdFGCk54k/eUtcJuWMLMB8kINj7ETlJh00UJQ=;
        b=SA8Z53k3/63BzYNTnc9m6WIxbJWLa6fsEcHfbLTYja59q6PcivhXvOKluqy4D6pG3q3En4
        LwsTjLc3fqGzW0t7KgkkstS6g7cnQlByrw9NV6G3EPpO1aUrvqokYa+4FaW8HZqUf5Jgu+
        NR1OdVOZ/qrS5fyQhVtG/1QlONClL+8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-Z9olGVilNmKjeu5BJvS9eA-1; Thu, 13 May 2021 10:39:39 -0400
X-MC-Unique: Z9olGVilNmKjeu5BJvS9eA-1
Received: by mail-ej1-f70.google.com with SMTP id j16-20020a1709062a10b02903ba544485d0so4759159eje.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N82rohKdFGCk54k/eUtcJuWMLMB8kINj7ETlJh00UJQ=;
        b=cylVsSsknsulwCOR9PSrFuzHJU9gKCv2FqQhUiRT4wQ7DCHzS/t0kTwlbPUDVMzkA0
         Wc7jcMy/OIbKLIx8OGL5yHbeJsTAhuGqBo5Wcb7eqWsyCN2rj5woIKMD1t4jusFq2Prn
         4f5V5GWXpm7Ksugdseq5KmqAq2l9gnWsm1392A+2dasEq81J0kxiPW1sBDjd/0qwtIhE
         +LB516IrspCKXkfyFpKoSxenV4PK0TJtsHgHn+GaE6AIUQSBLrLNTvreTEmXbPlWbJ8w
         ZMO4tIOKLrN9w/+LOk+B1ONeNCAbvvroCXLMANM9MocCT3cHATcnPVPoL5dDkd3FrBdq
         HIDw==
X-Gm-Message-State: AOAM530NuogPRtmbcvLoBlDq6zhdgM2xqYp/1PC8tR2IZre1QWUaO0gT
        DQd9e6Yknwg5MusL26BhIXJP9OB7egoVgWY5yWNTajEexLtjM0sGU7JwyQgqnab/xlQhEVIvlPX
        TezwMZ8KBMI8fGQP+kxSOHNHk
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr10339761ejc.58.1620916778021;
        Thu, 13 May 2021 07:39:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6bjGbGDFHaUHXa1mTNhvmWCWVj4h9WkeUZyes40YkuxE3JFn0GzZuWQ5ezvv5REXRd3xrtQ==
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr10339740ejc.58.1620916777865;
        Thu, 13 May 2021 07:39:37 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id b5sm2360100edz.88.2021.05.13.07.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 07:39:37 -0700 (PDT)
Date:   Thu, 13 May 2021 16:39:35 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wanjiabing@vivo.com
Subject: Re: [PATCH] vdpa_sim_blk: Fix duplicate included linux/blkdev.h
Message-ID: <20210513143935.7zlpo35d5uvr3ok6@steredhat>
References: <1620903900-69738-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1620903900-69738-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 07:05:00PM +0800, Jiapeng Chong wrote:
>Clean up the following includecheck warning:
>
>./drivers/vdpa/vdpa_sim/vdpa_sim_blk.c: linux/blkdev.h is included more
>than once.
>
>No functional change.
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 -
> 1 file changed, 1 deletion(-)

Wan sent a similar patch a couple of days ago:
https://lore.kernel.org/patchwork/patch/1422992/

Thanks,
Stefano

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>index 5bfe1c2..a790903 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>@@ -15,7 +15,6 @@
> #include <linux/blkdev.h>
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
>-#include <linux/blkdev.h>
> #include <uapi/linux/virtio_blk.h>
>
> #include "vdpa_sim.h"
>-- 
>1.8.3.1
>

