Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36310325037
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBYNO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBYNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:14:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FEDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 05:13:41 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lFGST-008RYO-Tv; Thu, 25 Feb 2021 14:13:34 +0100
Message-ID: <96d1f031409d87ff91582eb5b3c1db5af9832bf9.camel@sipsolutions.net>
Subject: Re: [PATCH 4/7] um: time-travel/signals: fix ndelay() in interrupt
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 25 Feb 2021 14:13:33 +0100
In-Reply-To: <20210223161449.7461e0b6dacc.I3507b456d425cb95a092eb50b6cb491fe8575c50@changeid>
References: <20210223152707.408995-1-johannes@sipsolutions.net>
         <20210223161449.7461e0b6dacc.I3507b456d425cb95a092eb50b6cb491fe8575c50@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-23 at 16:27 +0100, Johannes Berg wrote:
> 
> +void unblock_signals_hard(void)
> +{
> +	if (!signals_blocked)
> +		return;
> +
> +	if (signals_pending && signals_enabled) {
> +		/* this is a bit inefficient, but that's not really important */
> +		block_signals();
> +		unblock_signals();
> +	} else if (signals_pending & SIGIO_MASK) {
> +		/* we need to run time-travel handlers even if not enabled */
> +		sigio_run_timetravel_handlers();
> +	}
> +
> +	signals_blocked = 0;
> +}

This is, of course, racy & wrong - we could set signals_pending just
after checking it.

Need to make this

{
	if (!signals_blocked)
		return;
	signals_blocked = 0;
	barrier();

	if (signals_pending && signals_enabled) {
...


Anyway, I need to repost this series, but I'll wait a bit longer for
further feedback before that, since I know Arnd and others wanted to
take a look at the IOMEM and PCI bits.

johannes

