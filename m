Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71E4459427
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbhKVRrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbhKVRrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:47:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AF1C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:44:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id o14so14741403plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iU8M1V4J/uYNV7K52e6OuwXoGidrRJFTlyNk6cPUB+k=;
        b=T3/vryWoujBA7FVMvIZxpydx7qJ5m3c+5nRBrzrskq4n5L4LRbtQrncBd/qR7olqR2
         AdDqvTJbwKBo5m4Xb8uwaSf9ybxk8EMtkBbFSN5RvwNOno0aAZWfWxfMiybccKjYbmmt
         pUfIT2nWjs8kBCM50yy3WHSD1CoTZSn30NVJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iU8M1V4J/uYNV7K52e6OuwXoGidrRJFTlyNk6cPUB+k=;
        b=olex7kRRLg90Gs8sqG/X5ujH4VIeni5EfMyIQpc7+Inxnx456Cx0EawYDdPmskqGMd
         Lh02oHKDgLVVMSagtQFpp+/qLPRHbIbDPdBvY525F/Bnt5odvJpRQaSs+qj33Ni9OJ/h
         N1YPiE++eM4Nx69Gi+P/ZLYb6pecaVLL21EdTLGPB3Qojcr5wFfm9wrp8lEgxZS5vJD0
         jLJgdKB4SupqYDYC/fFIfFu+cPR1mko+iRP0TDBB2bUydrtgyAPpC1a/fL1CQ5IoRdWC
         zeUFY1RElT2Z+6uOvk8d+rGvRilC/QSTvqYXaevLR7nawiQ6SHomaIiZXL+RLYX+mJsC
         GT4g==
X-Gm-Message-State: AOAM532wB6K8YQVxO2RTGfNTvrpKKcV++eUj2hLsheSzs52DezEirXo8
        0alTBRAXJlrpOXKHNpb7DkgeVw==
X-Google-Smtp-Source: ABdhPJzxeSjejXfWQ3Gr56JUZQICipjIsLMqMZ5H5JrJqAv7s61AtjeIOCdky54IdArFgjzVgjhVAQ==
X-Received: by 2002:a17:902:82c9:b0:142:401f:dc9 with SMTP id u9-20020a17090282c900b00142401f0dc9mr110799433plz.43.1637603040487;
        Mon, 22 Nov 2021 09:44:00 -0800 (PST)
Received: from localhost ([2620:15c:202:201:4f58:9038:bf88:fe27])
        by smtp.gmail.com with UTF8SMTPSA id h21sm6747318pgk.74.2021.11.22.09.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 09:43:59 -0800 (PST)
Date:   Mon, 22 Nov 2021 09:43:57 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v17 2/7] of/platform: Add stubs for
 of_platform_device_create/destroy()
Message-ID: <YZvW3UEkXy8dPmpz@google.com>
References: <20211116200739.924401-1-mka@chromium.org>
 <20211116120642.v17.2.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116120642.v17.2.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 12:07:34PM -0800, Matthias Kaehlcke wrote:
> Code for platform_device_create() and of_platform_device_destroy() is
> only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
> symbols when CONFIG_OF_ADDRESS is not set.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>

Is anything preventing this patch from landing? It has Rob's ack and is
an improvement regardless of the fate of the rest of the series it is
part of. The patch was carried around unchanged in the last 10 versions
of the series, it would be nice if it could just get landed instead of
keep carrying it around :)
