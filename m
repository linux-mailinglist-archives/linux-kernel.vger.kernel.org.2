Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B632CBD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 06:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhCDFV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 00:21:59 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13814 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbhCDFVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 00:21:38 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60406e3a0000>; Wed, 03 Mar 2021 21:20:58 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 05:20:56 +0000
Received: from nvdebian.localnet (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar 2021
 05:20:54 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <hch@infradead.org>,
        <daniel@ffwll.ch>
Subject: Re: [PATCH v3 5/8] mm: Device exclusive memory access
Date:   Thu, 4 Mar 2021 16:20:52 +1100
Message-ID: <2083651.v4LkQjjfQp@nvdebian>
In-Reply-To: <20210302124152.GF4247@nvidia.com>
References: <20210226071832.31547-1-apopple@nvidia.com> <2758096.Z30Q8iEM0t@nvdebian> <20210302124152.GF4247@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614835258; bh=9xq8FfvlXkYAk6gs2678CTOmYbDE3Qd9No1oNQX9mU8=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:Content-Type:
         X-Originating-IP:X-ClientProxiedBy;
        b=pdZOZqStw2k9kfUFThuG08SuNOI+mxN+x8dJw3XY+pM3XOS0KNusvlx7Jc8OmFDTP
         1yLQwxTNBqHauziGi82t9z4NolEGpl064lNuH+GMljlF7shSZzhkX0cOxfFgsigt6T
         xTZCkHQHNCzFRImpRR2ildShmJcGlzmD9S2WSCmPGvQz1AuZIgLx2/B/LWMWl3Uygq
         22c/GzkFoGtVRvbdCQ/ffN0LnSmAmIJ4CxK9n7vAY+aaqagzn/7jl6GH6UwXw4Y54x
         fg7uzjwBKZt6NGVv2TKGuIXUv2P0JIZsIRJkaFC//mQiZr15JDiQyleyVMMn4J8u0M
         pFKBKhvcVbdbQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2 March 2021 11:41:52 PM AEDT Jason Gunthorpe wrote:
> > However try_to_protect() scans the PTEs again under the PTL so checking 
the 
> > mapping of interest actually gets replaced during the rmap walk seems like 
a 
> > reasonable solution. Thanks for the comments.
> 
> It does seem cleaner if you can manage it, the notifier will still be
> needd to program the HW though

Checking during the rmap walk wasn't hard but ultimately pointless. As you say 
a range notifier and lock is required to program the hardware, which requires 
checking the mappings with a mmu notifier sequence anyway.

 - Alistair



