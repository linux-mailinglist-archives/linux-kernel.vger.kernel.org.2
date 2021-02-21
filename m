Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9164320956
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhBUJWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 04:22:45 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:58579 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhBUJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 04:22:43 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lDkwA-001YAM-JI; Sun, 21 Feb 2021 10:21:58 +0100
Received: from x4dbf9e82.dyn.telefonica.de ([77.191.158.130] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lDkwA-003jWk-CM; Sun, 21 Feb 2021 10:21:58 +0100
Subject: Re: [PATCH] ia64: fix ptrace(PTRACE_SYSCALL_INFO_EXIT) sign
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-ia64@vger.kernel.org, "Dmitry V . Levin" <ldv@altlinux.org>
References: <20210221002554.333076-1-slyfox@gentoo.org>
 <20210221002554.333076-2-slyfox@gentoo.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <66569d56-1af0-a6bb-8b54-9d1cded893cd@physik.fu-berlin.de>
Date:   Sun, 21 Feb 2021 10:21:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210221002554.333076-2-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.191.158.130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei!

On 2/21/21 1:25 AM, Sergei Trofimovich wrote:
> In https://bugs.gentoo.org/769614 Dmitry noticed that
> `ptrace(PTRACE_GET_SYSCALL_INFO)` does not return error sign properly.
> (...)

Do these two patches unbreak gdb on ia64?

And have you, by any chance, managed to get the hpsa driver working again?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

