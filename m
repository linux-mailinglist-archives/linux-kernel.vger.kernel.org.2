Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83561447E57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbhKHK7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhKHK7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:59:10 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B18C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=x4sxFftELlia4A8wccMW8sIZZeVrDcr9gnNDldxODWE=;
        t=1636368986; x=1637578586; b=OrVWFZEEgbQqYz+LO9ausZwL51cfTCs5AghCG8Z6h+fTAf5
        PgSvvL0NdoH1KwI0ZCXWhSfqpwcqTw10pDyEPcJri+ljiLYa/zQV9LT73rvZ3k6JwRTMwZJqd1bpJ
        UyeGpUOKbFVYQtZoO8crBjTlW0IxD5U3q3DPRPpIQXCk6m8Ezy3+VqBPGKRncsq3JPqqH+h3tF/iI
        oHTwF9ZJdnq/w8FyLlxPCw8+Mb+RwuAlO9rc+yv4SGFZoDe5LqyKYIKZR+95Ltd0n5f5oHPfZmf/K
        YXEuj14EWAdkkb2R7QDEb74X/3xiykmUeI+yImkJZLuNvz7u+6NJogUx7hBX3flg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mk2K6-00CW2r-MD;
        Mon, 08 Nov 2021 11:56:22 +0100
Message-ID: <ce3a494b078ffca5df28475298ba6c491267da98.camel@sipsolutions.net>
Subject: Re: [PATCH v0 25/42] arch/um: Check notifier registration return
 value
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Date:   Mon, 08 Nov 2021 11:56:21 +0100
In-Reply-To: <YYkAiFhxVsLaPTqr@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
         <20211108101157.15189-26-bp@alien8.de>
         <129beb0a860102ba7970ab7497a5a83fe2041e68.camel@sipsolutions.net>
         <YYkAiFhxVsLaPTqr@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-08 at 11:48 +0100, Borislav Petkov wrote:
> On Mon, Nov 08, 2021 at 11:23:59AM +0100, Johannes Berg wrote:
> > Maybe it should just return it? I don't see how this is ever possible,
> > since it's an initcall.
> 
> If it would return it, you'd see the warning only when booting with
> "initcall_debug", I believe.

Oh, I thought we'd fail :)

> I can do that if it is preferred...
> 
No strong opinion either way.

johannes

