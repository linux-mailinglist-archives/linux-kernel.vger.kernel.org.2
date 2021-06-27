Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB53B5294
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhF0Ifh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 04:35:37 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:56721 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhF0Iff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 04:35:35 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lxQDz-001KP2-HR; Sun, 27 Jun 2021 10:33:07 +0200
Received: from p57ae5209.dip0.t-ipconnect.de ([87.174.82.9] helo=[192.168.178.35])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lxQDz-002ANq-AR; Sun, 27 Jun 2021 10:33:07 +0200
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Daniel Palmer <daniel@0x0f.com>, Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210623133205.GA28589@lst.de>
 <CAFr9PXk84aejj186UNizftwK_w5G1RXLMsSvAEVEYsXi8=yCoA@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <27c78c11-b230-a5b5-6648-6b93daf6afda@physik.fu-berlin.de>
Date:   Sun, 27 Jun 2021 10:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAFr9PXk84aejj186UNizftwK_w5G1RXLMsSvAEVEYsXi8=yCoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.174.82.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/21 5:08 AM, Daniel Palmer wrote:
> On Wed, 23 Jun 2021 at 22:32, Christoph Hellwig <hch@lst.de> wrote
>> I have a vague recollection that you were planning on dropping support
>> for non-devicetree platforms, is that still the case?
> 
> Are there any SH4 boards that actually support DT?
> I'm still using an ecovec24 board(SH7724). I'd love to use DT if
> that's possible.

There is an unmerged patch set by Yoshinori Sato that adds device tree support for SH.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
