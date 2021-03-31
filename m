Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB0034F5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhCaBKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:47 -0400
Received: from ozlabs.org ([203.11.71.1]:51867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233096AbhCaBKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:21 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XW5ZGgz9srX; Wed, 31 Mar 2021 12:10:19 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Denis Efremov <efremov@linux.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210305112807.26299-1-efremov@linux.com>
References: <20210305112807.26299-1-efremov@linux.com>
Subject: Re: [PATCH] powerpc/ptrace: Remove duplicate check from pt_regs_check()
Message-Id: <161715296614.226945.7764784471817464354.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:26 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 14:28:07 +0300, Denis Efremov wrote:
> "offsetof(struct pt_regs, msr) == offsetof(struct user_pt_regs, msr)"
> checked in pt_regs_check() twice in a row. Remove the second check.

Applied to powerpc/next.

[1/1] powerpc/ptrace: Remove duplicate check from pt_regs_check()
      https://git.kernel.org/powerpc/c/0b71b37241784c309bea6bd6a9d2027943c4ab94

cheers
