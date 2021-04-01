Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CF351F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbhDASyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238586AbhDASpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91CEF61377;
        Thu,  1 Apr 2021 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617293860;
        bh=IXOdIt86fhicqSs2zsLnGgHO1tc7gVCOeRRSgWNZheQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=PJCVnWRx65QkWqsQr/M4Bd+o8GWSqybD8vkORBd8WxQ6IcL+6nZQSjK4ZEKeR7pVT
         QyeiLFeRal4pHS4eXeUqZOhe0Pv7BozLNCg4iGkZXNJSKkAF62a7YWj9jQ7NGHnJBP
         nqrHiA3WM+x5zPdmexUAO+eL41BAcgk9qGcYcqSHTtEiy6Gw3GUYJ5Canytlepo2Dc
         +jB1FqSO4x2AjIgXszZw/SkuzCO0llQJwWkb1VdvEUztm+7Q3/xotugLoh9wQyj835
         HHTl1IQufQOdgTRCwzfbBYysfnYZ5mTsdW5RoBBE82xGQgq6WnPV+XpPz0oacWbtCw
         Yz/KYabXqWeBA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 22BF53522755; Thu,  1 Apr 2021 09:17:40 -0700 (PDT)
Date:   Thu, 1 Apr 2021 09:17:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     bp@suse.de, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Backporting to v5.6: fd258dc4442c ("x86/mce: Add Skylake quirk for
 patrol scrub reported errors")
Message-ID: <20210401161740.GA22501@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We are looking at backporting fd258dc4442c ("x86/mce: Add Skylake quirk
for patrol scrub reported errors") to v5.6.  When accompanied by these
guys, it passes our usual kernel smoke-testing:

1df73b2131e3 ("x86/mce: Fixup exception only for the correct MCEs")
1de08dccd383 ("x86/mce: Add a struct mce.kflags field")

Could you please let us know if there any non-obvious prerequisites we
should also be backporting?

							Thanx, Paul
