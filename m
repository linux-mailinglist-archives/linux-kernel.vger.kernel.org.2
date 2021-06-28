Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407ED3B6683
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhF1QRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhF1QRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:17:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289FBC061574;
        Mon, 28 Jun 2021 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZCLD8MBj2jLFJkWBGVsoZUuZJhShQvPQFbWNVUGT3z0=; b=OWG4fcCamJbgwFHvtjMQhJqJ5v
        tGw1Yms3M5TpPhkJgSRMXsmP13cw2449vGRTFWAXSu9vEU2dLWF5cviOX0Pqz/V/WcE8VI2uTBrHY
        MiOPuIMrxlqZ1rCmddNyMffQ4rYg7HGwn3ZwwjbjbAPvOfvnBLHWJfMfVHQY0RJYNrQ7/j0uzkR11
        IhoZz7ASG8l8lUEWe8oLzu0iNEoEu1wIV4ZPnXK6zSK2znqKwqi5VngW/ISySCJRxCG1f7MBII4+/
        a39D/rhOnhs2q72iJVvrsOucF+yJt9/OMQPU3CdUeqPOLiXPeQ80Ve02hlznhT5J8ZE1nxSJe9sFN
        c2VJteww==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxtum-008Yb0-V2; Mon, 28 Jun 2021 16:15:17 +0000
Subject: Re: [PATCH v5] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, drjones@redhat.com,
        robh+dt@kernel.org, shan.gavin@gmail.com
References: <20210628093411.88805-1-gshan@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <89e25fd7-b323-2092-4151-faba060d4c10@infradead.org>
Date:   Mon, 28 Jun 2021 09:15:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628093411.88805-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 2:34 AM, Gavin Shan wrote:
> The empty memory nodes, where no memory resides in, are allowed.
> For these empty memory nodes, the 'len' of 'reg' property is zero.
> The NUMA node IDs are still valid and parsed, but memory may be
> added to them through hotplug afterwards. I finds difficulty to
> get where it's properly documented.
> 
> So lets add a section for empty memory nodes in NUMA binding
> document. Also, the 'unit-address', equivalent to 'base-address'
> in the 'reg' property of these empty memory nodes is suggested to
> be the summation of highest memory address plus the NUMA node ID.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v5: Separate section for empty memory node
> ---
>  Documentation/devicetree/bindings/numa.txt | 61 +++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
