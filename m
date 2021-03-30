Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C734C34E0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhC3Fgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:36:54 -0400
Received: from verein.lst.de ([213.95.11.211]:57116 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhC3FgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:36:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F79168B05; Tue, 30 Mar 2021 07:36:07 +0200 (CEST)
Date:   Tue, 30 Mar 2021 07:36:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, xen-devel@lists.xensource.com,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, opendmb@gmail.com
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
Message-ID: <20210330053607.GA4863@lst.de>
References: <20210319040333.183827-1-f.fainelli@gmail.com> <20210319130731.GB2624@lst.de> <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com> <alpine.DEB.2.21.2103191718210.439@sstabellini-ThinkPad-T480s> <3db926f4-6047-cc62-8654-a965b8570e75@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3db926f4-6047-cc62-8654-a965b8570e75@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 12:30:42PM -0700, Florian Fainelli wrote:
> Should I toss this in Russell's patch tracker or do you need me to make
> some changes to the patch?

Due to all the other changes in this area I don't think anything but
the swiotlb tree makes much sense here.
