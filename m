Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3D3ECCB4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhHPCiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 22:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232094AbhHPCiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:38:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C5386142A;
        Mon, 16 Aug 2021 02:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629081468;
        bh=8x+g2ha9ik4Vgy3+UW2RYKLfsxqik39pgGC8FWWjP6o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ruaLrpfV3CVut1lGYP3YkImXbdMcb/OC5RPArUr+daWUt0Y49OOMKhoWzdeGWawso
         tiGMtEFgHGG9sU084D8mOVIZlt/2TmJut6zIvgprx0DujIT2IBOYdVK0UlAqqB8rXE
         aIJT/ei/ndGdRjuQSFmEv0wipJkvpBj3YeVFaCmaT+5uAF+ZBOjnr7mYm90z6Fb+be
         LrgTzMrXbhtIX52CdzGNH4z8hO+1fOui/xOwklAVCOD55IhHEdx2ICMYmiiEDnWkYU
         8hh8DFUo1tuNsyKLlylD8nitCjqizspr749TuLZZUQ3ByIRkbT6FVQUtZczlSqFOJ9
         cB5bIwyDIgzSQ==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce periodic iostat io latency
 traces
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20210803225542.3487172-1-daeho43@gmail.com>
 <2a79c1c5-366b-92d9-4025-dbda660b1178@kernel.org>
 <YRWKKQe0bcgjKIIA@google.com>
 <b1a7b8a6-89dc-9076-2388-ced59aa8c47c@kernel.org>
 <YRbARsMfs2O2fz2s@google.com>
 <b76b5b09-d806-992b-3256-fe7ebfc4a2df@kernel.org>
 <CACOAw_zTAFfQGqRVRADq_dyO-Rf++Sn+uhwJZ+4MHv4rPwozCw@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ceaed49c-9e7b-3d14-a540-28d5382b672b@kernel.org>
Date:   Mon, 16 Aug 2021 10:37:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_zTAFfQGqRVRADq_dyO-Rf++Sn+uhwJZ+4MHv4rPwozCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/15 12:27, Daeho Jeong wrote:
> Actually, I was working on it, after Chao pointed it out.:)
> Merging them into F2FS_IOST and separating it from other files looks better.

Cool, :)

Thanks,
