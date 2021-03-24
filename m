Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE3D347FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhCXRwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbhCXRwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:52:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148F8C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=cWD1YkAT602Bo4ovvV2QDn6jkJrROrkUMXV1Y4u1zvo=; b=rafG6BzZ8GeOVQwTMWlD9nvQjW
        S3i5Xkk1WjYAT74bBSg5+zjx5LgImQVIdrIfRhqNKLlTOfmgXn6Rh+rnxhrpJ8S4cQL767+IUPrGn
        +NojTCgFP5waIB35XQf30goq9Psg5AuDtucB+Ue8w9b40pE++dOGozNlgpYpd9SQki+8jJSmuDz1x
        DwJskEuaZAsW0O7qwzWGpRbH4PUTHjQZztGCssPkr5QP3XRy986b2BiGNwBuRRJ4VSxXwVzwPc2dQ
        1SLhlvabLE40l4ky1kbQIhLc/x4Vfu0ZlQ2/OjJmRnIQfhvZgvUYXGvaFIo3Ez9uTl6BeD8ADU2sO
        F1agfxAw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP7ex-00Beb1-Cw; Wed, 24 Mar 2021 17:51:29 +0000
Subject: Re: [PATCH] ALSA: pcm: A typo fix
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, perex@perex.cz,
        tiwai@suse.com, broonie@kernel.org, mirq-linux@rere.qmqm.pl,
        lars@metafoo.de, joe@perches.com, huawei@kernel.org,
        viro@zeniv.linux.org.uk, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210324065612.31362-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6d2e91a2-a013-c9b1-8725-1715253d0646@infradead.org>
Date:   Wed, 24 Mar 2021 10:51:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324065612.31362-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 11:56 PM, Bhaskar Chowdhury wrote:
> 
> s/unconditonally/unconditionally/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  sound/core/pcm_native.c | 80 ++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 17a85f4815d5..9884961bca7d 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> 
> -	return 0; /* unconditonally stop all substreams */
> +	return 0; /* unconditionally stop all substreams */
>  }
> 
> --

Please fix line 1472 (in linux-next) while you are touching this file:

 * Return: Zero if succesful, or a negative error code.


-- 
~Randy

