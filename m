Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD2C40458C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352468AbhIIGTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244314AbhIIGTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:19:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB2FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 23:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+rDn9niI6auN6DppWd/XkbmHQC+Jn0nMdhztebELsuk=; b=Oo0TzY1jbokYJR0ingKXUhlq6l
        UhWoACOhKO3V2VZGvwjL51JDFzJRPk+o+2nnaef6hBL+emIGtvU9NAN7yjygkSixKAeg7uUhf0MnB
        lU7P0lofWAlu5PdTtWalAJDMW+c3QttSNMxJam2jdRpi/UzDCZxU1PSi8if2fP53CvsBSk7G5NWKj
        HizrY6mokzKL/Oh14aB2oQzPvqfz0pgP+6jcdEzRiV9qOqBmA9cJ+IJzjSP5RRRdy0ToQHGW9elwI
        DVBQXxZKSGBTGg17K/fBWyTRlRkX8TQnU0yul+xHTQYhY+Aj8Pdn6FOkmOSZ/AL6CoOLhicL78A3s
        2dGRvgVw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mODNK-009XPU-0N; Thu, 09 Sep 2021 06:17:40 +0000
Date:   Thu, 9 Sep 2021 07:17:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: Re: [RFC PATCH v8 13/21] riscv: Add support for kernel mode vector
Message-ID: <YTmm+ewo0WDHH9hF@infradead.org>
References: <cover.1631121222.git.greentime.hu@sifive.com>
 <e3d94eee049fe9f3b6597e21748efbb1d4eb81de.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3d94eee049fe9f3b6597e21748efbb1d4eb81de.1631121222.git.greentime.hu@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:45:25AM +0800, Greentime Hu wrote:
> +obj-$(CONFIG_VECTOR)		+= kernel_mode_vector.o
> +riscv-march-cflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
> +riscv-march-cflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
> +riscv-march-cflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-cflags-y)c
> +riscv-march-cflags-$(CONFIG_VECTOR)		:= $(riscv-march-cflags-y)v
> +CFLAGS_kernel_mode_vector.o	+= -march=$(riscv-march-cflags-y)

Do we need a helper in arch/riscv/Makefile to define the vector flags
instead of open coding them where used?  Also I think the variable
name should include vector in it.


> +EXPORT_SYMBOL(kernel_rvv_begin);

> +EXPORT_SYMBOL(kernel_rvv_end);

This needs to be EXPORT_SYMBOL_GPL just like x86 kernel_fpu_begin/end
