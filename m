Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B973623B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbhDPPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:19:16 -0400
Received: from 8bytes.org ([81.169.241.247]:35302 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245441AbhDPPRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:17:24 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 12DF4B5; Fri, 16 Apr 2021 17:16:50 +0200 (CEST)
Date:   Fri, 16 Apr 2021 17:16:46 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, will@kernel.org, yong.wu@mediatek.com,
        kernel@collabora.com, dafna3@gmail.com,
        enric.balletbo@collabora.com
Subject: Re: [PATCH] iommu/mediatek: always enable the clk on resume
Message-ID: <YHmqXi8JHK5CoNNS@8bytes.org>
References: <20210408122842.29009-1-dafna.hirschfeld@collabora.com>
 <YHhA4u7zat3vtJfD@8bytes.org>
 <3c1f184f-e666-5198-e89e-c3774917c6d4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c1f184f-e666-5198-e89e-c3774917c6d4@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:47:01PM +0200, Dafna Hirschfeld wrote:
> Hi,
> I sent v2, removing the word 'comment' from the 'Fixes' tag
> after a problem report from Stephen Rothwell,
> could you replace v1 with v2?

Replaced it, thanks.
