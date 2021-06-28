Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2A93B6419
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhF1PEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbhF1Oph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:45:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3068C0613A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 07:27:01 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id v10so3043800qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5YE4V/oWmwNsGpB9kkiY2O6MIvafMjNySTzS8POYKJY=;
        b=Q59RhdJRjUI3getOisZfjq5ytUcecdmbTI18o89yBJGJrZ6YeEFFjeIIY5IYZhZPAc
         3B9kn6AFjbhQy1bcC9HLLuMl9xTPoeZuq/yS2mKzTR2NSfIF0h7NYCqzlntlr/efDfwx
         lRlbQoQaXLf7RRsdCJjiCFPi6CjZcGhYwCeyD7MWE6SwQTTWxJfwGVQpX/OwCXaOtAy/
         x7d0lZX59rOXJn6Dvpj7ICR4b7wk6qNSeUTW/YYcMpnQ587g5G7UJKoJ1D73frJc14pA
         FQ8HRY9XDpWOgV5cZ7VWp3gBg2Op3/vJrbOU7C6joSBU34xywDTBiRyZVZaPlz3YNCg8
         j+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5YE4V/oWmwNsGpB9kkiY2O6MIvafMjNySTzS8POYKJY=;
        b=U+HOoFw3xByK79SlubKHx6VXzmEJTEUZAfL+inPK6l2TdLLr50uBTuML2V7owhlFuI
         PCj8hAb1iBzpMUpQk5x7oec2zzrUhN0qGXEHyGf07CHBig9+3M0Ko4ovYgHMBoJRibwH
         KHwvse+weWSPK+jaPxSBJseQw6yC2epGlPCQZ1MjoaaCslLxkKYNUIpXEX/An+Q3JWTC
         XVU9frX7h41kGaBL06S8wqgDHAc+o6wWLoWFngj4txg/3X3peQHuyMRwgo5+QCZ3yVa2
         umEEFSXAQ4bMxD+Ekx2NsVFhg+qpSgGs4cAwuRbWzfLIoK2ccDHfJCtr8GswAT4gRJZs
         GaWw==
X-Gm-Message-State: AOAM531W2Qy0i/R1X8Z6B2bDhPseiorEO6TB+B/txFoqCHZ03gGtStQp
        8uKg+JZDKQ+7vL6nB+AHCqudZg==
X-Google-Smtp-Source: ABdhPJz7lVqem6DvmKK1aKKATDHADiMpSK/fEmVgrrRgrB9kbOMKKf+ainNemv4+CGog0ym5bQo+8g==
X-Received: by 2002:ac8:549:: with SMTP id c9mr22061595qth.80.1624890421193;
        Mon, 28 Jun 2021 07:27:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id m189sm10452962qkd.107.2021.06.28.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 07:27:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lxsDz-000dJL-Ra; Mon, 28 Jun 2021 11:26:59 -0300
Date:   Mon, 28 Jun 2021 11:26:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Benjamin LaHaise <ben@communityfibre.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: linux-mm@kvack.org - limping on a backup
Message-ID: <20210628142659.GB4604@ziepe.ca>
References: <20210622145954.GA4058@kvack.org>
 <214c41fae1f1b148e5b04a58c1b018fb091d7e83.camel@HansenPartnership.com>
 <20210625171259.GG4058@kvack.org>
 <6f309c63f5b7be968ae679e81ab959db05681e8a.camel@HansenPartnership.com>
 <20210625192607.GH4058@kvack.org>
 <20210628134607.GA4604@ziepe.ca>
 <20210628135352.GL4058@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628135352.GL4058@kvack.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 09:53:52AM -0400, Benjamin LaHaise wrote:

> The fact of the matter is that the DKIM spec is broken and doesn't
> properly address issues relating to transport of emails containing UTF-8
> content over SMTP sessions which are limited to 7 bit transport due to
> backwards compatibility assumptions.

Isn't a 7-bit conversion what I pointed at last time we talked about
this?

DKIM assumes a "modern" mail system, there should not be 7bit
conversions in the mail pipeline. Anyone sending DKIM needs to be 8
bit clean.

Jason
