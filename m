Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D295E388375
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbhESAIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232153AbhESAIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:08:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE16D60FF1;
        Wed, 19 May 2021 00:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621382821;
        bh=igG7TCML8gWkBBfJiu0ezsZKJn9SVG1ie5msLAkFJvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F8RZal6kWO+wZAM/iB0Jz7evi53S618OaElIWo4UD7p0sQhkolr6NiopgWhdmV7Ny
         +8uZrEAEsvfcicJwx1JC35SVkHnpPIDrN0gCCuexnrLxhCrCFz1rFLlFCnHz7f+JVT
         MII9EklLY4RNXTBE99oMiiUFB5jI4XXmRxs1YrYE=
Date:   Tue, 18 May 2021 17:07:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Oliver Glitta <glittao@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [mm/slub]  ad36bafb3b:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
Message-Id: <20210518170700.0ffdcaeb55cf64607120d5be@linux-foundation.org>
In-Reply-To: <20210516144152.GA25903@xsang-OptiPlex-9020>
References: <20210516144152.GA25903@xsang-OptiPlex-9020>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 May 2021 22:41:52 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597 ("mm/slub: use stackdepot to save stack trace in objects")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 

I expect
https://lkml.kernel.org/r/20210516195150.26740-1-vbabka@suse.cz will
fix this?

