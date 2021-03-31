Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9608C34F43B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhC3W1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhC3W1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:27:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDADC061574;
        Tue, 30 Mar 2021 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:Subject:From:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cK8Z9iGFvUNS7jALgGNs+GKXct6mxa7UoFFALh+bnS4=; b=GhDvbWckfx8BpRKgY6fID+VR5e
        6PwsuBmAgBobFeAkQ9OYym6nahPxnUa096wAxHx1c1SlrVijovuhzivYVCGC+D3Hl3+DdZ4rzZz31
        bgDJTOFwDKHDsPv1UvGVOKthr2oGAsvgbMyj4Ryod4+CR9P2NGGhufYq5zXEGzBePA0qZVsMRJ4l3
        zvhjoJCt/VSVsJ4VnJRGCvzuKx7vr+Jo+b65uVOFiTKmlGkBVm/hc7tZ2XKHTsp7W5+iucb/xXyxC
        Hn7SO80MjcEDpLZ6dngIqX+A0ahnjewVgNVox5xAXWgy9JgzRnUcRvlRj2nP9ZZhwkogVCfgikwj7
        /F1mQzLw==;
Received: from [2601:1c0:6280:3f0::4557]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRMp4-003hRm-1Z; Tue, 30 Mar 2021 22:27:02 +0000
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: crypto: FIPS 200 mode
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <4e940d39-77c0-74d4-d282-216cc6030c11@infradead.org>
Date:   Tue, 30 Mar 2021 15:26:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The Kconfig help text for CRYPTO_FIPS says

config CRYPTO_FIPS
	bool "FIPS 200 compliance"
...
	help
	  This option enables the fips boot option which is
	  required if you want the system to operate in a FIPS 200
	  certification.  You should say no unless you know what
	  this is.

This seems confusing to me since it says "compliance" in one place and
"certification" in another place. And AFAICT, those two words don't
mean the same thing as far as NIST & FIPS are concerned.


Should it say "compliance" in both places?  E.g.

	help
	  This option enables the fips boot option which is
	  required if you want the system to operate in FIPS 200
	  compliance mode.  You should say no unless you know what
	  this is.


thanks.
-- 
~Randy

