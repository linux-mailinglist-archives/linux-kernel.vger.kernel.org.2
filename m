Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B5D39A943
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhFCRf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhFCRfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:35:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D919600EF;
        Thu,  3 Jun 2021 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622741621;
        bh=/UCRcRzeBqTtEan+hKQQytxiVuqK6B0k/wsPUAzHz04=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MFTkiPeD9pCOCOqPoN5+CzEhXI99TCb/39pyxVHmsIu2k1fk8H/SddDyBYcnAZjdS
         xdHSwL+7enafUpzCDPPWhuip9DqrJ3fgknH6swTLZGTiCVZtJ3H91+7Jf4luWtvAsM
         t4nClvFCW1FHgSSW6qB2ZrbsTKofuoGjV47JEPaSNXeuxOGPapBCUc9lFVQruBLTTW
         2Ws3Gqt1g/sEt2+i9gvAEBowH0WoN7WHRtG++WdSXO3iwwOv55pJU+p4KiINspejbD
         vefQqFY64InbySwuXs6s50UHsk9hQWmicWTdvP4UZup7oMXGa2YBPm9L/nb8oaeS9g
         ITvifMb0XbFfw==
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
Date:   Thu, 3 Jun 2021 10:33:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-2-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 5:41 PM, Andi Kleen wrote:
> Only allow split mode when in a protected guest. Followon
> patches harden the split mode code paths, and we don't want
> an malicious host to force anything else. Also disallow
> indirect mode for similar reasons.

I read this as "the virtio driver is buggy.  Let's disable most of the
buggy code in one special case in which we need a driver without bugs.
In all the other cases (e.g. hardware virtio device connected over
USB-C), driver bugs are still allowed."

Can we just fix the driver without special cases?

--Andy
