Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF4445256
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 12:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKDLnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 07:43:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:45822 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhKDLnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 07:43:02 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1A4BXrIY010918;
        Thu, 4 Nov 2021 06:33:53 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 1A4BXpu3010915;
        Thu, 4 Nov 2021 06:33:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 4 Nov 2021 06:33:51 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     davidcomponentone@gmail.com, sxwjean@gmail.com,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        nathan@kernel.org, yang.guang5@zte.com.cn, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: use swap() to make code cleaner
Message-ID: <20211104113351.GK614@gate.crashing.org>
References: <20211104061709.1505592-1-yang.guang5@zte.com.cn> <20211104210637.3c424bcc@elm.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104210637.3c424bcc@elm.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 09:06:56PM +1100, Stephen Rothwell wrote:
> On Thu,  4 Nov 2021 14:17:09 +0800 davidcomponentone@gmail.com wrote:
> > From: Yang Guang <yang.guang5@zte.com.cn>
> > 
> > Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> > opencoding it.
> 
> So if swap() is in the above include file, then you should include it.

It is included from kernel.h already (which is included from delay.h).


Segher
