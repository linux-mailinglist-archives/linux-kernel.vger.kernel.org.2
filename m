Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6036C7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhD0OdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:33:17 -0400
Received: from ms.lwn.net ([45.79.88.28]:60432 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0OdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:33:15 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1E0BC2C1;
        Tue, 27 Apr 2021 14:32:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1E0BC2C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1619533951; bh=Gb7wiNNqlbPlp42zPyXWy/+V9Yc2Z/CrlIYpbL74jOI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gZgNCb93URTijLQ8kRuP+3MHHX/EWyVg8qbobDs+DPL7wjsqZbtPBdfXKaZYOu/s+
         7LMjnvPjx6mP0HBttSLv5BnZ2mDJGzR+stRUc6yD6OfDEK3R03kaU0dtmn1kTURWCl
         ghGk5l4O8aJ80fN53BmMqeESREo6BKW5jp7jY1ZS7TbI0NUmIpbQ5Y1Xfbg2UQqmf5
         qUR/0oSI8GY3FmkpjUe3v5zvUy4qVf9B9WMHe4/BySLP89+FsWyFy/Krn0N26KmTWy
         2Qj9EpV1yVulB+u+nU/eYLuMKNHkj1yzdOy9jjc7UdzHRgmeM13lU0PyEz3A4IqW0O
         QieTKHMWJ5fbg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, nathan@kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, viro@zeniv.linux.org.uk,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH  RESENDING 0/3] Removed oprofile stale entries
In-Reply-To: <20210426220844.HQ75oVReql8ttKS4sU3Qlcz-97Xx0o5baf7MqLul7dI@z>
References: <20210426220844.HQ75oVReql8ttKS4sU3Qlcz-97Xx0o5baf7MqLul7dI@z>
Date:   Tue, 27 Apr 2021 08:32:30 -0600
Message-ID: <87a6pjer29.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> This patch series trying to clean up the remaining debris of removed
> functionality.Kindly see the commit : 24880bef417f(oprofile-removal)
>
> In truest sense, it is all trivial in nature, so cc'ing that mail id too..
>
> trivial@vger.kernel.org
>
> Bhaskar Chowdhury (3):
>   Removed the oprofiled version option
>   oprofiled version output line removed from the list
>   Enlisted oprofile version line removed
>
>  Documentation/process/changes.rst                    | 1 -
>  Documentation/translations/it_IT/process/changes.rst | 1 -
>  scripts/ver_linux                                    | 1 -
>  3 files changed, 3 deletions(-)

So why are you resending something that only showed up last Friday.  And
during the merge window at that?  This is not an urgent fix...  Be
patient and it will be handled.

Thanks,

jon
