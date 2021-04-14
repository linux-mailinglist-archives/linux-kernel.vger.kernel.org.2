Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F56B35F47C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhDNNF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhDNNFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:05:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 06:05:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e8f0048923c048b418a85.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8f00:4892:3c04:8b41:8a85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9DEEB1EC0258;
        Wed, 14 Apr 2021 15:05:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618405514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pDuekF9w0MXd1qItoeFQ9QxXI7Xjo0WpNUInm4OD5SM=;
        b=gqITvJI1pOnfp6ueiuu+dKNSWjZG9ml543//8THt7p8wjk2BrwH8JGAXY8GI/KQezikMhP
        uuWiOhv5p4q9YuJLTybHUAZJEHdw1tN/A7bCMpe9tm/Ek+KRxUO2MUHHJy/upYGo0TWq3R
        QzheHW9yXsTHICoO4yesmocUjMWgln8=
Date:   Wed, 14 Apr 2021 15:05:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEoIOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Message-ID: <20210414130509.GF10709@zn.tnic>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-4-tony.luck@intel.com>
 <20210407211816.GP25319@zn.tnic>
 <20210407214310.GA479383@agluck-desk2.amr.corp.intel.com>
 <20210408084958.GC10192@zn.tnic>
 <20210408170852.GA485019@agluck-desk2.amr.corp.intel.com>
 <20210413100722.GC16519@zn.tnic>
 <bd3dbae888584ce58a8d6e4b549b29ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd3dbae888584ce58a8d6e4b549b29ce@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:13:03PM +0000, Luck, Tony wrote:
> Even if no applications ever do anything with it, it is still useful to avoid
> crashing the whole system and just terminate one application/guest.

True.

> There's one more item on my long term TODO list. Add fixups so that
> copy_to_user() from poison in the page cache doesn't crash, but just
> checks to see if the page was clean .. .in which case re-read from the
> filesystem into a different physical page and retire the old page ... the
> read can now succeed. If the page is dirty, then fail the read (and retire
> the page ... need to make sure filesystem knows the data for the page
> was lost so subsequent reads return -EIO or something).

Makes sense.

> Page cache occupies enough memory that it is a big enough
> source of system crashes that could be avoided. I'm not sure
> if there are any other obvious cases after this ... it all gets into
> diminishing returns ... not really worth it to handle a case that
> only occupies 0.00002% of memory.

Ack.

> See above. With core counts continuing to increase, the cloud service
> providers really want to see fewer events that crash the whole physical
> machine (taking down dozens, or hundreds, of guest VMs).

Yap.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
