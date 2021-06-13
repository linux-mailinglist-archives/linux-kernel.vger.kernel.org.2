Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E683A5ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhFMXI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhFMXIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:08:24 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C4C061574;
        Sun, 13 Jun 2021 16:06:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 120AC2C0;
        Sun, 13 Jun 2021 23:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 120AC2C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623625582; bh=OJya1Jx+lfeqjHcspdvU0tzgzxeOAl0JykBkcS+rsT4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BI2mn7K+pVBKlqBQlR78AWFR9+FiotxLJ/s7lF1gvfRNE/irXCEFdMwFRHSsxl6Li
         Jx8kFCvAqlU6e32Q2DShGebV0SAYUlsu/5cVPd7/CK6IMS4w7WAfXzxwouX2eZQVnW
         kFLoKU8RzdECHP+YLSGw9KC2ky1pyG+oWt8hw6c0uZFfCqt02XUoSYFhvO6q1HEYxk
         wTkWRi33BEDAEstOS16nTl5DagXnBXLJlowZNZw1OMUJl2bDl/ytCcydcXDWlSu4tq
         eGiXfGwk2C6h3IAmCRaVPnzvVnxwGyom4r1B3a7KoCTjILEQ6CuEsuR/PP6xOJPkEL
         s1GKmjabk8R0A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hubert Jasudowicz <hubert.jasudowicz@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: Remove references to IBM Calgary
In-Reply-To: <1bd2b57dd1db53df09e520b8170ff61418805de4.1623274832.git.hubert.jasudowicz@gmail.com>
References: <1bd2b57dd1db53df09e520b8170ff61418805de4.1623274832.git.hubert.jasudowicz@gmail.com>
Date:   Sun, 13 Jun 2021 17:06:21 -0600
Message-ID: <87h7i1bc0i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Jasudowicz <hubert.jasudowicz@gmail.com> writes:

> Calgary IOMMU driver has been removed in 90dc392fc445.
> Clean up stale docs that refer to it.
>
> Signed-off-by: Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
> ---
>  Documentation/x86/x86_64/boot-options.rst | 31 +----------------------
>  1 file changed, 1 insertion(+), 30 deletions(-)

Applied, thanks.

jon
