Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CBE36D1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhD1GAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235809AbhD1GAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:00:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6570261418;
        Wed, 28 Apr 2021 05:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619589590;
        bh=FgrS4XUHz0O6Fa4p86bx504/a38cD5C/C9ebOq8CMgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kxQO8XXtHgJ92g69cQtUE/ztppXG10NjcTg3AAVJeNGHFfHBIwaxtHqYm4HKtsOM8
         4pSH5hGTD/9dj+8+vp8XTh4poyGEKzDLbHfyz/p+fkTYk5UbI7PvZTP0EBlYgRcDBt
         /UDubaGboihUuxJZ1iP9B6sJRYsCqp62pwxj1WOiQZr6AQIXrzuCoeW+b3lhv2xDNN
         SwA6SCvteDVDkn4bMSCBOJLV9ILEVFDAzMKmVvjSB+LjAS1Zh6xwmAuOxr+nuYUIDO
         hivwDhPoKspBevnIwMGctMyL5ixCSC4HKCbNvK1zsCWv9dkrAhxTjUQvkAJ6nuZtK0
         Yj87vphXjtkmg==
Date:   Wed, 28 Apr 2021 08:59:41 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
Message-ID: <YIj5zcbHBHt7CC8B@kernel.org>
References: <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
 <YIEl8aKr8Ly0Zd3O@kernel.org>
 <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
 <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
 <YIZNq5HMfJ1rWytv@kernel.org>
 <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
 <YIet5X7lgygD9rpZ@kernel.org>
 <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 07:08:59PM +0800, Kefeng Wang wrote:
> 
> On 2021/4/27 14:23, Mike Rapoport wrote:
> > On Mon, Apr 26, 2021 at 11:26:38PM +0800, Kefeng Wang wrote:
> > > On 2021/4/26 13:20, Mike Rapoport wrote:
> > > > On Sun, Apr 25, 2021 at 03:51:56PM +0800, Kefeng Wang wrote:
> > > > > On 2021/4/25 15:19, Mike Rapoport wrote:
> > > > > 
> > > > >       On Fri, Apr 23, 2021 at 04:11:16PM +0800, Kefeng Wang wrote:
> > > > > 
> > > > >           I tested this patchset(plus arm32 change, like arm64 does)
> > > > >           based on lts 5.10，add some debug log, the useful info shows
> > > > >           below, if we enable HOLES_IN_ZONE, no panic, any idea,
> > > > >           thanks.
> > > > > 
> > > > >       Are there any changes on top of 5.10 except for pfn_valid() patch?
> > > > >       Do you see this panic on 5.10 without the changes?
> > > > > 
> > > > > Yes, there are some BSP support for arm board based on 5.10,
> > Is it possible to test 5.12?

Do you use SPARSMEM? If yes, what is your section size?
What is the value if CONFIG_FORCE_MAX_ZONEORDER in your configuration?

-- 
Sincerely yours,
Mike.
