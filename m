Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6599043B60F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbhJZPvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbhJZPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:51:49 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867DAC061220;
        Tue, 26 Oct 2021 08:49:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0865E4B9E;
        Tue, 26 Oct 2021 15:49:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0865E4B9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635263365; bh=Pg1HyIVWDqYh3KdDEdBF9F6z/oqCMmI+IVUhFzqsTP4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Is96Qr/8xweF1Unmvtua/rNvjIvTsMWkVgCCoDmUkdrm+CgkeXXo41VSqwh/lj9SH
         8OEiYu93gxau+4MRXwveTZpzZl9l70ivOQ8nIZjGn4/8p6nJ12+7PXJLUreJbN4CEP
         PeneENpFTs6SkzHMctXxqoVs7CoSSVKpB7YxzCe1lEAKCWy4suxvomwHjD345vrVMy
         QOwTZwnYqoq62RkuQ7FR5HZa7JpHdH8uZBPDn039HiPEG1x+D9uHqnac8/RKaj4JQ+
         sf/Hzz1oMZ2sZ5nrLABEcfdfO5RMQSqf+bDknFgbgOPi+5TQgCZjf62HSNgq8zjaxX
         XRVsUM4Z79klw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] docs: submitting-patches: make section about the
 Link: tag more explicit
In-Reply-To: <20211025210536.hlmkpjwf3nll6mlm@meerkat.local>
References: <cover.1635152553.git.linux@leemhuis.info>
 <27105768dc19b395e7c8e7a80d056d1ff9c570d0.1635152553.git.linux@leemhuis.info>
 <20211025210536.hlmkpjwf3nll6mlm@meerkat.local>
Date:   Tue, 26 Oct 2021 09:49:24 -0600
Message-ID: <87wnlzeqgr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Mon, Oct 25, 2021 at 11:06:35AM +0200, Thorsten Leemhuis wrote:
>> +If related discussions or any other background information behind the change
>> +can be found on the web, add 'Link:' tags pointing to it. In case your patch
>> +for example fixes a bug, add a tag with a URL referencing the report in the
>> +mailing list archives or a bug tracker; if the patch is a result of some
>> +earlier mailing list discussion or something documented on the web, point to
>> +it.
>
> The "for example" is splitting the sentence awkwardly, so I would move it to
> the beginning of the sentence:
>
> "For example, in case your patch fixes a bug, add ..." etc
>
> Otherwise,
>
> Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

I tweaked things along these lines and applied the patch, thanks.

jon
