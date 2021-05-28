Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70939464D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhE1RUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:20:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhE1RUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:20:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622222341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XXMkpQsbehg+qNK7ZVP15wb2+6lgaNxZ16dFAzSN/o=;
        b=EuPc6Lj5b9dnblHQPS+OwPpQ7zcB8NAYy/kfsmS7bO4+Hx0QEUEPE864ApUB8ZRLpnr+dV
        hUiPgLtRO3dOJKQuh/64xShuq74ZQCjsfxSyBvZWar2Z2KifbCPmhR3eSTxXCe51oAYL0U
        0PvaD/UXFh+vnsiMwS8r/ervoWmCCbS9HjbphDKPzhAQOfrMd2FSCXYqGKqvJgo5IfKd3Y
        00zLxNodFIcWXF7yN2rBZg/84RXs061KXOQsc5fiLFs+9YfPlGI14CATq4IlTY7AfUnJIM
        uBeSV0DB+ydUr8WoXo7eVeC0MgREjx3vWAHq1X0W5lHkf2GUt2dVYrSCB2kx1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622222341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XXMkpQsbehg+qNK7ZVP15wb2+6lgaNxZ16dFAzSN/o=;
        b=gUaXmYnowiug3bVJ1B45870TyHL7gfy7S310FEOStjQTVAwFwRfASjTeLpewx7IkJ6VHkq
        6C60yQ4MUIupmQCw==
To:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, luto@kernel.org, shuah@kernel.org,
        babu.moger@amd.com, dave.kleikamp@oracle.com, linuxram@us.ibm.com,
        bauerman@linux.ibm.com
Subject: Re: [PATCH 0/5] x86/pkeys: PKRU manipulation bug fixes and cleanups
In-Reply-To: <4c3bfc27-a542-8e91-7ccf-4be8b1e6c844@intel.com>
References: <20210527235109.B2A9F45F@viggo.jf.intel.com> <87eedq7u2b.ffs@nanos.tec.linutronix.de> <4c3bfc27-a542-8e91-7ccf-4be8b1e6c844@intel.com>
Date:   Fri, 28 May 2021 19:19:00 +0200
Message-ID: <878s3y7p4r.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28 2021 at 09:11, Dave Hansen wrote:
> On 5/28/21 8:32 AM, Thomas Gleixner wrote:
> There are also the usual concerns that folks doing user-level context
> switching or other insanity get PKRU context switching for "free" when
> it's XSAVE-managed.  Moving away from that could break them.

Both issues are trivial to solve.

We can have pkru enabled in xcr0 and just do not restore it when
returning to user space (clear the mask bit).

When we restore it in sigrestore via xrstor then we read it via rdpkru
afterwards and update task->thread.pkru.

Thanks,

        tglx
