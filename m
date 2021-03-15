Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F62933C6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbhCOT0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:26:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:44318 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbhCOTZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:25:52 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A38B72C4;
        Mon, 15 Mar 2021 19:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A38B72C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615836351; bh=P6fZS9Ge8p5a2gEMWcTKjltBgeGGppmH6MaIdBUw2gY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fhmvWeKci/KsWAejS6d+VbNvx9GG6w47Mzfz6k7KSP53roiSpLmeitw6Vr4TXOdCh
         qMf7IMnK+6yWgxjiWT3C3eOnF9tUMKDbIcVOdBTYQVoJCivxejbjS/rc/1hNtU4AAd
         pxuOA54i/g2pTypnkBysyGtCwLJGHyRId896zcOmm7Ant68/Dk+QIYcnIrZ1krkYMV
         3hgr/HL5o8MOlYK0d9URDKZnKXIbGh8bnD1xSXQK9pjo8iLWVWeY3Wk/2z071n7c1p
         tUsX2P+SdgZQpHCA8l/xMHFj5wz6hvPDLXv4RJjR4VI0VcSUvd0mixbYdcsBogp0TG
         F3N3EG+NKYV+g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya <yashsri421@gmail.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Cc:     lukas.bulwahn@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
In-Reply-To: <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com>
References: <20210309125324.4456-1-yashsri421@gmail.com>
 <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com>
Date:   Mon, 15 Mar 2021 13:25:51 -0600
Message-ID: <871rcg2p8g.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya <yashsri421@gmail.com> writes:

>> The opening comment mark /** is used for kernel-doc comments [1]
>> 
>> [1]
>> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments
>> 
>
> Hi Markus!
> That's true. But the content inside the comment does not follow
> kernel-doc format.
> For e.g., try running kernel-doc -none/man/rst on the above file in
> the example("sound/pci/ctxfi/ctresource.c").
> The starting 2-3 lines in files generally do not contain any
> struct/enum/function, etc. declaration.

The problem is that it's marked as a kerneldoc comment without actually
being one; it looks like somebody's internal corporate formatting.  The
fix is not to put a hack into kernel-doc - we have more than enough of
those in the file already!  The right thing to do is to remove the extra
"*" so that the comment doesn't look like a kerneldoc comment anymore.

Thanks,

jon
