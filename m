Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805F34555EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbhKRHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 02:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244045AbhKRHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 02:45:04 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25298C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SMmOFHUIhJnZIRBpVlk2wpCUOnsf6/Vk010L/atc08s=; b=MdSRyMR4JH1h2xbZnCVdKcSsFz
        Y+FJO+AfE+uLKRLxidV9TGhdGHYsH48oI7R7fSGyDbsSiNzIs0ZygAZYnBUawwggO/Xf6eFjURz3K
        8rNylfxVX1ZgsEjTpjUA5IHE0vruHLL3Kg/CoRCjhGTl5azbq0M4N6/rDnVKPxMSq/mHXVMsRfRH4
        ZRj9qIZEItMtbjT1J7C5bl+DElvFLSE4aJJi27LZBkaYHSZZIs5B51LXnnU06BGCT/IjvF35CWIGB
        c97ysgAyCHf8CeapfnSaMRu5V8yWYY43iludTaRzqueNh+4tx1oKPizOstyYZ/QUa85/av7sjNvfL
        eUUxvdXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnc3U-00GeWB-DT; Thu, 18 Nov 2021 07:42:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 777619863CD; Thu, 18 Nov 2021 08:42:00 +0100 (CET)
Date:   Thu, 18 Nov 2021 08:42:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refcount: introduce refcount_is_one() helper function
Message-ID: <20211118074200.GF174703@worktop.programming.kicks-ass.net>
References: <20211118035328.5730-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118035328.5730-1-yajun.deng@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 11:53:28AM +0800, Yajun Deng wrote:
> There are many cases where it is necessary to determine if refcount is one,
> introduce refcount_is_one() helper function for these cases.

Give me one that is not racy?
