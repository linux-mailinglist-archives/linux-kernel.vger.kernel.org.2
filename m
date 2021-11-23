Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42D45A92C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbhKWQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236001AbhKWQsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:48:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DCEA60C4A;
        Tue, 23 Nov 2021 16:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637685945;
        bh=3KEImncoqMLthsMarKv21aRN6/5hNWPKDMzLQKihgKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=koRSe/9rQ/dfUInsksU7RXviAdkKjVU+u7VVZh8IRsU5d6ULNKTT74BGLEKjeXSvm
         06lE1xMJQryO8mIoioqNC5O0bMdl+GXnb/i+yeWVinLanMG/1ZT+A1x6AbYo5wr8sr
         B3MlnESy9Ie2IxGOPlJjLX3ljwPVbYkR7eQ0oYv+NRMUqYDKg9q0bCaB0jDaWXrmOn
         PbahKRlYyGf3YmaXx6Rh6RppbfvEVnUso+WDOEeyqBPKK+/PcaiqumzS14AFsnM3MT
         4tQIsCLZYXWNS5yBUIvb80PVip13LjlaANQ1eTkd7bH6N3MonIaqB9TGV7gOubJw1M
         o5HntmeVruUtg==
Date:   Tue, 23 Nov 2021 10:50:57 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: arch/mips/mm/tlbex.c:2243:3: warning: unannotated fall-through
 between switch labels
Message-ID: <20211123165057.GA7382@embeddedor>
References: <202111230719.OZDUHU4z-lkp@intel.com>
 <20211123005528.GA550759@embeddedor>
 <ea07a2f1e20503965c7c2eba7c0a7a4538457265.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea07a2f1e20503965c7c2eba7c0a7a4538457265.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:52:30AM -0800, Joe Perches wrote:
> 
> Perhaps this would be better:

Feel free to send a proper patch.

Thanks for the feedback.
--
Gustavo
