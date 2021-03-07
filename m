Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB4132FE63
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 02:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCGBpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 20:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhCGBpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 20:45:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD8C06174A;
        Sat,  6 Mar 2021 17:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yowjMpguvRVlCMfZy2mi35DmOW+KXVYAeHTatHqiuns=; b=vGo2+wxf5JmJlFh/XZ6miai8Wi
        8aICtqLNrH4RIF5V28A6T/rAx8C9J/dJ0b4V/UBHfgvV29nS6zY0FJQ4ufT3BXIrqwrQWqdw9BwEN
        /CaFPWmaaxPH60z+CCc2pBThp6YbCwKHUJ0qVA8WiUr49yLaHECVEHRMYQL58KcOp1z0tBFRtoRwY
        ltxt06yXYkI4IGZviO66PGQYfRO25UyjmaLHu+6T0ttu+6FjD2wwJ/1OQbJlSVt4wtir9hjHxQKRP
        XvMKBJY7E79er1xDp1mnxXHPDp8Lg44XI0ssKyNg2UO6T5Kc4P+JLJhn9yZSKaMN+3mrYOuph2+Fj
        AlWcVF8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lIiTN-00Dlko-70; Sun, 07 Mar 2021 01:44:48 +0000
Date:   Sun, 7 Mar 2021 01:44:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Wren Turkal <wt@penguintechs.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expose the bus kernel docs to the build docs.
Message-ID: <20210307014445.GT2723601@casper.infradead.org>
References: <20210307013301.39420-1-wt@penguintechs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307013301.39420-1-wt@penguintechs.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 05:33:01PM -0800, Wren Turkal wrote:
> Before, the bus type related APIs that were defined in the
> include/linux/device/bus.h were not referenced anywhere in the docs, so
> I linked it to the bus types api documentation.

I think this is a good thing to do.

> +++ b/Documentation/driver-api/driver-model/bus.rst
> @@ -144,3 +144,5 @@ sysfs directory using::
>  
>  	int bus_create_file(struct bus_type *, struct bus_attribute *);
>  	void bus_remove_file(struct bus_type *, struct bus_attribute *);
> +
> +.. kernel-doc:: include/linux/device/bus.h

Do you want to put a heading in front of it?  I did this in xarray.rst:

Functions and structures
========================

.. kernel-doc:: include/linux/xarray.h
.. kernel-doc:: lib/xarray.c

Also, I see that drivers/base/bus.c is included in
driver-api/infrastructure.rst, and I feel that they should probably be
included together?
