Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7C383A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbhEQQg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:36:57 -0400
Received: from foss.arm.com ([217.140.110.172]:57760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244641AbhEQQgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:36:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEA2C106F;
        Mon, 17 May 2021 09:35:30 -0700 (PDT)
Received: from [10.57.66.179] (unknown [10.57.66.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8D063F73D;
        Mon, 17 May 2021 09:35:28 -0700 (PDT)
Subject: Re: [PATCH v5 4/6] drm/sprd: add Unisoc's drm display controller
 driver
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
References: <20210425123607.26537-1-kevin3.tang@gmail.com>
 <20210425123607.26537-5-kevin3.tang@gmail.com>
 <20210430092249.n75to2das5m6p4zb@gilmour>
 <CAFPSGXYJxWJDo1cz+kJB8J9YayGx1hYa=04K5OJ3DHh9ifbuRQ@mail.gmail.com>
 <YKI26bZGAA+ZNLLj@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bc0e3025-60bd-c6b4-117f-592dc1c1a2f0@arm.com>
Date:   Mon, 17 May 2021 17:35:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKI26bZGAA+ZNLLj@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-17 10:27, Joerg Roedel wrote:
> On Fri, Apr 30, 2021 at 08:20:10PM +0800, Kevin Tang wrote:
>> Cc  Robin & Joerg
> 
> This is just some GPU internal MMU being used here, it seems. It doesn't
> use the IOMMU core code, so no Ack needed from the IOMMU side.

Except the actual MMU being used is drivers/iommu/sprd_iommu.c - this is 
just the display driver poking directly at the interrupt registers of 
its associated IOMMU instance. I still think this is wrong, and that it 
should be treated as a shared interrupt, with the IOMMU driver handling 
its own registers and reporting to the client through the standard 
report_iommu_fault() API, especially since there are apparently more 
blocks using these IOMMU instances than just the display.

Robin.
