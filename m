Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEEF40DE49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhIPPnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhIPPnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:43:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 874CE60EE2;
        Thu, 16 Sep 2021 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631806901;
        bh=UAORQUyZIBNMaHBXhptL5A8Hmh9AyOdN3q7kV95S6P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCF98yje8MH2niOd/xPZPnkw0I511PbyOn+8fW1m4vw3BopO+xP+Q7/H0SUpdCvNe
         OXGS79LAYlIo/+8C3sGjUvHamoVuzwL1pWXzUnWY99lSbNfY6+Tuxs94bTtN9/6mZG
         wyQtUcBfSvky0a3PVu8OXNa0Ynm98i93OK9CJszY=
Date:   Thu, 16 Sep 2021 17:41:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, ryabinin.a.a@gmail.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, elver@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 0/3] arm64: support page mapping percpu first chunk
 allocator
Message-ID: <YUNlsgZoLG3g4Qup@kroah.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
 <c06faf6c-3d21-04f2-6855-95c86e96cf5a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c06faf6c-3d21-04f2-6855-95c86e96cf5a@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 04:33:09PM +0800, Kefeng Wang wrote:
> Hi Greg and Andrew， as Catalin saids，the series touches drivers/ and mm/
> but missing
> 
> acks from both of you，could you take a look of this patchset(patch1 change
> mm/vmalloc.c

What patchset?

> and patch2 changes drivers/base/arch_numa.c).

that file is not really owned by anyone it seems :(

Can you provide a link to the real patch please?

thanks,

greg k-h
