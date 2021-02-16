Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883A731C7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBPJRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhBPJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:16:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC1CC061574;
        Tue, 16 Feb 2021 01:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5OncMz6XG/6O+UCADq1gQCjNLWIhEjBR9vW8asBdIko=; b=t0DIveLS5z7VKOVUisQxRGEnAa
        5wsW31URbqcnLTYaiW41AonQpGUhzVUVEt/cHxpPV1O433ivvWSfBYykdxmLn2NuroMRXD80vEdPd
        7zA4e1+/w+XN7GjOkN7bq0451WPrTHpNrk4O4EYO4YAqLOmhZtRvJ49zEMuJEQwIHjfw0/R3qU50g
        92u3UBidSeWYA5NFlEU9naWsU87lo25mI596KtGnJWId03loJ/3WyIPkPDXaBoOKey43d2BqGb44S
        pHoHKqADdLwzRfgx0NkO15WEBHOwqvD2BMupP/LWKJ8UxnrdANJKQK9X0ikAlKfbL9KtKSxnH7DNa
        ieL+Z1FA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBwRI-00GgWK-6M; Tue, 16 Feb 2021 09:14:50 +0000
Date:   Tue, 16 Feb 2021 09:14:36 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: Export partner Source Capabilities
Message-ID: <20210216091436.GB3973504@infradead.org>
References: <20210214033052.1284385-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214033052.1284385-1-kyletso@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 11:30:52AM +0800, Kyle Tso wrote:
> Export a function for other drivers to get the partner Source
> Capabilities.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Who is going to use this?  Please submit any new export together with
the actual user.
