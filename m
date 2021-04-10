Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFDA35AE55
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhDJOaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:30:02 -0400
Received: from ozlabs.org ([203.11.71.1]:57423 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234909AbhDJOaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:30:00 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FHcpG2JTPz9t0l; Sun, 11 Apr 2021 00:29:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Yang Li <yang.lee@linux.alibaba.com>, mpe@ellerman.id.au
Cc:     paulus@samba.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1617672785-81372-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1617672785-81372-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] powerpc/pseries: remove unneeded semicolon
Message-Id: <161806493784.1467223.15378617494093429902.b4-ty@ellerman.id.au>
Date:   Sun, 11 Apr 2021 00:28:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 09:33:05 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./arch/powerpc/platforms/pseries/lpar.c:1633:2-3: Unneeded semicolon

Applied to powerpc/next.

[1/1] powerpc/pseries: remove unneeded semicolon
      https://git.kernel.org/powerpc/c/01ed0510941ae1350c501977132bdb54630614e2

cheers
