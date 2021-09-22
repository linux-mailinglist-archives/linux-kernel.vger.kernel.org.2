Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D2F414BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhIVOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:20:04 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:34642 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbhIVOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:19:59 -0400
Received: by mail-vs1-f53.google.com with SMTP id u8so3157659vsp.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4PAUUUtUWlJzST2fG7TdOWPNu1FCJMhkGhRnMRQX8Oc=;
        b=GbHvSmqHVnm9+/nv6aq9BKoYemnBZqdl1xtHzESrgp8VYskmqDqnZ1olzwEzq+VSL3
         zSH/kzMc7RSJ9vIQUBavqTxHpAXLx9V5kjVcQnwMwkzLntX30LqzSA/PtJg//vrjOqwZ
         36p9AOfeCZfCG94S3Z/5UcaCtq2oKXZUlT1kewT7dOBF/oP0OFalAlZ4zsdh20ddj3fv
         Smw/dnxlGs1xXpn1cMlBS0pOLb+ajGah1kiTYXWJRWjcuWqnfZtbRyU2mDRLhrGY7gr6
         pd3iGkTua8a8/t4Od6b7DIEMds2mfznEXjdespEHVGrkNMR0zxsp0eUVRCOoaRO2Rgru
         fKvg==
X-Gm-Message-State: AOAM530+wrN7OZYmrLCCwbjiyDVW5EckMn/rdc34ZCyFw8GO+Qs6KYH+
        CWOi2kKlkiteXZ9S2dSYtHgT4ixlyEcL5zG7F2E=
X-Google-Smtp-Source: ABdhPJz5A6+t/+J2P2icovoL2g+OWJpt4lZNgsemjl/kVjg7/1o8O6j2TksYmHj2qEDi5s1cVbmsKe1vWCZU194fgps=
X-Received: by 2002:a67:f147:: with SMTP id t7mr20253515vsm.41.1632320309397;
 Wed, 22 Sep 2021 07:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210921215218.89844-1-michael.christie@oracle.com> <20210921215218.89844-3-michael.christie@oracle.com>
In-Reply-To: <20210921215218.89844-3-michael.christie@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Sep 2021 16:18:18 +0200
Message-ID: <CAMuHMdWeToGusZvg+7x_iwa9vCk3Y7ByDADw70JVZ5AZoVdR0g@mail.gmail.com>
Subject: Re: [PATCH V2 2/9] fork: pass worker_flags to copy_thread
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hdanton@sina.com, Christoph Hellwig <hch@infradead.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:55 PM Mike Christie
<michael.christie@oracle.com> wrote:
> We need to break up PF_IO_WORKER into the parts that are used for
> scheduling and signal handling and the part that tells copy_thread to
> treat it as a special type of thread during setup. This patch passes the
> worker_flags to copy_thread, so in the next patch we can add new worker
> flags that function can see.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

>  arch/m68k/kernel/process.c       | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
