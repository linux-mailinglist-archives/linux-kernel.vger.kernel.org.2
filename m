Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F3F3BDBEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhGFRJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 13:09:54 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37221 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbhGFRJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 13:09:52 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1m0oXP-002Cmb-J9; Tue, 06 Jul 2021 19:07:11 +0200
Received: from p57bd964c.dip0.t-ipconnect.de ([87.189.150.76] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1m0oXP-0046JR-2i; Tue, 06 Jul 2021 19:07:11 +0200
Subject: Re: add linux-alpha archives to lore.kernel.org?
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
References: <20210706161234.GA797557@bjorn-Precision-5520>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <73238fc5-c9da-df08-aa21-fefee98beef1@physik.fu-berlin.de>
Date:   Tue, 6 Jul 2021 19:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706161234.GA797557@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.76
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn!

On 7/6/21 6:12 PM, Bjorn Helgaas wrote:
> Is there any interest in adding linux-alpha archives to
> lore.kernel.org?  See https://korg.docs.kernel.org/lore.html for
> details.
> 
> I don't know whether alpha is still viable.  Krzysztof has been
> struggling to get a working alpha qemu and userspace working to do
> boot testing of some PCI-related changes, and it's pretty hard.  But
> maybe it's at least of historical interest, since alpha was one of the
> first non-x86 ports?

If Krzysztof has any patches for testing available, I'm happy to give those
a spin on any of my Alphas. I have various AlphaStations available (233,
433au, XP1000 as well as a DS-20E and an ES-40).

> Cc'd you, Eric, since you've done recent alpha fixes and apparently
> have a bootable qemu-system-alpha:
> https://www.spinics.net/lists/linux-alpha/msg07206.html

FWIW, I haven't had any issues installing Debian unstable inside qemu-system-alpha
with the images I am regularly creating for Debian Ports:

> https://cdimage.debian.org/cdimage/ports/snapshots/2021-06-09/

Let me know if you run into any problems.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
