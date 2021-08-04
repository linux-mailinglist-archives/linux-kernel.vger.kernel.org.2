Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441F73E07AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbhHDSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbhHDSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:34:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B97C0613D5;
        Wed,  4 Aug 2021 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m06WdUPrsjECa9DDzV6g+lGJLwGjyTbvcHlBD8ZFWyo=; b=vXBDLPhM1KPN3pPPUj19jWjJhE
        /alyklTaF7q0YrWK0IisnwoxrpmleyK+UKYaVV2CWTOs4HN2xXk1gpCXi1dPaO3TMiJQ6SPeFxBHR
        so96eZGsbYvKQOMp4GqHoYT8iOgSOMbMPLy2qedzaddSBSQwjtiHj8zFUWAEWvAJ3BMu2ClxNOOyh
        Bu/InwPIyBBTAFydBLm0TrR3rW+a3nk7JWxgacqN+9C1WZh6g+nHp5tq36DV5M5ODcQy3iIm6Vm/E
        yazcypvYd5QBPhxVZSc8v54iwHX09AMFQLrDLia+eZ/XGRDs3uFehxTGBcM7QWb5IY5lX/uWB83Fn
        bOtrQALg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBLhb-006Arb-6f; Wed, 04 Aug 2021 18:33:26 +0000
Date:   Wed, 4 Aug 2021 19:33:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQrda1yuRGXYLdT0@casper.infradead.org>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrXhnHJCsTxiRcP@casper.infradead.org>
 <0e20cad3-8ba4-71bc-5bfd-3246ef991c6d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e20cad3-8ba4-71bc-5bfd-3246ef991c6d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:29:31AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 8/4/21 11:08 AM, Matthew Wilcox wrote:
> > Why use a doubly-linked-list here?  An allocating xarray should perform
> > much better and use less memory.
> 
> We don't expect the list to be too long. So we may not gain any significant
> advantage in terms of performance or memory when using alternate lists. Since
> linked list easier to use, we chose it.

It is not easier to use.
