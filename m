Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA997356173
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbhDGCkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDGCkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:40:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347E2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uhOYkQO774jNDcmHPctjGjKcc0cOaB158ggEKqgnGnE=; b=TdNLBuS1SqLrQ7x+puvft7jQH1
        obQFBOdNEkYnKl8JwCBFolMQ+7w1A6pcPaBT3PUdgAj1XG9sclZpJiRnCmP8vYYl87+pADZn7J60i
        7RC2dmkaUaKw2PgQO4uVmpK4JrA683FC1xJDbW+mH6YBmz/pefufXu16U/oQDYCx775WT7mjZrvpV
        MFgS4dmDW3hgC3cwPLizUwZcA2t8nYdQTqPOESyCQQfBz7rDb/bkGtjk6AVD45A6u38sSMrkC2jJE
        te4KrLy8yMqJY0DOfl8QeJFBawMhYH0xnzAKEj2TzWt60OZsciXoQKg8B3i59OwkHl6V9w9HR2oDm
        ruIBRUEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTy6a-00Dm9H-Dr; Wed, 07 Apr 2021 02:39:47 +0000
Date:   Wed, 7 Apr 2021 03:39:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 29/37] fs: list file types that support speculative
 faults.
Message-ID: <20210407023944.GZ2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-30-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407014502.24091-30-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:44:54PM -0700, Michel Lespinasse wrote:
> Add a speculative field to the vm_operations_struct, which indicates if
> the associated file type supports speculative faults.
> 
> Initially this is set for files that implement fault() with filemap_fault().

Ugh, no.  This goes away if you don't call ->fault speculatively.
