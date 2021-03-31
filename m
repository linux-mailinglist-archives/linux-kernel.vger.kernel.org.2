Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7F34F5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhCaBLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:25 -0400
Received: from ozlabs.org ([203.11.71.1]:40965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233317AbhCaBKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:45 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xz2kppz9sf9; Wed, 31 Mar 2021 12:10:40 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        paulus@samba.org
In-Reply-To: <1615793096-83758-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1615793096-83758-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] powerpc/xive: use true and false for bool variable
Message-Id: <161715297781.226945.7968027542585068841.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 15:24:56 +0800, Yang Li wrote:
> fixed the following coccicheck:
> ./arch/powerpc/sysdev/xive/spapr.c:552:8-9: WARNING: return of 0/1 in
> function 'xive_spapr_match' with return type bool

Applied to powerpc/next.

[1/1] powerpc/xive: use true and false for bool variable
      https://git.kernel.org/powerpc/c/9214cf0f48cac3c6aa86f34e14969b5eccb72fad

cheers
