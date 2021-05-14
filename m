Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB53813F2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 00:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhENWyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 18:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhENWyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 18:54:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 867146140A;
        Fri, 14 May 2021 22:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621032809;
        bh=53wkinNMi3Pyh3InvMTt+f+Nu4TGkqEqo6TxC2f9rUk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kbpQfilncOuNChvNO8T2vfDJkv3Xf27j2eyHK4j9APwlsf2hbVayd9UFmpwKpPvOT
         Sd+c/hPRe2lQ7ECpxv/nKqg9YQkgdqByOEjcEVC7I7FUYE9TmtWvYkxl/sRbJAnGhZ
         CaYsLaQHren8dHHOyVKW39XUe6UFTjYsF7/zZVCxM8erF/dq3IZE/3FmWE92P1k92c
         qggSv5Spt5pNYtLctl92o8jlkhJvcV5NI3VHh+DzO3XN+aNvQhxnFrnjeD5Qe0pml/
         rsilyGlkuw3Z/v5e/QQ0uYE+IJlLPQCZ3I8Ckcbsk1izWKlm3YfsOsPEqpyPAzpzEp
         At7nRjW0Yh8GQ==
Subject: Re: [PATCH 2/6] x86/irqvector: add NR_EXTERNAL_VECTORS and
 NR_SYSTEM_VECTORS
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210511005531.1065536-1-hpa@zytor.com>
 <20210511005531.1065536-3-hpa@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <0228acdc-41ac-933a-03ec-9d8bbfb5c729@kernel.org>
Date:   Fri, 14 May 2021 15:53:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511005531.1065536-3-hpa@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 5:55 PM, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Add defines for the number of external vectors and number of system
> vectors instead of requiring the use of (FIRST_SYSTEM_VECTOR -
> FIRST_EXTERNAL_VECTOR) and (NR_VECTORS - FIRST_SYSTEM_VECTOR)
> respectively.


Acked-by: Andy Lutomirski <luto@kernel.org>
