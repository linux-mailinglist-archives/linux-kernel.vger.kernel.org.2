Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107A8453C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhKPXI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:08:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38217 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKPXIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637103925; x=1668639925;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Lfc3GEcBsLhSnyg1tnguuBnuE2boC1l87fOb7QPFVqw=;
  b=aVIbv13qRqrogUaARYfxt3Ncmie6y1QcFcSO6GLaU5GeR6eUlBVZibke
   xlhZrDBBxRnWttY2oryLekJGYe+pEtcxte8/3E8ItS2Dk9SPfPW+TxL42
   eBYudmxXjuMp5Ua41gztfxptDOr6nY7rlJyMyqe/Wslh5HTZdJD1hZBab
   8jPn7IUG+7E6OhuTM44vGnGU2dacPm65u12B+B+8R8X6RVvvkqYce80mA
   PI8O7SiaenGXuzYLz3AUvgdbwQ4XPMOe8oPkiAbDd2NZ7Z05KVR7E9tOS
   5euKZPrhBttf03Vd/FvZ3uTTs4/Wd1gI1jAYDyo53AcD9YBuH5btzXAsb
   w==;
X-IronPort-AV: E=Sophos;i="5.87,239,1631548800"; 
   d="scan'208";a="186781789"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2021 07:05:25 +0800
IronPort-SDR: Bhj3Xz+n7V5zbXlsYcV7qowk1/KzUYc9Iw0ZwhgvDV4SbngAed0pvL4Nsts2h4tNhEctJyVSvI
 fjlIi3TIkObXYKPb2Lbj7FnoCrpFpYI+T7ZQX/KIDeyPRh1dAAiRcdxRs7XVD0pv5xXy1y9EUA
 Vp0wiJgDQNPqNz2K9+UK3ptOzGSRBLAP5WqyVMIs1xILRDUWGHM5za9t4UM7snZUpOu+2xEtxL
 LQJCM+qpu0B9g3nhVXMATfV0snhFXM/pVuocZ31SxRYZqWNLWgV0nvUWXYhW+6w1aqsRPrCe9p
 7py7uo7jzp7mtvS0a4nRBlRx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 14:40:27 -0800
IronPort-SDR: Z/0N0In/YEC5OxgbLtwra5CmGZRwz/tVzgcAG4pJ00INQe1caLK77FQZMoPN4RsapVgQX4RjSU
 G8EdRkAJPhe0fQsiz31TWBHlEq6MP8CsgjtwJWdc9TI62Xf2A6P9cF1nk7XzJlO1d6oS4Joq9+
 KKZycAcxI+BZzvB5t1tYWfLfOx6iS8WvAP1hRF5E0tpDR336FBylXtAqSJ0qZKfYHvNizAkqrU
 3EOzEA9QVwvmKCwSz8PYLoU7laaKdO8dd/NRqb3zAw7NA9O8XLAK5UCJruQvhTYkJMcBxTQr4T
 Uv0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 15:05:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hv1qm0LwTz1RtVn
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 15:05:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637103923; x=1639695924; bh=Lfc3GEcBsLhSnyg1tnguuBnuE2boC1l87fO
        b7QPFVqw=; b=RO4whdX0QeutVQCVMw3sjYtpoPQvwR0WAf5yQIj3Z7A26H74KXn
        E56hPiU7rGjOwREsQPC0qeDxElRzfibc6z2j0G+zum5KyU26XdRw0rZJktQrV2Je
        UszDOf9MT4O0fjZhEmM3YcuW2qCqmGvyJAawjGjxRdB4svyMUWHlM7JVd2DIcXDT
        RcIdxhYhXJO1AyZXR9athPK3EH/ktrSxJfgeNQE/dpyw5vDyqexpuEJ3Dk/5Ghvc
        00A1Bz5hvPG8ikvvxky1Pn4UA4TTXESgLCN0uIM9Nxe26Cb4+E6i5Cl5maFrxGse
        f0QGJ2B9gbaprlqGBILLmTc8A/Z3YGbe4Xg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pHWjThBm_9aj for <linux-kernel@vger.kernel.org>;
        Tue, 16 Nov 2021 15:05:23 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hv1qk5qLrz1RtVl;
        Tue, 16 Nov 2021 15:05:22 -0800 (PST)
Message-ID: <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
Date:   Wed, 17 Nov 2021 08:05:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
Content-Language: en-US
To:     Yuji Nakao <contact@yujinakao.com>, linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <87h7ccw9qc.fsf@yujinakao.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <87h7ccw9qc.fsf@yujinakao.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/16 21:44, Yuji Nakao wrote:
> Hello,
> 
> I'm using Arch Linux on MacBook Air 2010. I updated `linux` package[1]
> from v5.14.16 to v5.15.2 the other day, and the boot process stalled
> with the following message.
> 
> ```shell
> :: running early hook [udev]
> Starting version 249.6-3-arch
> :: running hook [udev]
> :: Triggering uevents...
> Waiting 10 seconds for device /dev/sda3 ...
> ERROR: device '/dev/sda3' not found. Skipping fsck.
> :: mounting '/dev/sda' on real root
> mount: /new_root: no filesystem type specified.
> You are now being dropped into an emergency shell.
> sh: can't access tty; job control turned off
> [rootfs ]#
> ```
> 
> In the emergency shell there's no `sda` devices when I type `$ ls
> /dev/`. By downgrading the kernel, boot process works properly.
> 
> See also Arch Linux bug tracker[2]. There are similar reports on
> Apple devices.
> 
> `dmesg` output in the emergency shell is attached. I guess this issue is
> related to libata, so CCed to Damien Le Moal.

I think that this problem is due to recent PCI subsystem changes which broke Mac
support. The problem show up as the interrupts not being delivered, which in
turn result in the kernel assuming that the drive is not working (see the
timeout error messages in your dmesg output). Hence your boot drive detection
fails and no rootfs to mount.

Adding linux-pci list.



> 
> Regards.
> 
> [1] https://archlinux.org/packages/core/x86_64/linux/
> [2] https://bugs.archlinux.org/task/72734
> 
> 


-- 
Damien Le Moal
Western Digital Research
