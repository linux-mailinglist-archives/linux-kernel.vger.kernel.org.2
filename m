Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A75319739
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhBKX5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:57:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhBKX5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:57:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84C7064DEA;
        Thu, 11 Feb 2021 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1613087786;
        bh=yUghPReuY5u0i+osAGUMP7Q8VW5n7dV2KSBfDb+C0uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w7K/oUXRpGsbQs/7fgxrjxvcTAPAIe/fvDEB7teJqpGJwmIAhZ2/KTLKdov9MgESZ
         MbEg8ZlqP0+K1ChJF8kgFidHQjv2OKSotZOELAdSwS3vygnxzjpfD1unl5Xayfhkke
         DmOdcE0QUbcTBGlu58jtOm1P+PkJlBlXFLGf8gpc=
Date:   Thu, 11 Feb 2021 15:56:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Prathu Baronia <prathubaronia2011@gmail.com>,
        linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/1] mm/highmem: Remove deprecated kmap_atomic
Message-Id: <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
In-Reply-To: <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
        <20210204073255.20769-2-prathu.baronia@oneplus.com>
        <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 16:33:07 -0800 Ira Weiny <ira.weiny@intel.com> wrote:

> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> This already has my signed off by so I'm not going to 'review'.  With Prathu's
> testing information I hope this can land.
> 
> Andrew did you see this patch?

I did now ;)

Tossed onto the post-rc1 pile, thanks,
