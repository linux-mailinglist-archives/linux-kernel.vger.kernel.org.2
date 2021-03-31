Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2963034F5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhCaBLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:07 -0400
Received: from ozlabs.org ([203.11.71.1]:34051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233256AbhCaBKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:37 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xr2p72z9srY; Wed, 31 Mar 2021 12:10:34 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210325200820.16594-1-rdunlap@infradead.org>
References: <20210325200820.16594-1-rdunlap@infradead.org>
Subject: Re: [PATCH] selftests: powerpc: unmark non-kernel-doc comments
Message-Id: <161715298092.226945.12479557880840484464.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 13:08:20 -0700, Randy Dunlap wrote:
> Drop the 'beginning of kernel-doc' notation markers (/**)
> in places that are not in kernel-doc format.

Applied to powerpc/next.

[1/1] selftests: powerpc: unmark non-kernel-doc comments
      https://git.kernel.org/powerpc/c/dfc4ae3372182a168146745def03d877f31fcf2f

cheers
