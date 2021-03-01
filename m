Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB132A014
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575255AbhCBDyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:54:43 -0500
Received: from ms.lwn.net ([45.79.88.28]:44396 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244899AbhCAWR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:17:56 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 31A402BA;
        Mon,  1 Mar 2021 22:17:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 31A402BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614637034; bh=XMDzNxNt6syqrf2sfO8/N05WszPdNC7VQGPu5pgkxaU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lNSGRgYRbrmNIN/Hc5lllNz9LT3t95Cyzh0tQODmKTMwkw3GhAW4b2psCQBV/PFBR
         ScJF+X9eOFVzgJXvOKlz+XXGNzk0SsMwQhFIo0SisgbONwaZ+6+6UXF49EnG0Dnnrt
         33+7SA+3f6jIROsmiZFfLCrV+GbEMvJDWGJtismP7eZx8xg38msiSi1JTTfjQbWaZ+
         VgWKKKxiV3+i+Lh1iGJ+vESBEyuBHIK2pcgKf5tp3QabK0VUacD8Fvo3KV5NFTmM4k
         vyxbsSzjJ6z6sx9Ap0ERukvCGcj5csR8LLm1KLIUMNR5o3tkq4BqmS4SyB4TJAdfXj
         LwcOBhPXkbXmQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     peterx@redhat.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] docs: filesystem: Update smaps vm flag list to latest
In-Reply-To: <20210212225533.12589-1-peterx@redhat.com>
References: <20210212225533.12589-1-peterx@redhat.com>
Date:   Mon, 01 Mar 2021 15:17:13 -0700
Message-ID: <87v9aa1pue.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> We've missed a few documentation when adding new VM_* flags.  Add the missing
> pieces so they'll be in sync now.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  Documentation/filesystems/proc.rst | 5 +++++
>  1 file changed, 5 insertions(+)

So this patch doesn't apply; what version of the kernel did you generate
it against?  Could you redo against current kernels, please?

Thanks,

jon
