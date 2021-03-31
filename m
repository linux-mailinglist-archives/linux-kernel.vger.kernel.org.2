Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B504D34F5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhCaBKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhCaBKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:25 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0B6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:24 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XZ00p8z9srY; Wed, 31 Mar 2021 12:10:21 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        paulus@samba.org
In-Reply-To: <1615793724-97015-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1615793724-97015-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] powerpc/pci: fix warning comparing pointer to 0
Message-Id: <161715297797.226945.2209943629327029406.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 15:35:24 +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./arch/powerpc/platforms/maple/pci.c:37:16-17: WARNING comparing pointer
> to 0.

Applied to powerpc/next.

[1/1] powerpc/pci: fix warning comparing pointer to 0
      https://git.kernel.org/powerpc/c/7a0fdc19f2415683f403abee7bb87085d0c624ad

cheers
