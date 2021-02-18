Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875AD31EB26
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhBROwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:52:20 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43825 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233034AbhBRMuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:50:16 -0500
Received: from [192.168.0.6] (ip5f5aecdc.dynamic.kabel-deutschland.de [95.90.236.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B4DDE20645D7E;
        Thu, 18 Feb 2021 13:47:40 +0100 (CET)
Subject: Re: [PATCH] ARM: dts: nuvoton: Fix flash layout
To:     "Anton D. Kachalov\"" <gmouse@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210218122546.3546582-1-gmouse@google.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <665439b1-f5b7-bcc9-22dd-134f4ce09f01@molgen.mpg.de>
Date:   Thu, 18 Feb 2021 13:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218122546.3546582-1-gmouse@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Anton,


Thank you for your patch.


Am 18.02.21 um 13:25 schrieb gmouse@google.com:
> From: "Anton D. Kachalov" <gmouse@google.com>
> 
> This change satisfy OpenBMC requirements for flash layout.

Can you please list these requirements in the commit message? Maybe, 
also add OpenBMC to the commit message summary.

> Signed-off-by: Anton D. Kachalov <gmouse@google.com>
> ---
>   arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 28 +++++++----------------
>   1 file changed, 8 insertions(+), 20 deletions(-)

[…]


Kind regards,

Paul
