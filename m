Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2D309042
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhA2WpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhA2WoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:44:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9018FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=RLjjVEupP+ggBlUVzmKIkCNdgVo0qLXK5FAaN/TgVGI=; b=0oKAzliKVXm11xqfTZWqXg/VOG
        Z96dELldJKI/8/7RoLGSzcVclESOpBdRU7RTZKWxkLfliXzBNDoqLLT052OeJ+Wz3wnTLoJvz50w7
        Pg5n9xhQ7jsDI28a84QBbkZKjmheh7BEB7ReEmaZzyi1edYO49vMjniHOx0ofDXAaZdepC8QLIml0
        gq1UAHx1gB+vIrRfK0n2/Iwnon6fyB9/3n2SvG7P/o6eicsogd9pu9/xnqQsc+4v81ng5uAhRT8Dn
        jXMYrnnfqrZFXepHYw1LfhStfLOJLW4HRymt2BgVN/IWm27i6s4/m7Z19JGAbUFkGvOSGB0k9J9YD
        wYgpNa6w==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5cUE-0004bO-23; Fri, 29 Jan 2021 22:43:30 +0000
Subject: Re: [PATCH] lib: crc8: Pointer to data block should be const
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, arend@broadcom.com
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
References: <20210129164120.27604-1-rf@opensource.cirrus.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eafaab98-9300-a155-c0ac-6fe2aa1cf3d6@infradead.org>
Date:   Fri, 29 Jan 2021 14:43:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210129164120.27604-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/21 8:41 AM, Richard Fitzgerald wrote:
> crc8() does not change the data passed to it, so the pointer argument
> should be declared const. This avoids callers that receive const data
> having to cast it to a non-const pointer to call crc8().
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/linux/crc8.h | 2 +-
>  lib/crc8.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

You need to Cc: someone to merge it, like Andrew Morton
or whoever scripts/get_maintainer.pl tells you.

Thanks.
-- 
~Randy

