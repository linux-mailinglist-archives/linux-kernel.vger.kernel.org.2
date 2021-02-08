Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A18313E8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhBHTKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhBHRtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:49:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56F7664E28;
        Mon,  8 Feb 2021 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612806519;
        bh=zcrfBV/hRGvlrzEODhD3RrXvNDEl99yvRmZk381j244=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mIAzVMKyC3e53aP+R23D+0TBSR5bgfCs+hMu9RwVHQTmwXPfRsbEWaqb55G7AANzq
         3ixfmgywC//f0R/ke6GQJTWbahXArazeKLWPFPnEzuHztrZmOtvlekb60uwMMy7IkG
         gP66ciCkAkhCtaPMI1OHzM/U3hAcqE/Jq/xLI1jU=
Date:   Mon, 8 Feb 2021 09:48:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-Id: <20210208094838.74c7ca910a16f33aacacb4b0@linux-foundation.org>
In-Reply-To: <YCE3cjDNOvpeCCeA@ubuntu-x1>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
        <20210207144831.lsrm74ypbz7i37uz@box>
        <YCE3cjDNOvpeCCeA@ubuntu-x1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 07:06:58 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:

> On Sun, Feb 07, 2021 at 05:48:31PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Feb 05, 2021 at 05:06:20PM -0600, Seth Forshee wrote:
> > > This feature requires ino_t be 64-bits, which is true for every
> > > 64-bit architecture but s390, so prevent this option from being
> > > selected there.
> > 
> > Quick grep suggests the same for alpha. Am I wrong?
> 
> No, it appears you are right. Looks like my grep missed alpha somehow.
> 
> Andrew, do you prefer an additional patch or an updated version of the
> previous patch?

Doesn't matter much.  A second patch for Alpha would be best, I guess. 
Thanks.

