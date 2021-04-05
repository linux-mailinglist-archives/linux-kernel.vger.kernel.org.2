Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7533542D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 16:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbhDEObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhDEObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 10:31:15 -0400
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Apr 2021 07:31:08 PDT
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7331C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1617632589; h=date : from : to : cc : subject : in-reply-to :
 message-id : references : mime-version : content-type : from;
 bh=zs5AsGrzV9IoOZz9lo1o8BS7yOEFRjrGPusr0RDiYXg=;
 b=xwbrQrN9QLjEN4v8ESA1EzYk4nuNAbnvqODLnvg2Gi7RpJ6FfTsfNJB6N2cc0Lc+oAI7V
 3lcBS5C+A4GKmCTAQ==
Authentication-Results: mail.nerdbynature.de; dmarc=fail (p=none dis=none) header.from=nerdbynature.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1617632589; h=date : from :
 to : cc : subject : in-reply-to : message-id : references :
 mime-version : content-type : from;
 bh=zs5AsGrzV9IoOZz9lo1o8BS7yOEFRjrGPusr0RDiYXg=;
 b=cyzQHRUhSRwJjlNvI23UMC09A59p/RQ3P9ZD4GE30O4Y+M3uqxTUrWaB04IMC8a2jOS1P
 2IyOq4eNWzpdwi6aOSzcMbEbWy3q7WjrR3a1GfAXLDBVYJMNdH8qayCn9phKnNxULXQHbsn
 oOFq5UaANYG7oFZmWjouTCJFA76CqExEkTylEo9lQ5nB5veigk2cLfj5daSKErVE+CLlrpU
 M/F7SGzMbJoBLe+cRkMeCfnps5wLFoxW1Eltisp1lbJB2RXlfFn39BRWiT4yKI062gkoQ74
 SqhRHuH9EW7zcel9JZXtp+eGRT9XiDBynFBH3vj9gG9WV1Ogry8Hn+5Mz62Q==
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id C8C3A6029A;
        Mon,  5 Apr 2021 16:23:09 +0200 (CEST)
Date:   Mon, 5 Apr 2021 16:23:09 +0200 (CEST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
In-Reply-To: <20210401223329.GK2696@paulmck-ThinkPad-P72>
Message-ID: <442f7b5-6a6e-f2f6-3980-add12adbdb1e@trent.utfs.org>
References: <20210401132602.116352-1-frederic@kernel.org> <20210401185116.GH2696@paulmck-ThinkPad-P72> <20210401203112.GA116405@lothringen> <20210401204022.GI2696@paulmck-ThinkPad-P72> <20210401204113.GB116405@lothringen> <20210401210253.GJ2696@paulmck-ThinkPad-P72>
 <20210401210802.GC116405@lothringen> <20210401223329.GK2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021, Paul E. McKenney wrote:
> +# This script knows only English.
> +LANG=en_US.UTF-8; export LANG

This, too, will only work if en_US.UTF-8 is installed . Check with "locale 
-a" if it is. Also, Perl will complain loudly if the language is not 
installed (try: "LANG=en_US.UTF-9 perl"), a nice way to test if LANG works 
as expected.

So, wouldn't LANG=C be a more conservative fallback here?

</bikeshed>

Christian.
-- 
BOFH excuse #58:

high pressure system failure
