Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E888A3C3439
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhGJKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 06:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232387AbhGJKo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 06:44:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3608761206;
        Sat, 10 Jul 2021 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625913733;
        bh=lhKGmUxmKWhzNv905Oek6K4ehDxviGsc0ezlV3WIHAE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QKbcV6HfK5H3ZmXNkbPznYubj5Uu3CB3gjQMKLnQ/FrsaPYT+uGwlWnx8jK5xY1Rl
         DsVQB2eDfRhjC/Kau03qvyLUdqYlLC0GZHai1aRHXRM/omfK0inTdbaqNKwICogDSg
         J/DUVKd6EITqRWY73dH+ifAYbnLxaIfXAzifZZLl1aXlRXg5Z24VNjTcbhthJRq3GW
         MFzwhBvoggRCOGWl0iPrFHKefw/dqcIAj89rpwmKHd89qKb4TdcmAXutDVGTbvyBvy
         eqM/a/ndgCRJBcsxS6PK17hHFlW+0/mjI+ch8eFTsqyWsbRVrHCPKa9BQpHjCg2K19
         6KoFq2P+bNs0A==
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add sysfs nodes to get GC info for
 each GC mode
To:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20210710055357.1638111-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5cdacf69-329e-f883-82fc-3eac08c3d539@kernel.org>
Date:   Sat, 10 Jul 2021 18:42:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210710055357.1638111-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/10 13:53, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added gc_reclaimed_segments and gc_segment_mode sysfs nodes.
> 1) "gc_reclaimed_segments" shows how many segments have been
> reclaimed by GC during a specific GC mode.
> 2) "gc_segment_mode" is used to control for which gc mode
> the "gc_reclaimed_segments" node shows.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>
