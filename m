Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0099C41003A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbhIQUM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhIQUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:12:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013AFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aEK83AieghbBJC9Ys7CmhgCvWyDGv0HEvulXEKS3S0A=; b=fBgk+u7GDLNOsAIX6LzFPSRbUw
        lsP8h4bpqydjHHnIk5w9ikm0ZhBwIEdtDpvBjWOmKo4BJQGqwVm0SMBPyq54FfyG0Up85Z+YhMWaa
        fR9OrWqFjkOtecNrQRYvKbHAXWGpMlB+AkCkHkOiWTWuQPfqu1RLDRMAV8OHigWYa06VOf+koc6kD
        GHki/UO5GRCdHR5LwlgvOvsUBMetzEnprhyjlNaEJqtoK8qFkgPCi8hzC9oaZRLhVsFJGOQMQ7HQl
        xz6lIZ/DbXe/kyS5qFbr69IXrBArmamAeCTYnRXB5gwOLkwSR4CUxtfM3XVJnA77flC+mjG1EUB8D
        5cCx8FBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRKBO-000alZ-N6; Fri, 17 Sep 2021 20:10:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A13659811F9; Fri, 17 Sep 2021 22:10:01 +0200 (CEST)
Date:   Fri, 17 Sep 2021 22:10:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Linux-kernel <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: Unloading a module with a function which is used by a static call
Message-ID: <20210917201001.GJ4323@worktop.programming.kicks-ass.net>
References: <d72f55fc-bbe2-b02d-0a90-ad6aaef8810e@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d72f55fc-bbe2-b02d-0a90-ad6aaef8810e@linux.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:07:22PM +0300, Denis Efremov wrote:
> Hi,
> 
> I'm not sure, but is it intentional that we don't increase a module refcounter
> when we call static_call_update()? Let's imagine that:

For all intents and purposes, static_call_update() is the same as
assinging a function pointer. That also doesn't increment module counts.

If your case requires management of module refcounts, you get to do so.
