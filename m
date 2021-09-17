Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF0740F3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbhIQIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbhIQIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:04:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8706BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YK8khSyl2xX+jHd+eUzLYa7jXWZ6y9Xvg5caCBnq2nY=; b=TZNzPq5Lbhh3Y1pWBZ6aBq6u80
        2HidQwWgaSKaFdyLuyGpnkwWreG9bDozfD3PbAZLj5Hy0ggEUcTgF8I6hcpOktWZV7tiCTHCutJoX
        8vVStd5XpR0V+rCk99mwcmxJSY2ToposiiIZNY+aMhJv7GJ+G8mKdTnptbD5jhpNMnJ6adShTCuba
        ASJCtaAKLzTuKPzxYlGbFzYihkt7MCunyuysjFPYeBnwobA8oVSwueyxvhVaW564Gjo6OSM3nLTWh
        SfQewKAKwI6T3QsruYKBEvX9gb5JopexkJrDd21D8IFZC5E8G22nsqFaMKOnCEzWKEhAhfazRTQ7x
        W+/s2d0A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mR8ny-0002gf-Dm; Fri, 17 Sep 2021 08:01:18 +0000
Date:   Fri, 17 Sep 2021 09:01:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Christie <michael.christie@oracle.com>,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] fork: add helper to clone a process
Message-ID: <YURLQvJAO2mCX0zJ@infradead.org>
References: <20210916212051.6918-1-michael.christie@oracle.com>
 <20210916212051.6918-2-michael.christie@oracle.com>
 <YUQvAy8HDh5oYyqn@infradead.org>
 <20210917074440.qwo6anrtxa7lj657@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917074440.qwo6anrtxa7lj657@wittgenstein>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:44:40AM +0200, Christian Brauner wrote:
> > generally want a printf-like varargs caling conventions.  I'd also
> > much prefer to hide as much as possible in the actual helper.  That is
> > build a helper that gets the name, a flag to ignore the singals etc
> > instead of exporting all these random low-level helpers.
> 
> Yes, I think that's really what we want here.

In a way this would mean enhancing the kthread API to also support I/O
threads.
