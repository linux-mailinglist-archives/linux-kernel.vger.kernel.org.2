Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3033B16C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhFWJ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhFWJ12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:27:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5B9661002;
        Wed, 23 Jun 2021 09:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624440311;
        bh=KcSGnJ6rJfoN2ADeWGsdDAthEe0YOdL1YycYES+WbDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUFAhVxTGqyrt6Yfy14/y6hlDurgxx5x2lV0zdqMBQcA1sBPqTPVQ5bAxHLVjoTOy
         3cRcFsskPoAM09Dzf8MS3B+CRrSrPpeaVDWU4jlDmskIgFd4Hsf8aNpasKUJxPhED5
         w644uHF7CoSbDGFhiTLrYmQvM1uCh6etpg8p3rNc=
Date:   Wed, 23 Jun 2021 11:25:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wubian <wubian@uniontech.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: Fix bus error that access memory mapped by physical
Message-ID: <YNL99ImFxKADvDIB@kroah.com>
References: <20210623065214.4525-1-wubian@uniontech.com>
 <YNLfVX5YVWouP1qD@kroah.com>
 <5a2737e1-2a77-98b0-eea7-eae04d7a9fba@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a2737e1-2a77-98b0-eea7-eae04d7a9fba@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jun 23, 2021 at 04:49:16PM +0800, wubian wrote:
> First,thanks for your reply
> 
> I haven’t found this problem on the x86 platform. I only found it on arm64.
> I used gdb to track memset and found that the bus error in
> glibc/sysdeps/aarch64/memset.S: dc zva, dst; reference "Architecture
> Reference ManualArmv8, for Armv8-A architecture profile" manual found that
> the dc assembly instruction（performance optimization） is related to the
> operation of the cache, that is to say, there is a bus error in the
> operation of the cache, and then check the "ARM Cortex-A Series Programmer's
> Guide for ARMv8-A " manual, found that the armv8 architecture cache has data
> cache and write buffer, and there are two operation modes write-back and
> write-through, write operations in these two modes, the data flow will pass
> through the write buffer, and pgprot_noncached will prohibit data Cache and
> write buffer, this causes the dc command in memset to fail (bus error), and
> pgprot_writecombine does not prohibit write buffer, so the dc command in
> memset is successfully operated when pgprot_writecombine is used.

Are you sure this is not just a specific hardware platform issue?  Are
you sure this is going to be correct for _ALL_ arm64 systems?

Perhaps get the arm64 developers to agree with what is happening here as
this is the first time anyone has reported this problem.

What specific platform are you using that this issue happens on?

thanks,

greg k-h
