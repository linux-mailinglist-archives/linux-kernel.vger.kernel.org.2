Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC55C30FF73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhBDVmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhBDVmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:42:00 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20531C0613D6;
        Thu,  4 Feb 2021 13:41:20 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C68C01E77;
        Thu,  4 Feb 2021 21:41:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C68C01E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1612474879; bh=YjeXLquClJaYkzt1j4Z1MSVPxqa4G3nDPIp/ov8F8RA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sDxMX/HWW4ZJF4CN98thSt11js2GJsslTgmqN5rivq9zfq0pm2Jva0vdVSviANNIL
         DzZ4rhouuL/NvRImrUgEw2bsFBXfHLNEq0pwlXmd7A1PJrsXRaFlNLp4tybg93cUnm
         y2z45/AnEZpNYLQWORzpGOAFU6KV0Kjkjzk+Nr5rdEd0r4GXOZxrGR0DhdFImISUa+
         kJNpSHxrNjwBPqj5M/P2MdbJfQ8ajv0VtWDt14y/CZkmRwEr75YeyyqX3LA2buRS+t
         zAzxXYVYZeq6wBYMbQyJ81hh53//AUWEC2S8zYkH3HsCz3g7nsQRrLRYWvdk02SEWK
         qwBzGGb0FQugg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>, Jiri Kosina <trivial@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org
Subject: Re: [PATCH 01/29] coding-style.rst: Avoid comma statements
In-Reply-To: <19fb55171ddc81293e149041c33fa6ce48daed7f.camel@perches.com>
References: <cover.1598331148.git.joe@perches.com>
 <2a97b738bba335434461a5a918053a49c1fb6af4.1598331148.git.joe@perches.com>
 <19fb55171ddc81293e149041c33fa6ce48daed7f.camel@perches.com>
Date:   Thu, 04 Feb 2021 14:41:17 -0700
Message-ID: <878s83fr42.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Mon, 2020-08-24 at 21:55 -0700, Joe Perches wrote:
>> Commas are not how statements are terminated.
>> Always use semicolons and braces if necessary.
>
> ping?

Hey, it's only been five months and some...you gotta stop rushing
maintainers this way :)

I guess at the time I assumed that somebody would take care of the
29-part set as a whole.  I've now applied this piece, thanks.

jon
