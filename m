Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EA836EBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbhD2ODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbhD2ODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:46 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E6C061343
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:02:59 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJd0zQ0z9tjx; Fri, 30 Apr 2021 00:02:57 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Yang Li <yang.lee@linux.alibaba.com>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        oohall@gmail.com, paulus@samba.org
In-Reply-To: <1612236096-91154-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1612236096-91154-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] powerpc/eeh: remove unneeded semicolon
Message-Id: <161970488452.4033873.1131287049605966415.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 11:21:36 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./arch/powerpc/kernel/eeh.c:782:2-3: Unneeded semicolon

Applied to powerpc/next.

[1/1] powerpc/eeh: remove unneeded semicolon
      https://git.kernel.org/powerpc/c/f3d03fc748d4e48f4cd8dea1bfeb173cb3b0c19f

cheers
