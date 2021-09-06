Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8A40215A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 00:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhIFW4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 18:56:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:55176 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhIFW4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 18:56:11 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3FF506E2;
        Mon,  6 Sep 2021 22:55:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3FF506E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1630968906; bh=rxUjtcftkWdxQebUVXYg7ThhIwD2oFLu6PrQI5V7y0o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cT9eHKTvLjy+2EF41OQBspdzGQcdcWrJdttmJKs3KykhzPJnE3FEyaxHAgaPMTQVH
         SR++cCMVT2OMWF1yX3/vJIb07bkoLVbgTvhqrL45o/4wylKLJC6HjoF6K0lNSGSIAK
         Gf0ctSJSb9YClNIB3GpMfb5ZEC7w2cdlIjifZw0mRaFe1YN+EuWxBP9B9MSlch8oY3
         T20bIM/K1FF8FP7aEjzP0iFoeGZ4ZYsimYmcSLtiSGRtQGcaqvqDvd5RxbK7xtCmsa
         lGENjgo27BMS/nR/XAeiih75e5s0hb/gAhoQws5tIi5vn0zlhxFrMP3TIK/NwtrrT0
         W47R8ZldWLGOw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: pdfdocs: Fix typo in CJK-language specific font
 settings
In-Reply-To: <bb148975-2839-7ad7-8bd0-b3b844820c9a@gmail.com>
References: <ad7615a5-f8fa-2bc3-de6b-7ed49d458964@gmail.com>
 <bb148975-2839-7ad7-8bd0-b3b844820c9a@gmail.com>
Date:   Mon, 06 Sep 2021 16:55:04 -0600
Message-ID: <87eea1uxfb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Hi Jon, [most CCs dropped]
>
> Just a reminder in case you have missed this fix.

Interesting, I'm not quite sure how that fell through the cracks.
Applied now, it'll go upstream shortly.

Thanks,

jon
