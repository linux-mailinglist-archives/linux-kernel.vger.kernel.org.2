Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E783E09D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbhHDVIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhHDVIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:08:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A18C0613D5;
        Wed,  4 Aug 2021 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bpxyDpnvly9eIlMQTFPJ1aBcN9lOvzkoVYTJFUDJnqo=; b=iLoMBWKjIEusVQoTWW/PDbf4E6
        UpBvg0/6a7I3wA1o0hOk+3nIixZMjbuU7AvdPcOKwOHcxBJJxKPbw+sVrBvYmdHKAJC1+7ivKtRCW
        kw51BIbzdxEgabH2EqeEkojnf/p8N6qRwm3jfLoqiPMn8bw2ImSKR1bKk7RxwBR0/1nD2ktoveeXy
        uw3t0cctv1UXtLL2gLzkOW3aGA4l1asOPtBeBC/leUQBRFaTPM5o48yWRjN2ja0OMNj7WPlSdJNQM
        QChffB6AwMrUaPh+iaThHIffvV/O4P3Wk29gLPuGRqg/qsmyay8NgDlcmM5YfEFD+KLW87Vjcrsla
        9NH6/B2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBO6W-006IQp-Ga; Wed, 04 Aug 2021 21:07:16 +0000
Date:   Wed, 4 Aug 2021 22:07:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQsBfAVPomaC97Rm@casper.infradead.org>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <CAPcyv4iEEDCz5719d0vNi=zi=6oN5vctcVfY5P=WQ9j_Zpz6eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iEEDCz5719d0vNi=zi=6oN5vctcVfY5P=WQ9j_Zpz6eA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 01:11:27PM -0700, Dan Williams wrote:
> On Wed, Aug 4, 2021 at 12:29 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Why not just make distros that want to support this type of platform,
> > also provide these tiny kernel images?  Why are you pushing this work on
> > the kernel community instead?
> 
> In fact, these questions are where I started when first encountering
> this proposal. Andi has addressed the single kernel image constraint,
> but I want to pick up on this "pushing work to the kernel community"
> contention. The small list of vetted drivers that a TDX guest needs
> will be built-in and maintained in the kernel by the protected guest
> developer community, so no "pushing work" there. However, given that
> any driver disable mechanism needs to touch the driver core I
> advocated to go ahead and make this a general purpose capability to
> pick up where this [1] conversation left off. I.e. a general facility
> for the corner cases that modprobe and kernel config policy can not
> reach. Corner cases like VMM attacking the VM, or broken hardware with
> a built-in driver that can't be unbound after the fact.

I don't understand how this defends against a hypervisor attacking a
guest.  If the hardware exists, the hypervisor can access it, regardless
of whether the driver is default-disabled by configuration.
