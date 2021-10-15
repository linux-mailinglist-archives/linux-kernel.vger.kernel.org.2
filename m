Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6942E56B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhJOAt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:49:57 -0400
Received: from out2.migadu.com ([188.165.223.204]:41041 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhJOAtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:49:55 -0400
Date:   Fri, 15 Oct 2021 09:47:39 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634258869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ickJvln+rsXVabX/wO+mljmO4yfFMnfLFPLPT5C0Ex4=;
        b=IWulHE5VlIH9WX+kHlx/0BjQ7wbBYLwmPIFXRqM5DiN7UHsz8DJ58ZqnjhB+OFYDpdw2I/
        gX8YRoSDuX7oG/JWx6MxZ/1l+UfysZCK1Jc4wQwz0dOIaTEpUc1jVlVM6o1UimkLG2T9Tz
        t7WVZLkZhdUmgofWDHtltTL0fbMz+48=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/memory_failure: constify static mm_walk_ops
Message-ID: <20211015004739.GA2055926@u2004>
References: <20211014075042.17174-1-rikard.falkeborn@gmail.com>
 <20211014075042.17174-3-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014075042.17174-3-rikard.falkeborn@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 09:50:42AM +0200, Rikard Falkeborn wrote:
> The only usage of hwp_walk_ops is to pass its address to
> walk_page_range() which takes a pointer to const mm_walk_ops as
> argument. Make it const to allow the compiler to put it in read-only
> memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
