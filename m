Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F79536D78F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbhD1Mmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbhD1Mms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:42:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAB3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ahYsnLotKTcvKL9mNUCMS2hcD/NVR1RLqacIcmuWDu0=; b=vcJvoG4EETaeCmRfy6Hn5WL1Hx
        Z47j3zEAIz5rxmh0DYRg2zmJaQgl2KGokE/t2yA7NO765WT1OUboWgCAQOjGPNMjG2Y9IZ+LFyXDk
        kJVeTb2hjWHYyeUipqT0bPcSs57fDv+IYBtkIVbkQjbGZWU1VMCNNQS+YGZMDyAzrypuIwJ6p/KGd
        5Qf1wQsGRm6YZ+J/32gHWfn5WtWqVrxzR4bNc6NDVzRgcgcSxZZh2MbetXRIq4NY6y/tcpAhZEW/w
        5u0dIigytlhY5JEH/1+2XLwLZ0Z6kw464u1wNSoMmqWfpnQC2SH1AFWjFMjXcVvFo6hhekteMEsxY
        LxoA5D1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbjVQ-008Hzp-9Q; Wed, 28 Apr 2021 12:41:31 +0000
Date:   Wed, 28 Apr 2021 13:41:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove argument from mem_init_print_info()
Message-ID: <20210428124128.GA1847222@casper.infradead.org>
References: <1846777.ZUqDs8pn68@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1846777.ZUqDs8pn68@mobilepool36.emlix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:20:51PM +0200, Rolf Eike Beer wrote:
> All callers passed NULL there, and I have not found anything in git history that
> shows this has been any different in the last 15 years.

You aren't trying hard enough ;-)

Used in d9d7e769815c9cb66c8a4b144f066bb957ebd98e (blackfin)
Deleted in 4ba66a9760722ccbb691b8f7116cad2f791cca7b (removal of blackfin port)

It can be removed now.
