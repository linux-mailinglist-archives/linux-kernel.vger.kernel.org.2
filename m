Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7573102C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhBEC1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhBEC1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:27:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D399864E27;
        Fri,  5 Feb 2021 02:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612492016;
        bh=NvTeyLkGnCyH2iLBqvoIV8wdZ2ZVNl8xEvCA36FMQa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbFQDWu0/SSpstCk4fsRb0CvXGO3w0yVyoSu64AWZHxfdhzFaIVAzWvOcK/IfLG73
         KJsIe5L+ye/AF6i9tjwKx0U7lz2US7rbh3OZFoqDypDEvsIAZxLfy+1fY/u2Gc0UFN
         ULrequ+7DJV/WBXt/+1CwxWiK4rXynijPI4TkzrRlzYF+ybIkgibFRTFf5MfckxuZt
         J7qlebEsvInWBIP+nOsTlSvFyAXcLZUaQNhy/3RogleigrcFTlcBO9ls94EpS/e1gg
         9nvEJa8+nxFFMKS03UKKrmCvRCHcYz506K6dnF99gSdW0rbkrzBT7UyDj8z18maNMa
         YhB405qfNSIjg==
Date:   Fri, 5 Feb 2021 04:26:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@suse.de>, linux-sgx@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] x86/sgx: Drop racy follow_pfn check
Message-ID: <YBys6Io1ZbZdzWmj@kernel.org>
References: <20210204184519.2809313-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204184519.2809313-1-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 07:45:19PM +0100, Daniel Vetter wrote:
> References: https://lore.kernel.org/dri-devel/20201127164131.2244124-1-daniel.vetter@ffwll.ch/

What is the difference between this and "Link:" anyway?

/Jarkko
