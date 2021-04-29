Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC7A36EBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbhD2ODr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36171 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240110AbhD2ODn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:43 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJb6lklz9tB1; Fri, 30 Apr 2021 00:02:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Yang Li <yang.lee@linux.alibaba.com>, mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        paulus@samba.org
In-Reply-To: <1612236877-104974-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1612236877-104974-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] powerpc/64s: remove unneeded semicolon
Message-Id: <161970488472.4033873.17685966571846339561.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 11:34:36 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./arch/powerpc/platforms/powernv/setup.c:160:2-3: Unneeded semicolon

Applied to powerpc/next.

[1/1] powerpc/64s: remove unneeded semicolon
      https://git.kernel.org/powerpc/c/caea7b833d866e0badf4b12dc41bf9fe6a7295f3

cheers
