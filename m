Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49D3AD143
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhFRRiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhFRRit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:38:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207B1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:36:40 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1luIPr-008atf-4G; Fri, 18 Jun 2021 19:36:27 +0200
Message-ID: <2760706369e7401dd794339e3f22859c243272ea.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] Fix issues in check_irq_usage()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Date:   Fri, 18 Jun 2021 19:36:26 +0200
In-Reply-To: <20210618170110.3699115-1-boqun.feng@gmail.com> (sfid-20210618_190144_566235_DE7F4D24)
References: <20210618170110.3699115-1-boqun.feng@gmail.com>
         (sfid-20210618_190144_566235_DE7F4D24)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boqun,

Great, thanks! I'll ask the folks who could reproduce this issue to do
so as soon as possible.

Not sure if you saw my previous posting:
https://lore.kernel.org/lkml/8a61ecda99843307018e3e71a5540682436443fc.camel@sipsolutions.net/T/#u

That was with patch 3 of this set already applied.


If I understand correctly, then you're basically saying that if we apply
all the 3 (or 4) patches here, it'll just change the report (that you
can see at the link above) to actually say something that I can
understand to see where the issue is?

Thanks,
johannes


