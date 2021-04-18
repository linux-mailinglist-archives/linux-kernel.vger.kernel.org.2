Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736A636365D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhDRPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhDRPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 11:32:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F6C061761
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 08:31:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so7014689wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wCoaBkNa3VJWit/u5WP0EddXypbcFUqAfWjortYHCcM=;
        b=Y1Uj7r+xHMqa41sYVOuKKU5nYCStTz9MBwULDS3Ah6rg4j1l8jyLV2oIaoCfJkAix+
         I6no53l/Zo6OZPeE4eNR4ROV4wYCENUrOtqHgkoHdfvXl7PfoPCssSSfcZq41nbmPaMH
         FHCosovF4CR0dg/JPuIkDPXBNr7k1rV3XktBzdTRhBFZkmKD9TprJIdxq5RBC+/FPCwy
         EakXt1fMSMZWWwWi6auAB0P0zHTZtdjxG+U/5R4wVvMn3qBvsDRjUjAaE6hhZlvkD1tK
         msCA+xl8kcrJzdPEcRAUrsArtd9oNPvoSw44y6zM9yVrpDnEA6oRcKtg/W2sJBMwKvbh
         PLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wCoaBkNa3VJWit/u5WP0EddXypbcFUqAfWjortYHCcM=;
        b=p0VGIaGckjPTeOTpY+Cdo4iYxHNWEr/6OtOZBCuuFK4/Xloi7NzA8EywYCLPjGUXxZ
         l3/YdcLCIYck2uz4bZCcBLebMHL9EhHyPBTQU5IKKkZabvl1xIBEeOT5OjcClLfvOjoW
         PatLzCbwwBfuzb+pIib0799CZGoffdccaTOaAfZbgfrjkgzWqcgHbWDBJgDu7wuUdwWg
         XW76kP4/bW56n9jHXYhSrv64WVJvQ0oVDa483uAZO7d9UPAcosXMQlfR1dUyDD8cA9UJ
         tf35nwScSY22ec6Y51MiO/eDnBH2FEioL8pXxrU+h7qks6Veu67ihz4znF6p3Y4mLhvh
         9K6Q==
X-Gm-Message-State: AOAM533evHYzYA0Ibdc8Dywfmn9eIkZ8me+cPU5iIQySWGlnLcC3xNHt
        bWkIqsLpbi4FPBKhLDcSNj9z
X-Google-Smtp-Source: ABdhPJyAf5toSH3Pw9LDZ5XIZFh3Mje2jLFdSflkbGRQMjyPmfxF9W17lC21uzzXnb0HZvh1Rn3Khg==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr17053522wml.113.1618759906604;
        Sun, 18 Apr 2021 08:31:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:209:b40b:f0d6:b292:d186])
        by smtp.gmail.com with ESMTPSA id p18sm18578718wrs.68.2021.04.18.08.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 08:31:46 -0700 (PDT)
Date:   Sun, 18 Apr 2021 16:31:42 +0100
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     ojeda@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <YHxQ3hd+23qQUnTr@google.com>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <20210414200953.GX2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414200953.GX2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 09:09:53PM +0100, Matthew Wilcox wrote:
> By the way, I don't think that Rust necessarily has to conform to the
> current way that Linux works.  If this prompted us to track the current
> context (inside spinlock, handling interrupt, performing writeback, etc)
> and do away with (some) GFP flags, that's not the end of the world.
> We're already moving in that direction to a certain extent with the
> scoped memory allocation APIs to replace GFP_NOFS / GFP_NOIO.

I hadn't myself considered this option but it looks enticing to me. Do you have
a sense of which GFP flags we wouldn't be able to obviate even if we did track
state?
