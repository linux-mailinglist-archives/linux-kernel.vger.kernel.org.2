Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23353E4C0D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhHISZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhHISZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:25:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16BF961004;
        Mon,  9 Aug 2021 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628533489;
        bh=tDOfWjGdsyuIyylW8J8O8/FCq1h6g+rfI7buXbmQ0Jg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sFLArbVGTyA8p27aYlQGpKtrlV0EUYQTK5d9eFT2P/e8nkcpdB4iWP2zB04li1DAr
         xYZTpkl2DKt61PYuQuJxZwfvs64rJiMh7mKyC40xfec+ZUPvYbUY4Edzr2MDXwH0X/
         YI1L6iPzZ73xXNo/r0HLNl0Cc8K77GWOF4zDdYcE=
Date:   Mon, 9 Aug 2021 11:24:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH] mm: use in_task() in __gfp_pfmemalloc_flags()
Message-Id: <20210809112448.3d7d8f2522e18e75ba6e31c0@linux-foundation.org>
In-Reply-To: <f748aef6-9def-bea1-de7f-5ff88d7b3285@virtuozzo.com>
References: <f748aef6-9def-bea1-de7f-5ff88d7b3285@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 11:23:29 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:

> obsoleted in_interrupt() include task context with disabled BH,
> it's better to use in_task() instead.

Are these just blind conversions, or have you verified in each case
that it is correct to newly take these code paths inside
local_bh_disable()?

If "yes" then please provide the reasoning in each changelog?
