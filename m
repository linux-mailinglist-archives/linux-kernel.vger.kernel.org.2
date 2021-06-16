Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4893A92F1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhFPGn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhFPGn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:43:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C927660FE8;
        Wed, 16 Jun 2021 06:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623825710;
        bh=k+zi3tBcdCGiZHiNIoER+sxJM5mXn3Fn0SDfBbjp7zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBLGCSA8AVaRZXFyFzhARKz0guQMcRfsgjx15TIaoyuuVKAZusvF6/m3NgId5VuJi
         Mq5WMSenAJ5VGsqJTBzhwPmfpYAdn9z5Gb4qcvEUIbG5Sy0o+Lky1E9VmJ8wRo/tZY
         6q1ksMilZT4kUSGm3gnF+09lgpD0yVFl3St2ISzk=
Date:   Wed, 16 Jun 2021 08:41:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 1/3] mcb: Use DEFINE_RES_MEM() to simplify code
Message-ID: <YMmdKrnX5iIaUZcC@kroah.com>
References: <cover.1623768541.git.johannes.thumshirn@wdc.com>
 <1eefa01948355a890b18a68c1eb6a90dc9dc6a87.1623768541.git.johannes.thumshirn@wdc.com>
 <YMjKZhC0vHkikUQs@kroah.com>
 <454b2783-8415-22f4-876a-156973480cd6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454b2783-8415-22f4-876a-156973480cd6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 09:31:37AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/6/15 23:42, Greg Kroah-Hartman wrote:
> > On Tue, Jun 15, 2021 at 11:55:28PM +0900, Johannes Thumshirn wrote:
> >> From: Zhen Lei <thunder.leizhen@huawei.com>
> >>
> >> The value of '.end' should be "start + size - 1". So the previous writing
> >> should have omitted subtracted 1.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
> >> ---
> >>  drivers/mcb/mcb-lpc.c | 13 ++-----------
> >>  1 file changed, 2 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
> >> index 506676754538..53decd89876e 100644
> >> --- a/drivers/mcb/mcb-lpc.c
> >> +++ b/drivers/mcb/mcb-lpc.c
> >> @@ -105,17 +105,8 @@ static int mcb_lpc_create_platform_device(const struct dmi_system_id *id)
> >>  	return ret;
> >>  }
> >>  
> >> -static struct resource sc24_fpga_resource = {
> >> -	.start = 0xe000e000,
> >> -	.end = 0xe000e000 + CHAM_HEADER_SIZE,
> >> -	.flags = IORESOURCE_MEM,
> >> -};
> >> -
> >> -static struct resource sc31_fpga_resource = {
> >> -	.start = 0xf000e000,
> >> -	.end = 0xf000e000 + CHAM_HEADER_SIZE,
> >> -	.flags = IORESOURCE_MEM,
> >> -};
> >> +static struct resource sc24_fpga_resource = DEFINE_RES_MEM(0xe000e000, CHAM_HEADER_SIZE);
> >> +static struct resource sc31_fpga_resource = DEFINE_RES_MEM(0xf000e000, CHAM_HEADER_SIZE);
> > 
> > Does this simplify stuff, or does it fix a bug with the existing
> > definition?
> 
> It does not fix a bug, the actual value of .end should be "0xe000e000 + CHAM_HEADER_SIZE - 1".
> There is no functional problem, just a little more memory. So it's just been corrected in the
> process of simplification.
> 
> Do you think it's necessary to split it into two patches?

No need, I just want to know if this is a fix that needs to go to older
kernels as well.  The text was very vague.


thanks,

greg k-h
