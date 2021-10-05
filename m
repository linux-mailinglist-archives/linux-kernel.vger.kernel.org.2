Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0734232F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhJEVpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbhJEVo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:44:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DB8961163;
        Tue,  5 Oct 2021 21:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633470188;
        bh=g/LtuMoXlaHezf4SYW6I64I+lkHJGCjMAkb9z0woxbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KLiofxUvwbRrylHZdh4h6JVgPlR9Qv5QjiFQCJHjXruxzvIyc6cra75NOB4zchOPb
         Msw41+WGaY/89HNl3WgEE3BK5W6nmD5XK6BXBAQcVyCIq1PXqX51+kOPTh4jJu6WcZ
         rkMb4vDs41yWlqID4ZBMQB8NgMxSqUhmqmu3jwzI=
Date:   Tue, 5 Oct 2021 14:43:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, faiyazm@codeaurora.org,
        andreyknvl@gmail.com, ryabinin.a.a@gmail.com, thgarnie@google.com,
        keescook@chromium.org, bharata@linux.ibm.com, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm, slub: fix incorrect memcg slab count for bulk
 free
Message-Id: <20211005144307.9c2eedd9c4802d47c64df2aa@linux-foundation.org>
In-Reply-To: <25db026b-76bc-cad3-7913-c310fc6cd822@suse.cz>
References: <20210916123920.48704-1-linmiaohe@huawei.com>
        <20210916123920.48704-6-linmiaohe@huawei.com>
        <25db026b-76bc-cad3-7913-c310fc6cd822@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 12:50:08 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> I now noticed the series doesn't Cc: stable and it should, so I hope Andrew
> can add those together with the review tags. Thanks.

Done, thanks.
