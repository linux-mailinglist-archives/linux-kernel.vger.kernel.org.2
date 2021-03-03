Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B1A32BE3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhCCRMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240903AbhCCNWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:22:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC9EF601FF;
        Wed,  3 Mar 2021 13:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614777171;
        bh=v9xaJ8OzavzrXrL/dKUBylNt92OheY14Ppsso/1Q/dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sn/QA8i8arLz4hdx+s5S2lrDRWJXrPVAVOX3sCqEWIr2aQnLwRfXea7LSFluzXzRr
         k1buGV6247pKtkspUZJVmY1/AZ9TgebakIkCAwrnccZt3yXjlHtJHRqcO3ohM5QK/H
         sp+8qB/mb5NzwC7qygYrMzLrP4DR7So5g0q0+L+SVaNNN/y3tpKCRqIEZQyC2BPUiQ
         UhDJUNQdFFDerv83QcFvGvSdZOk++IvA5JQ5U5Oo/Y413llEIvI+PaLBifQuh/3SHT
         XVAyj3HoSgXS0MrKLJ6ExACvAC5AyII7eLv3/vYJ/djwR3dO9eaBfeZjnsdRZAF3u3
         vZcm3XVsj5oaw==
Date:   Wed, 3 Mar 2021 13:12:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Li Huafei <lihuafei1@huawei.com>, gregory.herrero@oracle.com,
        catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, zhangjinhao2@huawei.com,
        yangjihong1@huawei.com, xukuohai@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Chen Jun <chenjun102@huawei.com>
Subject: Re: [PATCH] recordmcount: Fix the wrong use of w* in
 arm64_is_fake_mcount()
Message-ID: <20210303131244.GA18661@willie-the-truck>
References: <20210225140747.10818-1-lihuafei1@huawei.com>
 <20210225094426.7729b9cc@gandalf.local.home>
 <20210225160116.GA13604@willie-the-truck>
 <20210302173058.28fd3d36@gandalf.local.home>
 <20210302173335.71eded37@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302173335.71eded37@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 05:33:35PM -0500, Steven Rostedt wrote:
> On Tue, 2 Mar 2021 17:30:58 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I just realized that I received this patch twice, and thought it was the
> > same patch! Chen was three days ahead of you, so he get's the credit ;-)
> > 
> >  https://lore.kernel.org/r/20210222135840.56250-1-chenjun102@huawei.com
> 
> I'm applying this patch (same one here but came earlier).
> 
> Will, you still OK with your acked-by on it?

Absolutely!

Will
