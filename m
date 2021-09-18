Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02326410674
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhIRMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236070AbhIRMmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:42:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA9486126A;
        Sat, 18 Sep 2021 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631968844;
        bh=181rwogf0AnCsX8gVJgamab5c/PSOFVPKPlSNnoLpyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtlCwGHRBQ86hplSM0c4ckwq/W3X1XUL48cZ7GNLR2wjSd8fyeyRvRa/MNq8ewWxQ
         fYnXiCtyA4TlTYs4LIy3NEdAWe5DxJ5lpD3cEarnqDxe+1HQ3geqBTvC8D0t76GPGG
         dItGHrn9sqc92OcdXKs1olW0EZQlpRvhiOZiiwFk=
Date:   Sat, 18 Sep 2021 14:40:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Daniel Axtens <dja@axtens.net>, jirislaby@kernel.org,
        amit@kernel.org, arnd@arndb.de, osandov@fb.com,
        shile.zhang@linux.alibaba.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v8 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YUXeSUVQRDXzAqhf@kroah.com>
References: <20210818082122.166881-1-xianting.tian@linux.alibaba.com>
 <20210818082122.166881-3-xianting.tian@linux.alibaba.com>
 <87pmu8ehkk.fsf@linkitivity.dja.id.au>
 <6e36640d-b55f-ece4-4cab-437ecec0964a@linux.alibaba.com>
 <614b778b-8486-c20f-d5ed-37cc3b92ada1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <614b778b-8486-c20f-d5ed-37cc3b92ada1@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 08:32:01PM +0800, Xianting Tian wrote:
> hi
> 
> Will you consider to continue the disscussion of this patch? thanks

I do not see a newer version of this series.

thanks,

greg k-h
