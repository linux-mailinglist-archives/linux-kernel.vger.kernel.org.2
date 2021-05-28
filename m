Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9E3393D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhE1HG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhE1HGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:06:55 -0400
Received: from resqmta-ch2-01v.sys.comcast.net (resqmta-ch2-01v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11EAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 00:05:20 -0700 (PDT)
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-01v.sys.comcast.net with ESMTP
        id mWWIlAUUKfFsMmWYYlnd7a; Fri, 28 May 2021 07:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1622185518;
        bh=A2OZUP7oixGv9GS34bKrt3L2kgQ0JqLmXuT5mLmdGfc=;
        h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
         MIME-Version:Content-Type;
        b=qXw82WJL6JAmljyjQF1NzjCNhz9ZHw8XqxqEmk9se4gne7myX35Se4gx6Hnc202i5
         gzBZSS8IzqqQzTKYn14lCXx/eqEfODMPCmS7eJQArk7NrsHAvPu1pZ08a3heYtHSTB
         yoYKLHVdRRv4gVkJ2VUuAG1xAQtlP2DhU2x7Cgkx3VaYTZyrQaNc6RCeirMvz8xGFy
         vY1ofrm8JRuX8qCjQOTOxUJmNNI+IdZuoYq9dYRXEH+HX5+aDVsPwANaDd75ocUsW+
         65GpTsbV4jA5PMOXQrpVRmaVol814xuJl/l/emNGNkumxlETUL8rNgbTKYEiwuCpkp
         Yk+rmcd85UYMg==
Received: from [IPv6:2001:558:6040:22:2171:426f:b27e:296d]
 ([IPv6:2001:558:6040:22:2171:426f:b27e:296d])
        by resomta-ch2-20v.sys.comcast.net with ESMTPSA
        id mWYVlCY0SnYgZmWYWlA4Lp; Fri, 28 May 2021 07:05:17 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Reply-To: james@nurealm.net
Subject: Re: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86-ml <x86@kernel.org>
References: <YKWAt1zLM2vfv4Sp@zn.tnic>
 <e7701de5-35f3-da9d-7339-df2de6d8b3cf@nurealm.net> <YKYqABhSTTUG8cgV@zn.tnic>
 <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net> <YKjJfu4kRDflQS5e@zn.tnic>
 <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net> <YKqLSqIM7Gi5x+IA@zn.tnic>
 <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net> <YKtbBXZGpVZS1M4R@zn.tnic>
 <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net> <YK905sC/2cVOYo6I@zn.tnic>
From:   James Feeney <james@nurealm.net>
Message-ID: <e23ae63a-8b5b-f2e7-1037-05808a4d08df@nurealm.net>
Date:   Fri, 28 May 2021 01:05:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK905sC/2cVOYo6I@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 4:31 AM, Borislav Petkov wrote:
> it took me a while to find a box like yours to reproduce on. Anyway,
> here's what looks like the final fix, you could give it a run.

Going through the motions, I can confirm "no surprises".  The final patch is working as expected, with both full power-off boots and "warm" reboots.

On 5/27/21 12:09 PM, Srinivas Pandruvada wrote:
> My guess is that system is booting hot sometimes. SMM started fan or
> some cooling and set a temperature threshold. It is waiting for thermal
> interrupt for temperature threshold, which it never got.

I remind, that when the boot would hang at "Trying to unpack rootfs image as initramfs...", then if the machine is let sit in this state, the fan will begin to run full, off and on, suggesting that maybe the processor is still running and running full power.  Something - maybe the management engine? - is still running, and able to cycle  the fan speed, high and low.  There *must*, then, be "high" and "low" temperature thresholds being reached, as the fan speed cycles, and there is *no* continuation of the boot process when either of these thresholds is reached.  So that interpretation - waiting for thermal interrupt - does not seem to address all the circumstances.

James
