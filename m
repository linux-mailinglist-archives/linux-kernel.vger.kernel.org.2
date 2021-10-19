Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82043369F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhJSNGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSNGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAA1061360;
        Tue, 19 Oct 2021 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634648627;
        bh=I7JwFHSmv1BT930lTSC6hdElWCbCHQMERETOEA78i0k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PypRr6vTgk9g7BuW7HmQemLz1Sf8vLq9WneM3HZL0HS4l5YHlXjNOcmo3bvd4Rxxm
         sJymSzuPjxmz3AZ2SKr7IrWHJ0SkLy/CuCbcGxYDCcrN0aBLcx7YKqpqh/f8/22SQ0
         kgAr/TIEYmLHLU3dNxhC9EQZeUINGLdhIMEzF43lkvsrVJHzInLHB5SkDUlo1+ghjm
         Taf/y1i/iR0FdkpYI4krHFAMWpl72LEBHVnre0nWa2UIXzQoh3rk+f1K7frfRtSoPO
         AXIJohp0sXPvDur0u24O2Sg6xPbJWwygnw4wHU1LPPSsnnIrkgPo3xMvT96++JE5qG
         x1hXCRI1hdcbQ==
Message-ID: <88cc9caf-1d50-2d0f-de0e-09456339b996@kernel.org>
Date:   Tue, 19 Oct 2021 21:03:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 6/7] erofs: rename some generic methods in decompressor
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Lasse Collin <lasse.collin@tukaani.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211010213145.17462-1-xiang@kernel.org>
 <20211010213145.17462-7-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211010213145.17462-7-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/11 5:31, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Previously, some LZ4 methods were named with `generic'. However, while
> evaluating the effective LZMA approach, it seems they aren't quite
> generic at all (e.g. no need preparing dstpages for most LZMA cases.)
> 
> Avoid such naming instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
