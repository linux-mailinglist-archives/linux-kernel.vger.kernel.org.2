Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326E33DCD45
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhHATdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhHATdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 932CB6024A;
        Sun,  1 Aug 2021 19:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627846417;
        bh=ag97U05m+dlz24Ct0ed4Y5I6gEAxYpIm0JpcOvq/BwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CNIq9NY4c6JZNHKpZZ7SpHhq5+7iSGQzYwcZ+fA2m3Adxo6J5hC/GEQufdmrtdrOP
         Dosb4E5Gbp7lJoGLIRyxQ+uIs2f/oXsrKA7qcHpJejJFz7yGlDVLtYuhD9rejo9i8G
         iX5J/yyrc2FFaWAGKBeEcrvOpHLjqeHYAmdCCXO0=
Date:   Sun, 1 Aug 2021 12:33:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Message-Id: <20210801123335.6a7f8e1ee1e52ea64db80323@linux-foundation.org>
In-Reply-To: <20210731175341.3458608-1-lrizzo@google.com>
References: <20210731175341.3458608-1-lrizzo@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2021 10:53:41 -0700 Luigi Rizzo <lrizzo@google.com> wrote:

> find_vma() and variants need protection when used.
> This patch adds mmap_assert_lock() calls in the functions.
> 
> To make sure the invariant is satisfied, we also need to add a
> mmap_read_loc() around the get_user_pages_remote() call in
> get_arg_page(). The lock is not strictly necessary because the mm
> has been newly created, but the extra cost is limited because
> the same mutex was also acquired shortly before in __bprm_mm_init(),
> so it is hot and uncontended.
> 

Well, it isn't cost-free.  find_vma() is called a lot and a surprising
number of systems apparently run with CONFIG_DEBUG_VM.  Why do you
think this cost is justified?

