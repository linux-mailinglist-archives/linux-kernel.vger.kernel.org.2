Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD143A5AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhFMXLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhFMXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:11:43 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F2BC061574;
        Sun, 13 Jun 2021 16:09:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1363C4B7;
        Sun, 13 Jun 2021 23:09:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1363C4B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623625781; bh=IsImyvcZd8Vhl3L9cDzG5pVt7HN8kRB69c7BWJPZqG0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=r5xBg10Qjv5Qt3InGBLfq55Fs+HjjvaGWHwpRAddQH3VV/bIUQX2mJWEOYy1Zlp4u
         D4S81gh3G4ySHv4PPhdFDhkwuTrsVLKfXj6TgyPi/jqngc9/+5nsgwTToXI5z71K9w
         dvUZcgrtn9QCs3CCaY8iCZj61ARhT0FljTY+79eO1HmNYTAyjmaergO5N3UCdWNlwp
         QPRwp4B5DJoONhLbugUfJmaPJ9Yzm30M2Uy8t6n94099jWdntcX1nFHB2VPbmfEoi5
         2vXkx3aDpXaH4f75kA0iY4yKXkmqpmPk37gQzRFb9nsQvdASXwhR839wsurMgWIjBs
         9S2AgTxbgXeZQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Peter Anvin" <hpa@zytor.com>, vgoyal@redhat.com,
        x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
        dyoung@redhat.com
Subject: Re: [PATCH v3] Documentation: kdump: update kdump guide
In-Reply-To: <20210609083218.GB591017@MiWiFi-R3L-srv>
References: <20210609083218.GB591017@MiWiFi-R3L-srv>
Date:   Sun, 13 Jun 2021 17:09:40 -0600
Message-ID: <878s3dbbuz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> Some parts of the guide are aged, hence need be updated.
>
> 1) The backup area of the 1st 640K on X86_64 has been removed
>    by below commits, update the description accordingly.
>
>    commit 7c321eb2b843 ("x86/kdump: Remove the backup region handling")
>    commit 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
>
> 2) Sort out the descripiton of "crashkernel syntax" part.
>
> 3) And some other minor cleanups.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Applied, thanks.

jon
