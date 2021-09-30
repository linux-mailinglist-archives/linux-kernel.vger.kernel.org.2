Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7741DAA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351330AbhI3NJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:32824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351400AbhI3NI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:08:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45CAC6126A;
        Thu, 30 Sep 2021 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633007203;
        bh=2E12lxsILybA6TcVpH3Clkx1XYrdgQW3E8uFB2oiPBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgdiosn93AauLXFMrr9Usc2pvpe/W79Bk/F24VYCqaajlvOZW38VnA1SHe8Q5ZSSR
         +k3SeIa2jPtwhRk/pPRUWlUZAStkuID2g1hXF+eOCILkYNcrT6F8tgExarm1azlP59
         IWMXzzwDbwBujNxfnprNQQlud94H2E+Bmzn6p3LmfTJuG7yY0eIt98OHAl85+m5PCg
         luTsXtXHX+um80MmKnbFnREoX1fuqEi2ClAZZ80vQbX5NZHKPJtFHxjEqzojsCMrAZ
         y67L2Yqv8blaQ8m0lyqaSvs1+3vuj0jv3FxirIFYE4mOx2dQSqgynxx5qXjAKnP1Fh
         5VbBl+zV7oh/A==
Date:   Thu, 30 Sep 2021 15:06:40 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     ebiederm@xmission.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, containers@lists.linux-foundation.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
Message-ID: <20210930130640.wudkpmn3cmah2cjz@example.org>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133>
 <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133>
 <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org>
 <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:39:06PM +0000, Jordan Glover wrote:
> > I'm still investigating, but I would like to rule out one option.
> >
> > Could you check out the patch?
> 
> 
> Thx, I added it to my kernel and will report in few days.
> Does this patch try to fix the issue or make it easier to track?

I suspect the error is caused by a race between allow_ucounts() and
put_ucounts(). I think this patch could solve the problem.

-- 
Rgrds, legion

