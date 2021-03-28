Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B350734BF7B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 23:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhC1Vwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 17:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhC1VwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 17:52:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0995161951;
        Sun, 28 Mar 2021 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616968338;
        bh=mxXki6V6crflYsyzwyEM2EMqDh7cmMgym/XCPjxzAoA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dYm5gyr2JLcBEuk65R4PDtfNNnOjSoEDDHExoMoIqHluH3Rnf14dZ9BIj0Gqr6e/w
         sk1Lb1xKAVB4bFXLvCPya6WDNEr2d8MAIsNxvjncYKRsqpyRtqlXyf2SZZtfouNRZ+
         TRobB7gCqnxTpCh4GydYzOvVjbSZGI1t9wTYbBF8=
Date:   Sun, 28 Mar 2021 14:52:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Rik van Riel <riel@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH, -v3] mm: Fix typos in comments
Message-Id: <20210328145217.61331e5d8518bc040f1a0cb0@linux-foundation.org>
In-Reply-To: <20210322212624.GA1963421@gmail.com>
References: <20210322025152.GA1922846@gmail.com>
        <1c098463-9db9-372f-82ba-48a12849707f@infradead.org>
        <20210322205016.GA1959563@gmail.com>
        <8d8dbd68-e53d-9043-17b7-af0d44ab0075@infradead.org>
        <20210322212624.GA1963421@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 22:26:24 +0100 Ingo Molnar <mingo@kernel.org> wrote:

> * Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > > New version attached. Can I add your Reviewed-by?
> > 
> > Sure.
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> -v3 attached, the only change is the addition of your Reviewed-by.
> 
> This would be for -mm I suppose, if Andrew agrees too?

Yup, thanks.  This one-fix-per-email thing was killing me ;)

I just queued this behind everything else and will send to Linus
whichever fixes are still applicable, easy.

