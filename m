Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E344B44EF32
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhKLWZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:25:50 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37914 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKLWZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:25:49 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4HrY4b2NTNz1qwyc;
        Fri, 12 Nov 2021 23:22:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4HrY4b1jBWz1qqkB;
        Fri, 12 Nov 2021 23:22:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id SCeZGLDoE2bf; Fri, 12 Nov 2021 23:22:54 +0100 (CET)
X-Auth-Info: RW8h+FSRRzkLu9k8ehRaMppl2SdT1LX5nbc4X25EYpVibUHp04OzscLLLfKgurqT
Received: from igel.home (ppp-46-244-178-12.dynamic.mnet-online.de [46.244.178.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 12 Nov 2021 23:22:54 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 215462C3936; Fri, 12 Nov 2021 23:22:54 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [GIT PULL] RISC-V Patches for the 5.16 Merge Window, Part 1
References: <CAHk-=whkh5Qma5rHtiRQXF9jVRXDe=bRG+D+LFu4dZpwP1uWAw@mail.gmail.com>
        <mhng-8aed9afb-1b05-413b-9808-5d0936c9f131@palmer-ri-x1c9>
X-Yow:  Yow!  Am I having fun yet?
Date:   Fri, 12 Nov 2021 23:22:54 +0100
In-Reply-To: <mhng-8aed9afb-1b05-413b-9808-5d0936c9f131@palmer-ri-x1c9>
        (Palmer Dabbelt's message of "Fri, 12 Nov 2021 13:52:46 -0800 (PST)")
Message-ID: <87mtm9rp35.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 12 2021, Palmer Dabbelt wrote:

> I wasn't planning on sending anything else for the merge window.

Not even the KBUILD_EXTMOD build fix?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
