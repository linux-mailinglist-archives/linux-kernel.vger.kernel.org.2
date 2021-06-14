Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAEC3A67D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhFNNbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:31:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbhFNNbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:31:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 259ED6D;
        Mon, 14 Jun 2021 06:29:15 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A18ED3F719;
        Mon, 14 Jun 2021 06:29:13 -0700 (PDT)
Subject: Re: Regression in at least 5.10.y and mainline: Firewire audio
 interface fails to work properly (when booted under Xen)
To:     Salvatore Bonaccorso <carnil@debian.org>,
        =?UTF-8?B?5bCP5aSq?= <nospam@kota.moe>,
        Jianxiong Gao <jxgao@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        xen-devel@lists.xenproject.org
Cc:     989778-maintonly@bugs.debian.org
References: <162352833546.2353.230557992597997974.reportbug@home.kota.moe>
 <YMWl4UnFBAVRDnys@eldamar.lan>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2f7c7d36-b6f4-f8ab-756e-a563fa03b9e4@arm.com>
Date:   Mon, 14 Jun 2021 14:29:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMWl4UnFBAVRDnys@eldamar.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-13 07:29, Salvatore Bonaccorso wrote:
> A user in Debian reported the above issue, which was reproducible with
> 5.13-rc5 and 5.10.y as packaged in Debian and found that 85a5a6875ca9
> ("swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single") that
> introduced the issue.

Sounds like it's probably the same thing as being discussed over here:

https://lore.kernel.org/linux-iommu/2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com/

Robin.
