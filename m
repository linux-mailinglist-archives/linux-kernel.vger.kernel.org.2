Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665CF3A274C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFJIml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:42:41 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:57070 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFJImj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:42:39 -0400
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D51C9AC8EE3;
        Thu, 10 Jun 2021 10:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1623314442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZ5PoN9svtHAXgn4Aog0MvH+fbi6k6ZsouWk2RBwJrE=;
        b=jX7jKEvlifW0Ktpr778aXv8q6EQHCGrajesTO4jQbbbcv/WI8d0ObiNGAYLy7aXDJ33HFx
        gbbRv3zrc6likDWQ1NtNp6uPg+aQsddTa9pOOyMvDinqJKunbx6UwBPbDBVJ6+eJRNhKmh
        s5XyeJN6+lGICdeMGjGmh/nZ1yR6V7c=
Date:   Thu, 10 Jun 2021 10:40:41 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: repeating [Hardware Error]: Corrected error, no action required.
Message-ID: <20210610084041.42a73peuwy7ivyt4@spock.localdomain>
References: <cba1f224-7a21-7a1f-3f82-6f7e98a274d0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cba1f224-7a21-7a1f-3f82-6f7e98a274d0@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Wed, Jun 09, 2021 at 08:27:26PM +0200, Toralf Förster wrote:
> My syslog messages show at a hardened Gentoo
> 
> # uname -a
> Linux mr-fox 5.12.9 #8 SMP Thu Jun 3 17:59:32 CEST 2021 x86_64 AMD Ryzen
> 9 5950X 16-Core Processor AuthenticAMD GNU/Linux
> mr-fox ~ #
> 
> repeating entries every 5 mins like (always same address
> 0x000000031fb566e0):
> 
> Jun  9 16:21:24 mr-fox kernel: mce: [Hardware Error]: Machine check
> events logged
> Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: Corrected error, no
> action required.
> Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: CPU:0 (19:21:0)
> MC17_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0xdc2040000000011b
> Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: Error Addr:
> 0x000000031fb566e0
> Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: IPID:
> 0x0000009600050f00, Syndrome: 0x33fa01000a800101
> Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: Unified Memory
> Controller Ext. Error Code: 0, DRAM ECC error.
> Jun  9 16:21:24 mr-fox kernel: EDAC MC0: 1 CE on mc#0csrow#1channel#0
> (csrow:1 channel:0 page:0xcaed59 offset:0x8e0 grain:64 syndrome:0x100)
> Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: cache level: L3/GEN,
> tx: GEN, mem-tx: RD
> 
> 
> A hw mem check by Hetzner didn't found anything.

Did they run memtest in a loop for 10 times at least?

> May I asked whether I sahll worry about or not ?

If the reported page is indeed the same, then probably yes, you should
worry.

-- 
  Oleksandr Natalenko (post-factum)
