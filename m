Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C83E0739
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhHDSJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240015AbhHDSJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:09:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE5C0613D5;
        Wed,  4 Aug 2021 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HpBw3SJs+17F/1MWyg77w4ci6hzkc6ALjrYnSEiZYhE=; b=G/k6vjPcW/kzCpzvsN+sYmzFSv
        CdcEZ/91s4KWsHu/Dvn8P1s/6KeMdlTu43jvU0OuYhldWPXIDlVEXXHf9isG+KQU6HscnaFCMGezT
        9gIRhmuGjCfHo7MSWi/woP4LCM6zTJr8AW3/hGysYZyRRvJT2GCiGWgou1VLOKUr5SyCG0JfpsWDT
        GNHv3IeZBAEJ3yUGwBHxC5rou7wM3RE0w8C5yEDYXCCU3UxXFPaecn3DWWVUn/cj+g6hbaMhGiYV9
        iYK/wiKpaUOsewEQkGL2EB6WpPw9yUv51rxF2PMy1lvV/zY5eQkUHx7U20AhlZamiAP4AFMkxZOAu
        3Dxf2Qbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBLJG-0069Rj-ET; Wed, 04 Aug 2021 18:08:14 +0000
Date:   Wed, 4 Aug 2021 19:08:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQrXhnHJCsTxiRcP@casper.infradead.org>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 10:43:22AM -0700, Kuppuswamy Sathyanarayanan wrote:
> +/* Driver allow list */
> +static LIST_HEAD(driver_allow_list);
> +/* Driver deny list */
> +static LIST_HEAD(driver_deny_list);

Why use a doubly-linked-list here?  An allocating xarray should perform
much better and use less memory.
