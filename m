Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FD03EFDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbhHRHQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbhHRHQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:16:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F50EC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IY1rYvs/55MDJaEBbVK760ru7sspZ6Ehf+ilKA9rPY0=; b=vNjVcm++XvMpyOlx8qrauHkNpe
        t+T3//BnaysD5St6yb4+jcqXZXEHEj337Sjzx+5Nu8VJ9/Zc+yhfJUucoj0QHVpkRuCN+3jiiMqu6
        OH0/qFBnsIwdIj280OJRHX15B0itBao93MTPiveoHrpJqY1GCHZLZqG1gaU3CxdZb6TJsIEMl/tOE
        XTPGI7aFfCyjaKfa5Wtfu9SEUubcbDCeWT+ob9yCBAFRp+qNVvXZSGGP0lQ2eeHHuUwUb9k+V01f5
        JxYbOkF55KXjl+PWlzfo5sri7MGjArKCb1OQtdNQH6EDSeeNUssiZgq2I+u3KHc0fuO/kCWjaUYd/
        gjIzvU0Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGFnB-003Ufz-SC; Wed, 18 Aug 2021 07:15:35 +0000
Date:   Wed, 18 Aug 2021 08:15:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     torvic9@mailbox.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
Message-ID: <YRyzhWJrqcRZkYRM@infradead.org>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796036867.117557.1629210288168@office.mailbox.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 04:24:48PM +0200, torvic9@mailbox.org wrote:
> +	  Generic x86-64 CPU.
> +	  Run equally well on all x86-64 CPUs with min support of x86-64-v2.

> +	help
> +	  Generic x86-64-v3 CPU with v3 instructions.
> +	  Run equally well on all x86-64 CPUs with min support of x86-64-v3.
> +

> +	help
> +	  Generic x86-64 CPU with v4 instructions.
> +	  Run equally well on all x86-64 CPUs with min support of x86-64-v4.

How the f&%$% is a user supposed to know what these garbage descriptions
are supposed to mean?
