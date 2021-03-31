Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BB43507A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhCaTwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:52:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:48346 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236333AbhCaTwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:52:44 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0659199C;
        Wed, 31 Mar 2021 19:52:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0659199C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617220364; bh=cMlbyuJFoNBkPPv7Kar1Y441Q03a0repCPdhp/ysA4Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pH2nN5Xqyk34Drrd06oknmlvkPjYR6qQ+N/5sF6cRWMbvBUkFL+DKQqjt8pPlM5gv
         J9mJqppRV0afklFJ9o/OX6j9JCufoCp6fF9oA0lyniXxk3/md9ibRx3ymhsB8JuGri
         uvhqiX7H7wsUL1WOD5pycGzchiL/4foS7oMNW4Mg+KsIABIFgRatG+dQuH83ibDx2O
         iojKD7Vh7xJR2Wwa6yXdhjVAoPtWYV8ZkDSO5/nmFndLHI3re5NjcFHkmv8yiWf5H/
         0wbuuxJ+cq71qqblS3Z032hQ75XRvDt2UmDsyipKASHFyPwdgE0euluYl2nOj33KPc
         mnKLUvHkrNrsw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mailmap: update email address for Alex Shi
In-Reply-To: <1616748571-52058-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1616748571-52058-1-git-send-email-alex.shi@linux.alibaba.com>
Date:   Wed, 31 Mar 2021 13:52:43 -0600
Message-ID: <874kgrksms.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Shi <alex.shi@linux.alibaba.com> writes:

> Add my kernel.org address for old email address.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

Both applied, thanks.

jon
