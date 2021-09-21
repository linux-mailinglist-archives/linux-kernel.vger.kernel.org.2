Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B1413DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 01:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhIUXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 19:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhIUXMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 19:12:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB70C061574;
        Tue, 21 Sep 2021 16:10:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A95E4735;
        Tue, 21 Sep 2021 23:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A95E4735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1632265849; bh=73WuaeALzhlRrsbXoGtItMRmtfuk2V2JbCR4hx/XQkk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tPM1UeG9HVIb9D5TIXL9rZfLuUQgdrwnPpphHXJqAOyAxp9N9dkolcAGG6gb/PHhN
         t+cG00UsL1VQ3izB+c1gLTPy6ztEuFdQKoUQErxbuQ73tWe/2MU+mwVz8bUEgayKsG
         /Hd6pZxZ5HiQhhE/5j7PTOkdK+/GL7ykzlLVbGYLvpwk3dRhpFNqwDsHc5etYX9DC9
         FbHhDjCP81QZfwj2Pt6j5Ju0XHjUoOxoc28OgfrDYiVAZWKGagb+PlhXpVOiGuAl8J
         4c+DR/dhA0fosw3XYl16OtXBiZ65FeQuMqy0NAq4UQLjz7fCCxjedU/xo2DQOXzQwb
         icLnbAcbRDcRA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>, roger.pau@citrix.com,
        jgross@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Update SeongJae's email address
In-Reply-To: <20210917122222.3109-1-sj@kernel.org>
References: <20210917122222.3109-1-sj@kernel.org>
Date:   Tue, 21 Sep 2021 17:10:49 -0600
Message-ID: <87bl4ltthi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae Park <sj@kernel.org> writes:

> This commit updates SeongJae's email addresses in documents to his
> preferred one.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-driver-xen-blkback   | 4 ++--
>  Documentation/ABI/testing/sysfs-driver-xen-blkfront  | 2 +-
>  Documentation/translations/ko_KR/memory-barriers.txt | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

jon
