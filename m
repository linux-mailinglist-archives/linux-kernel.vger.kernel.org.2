Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB2355C19
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbhDFTVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:21:13 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:40599 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhDFTVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:21:12 -0400
Received: by mail-oi1-f182.google.com with SMTP id i3so16265595oik.7;
        Tue, 06 Apr 2021 12:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZkkhcGwXE8ISA2k/jOIm9eSXhDLGB/Bawfl6kzwO91M=;
        b=MOz4F0qXiKt517vWqH+zsg0h1rurT6t9fiB3UZfzwPeag1HWn+KuHgE1yrutfow5Go
         J0aiY7gndKDNjoid1bQO/NnRgSHHi7Y/1ATSuFu0f6FNjP57WxZp6MI30Zz+Nm/VgTN6
         VtvVvGQGedLH5wTxjKZlMqPjFOsThr2LoU6ikgNTIQXAIHXQgyeZ7W+8mRd7VV2LsapW
         VL1QiUTP9BCACguO3M+0+mqCcqiE3Q+i5TZClY6a/Nrvq773HD6+DozVBT+KHCGousiV
         vvv2AtJUWyMjiuRSsWmfGoq34WGN/SjzuyZSzCMi9utQJ8J3fvY+igeIPI8OcCe3s0MP
         NgUQ==
X-Gm-Message-State: AOAM533TDE5hR9EzJMUhRCSoIPjf9B5Sz9KvtC3nB0tGXqJBsq/Lkc1O
        Et0teCjLDDyLjJ1cQ0gkNDgHILUQ/g==
X-Google-Smtp-Source: ABdhPJxTT6YJGTu/EWts/mpNNCM/hQk4xVcit/FLG4BzmmNXmfVbR8MQs4lWvx/LTIcKJvB0q3lDyg==
X-Received: by 2002:aca:af43:: with SMTP id y64mr4555484oie.46.1617736862283;
        Tue, 06 Apr 2021 12:21:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l81sm3934251oif.31.2021.04.06.12.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 12:21:01 -0700 (PDT)
Received: (nullmailer pid 2150103 invoked by uid 1000);
        Tue, 06 Apr 2021 19:21:00 -0000
Date:   Tue, 6 Apr 2021 14:21:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] of: properly check for error returned by
 fdt_get_name()
Message-ID: <20210406192100.GA2050740@robh.at.kernel.org>
References: <20210405032845.1942533-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405032845.1942533-1-frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 10:28:45PM -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> fdt_get_name() returns error values via a parameter pointer
> instead of in function return.  Fix check for this error value
> in populate_node() and callers of populate_node().
> 
> Chasing up the caller tree showed callers of various functions
> failing to initialize the value of pointer parameters that
> can return error values.  Initialize those values to NULL.
> 
> The bug was introduced by
> commit e6a6928c3ea1 ("of/fdt: Convert FDT functions to use libfdt")
> but this patch can not be backported directly to that commit
> because the relevant code has further been restructured by
> commit dfbd4c6eff35 ("drivers/of: Split unflatten_dt_node()")
> 
> The bug became visible by triggering a crash on openrisc with:
> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> as reported in:
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> 
> Fixes: commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> ---
> 
> This patch papers over the unaligned pointer passed to
> of_fdt_unflatten_tree() bug that Guenter reported in
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> 
> I will create a separate patch to fix that problem.

Got an ETA for that?

Rob
