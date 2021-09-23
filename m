Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765F6416196
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbhIWPAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241867AbhIWPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:00:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D154C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:59:14 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d6800d149a76d0b562da3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:d149:a76d:b56:2da3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EFEC1EC056A;
        Thu, 23 Sep 2021 16:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632409148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T/zbVuqZ1HlM/RdSdAFVocNiGHn+dqQu0D+Cgr2+0TY=;
        b=fcMBC6ju6ENW9WoA1WUjXfPEd5eRH5ROjdyALMm5iqLvZmJ41bPYUV7LXb00Zjbtz7iVEg
        ltBIIZ8KLvu3+6ZyvRgzJMfpQ+XpTan1UDqA05uGlaJGTwmW98U48L5OKWtCD+JQ7vmxsD
        wEj6E6tA93ty97Bge2XQFhSp6dN19o0=
Date:   Thu, 23 Sep 2021 16:59:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Marcus =?utf-8?Q?R=C3=BCckert?= <mrueckert@suse.com>
Subject: Re: [PATCH] x86/umip: Downgrade warning messages to debug loglevel
Message-ID: <YUyWNnzogxflFIwd@zn.tnic>
References: <20210907200454.30458-1-bp@alien8.de>
 <20210911011459.GA11980@ranerica-svr.sc.intel.com>
 <YTx0+0pfyzHuX80L@zn.tnic>
 <20210913213836.GA10627@ranerica-svr.sc.intel.com>
 <YUDTCgEOZ3JOMSl7@zn.tnic>
 <20210915113410.GA7130@ranerica-svr.sc.intel.com>
 <YUIHPOmSQyZSkMaC@zn.tnic>
 <20210916002735.GA9330@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916002735.GA9330@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 05:27:35PM -0700, Ricardo Neri wrote:
> FWIW, Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thx.

So this thing is not completely quiet:

# dmesg -l err,warn,notice -x
...
kern  :notice: [   17.974749] random: dd: uninitialized urandom read (512 bytes read)
kern  :notice: [   18.063596] random: dbus-daemon: uninitialized urandom read (12 bytes read)
kern  :notice: [   18.065212] random: dbus-daemon: uninitialized urandom read (12 bytes read)
kern  :notice: [   20.161303] random: crng init done
kern  :warn  : [  144.505690] umip_printk: 403267 callbacks suppressed
^^^^^^^^^^^^^^^^

so at least it says that umip is being busy logging stuff and if one
wants to see them, one can do:

# dmesg -l err,warn,notice,debug -x
kern  :notice: [   17.974749] random: dd: uninitialized urandom read (512 bytes read)
kern  :notice: [   18.063596] random: dbus-daemon: uninitialized urandom read (12 bytes read)
kern  :notice: [   18.065212] random: dbus-daemon: uninitialized urandom read (12 bytes read)
kern  :notice: [   20.161303] random: crng init done
kern  :debug : [   24.501738] umip: sidt[1882] ip:5570e245a083 sp:7ffdbe080390: SIDT instruction cannot be used by applications.
kern  :debug : [   24.501743] umip: sidt[1882] ip:5570e245a083 sp:7ffdbe080390: For now, expensive software emulation returns the result.
kern  :debug : [   24.502566] umip: sidt[1883] ip:55c63b5ff083 sp:7fffde333160: SIDT instruction cannot be used by applications.
kern  :debug : [   24.502569] umip: sidt[1883] ip:55c63b5ff083 sp:7fffde333160: For now, expensive software emulation returns the result.
kern  :debug : [   24.503259] umip: sidt[1884] ip:55e4bff9e083 sp:7ffecb324530: SIDT instruction cannot be used by applications.
kern  :warn  : [  144.505690] umip_printk: 403267 callbacks suppressed
kern  :debug : [  144.505692] umip: sidt[9170] ip:560d1457f083 sp:7fff1d5d9df0: SIDT instruction cannot be used by applications.
kern  :debug : [  144.506484] umip: sidt[9170] ip:560d1457f083 sp:7fff1d5d9df0: For now, expensive software emulation returns the result.
kern  :debug : [  144.507218] umip: sidt[9171] ip:556f4549c083 sp:7ffc146ab2a0: SIDT instruction cannot be used by applications.
kern  :debug : [  144.507221] umip: sidt[9171] ip:556f4549c083 sp:7ffc146ab2a0: For now, expensive software emulation returns the result.
kern  :debug : [  144.507951] umip: sidt[9172] ip:55662fdd8083 sp:7ffefcdbc0d0: SIDT instruction cannot be used by applications.

ok, lemme queue it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
