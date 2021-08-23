Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215E13F46A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhHWIeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:34:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45387 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbhHWIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:34:18 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GtQVz6xw4z1qwy3;
        Mon, 23 Aug 2021 10:33:31 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GtQVz5854z1qqkb;
        Mon, 23 Aug 2021 10:33:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id GGDnTnGS58eH; Mon, 23 Aug 2021 10:33:31 +0200 (CEST)
X-Auth-Info: a+1O7isek3JZDPNKtVNsCYwHfVgro13FVrH+P18vbWUWubMUmcVgyl/tu9OSSa3n
Received: from igel.home (ppp-46-244-177-181.dynamic.mnet-online.de [46.244.177.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 23 Aug 2021 10:33:30 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 3F0B32C07D8; Mon, 23 Aug 2021 10:33:30 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/syscalls: Remove __NR__exit
References: <6457eb4f327313323ed1f70e540bbb4ddc9178fa.1629701106.git.christophe.leroy@csgroup.eu>
X-Yow:  Is this BOISE??
Date:   Mon, 23 Aug 2021 10:33:30 +0200
In-Reply-To: <6457eb4f327313323ed1f70e540bbb4ddc9178fa.1629701106.git.christophe.leroy@csgroup.eu>
        (Christophe Leroy's message of "Mon, 23 Aug 2021 06:45:20 +0000
        (UTC)")
Message-ID: <87y28ssgpx.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 23 2021, Christophe Leroy wrote:

> __NR_exit is nowhere used. On most architectures it was removed by

ITYM __NR__exit, which is what you are removing.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
