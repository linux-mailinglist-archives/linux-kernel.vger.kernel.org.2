Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D26436042
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhJULbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhJULbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:31:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2E8960EFE;
        Thu, 21 Oct 2021 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634815776;
        bh=mcc72ZcqDdMDWiL2WxtN09zO3LW9PCTKiI0ho3RGf3k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AIGa8F4hEJ9tysD3zEuLrV/8EzNpzbOIYGrO0kBy4fh+xFqC4Pxeg8KwwwPkTyGFG
         /SiGt8Rlaw5iZsW9mNKPUeHchALKfHAVmss2slYOu1KAqMe6FxpA/33Im/4+nuee6D
         8EqYO+OmQUjMh7HCdZIJlNwqti6cc/WiC8eDgUuY+IlW8aqG4yT56LAfPeAi8O2QBc
         ajy60KmOnmJg43C0hj1ZhjK7KhTTgdRkUVuDjQt6e3+/wb6NgSqjCOjkMbeKCq8AKG
         rnj0YTE6R1EVI6dR0x9Mwib6f+ll4L6r61B4amIKRc5/RY8pdxg/j5+XYAcsdaQvyb
         vyaUVlm4J4Rng==
Message-ID: <0e77ea3e-196e-cc41-91eb-abc89ca6d522@kernel.org>
Date:   Thu, 21 Oct 2021 19:29:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: introduce fragment allocation mode
 mount option
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210929181203.1606675-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20210929181203.1606675-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/30 2:12, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added two options into "mode=" mount option to make it possible for
> developers to simulate filesystem fragmentation/after-GC situation
> itself. The developers use these modes to understand filesystem
> fragmentation/after-GC condition well, and eventually get some
> insights to handle them better.
> 
> "fragment:segment": f2fs allocates a new segment in ramdom position.
> 		With this, we can simulate the after-GC condition.
> "fragment:block" : We can scatter block allocation with
> 		"max_fragment_chunk" and "max_fragment_hole" sysfs
> 		nodes. f2fs will allocate 1..<max_fragment_chunk>
> 		blocks in a chunk and make a hole in the length of
> 		1..<max_fragment_hole> by turns	in a newly allocated
> 		free segment. Plus, this mode implicitly enables
> 		"fragment:segment" option for more randomness.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
