Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721553222D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhBVX4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:56:35 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:38101 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231569AbhBVX4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:56:33 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lEL3P-0009pk-HA; Tue, 23 Feb 2021 00:55:51 +0100
Received: from p57bd9049.dip0.t-ipconnect.de ([87.189.144.73] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lEL3P-0047bo-9w; Tue, 23 Feb 2021 00:55:51 +0100
Subject: Re: 5.11 regression: "ia64: add support for TIF_NOTIFY_SIGNAL" breaks
 ia64 boot
To:     Jens Axboe <axboe@kernel.dk>,
        Sergei Trofimovich <slyich@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210222230519.73f3e239@sf>
 <cc658b61-530e-90bf-3858-36cc60468a24@kernel.dk>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <8decdd2e-a380-9951-3ebb-2bc3e48aa1c3@physik.fu-berlin.de>
Date:   Tue, 23 Feb 2021 00:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cc658b61-530e-90bf-3858-36cc60468a24@kernel.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.144.73
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei!

On 2/23/21 12:34 AM, Jens Axboe wrote:
> On 2/22/21 4:05 PM, Sergei Trofimovich wrote:
>> Hia Jens!
>>
>> Tried 5.11 on rx3600 box and noticed it has
>> a problem handling init (5.10 booted fine):
>>
>> INIT: version 2.98 booting
>>
>>    OpenRC 0.42.1 is starting up Gentoo Linux (ia64)
>>
>> mkdir `/run/openrc': Read-only file system
>> mkdir `/run/openrc/starting': No such file or directory
>> mkdir `/run/openrc/started': No such file or directory
>> mkdir `/run/openrc/stopping': No such file or directory
>> mkdir `/run/openrc/inactive': No such file or directory
>> mkdir `/run/openrc/wasinactive': No such file or directory
>> mkdir `/run/openrc/failed': No such file or directory
>> mkdir `/run/openrc/hotplugged': No such file or directory
>> mkdir `/run/openrc/daemons': No such file or directory
>> mkdir `/run[   14.595059] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>> [   14.599059] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>>
>> I suspect we build bad signal stack frame for userspace.

For me, Debian also stopped booting on ia64 with systemd and I bisected it to this
change. Glad to see I'm not the only one.

The changes Jens suggested back then unfortunately didn't help :(.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

