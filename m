Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01C359C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhDIK4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:56:37 -0400
Received: from marcansoft.com ([212.63.210.85]:45928 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232087AbhDIK4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:56:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 06C683FA1B;
        Fri,  9 Apr 2021 10:56:19 +0000 (UTC)
Subject: Re: linux-next: build failure after merge of the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210409201316.6c9295a4@canb.auug.org.au>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <1d2feb6a-43a0-45b5-1c5f-50e23bb399be@marcan.st>
Date:   Fri, 9 Apr 2021 19:56:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210409201316.6c9295a4@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 09/04/2021 19.13, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the arm-soc tree, today's linux-next build (powerpc
> allnoconfig) failed like this:
> 
[...]
> Caused by commits
> 
>    7c566bb5e4d5 ("asm-generic/io.h:  Add a non-posted variant of ioremap()")
>    89897f739d7b ("of/address: Add infrastructure to declare MMIO as non-posted")
> (and maybe some others)
> 
> I have reverted 86332e9e3477..7d2d16ccf15d for today.

This is fixed in ea9629283839 in the soc tree, which went in a few hours 
ago. Sorry for the noise.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
