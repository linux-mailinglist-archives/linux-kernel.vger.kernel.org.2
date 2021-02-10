Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE8315F81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBJGdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:33:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhBJGdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:33:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6DD964E3E;
        Wed, 10 Feb 2021 06:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612938782;
        bh=oSqfTTuDPIyN6wja/9mtlslb94d9waIHGtAYATRHQho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLFnJxO+Dy9ew+Bk6wowGYwDn5M9C3cO069ghHJL98nnon7fvRZWj4RJZxm0QR/zU
         xwvvf2475Jl++uoT6cnAHg6IyqIcSgSxcRsCV+8P0sD+Bh+WjnJ8OVl6fG2ntLDa9+
         IKhZ6gNdoByIMHd+Fkv5EckNraNIKApONgKnQAZ2ccgqDxW/T8Yw9cINEJ7qVTOmGv
         euH5AgLrLyPJffgOOiUBoZNosepx7mBt44nmD5hsfhKdYsMYCBrz/F21lVZQP5FMJS
         E8Wpc0U7H3xyDCka492eNyUVLKnFTWXf63PvI+h0L6ZMcPEjGX7Qhgo0CO6zLZCQ34
         jcGA7my9SaL5w==
Date:   Wed, 10 Feb 2021 08:32:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daeseok Youn <daeseok.youn@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] memblock: remove return value of memblock_free_all()
Message-ID: <20210210063254.GD242749@kernel.org>
References: <20210209094327.GB242749@kernel.org>
 <CAHk-=wiNxm3FJEjTsY+g49GRWV4nhfivbkkb4b3=GabT=N65uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNxm3FJEjTsY+g49GRWV4nhfivbkkb4b3=GabT=N65uw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:17:30PM -0800, Linus Torvalds wrote:
> On Tue, Feb 9, 2021 at 1:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > This a small cleanup in memblock for 5.12 merge window.
> 
> If it's going to make Andrew's patches easier to apply during the 5.12
> timeframe, I'm happy to pull this early.
> 
> Yes/No?

No

-- 
Sincerely yours,
Mike.
