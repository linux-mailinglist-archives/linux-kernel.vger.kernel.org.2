Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8710D33C943
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhCOWVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:21:53 -0400
Received: from smtp.kvr.at ([83.65.151.181]:50365 "EHLO smtp.kvr.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhCOWVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:21:38 -0400
X-Greylist: delayed 1629 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 18:21:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=20200417.ckk.user; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SXXZ7zAtMIKTRWaFNBTob3b1oxLrYHdskmTBBva/ets=; b=IV5HwDUXvQxwg+CsM0dCxDQ5NQ
        l1+P00mEOkcoSkj7kgpaTSGXpL5rM45f5KWk3/ArcwG87XE8K7e4r/jNxqWWz8LONlAfC7ZEJsVX1
        0fJrqTEVopwKqGeZvtyhQ0+tRiFEMHz+06WDOhiMipTUnWdpi61JJFJg0lyj8NB+jx1QEPHu0/7+D
        UJ7WtCDbIHPXvI1W4voN/OiIwgHi6x+ZHLu6gSeuMLy82hq+aUvuKL5Ryx92jk8gTe1JYo4mqx2ET
        zrXtAcnGC2yYcCLBVfAVoGieOrbs+spjdZhX1XciU5LQx5zrWIfs2Z91qwyYAuPc3VYK9LgTHzxxG
        ue1O783/f0pjQuTsNysWPvFoEPq2yP4d3EYRxb07IS7ZZVtv/7NpzqVdHTDkHp+MVb1IkTt+JC2X8
        Ae0/JW1gxR8PTO6KwUBUZ2B1zm6DZOgrej93MpOCCYVECc6hCcv17+NiRK9gJxIL0bVIG3qHSFJuz
        OUuW+VERRIfbUWbN4KEahVM7bsHWHN/jpXzMSGGGDLznbLLdlyiG3oCAra87ww+b8FOkPBgFdGTgf
        KuJouqmRfNLY1xjhrkbFxX2jvt+2Cn0scXgCun54C3p5Ur5T+7R8WjdUwPF53MQLzrJ63gAOppzLQ
        dDPUNSmVoBNywEF2IQD8Vs40SNGMwGIjzcQnTU0E8=;
Received: from [192.168.0.7] (port=47058)
        by smtp.kvr.at with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <ckk@debian.org>)
        id 1lLvAP-002As1-7A; Mon, 15 Mar 2021 22:54:25 +0100
Subject: Re: turbostat: Fix Pkg Power on Zen
To:     Kurt Garloff <kurt@garloff.de>, Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1f1fb01e-0616-34ea-ede6-dc7dd679c3d4@garloff.de>
 <c7074c16-5d64-e829-10f6-ef91f5f6222b@garloff.de>
From:   Christian Kastner <ckk@debian.org>
Message-ID: <f6143d7a-079d-3f3c-c947-47fc9858a2bb@debian.org>
Date:   Mon, 15 Mar 2021 22:54:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <c7074c16-5d64-e829-10f6-ef91f5f6222b@garloff.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.02.21 10:01, Kurt Garloff wrote:
> Issue persists on Ryzen in 5.11-rc6:
> 
> kvmadmin@KurtSrv2018(//):~ [0]$ sudo /casa/src/linux-stable/tools/power/x86/turbostat/turbostat
> [...]
> kvmadmin@KurtSrv2018(//):~ [243]$
> 
>                             ^^^ Exit code
> 
> With the patch:
> 
> kvmadmin@KurtSrv2018(//):~ [243]$ sudo /casa/src/linux-stable/tools/power/x86/turbostat/turbostat   
> [...]                   
> Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
> -       -       27      1.04    2562    3411    16046   33      2931    12895   0.00    0.85    98.48   1.57    18.81
> 0       0       12      0.55    2193    3400    885     1       111     757     0.00    1.12    98.42   0.04    18.74
> 0       16      1       0.05    2351    3400    53      0       3       54      0.00    0.05    99.92      
> 1       1       20      0.89    2261    3400    478     0       39      427     0.00    0.37    98.80   0.06
> 1       17      9       0.40    2329    3400    308     0       38      282     0.00    0.35    99.29      
> [...]

I was seeing the same issue (no stats, program just exits with 243), and
Kurt's simple patch resolved it for me.

Best,
Christian
