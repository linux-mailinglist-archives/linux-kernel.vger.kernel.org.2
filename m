Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBCB32F5D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhCEWT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:19:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:37902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhCEWTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:19:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 946A0AD73;
        Fri,  5 Mar 2021 22:19:51 +0000 (UTC)
Date:   Fri, 5 Mar 2021 23:19:51 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] scripts/decodecode: Decode 32-bit code correctly
 on x86_64
Message-ID: <20210305221951.GC2896@zn.tnic>
References: <20210305183948.37738-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305183948.37738-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 08:39:48PM +0200, Andy Shevchenko wrote:
> On x86_64 host the objdump uses current architecture which is 64-bit
> and hence decodecode shows wrong instructions.
> 
> Fix it by supplying '-M i386' in case of ARCH i?86 or x86.

At the beginning of the script says:

# e.g., to decode an i386 oops on an x86_64 system, use:
# AFLAGS=--32 decodecode < 386.oops

What kind of oops are you decoding such that that doesn't work for you?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
