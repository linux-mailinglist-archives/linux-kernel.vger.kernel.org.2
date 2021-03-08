Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB5331374
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhCHQcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCHQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:32:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB1DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 08:32:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w11so12108867wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZhOIRRujtFql++R7kmG02ewhcSqkxodqDPwoZ1eINpo=;
        b=s7wwq7JPPm2U1+kZoiOap2OUsbwEZfRdvx0TrHnwyLQyMSZ5uHl5lEuLvJ+BHtLMt+
         10ZoFBK0PutMHQZ5G3D32MZDKWAf7OXnot/y6G7ywuGYwzJ17lF0xdlJrMjJ2zy1bNF3
         NGgSg/VKMPE0iBnhkB4ViUDxna67TjydDcYH4Dd9a+BImWf9f7IpaBEsAYRT38BTDzUa
         cXwfBTr5rvtiL52eyUMSTdo8kVKje69qLiaZ80jA8RKr+9RbrhIDnMEuPJoN67oI+yo3
         KBbfo2J47bTBmB3rtu/ZYxTxEZjrb2XfOtEGgznjZ2qdl9OlDGpRoUXv/pAQZ/6V2prG
         eNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhOIRRujtFql++R7kmG02ewhcSqkxodqDPwoZ1eINpo=;
        b=sHP7GXBjkKrte+omaha469nULBZPrUUQTvKxkoF6WL9l3+58lWWtFe6kDBJcDJzUJ2
         gWiZx2CL5p8c/4OiA3V6iNCrvDsGu06x3zT1ITLmRd/cs9IkaTyZ3gSFmXLrvw8Zj22d
         YFlbAlv/kgEC60S4qLQvIpNDi3P4cLsk/oakSCPt+IRqHLqRTI1E3lZnx9s1UPUiT3zw
         Fv//HfGwxpnqDNELUaSsepm9V3VL2UtZ5VbpFgCfMRzZkWQGh2RSeYuNW4PiaLkNXFqB
         cZL2bxXJobZScGBxpfXo6MPtQFgZenUj4axdVcdAUnMlWq00+/KC4gvfBwQVjMaHrBKD
         3I0Q==
X-Gm-Message-State: AOAM5312IvSxDIs0OIrw421uasPt8qeuXRNbCr/5DuFNFKG9leo56Z1A
        VyNDGkb42eg5A2Vk01zUBFaddFLZjGwg3h6ac5pMZNoVuy4=
X-Google-Smtp-Source: ABdhPJzUX5jh+8XN3AYCtdSJbFzW4c6ZYr1TPWIt4/x+IRTr/PSoT9pHIlJUxXmRsuDJpf1wcqDs0A2p/fLPe4njtcY=
X-Received: by 2002:a5d:5906:: with SMTP id v6mr23932781wrd.137.1615221152420;
 Mon, 08 Mar 2021 08:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20210308104226.165814-1-niklas.cassel@wdc.com>
In-Reply-To: <20210308104226.165814-1-niklas.cassel@wdc.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Mon, 8 Mar 2021 22:02:05 +0530
Message-ID: <CA+1E3rLY_FrjhXSFr4_V0OEiv6uFnD4bvY-XLyi9O4C3n_0CGA@mail.gmail.com>
Subject: Re: [PATCH] Revert "nvme: cleanup zone information initialization"
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 4:21 PM Niklas Cassel <Niklas.Cassel@wdc.com> wrote:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> This reverts commit 73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7.
>
> Commit 73d90386b559 ("nvme: cleanup zone information initialization")
> introduced the following warning at boot:
> WARNING: CPU: 0 PID: 7 at block/blk-settings.c:252 blk_queue_max_zone_append_sectors+0x7d/0x90
>
> The warning is the result of chunk_sectors being 0.

This looks same as what Chaitanya posted the fix for -
https://lore.kernel.org/linux-nvme/20210303224717.51633-1-chaitanya.kulkarni@wdc.com/
