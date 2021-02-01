Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC230B209
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhBAVXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBAVXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:23:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF65C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 13:22:58 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id a77so20461328oii.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOWrw7a+Nf/KygeG78AKIm4KgYP1X9MsGHak8Pcn4zg=;
        b=o5jpmsDsoy2ji8gpSb36ZTjvFoA1b9ZgnxGP7BNO941bOozBAgb85HxfqP7ke9weQZ
         SpK7oyNLgUjJX2fDxDZQDiKj5OnmmA1iQLR9Pql9Y7kN07+suHgVlZpX849oC7jsFT57
         cW0DfuuM2Hw+BuZiiWMrn3sKFp79qYjY1DUgakhu1dQ4GghBwUHxOdFyECtLgJOMYpS7
         W8pMJq1aTdPk1qovkiZBrTCtatjVdjA9o1hN0/ieRYZ0JWHw8Q5D/5SEmXQsU5cXpIOn
         sy0df7yFz7oIgQHyrO6/mHCdDwFjmVgfsBhSFTnEzLu5c/U7EipCXJRYolPbbg8FIuOo
         2P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOWrw7a+Nf/KygeG78AKIm4KgYP1X9MsGHak8Pcn4zg=;
        b=ZUMTHmBrXBD08K9pKBCezM6rMdOodyXnIEJ06g8VPhVqsgUZtccKW4fjgYL1dE0/5d
         NLuvcGYbnqv3vRvvzdLUaeDfCL5xJeC6L+7IR7XuK1s3b6w534K+CfZqvMDw/NvvhNwH
         LdGFPTGPjEX6rpnoiJk83Ph/gQyLGvpEWhWJGa8bEchl13jfdpHIF+M6Z+KKwsr/7QKm
         nRC/ZY7boVYc3pP2L6VvI4i0VuLYlAuq+FcEC/7CpDqEjVpDhZumXCm4fHIR1dDSkVMr
         /k/vVMBaoNS08BaO72QYE/JzoBDtCzihm2tn+j+q5AV3GLzkQM6DF0yBRUlcr9rFGpA1
         eKqQ==
X-Gm-Message-State: AOAM532aSBP44LRGS//9ukpWoXL62cTXdShuok96IR6dbIYDnVjeoA6K
        jHuHJY5on2D9xnns8VUawp3M7lnGO6FfRRYqO2ID4g==
X-Google-Smtp-Source: ABdhPJwLLr7HE/FPtCzHw8vOCiRi6L3hhZDdCNDFos3jTHmz5rAH077nWm3ycDUwLoEjDXEKNGh/LvplLh9wMECNwRg=
X-Received: by 2002:aca:be0b:: with SMTP id o11mr575501oif.42.1612214578188;
 Mon, 01 Feb 2021 13:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com> <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com> <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
In-Reply-To: <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
From:   Jianxiong Gao <jxgao@google.com>
Date:   Mon, 1 Feb 2021 13:22:45 -0800
Message-ID: <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To:     Keith Busch <kbusch@kernel.org>
Cc:     Erdem Aktas <erdemaktas@google.com>, Marc Orr <marcorr@google.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        gregkh@linuxfoundation.org, Saravana Kannan <saravanak@google.com>,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is this setting being done and undone on each IO? Wouldn't it be
> more efficient to set it once during device initialization?
>
> And more importantly, this isn't thread safe: one CPU may be setting the
> device's dma alignment mask to 0 while another CPU is expecting it to be
> NVME_CTRL_PAGE_SIZE - 1.

 I was having trouble getting the OS booted when setting it once during
 initialization. However when I rebased to the latest rc6 this morning it
 seems to be working with setting the mask on probe. I am still testing out
 and will appreciate any idea what may cause the nvme driver to fail
 with a single mask.
-- 
Jianxiong Gao
