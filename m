Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86C3B2A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhFXI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231936AbhFXI3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:29:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91EA260230;
        Thu, 24 Jun 2021 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624523210;
        bh=QsZCbmjyeZ6KeWiEMbwAM/b7482GJwwssD6Ntfd4XKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLWYaLhoZTb3h6Ws/owmwtkcAX7qHWV9PyaKi0LrJlTMLkB3KwNIz32PeNNgy4NxW
         3atG0LokhOF7K2OR0WK0thRGfrhYwfEYLEhL1GWNGyu+9ZqcX+ePeXdBB/eDr1mwEH
         0mxDN7+leYYPk3i5nkzW2ND2Ae+Hcxyb5YC8EmHTpJw9BUMEcN8SGj+QJwxftnryLf
         DU1ndCP7hHL1zPwnwc+v5ez/PwqDG/SIYqZu6U2bMKShVkH1V7g/CoNFbmTqYmzfjX
         wTOqBfUsozVZRaR3nUrGU8BlbU3S/4SRw5t9YoWaDfLkfTvcidxJCIF8kWb5FPjB4R
         aZHJdZLZrgtyA==
Date:   Thu, 24 Jun 2021 09:26:46 +0100
From:   Will Deacon <will@kernel.org>
To:     wubian <wubian@uniontech.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] uio: Fix bus error that access memory mapped by physical
Message-ID: <20210624082645.GA1169@willie-the-truck>
References: <20210623065214.4525-1-wubian@uniontech.com>
 <YNLfVX5YVWouP1qD@kroah.com>
 <5a2737e1-2a77-98b0-eea7-eae04d7a9fba@uniontech.com>
 <YNL99ImFxKADvDIB@kroah.com>
 <a6562bd2-9f42-1b39-bfe6-83f1cf53f72b@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6562bd2-9f42-1b39-bfe6-83f1cf53f72b@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[FYI: this landed in my spam]

On Wed, Jun 23, 2021 at 08:32:55PM +0800, wubian wrote:
> On 2021/6/23 下午5:25, Greg KH wrote:
> > On Wed, Jun 23, 2021 at 04:49:16PM +0800, wubian wrote:
> > > I haven’t found this problem on the x86 platform. I only found it on arm64.
> > > I used gdb to track memset and found that the bus error in
> > > glibc/sysdeps/aarch64/memset.S: dc zva, dst; reference "Architecture
> > > Reference ManualArmv8, for Armv8-A architecture profile" manual found that
> > > the dc assembly instruction（performance optimization） is related to the
> > > operation of the cache, that is to say, there is a bus error in the
> > > operation of the cache, and then check the "ARM Cortex-A Series Programmer's
> > > Guide for ARMv8-A " manual, found that the armv8 architecture cache has data
> > > cache and write buffer, and there are two operation modes write-back and
> > > write-through, write operations in these two modes, the data flow will pass
> > > through the write buffer, and pgprot_noncached will prohibit data Cache and
> > > write buffer, this causes the dc command in memset to fail (bus error), and
> > > pgprot_writecombine does not prohibit write buffer, so the dc command in
> > > memset is successfully operated when pgprot_writecombine is used.
> > 
> > Are you sure this is not just a specific hardware platform issue?  Are
> > you sure this is going to be correct for _ALL_ arm64 systems?
> > 
> > Perhaps get the arm64 developers to agree with what is happening here as
> > this is the first time anyone has reported this problem.
> > 
> > What specific platform are you using that this issue happens on?
> > 
> I apologize for the kernel mail reply format problem, I will pay attention
> to it in the future.
> 
> I only found this problem on Huawei Kunpeng 920 cpu at present, and found
> that some people
> have raised similar problems on the Internet.
> link：https://github.com/ikwzm/udmabuf/issues/31
> 
> @Catalin Marinas @Will Deacon Has anyone reported a similar problem on the
> arm64 platform?

The fundamental issue here (which seems related to [1]) is that you're
mapping MMIO into userspace and then expecting to be able to use standard
string routines such as memset and memcpy on them. This won't work, as the
architecture (and likely the MMIO endpoint) has restrictions on things like
unaligned accesses, access size and atomicity for MMIO that do not apply to
normal memory.

Returning non-cacheable rather than device mappings from UIO is likely to
cause more problems than it solves, as it permits the CPU to make
speculative accesses to the region. If the mapped device has side-effects,
then this will end in disaster.

So I don't think this patch is correct, and I think that if you're exposing
MMIO to userspace then you need to be very careful about what you do with
it rather than blindly pass MMIO pointers into standard routines that expect
to operate on normal memory. There's a reason drivers usually live in the
kernel :)

Thanks,

Will

[1] https://lore.kernel.org/r/da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com
