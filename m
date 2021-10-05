Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8469342346B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhJEXXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236930AbhJEXXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA1DA61184;
        Tue,  5 Oct 2021 23:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633476082;
        bh=9flL971iZoTbwXwyj/25Snm0LlcXB5mdLnv3zf+UZfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JIGAfSS9rt3COVJVGMCeYB4lahP5/RM+Mz3nqICF0p/u23Tpclzm0Zg4ZUIsHiinJ
         SUp5+6tV8M7gydGP3ytNcYbSf7zEsKEYh0StIWydNgkAXFB3N6uvfKJjZr/YWUD6aS
         7doTBTvDNXbXGSA+PUk/x6F38jmSViPXSpvWYF6g=
Date:   Tue, 5 Oct 2021 16:21:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] lib/string_helpers: add linux/string.h for strlen()
Message-Id: <20211005162121.a9eb9b1af38f56566a4bafdb@linux-foundation.org>
In-Reply-To: <20211005212634.3223113-1-lucas.demarchi@intel.com>
References: <20211005212634.3223113-1-lucas.demarchi@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Oct 2021 14:26:34 -0700 Lucas De Marchi <lucas.demarchi@intel.com> wrote:

> linux/string_helpers.h uses strlen(), so include the correpondent
> header. Otherwise we get a compilation error if it's not also included
> by whoever included the helper.

Is such a compilation error demonstrable in the current mainline kernel?
