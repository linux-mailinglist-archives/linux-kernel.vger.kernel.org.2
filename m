Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57864289A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhJKJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:30:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbhJKJaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:30:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE3FF20047;
        Mon, 11 Oct 2021 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633944491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzsf3qOeWL3PJZQYXdzcM4qU33SyWkAIXshFGPaeTMM=;
        b=ued5v0sFSNMVPRllyFCfLUKZ95H22GdIvG2tAhbnjyPI3mp3TUAeKsc9XsNJdUEzzjCM6j
        PYxNHl2RWLDc5JPVwu+LykQC/sMPkYOyX7LJNeBgTQIpHlLkb8QEyNhpnRFA+mG/CNkUtk
        e3Ot+kBeVmoBBjgTuQLpu2iIh6B11EA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 31155A3B8D;
        Mon, 11 Oct 2021 09:28:11 +0000 (UTC)
Date:   Mon, 11 Oct 2021 11:28:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     ultrachin@163.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, brookxu.cn@gmail.com,
        chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit time
Message-ID: <YWQDqtnA5FXk7xan@dhcp22.suse.cz>
References: <20211008063933.331989-1-ultrachin@163.com>
 <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-10-21 10:17:50, David Hildenbrand wrote:
> On 08.10.21 08:39, ultrachin@163.com wrote:
> > From: chen xiaoguang <xiaoggchen@tencent.com>
> > 
> > The exit time is long when program allocated big memory and
> > the most time consuming part is free memory which takes 99.9%
> > of the total exit time. By using async free we can save 25% of
> > exit time.
> > 
> > Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
> > Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
> > Signed-off-by: lu yihui <yihuilu@tencent.com>
> 
> I recently discussed with Claudio if it would be possible to tear down the
> process MM deferred, because for some use cases (secure/encrypted
> virtualization, very large mmaps) tearing down the page tables is already
> the much more expensive operation.
> 
> There is mmdrop_async(), and I wondered if one could reuse that concept when
> tearing down a process -- I didn't look into feasibility, however, so it's
> just some very rough idea.

This is not a new problem. Large process tear down can take ages. The
primary road block has been accounting. This lot of work has to be
accounted to the proper domain (e.g. cpu cgroup). A deferred and
properly accounted context implementation is still lacking AFAIK. I have
a vague recollection we have padata framework but I am not sure anybody
has explored this to be used for the address space shutdown. IIRC Daniel
Jordan was active in that area.
-- 
Michal Hocko
SUSE Labs
