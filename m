Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A9A35D849
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhDMGzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhDMGzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:55:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8699BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jwxAycbsASm0GWf+9F+ExTwdizKmiUk4L1b8AT82ci4=; b=B1tSGz0kmdSV5QlZ5Htwor9uWY
        n3hiBIHetYE7C+PLuxLVRKAkmPHzukonxNO9wdGDplzNkZkqs7jVTeXkKXvwft2StBK7bDB3N8LGL
        aWl0vqGkhfGBpr035kdhDvJg1a2Em9vaduUClXR6ZOBGMarfChN3JMwbBQhV5BkzvnakKWM4kZGTF
        s8f0ifOQdMYU1boXKX1/2NVB1cZgW2YHV+HBs0a3SNMVNhNm6qtWAauEgQLqz11MRTviRcl8TByo6
        XvK24VGuMw8jh9RhTIpfiQrqsPrCtQJQKyAZnja2HwOjidBQ8k0Z7IBdqdre9yDaLNR4yslgM/GAt
        lWQzuIrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWCw5-008RQa-Im; Tue, 13 Apr 2021 06:54:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78477300036;
        Tue, 13 Apr 2021 08:54:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B80E200CF8CA; Tue, 13 Apr 2021 08:54:06 +0200 (CEST)
Date:   Tue, 13 Apr 2021 08:54:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 4/7] mm: Introduce verify_page_range()
Message-ID: <YHVADhpkETMQGD5X@hirez.programming.kicks-ass.net>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.769864829@infradead.org>
 <202104121302.57D7EF8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104121302.57D7EF8@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 01:05:09PM -0700, Kees Cook wrote:
> On Mon, Apr 12, 2021 at 10:00:16AM +0200, Peter Zijlstra wrote:
> > +struct vpr_data {
> > +	int (*fn)(pte_t pte, unsigned long addr, void *data);
> > +	void *data;
> > +};
> 
> Eeerg. This is likely to become an attack target itself. Stored function
> pointer with stored (3rd) argument.

You got some further reading on that? How exactly are those exploited?
