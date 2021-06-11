Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0603A49A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFKT4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:56:44 -0400
Received: from foss.arm.com ([217.140.110.172]:39120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhFKT4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:56:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6312D1FB;
        Fri, 11 Jun 2021 12:54:44 -0700 (PDT)
Received: from bogus (unknown [10.57.73.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 576DC3F719;
        Fri, 11 Jun 2021 12:54:43 -0700 (PDT)
Date:   Fri, 11 Jun 2021 20:54:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/64: drop redundant defination of
 spin_until_cond
Message-ID: <20210611195422.uwtm5px5lr5pkljb@bogus>
References: <1fff2054e5dfc00329804dbd3f2a91667c9a8aff.1623438544.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fff2054e5dfc00329804dbd3f2a91667c9a8aff.1623438544.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 07:10:57PM +0000, Christophe Leroy wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> linux/processor.h has exactly same defination for spin_until_cond.
> Drop the redundant defination in asm/processor.h
>

Wow you must be real good at ML archaeology, this must have been at-least
3+ years old. I found this when I wanted to you spin_until_cond. Thanks
anyways for digging the original patch, nobody would have remembered even
if you posted fresh 😉.

-- 
Regards,
Sudeep
