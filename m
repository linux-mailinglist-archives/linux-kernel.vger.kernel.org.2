Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFB439FDC9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhFHRf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhFHRf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:35:57 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:33:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 27so17096662pgy.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sWNeSL+Bq72a437AxKxQVe0Uaeu2Nm8OpDkaGtEuRXM=;
        b=Kqic/OcsvMBiFMhntb0VgSYT7yhKK3qXwWc/y1DWmiUoAxhJFfIVM4HXXkezRAnIcb
         eWPMHke0GAc2x5PjLRdgAIGfiDbqRT8Y90u67zBEdCXpYSTc6/lobNpcy1YkOlWjr3JU
         n1zlDpvI6Idcz7GAiZQUyi48DdeMK9DuoM/A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sWNeSL+Bq72a437AxKxQVe0Uaeu2Nm8OpDkaGtEuRXM=;
        b=WtZgD1nvGAxkzy0GR1I0aYwqv334Z2Ij7/E76DFPy5V6yKCquQRwWB72gVS0vEcZHV
         yuVI9Syf00DA4GfJ0rsFWyeKzydLPubvGf2wbZ5OnUy4MwauhAC1IHNMZvZ8RC03yaJ1
         jqKqvD3k4KKibxLgQt4GkBynYIvh5/ajbA0NFCPCDNL/SvsDr+yw0/hZCI8nM12z81H2
         /7maJyBGhDWDwf6b8OrWtLUPMRGVUMJIMLoBmANHadkVZBC/YkdRnT49BB1apwQVjK6W
         mlz47gGF6KPc6EPYtyx6YOBVP8hAwIFb20yi5LO+hPnKH6Y8ixelK3UI4YZfOD8NY2Gy
         LxDw==
X-Gm-Message-State: AOAM532mGQNmgfYrEWwwXeQ4JZwcXa1ihqc9jYHZis4TGbnMNkHSPE/Z
        cbWyuCBbFFKI3cPM+/z8xTu4cQ==
X-Google-Smtp-Source: ABdhPJyW5o12lK2i8NyhtfF01aYhPcle5/0y9+/NtAzVkK25FOXHqk5pODvPkjT2lvLlw/rGv3M0nw==
X-Received: by 2002:a63:5756:: with SMTP id h22mr23206898pgm.377.1623173627855;
        Tue, 08 Jun 2021 10:33:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ig1sm15535215pjb.27.2021.06.08.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:33:47 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:33:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [EXT] Re: [PATCH v5 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202106081032.58FEA082CF@keescook>
References: <20210120121047.2601-1-bbudiredla@marvell.com>
 <20210120121047.2601-2-bbudiredla@marvell.com>
 <CAPDyKFoF7jz-mbsY8kPUGca5civFKRRyPpHbRkj9P=xevRRfbA@mail.gmail.com>
 <CY4PR1801MB2070F43EFCB9139D8168164FDE3A9@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFrVQbALjSeFBckaZQgkgwcBVuwHy563pdBxHQNA7bxRnQ@mail.gmail.com>
 <20210608161422.GA10298@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608161422.GA10298@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 06:14:22PM +0200, Christoph Hellwig wrote:
> Given that Kees was unwilling to take the series to unbreak the pstore
> block support I've sent a patch to Jens to mark it broken and thus
> effectively disable it.  We can't really let this spread any further.

Hmm? You never replied to my concerns:
https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

-- 
Kees Cook
