Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87D3E1494
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbhHEMSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241273AbhHEMSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:18:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0D8760F02;
        Thu,  5 Aug 2021 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628165880;
        bh=SnZyEDwSCGcMILVNay8kJLylO4dxnvZ30uP6PD40vys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pq8JnAHT0Nj6CCvb6OWE7mZTidN+sS03OJueS/j2ORg4/13bAzKPlhFvdYox8K1SK
         g/+gUCNoRLLQAHIjX195xj/llPbClQTbV+ewbEh9g0Es0c4wcBuQwf5mJoTVnGOlRo
         7LKvcavL2oHs7S6k6KFfEgkyqHxJlloXQK7G36mM=
Date:   Thu, 5 Aug 2021 14:17:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
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
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH v2 00/15] Introduce PECI subsystem
Message-ID: <YQvW9Ua2PpuDQnji@kroah.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803113134.2262882-1-iwona.winiarska@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 01:31:19PM +0200, Iwona Winiarska wrote:
> Hi Greg,
> 
> This is a second round of patches introducing PECI subsystem.
> I don't think it is ready to be applied right away (we're still
> missing r-b's), but I hope we have chance to complete discussion in
> the 5.15 development cycle. I would appreciate if you could take
> a look.

I will wait to review this when you all feel it is ready so as to not
waste my time finding things that you already know need to be resolved.

thanks,

greg k-h
