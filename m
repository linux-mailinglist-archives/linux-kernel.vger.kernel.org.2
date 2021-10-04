Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212734216F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhJDTFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbhJDTFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:05:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B239FC061749;
        Mon,  4 Oct 2021 12:04:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0fe4009c23c25c98857304.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e400:9c23:c25c:9885:7304])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 774201EC03D2;
        Mon,  4 Oct 2021 21:03:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633374238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0Nms4auAY3J/VUVtMgcFZcZpc069CLLUqzM+bdeYLVk=;
        b=hB1AzTSsB1cgjjLDziTXH0QngoL3aO0oKRg7k+c5hPO68B1wguz1yl6+QrOaVKi3NLEbrh
        joloXjbwL8oGdS5mMnbNgevjUzDOetUYM2ffcG/crFVIlxNq94ibITOrm89OrC30+oHyJW
        th69nz+SBcfqNS7StlH4IeV54nrlyNI=
Date:   Mon, 4 Oct 2021 21:03:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>
Subject: Re: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
Message-ID: <YVtQG+idmwKn0qLe@zn.tnic>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210803113134.2262882-2-iwona.winiarska@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 01:31:20PM +0200, Iwona Winiarska wrote:
> Baseboard management controllers (BMC) often run Linux but are usually
> implemented with non-X86 processors. They can use PECI to access package
> config space (PCS) registers on the host CPU and since some information,
> e.g. figuring out the core count, can be obtained using different
> registers on different CPU generations, they need to decode the family
> and model.
> 
> Move the data from arch/x86/include/asm/intel-family.h into a new file
> include/linux/x86/intel-family.h so that it can be used by other
> architectures.
> 
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
> To limit tree-wide changes and help people that were expecting
> intel-family defines in arch/x86 to find it more easily without going
> through git history, we're not removing the original header
> completely, we're keeping it as a "stub" that includes the new one.
> If there is a consensus that the tree-wide option is better,
> we can choose this approach.

Why can't the linux/ namespace header include the x86 one so that
nothing changes for arch/x86/?

And if it is really only a handful of families you need, you might just
as well copy them into the peci headers and slap a comment above it
saying where they come from and save yourself all that churn...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
