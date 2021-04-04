Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820443539FA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhDDUxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 16:53:31 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:42993 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230220AbhDDUxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 16:53:22 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lT9kB-0046DQ-4X; Sun, 04 Apr 2021 22:53:15 +0200
Received: from dynamic-089-012-130-202.89.12.pool.telefonica.de ([89.12.130.202] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lT9kA-001lL7-U1; Sun, 04 Apr 2021 22:53:15 +0200
Subject: Re: [PATCH] ia64: module: fix symbolizer crash on fdescr
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <20210403074803.3309096-1-slyfox@gentoo.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <a83c7df8-5747-9f88-11f8-94834ce36199@physik.fu-berlin.de>
Date:   Sun, 4 Apr 2021 22:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210403074803.3309096-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.12.130.202
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei!

On 4/3/21 9:48 AM, Sergei Trofimovich wrote:
> Noticed failure as a crash on ia64 when tried to symbolize all
> backtraces collected by page_owner=on:
> 
>     $ cat /sys/kernel/debug/page_owner
>     <oops>
> 
>     CPU: 1 PID: 2074 Comm: cat Not tainted 5.12.0-rc4 #226
>     Hardware name: hp server rx3600, BIOS 04.03 04/08/2008
>     ip is at dereference_module_function_descriptor+0x41/0x100
> 
> Crash happens at dereference_module_function_descriptor() due to
> use-after-free when dereferencing ".opd" section header.
> 
> All section headers are already freed after module is laoded
> successfully.
> 
> To keep symbolizer working the change stores ".opd" address
> and size after module is relocated to a new place and before
> section headers are discarded.
> 
> To make similar errors less obscure module_finalize() now
> zeroes out all variables relevant to module loading only.

Typo: s/zeroes/zero/.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

