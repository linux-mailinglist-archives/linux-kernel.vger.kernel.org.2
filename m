Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3098F366226
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhDTWaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:30:00 -0400
Received: from ms.lwn.net ([45.79.88.28]:60958 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233964AbhDTW35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:29:57 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 26FD07DA;
        Tue, 20 Apr 2021 22:29:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 26FD07DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618957765; bh=7uuK2tjREFu4yCuLr1biJCkH1dasIWWLO/M3i17nl4E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=h5ZZb0TD1EY/spR6gVSbjmq92ch78HxyyBhpwOWiXsKOqf4f/Um3Tlo1pyrWTzQsu
         V0KpTds+54lQEoc8mDfbBQw27YlIPF3je/plaa9J0tOE+Vm35d/MQdgbKC/miXDKaD
         3CanA19CeqCajUrUIN2qstisaysztCfTtcO6h7+CDyaB2L3JVo8DZbY8TBgQ8T8+5M
         2l6SxSlul5uf8G+tsonuejcvoPq6gUCh5l9tKzg57rdvUdlf3WBsUF3S7U67P/vgeQ
         mQWN4+m7H2VnwjkrxlashHt72k3UzUB+7x8H0pjddDZs6welkm1nk9crr1+WH4gpYC
         NA6iZC+4Xjsgw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] docs: driver-model: Update the documentation for
 device class
In-Reply-To: <20210407061053.81940-1-manivannan.sadhasivam@linaro.org>
References: <20210407061053.81940-1-manivannan.sadhasivam@linaro.org>
Date:   Tue, 20 Apr 2021 16:29:24 -0600
Message-ID: <87czuoio8r.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> The current documentation about the device class is out of date such
> that it refers to non-existent APIs and structures. This commit updates
> them to the current device class APIs and structures, removes wordings
> that no longer valid while trying to keep the original content intact.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>
> Changes in v2:
>
> * Fixed CLASS_ATTR_RW as spotted by Greg
>
>  .../driver-api/driver-model/class.rst         | 144 ++++++++----------
>  1 file changed, 66 insertions(+), 78 deletions(-)

Note that this file was removed in commit 1364c6787525 back in
February by Geert (added to CC).  If you want to update this document,
you'll first want to bring it back.

Thanks,

jon
