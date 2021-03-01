Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034D232A00A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575189AbhCBDyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbhCAWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:06:39 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E61C061788;
        Mon,  1 Mar 2021 14:05:54 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 841CA2BA;
        Mon,  1 Mar 2021 22:05:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 841CA2BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614636354; bh=4dMqcg0qv92sCVUfNqP0aiZ9+W8s7Dqb9NzfQxgREOM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o28ZEQO7sEFvtq1pbJ6WIt9wouywBFzDnT2xefn6KdsSelinLc54wjd7EFXHZcE4f
         CbH+2rtQbUyTtQRA7w+Sx2nGu0TovfkfATQY5v+hN8E8xCFUpJZWdHLa/Ltjjaw2O1
         JDVaY8CKmMm4ayWSN1MKF04pwKFpmyyZIQ76xbSQtixOO6XEaGk5cufmh5BiODbLea
         4h4VtUv5snsDu5+MkQfvWMDHGkuiO2/MUb16EsmO28lR2UrtnVfCar5AedHLNOa1Gw
         RFULeKN2fypqJPYZxq1KX6HvNzy/gl5u89nuncmT75LARDd2zSbN5JjhDd8seM0Itb
         xCwep/2EOVg2w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joerg Roedel <joro@8bytes.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Damian Tometzki <linux@tometzki.de>
Subject: Re: [PATCH] docs: reporting-issues.rst: explain how to decode stack
 traces
In-Reply-To: <20210215172857.382285-1-linux@leemhuis.info>
References: <20210215172857.382285-1-linux@leemhuis.info>
Date:   Mon, 01 Mar 2021 15:05:54 -0700
Message-ID: <878s7634xp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Replace placeholder text about decoding stack traces with a section that
> properly describes what a typical user should do these days. To make
> it works for them, add a paragraph in an earlier section to ensure
> people build their kernels with everything that's needed to decode stack
> traces later.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> ---
> v1->v2
> * Fix typo pointed out by Randy
> * include review feedback from Qais and bis Reviewed-by:
>
> v1:
> https://lore.kernel.org/lkml/20210210054823.242262-1-linux@leemhuis.info/
> ---
>  .../admin-guide/reporting-issues.rst          | 81 ++++++++++++++-----
>  1 file changed, 59 insertions(+), 22 deletions(-)

Applied, thanks.

jon
