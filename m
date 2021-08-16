Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5942C3ECF9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhHPHoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234168AbhHPHoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:44:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA1C761ACF;
        Mon, 16 Aug 2021 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629099819;
        bh=U/7WQDfo/Qzy9+DjcIIAqHhrpYiE7FohGVxSzIJvDVo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h8CnmTOXZnIpGStqbefpN8NqUfXS02jg7aHR4K+eppyHbzr+9JN/t2BYf/EykzQQe
         zvQr0wbG/MTqFl3mXTzk5Z4ofW7x010aZFcYRoOfJvWWztgAm6e5Z2gAhoDOInhA/6
         8SF6A9eA5QMGMs3QBPWL+MeRocZu4bX6UOR62fx/EUK/zvEa/MiXHa0rL3xUPzM+Nm
         o4419Beq4E4sVz7YDZ0CpAE4o0Y/OaD3Ij0Yf7ByapyFK3KkjjTFZDcST9skepALrR
         yc1T3dhg8CMVanxf/smyUOMzTMvD77u40/gK8mCQBKf7w64AfOwDT/0KsgwoFzHrLK
         2KP3sM1FUyK+g==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce blk_alloc_mode mount option
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20210809185449.2565768-1-daeho43@gmail.com>
 <425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org>
 <CACOAw_xTh_HZizaVzDNjnVswu_OQwOjzEWRNxouGtM9E5qj6Pg@mail.gmail.com>
 <071534dd-cf10-38d3-b83b-c833f9c0a70a@kernel.org>
 <CACOAw_ye4y-njHbewXsvVr3gTT4URsw7VH4HM_D_g=zntwjtdA@mail.gmail.com>
 <dc21e445-126d-ef74-3d09-c5a71782ed2a@kernel.org>
 <CACOAw_x1F6Uu3p9RA8S7XBXnEYsnjPFY0JSG_VqBLrUjqAGeCA@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <50bfbeee-e165-5bcf-1c47-a45ef8b36ebf@kernel.org>
Date:   Mon, 16 Aug 2021 15:43:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_x1F6Uu3p9RA8S7XBXnEYsnjPFY0JSG_VqBLrUjqAGeCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/16 15:11, Daeho Jeong wrote:
> I agree with you. But still I think "fragment" mode should work even
> in low free space conditions.
> Otherwise, it will be seeking the free blocks again and again like a busy loop.
> Or we can change the block allocation way into adaptive mode under low
> free space even staying in "fragment" mode.

I think fallbacking to adaptive mode sounds good to me, so the condition
of fallback may be there is no more free segments?

Thanks,

> 
> If we can handle this, we might use "fragment" mode for both
> simulating after fragmentation and making the filesystem fragmented.
> 
