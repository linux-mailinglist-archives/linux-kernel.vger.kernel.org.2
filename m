Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9837E31FEFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBSSul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhBSSuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:50:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3532864E86;
        Fri, 19 Feb 2021 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1613760599;
        bh=Gx38bxWA0hpuTupGYkgQ7pMKLZgHu2J7x0b4iAi9t00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hlsl7wMcUltsM5a4f/58Iozcxj1MXh6v/B6HOFLw1aAhUnlSQFf7sFanmfOu214gl
         sSQjHlxye19JxZ59jtFXFTzCRbpsAb7dZP7KYnvfq7zue5c3GE6vVbTD+MkHBEbZo1
         d6Qdv6k9vwxLXtoY7/6EAoOPcVwdZ2CN4wzW5jnw=
Date:   Fri, 19 Feb 2021 10:49:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: Re: [PATCH] ntfs: check for valid standard information attribute
Message-Id: <20210219104956.09e869c36f065a78d1901725@linux-foundation.org>
In-Reply-To: <42B686E5-92C1-4AD3-8CF4-E9AB39CBDB7B@tuxera.com>
References: <20210217155930.1506815-1-rkovhaev@gmail.com>
        <42B686E5-92C1-4AD3-8CF4-E9AB39CBDB7B@tuxera.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Feb 2021 01:54:30 +0000 Anton Altaparmakov <anton@tuxera.com> wrote:

> Hi Andrew,
> 
> Can you please push this one upstream?  Thanks a lot in advance!

The changelog is a bit brief...

> 
> > On 17 Feb 2021, at 15:59, Rustam Kovhaev <rkovhaev@gmail.com> wrote:
> > 
> > we should check for valid STANDARD_INFORMATION attribute offset and
> > length before trying to access it

It's a kernel a crash and I assume it results from mounting a corrupted
filesystem?

I think it's worth a cc:stable, yes?


