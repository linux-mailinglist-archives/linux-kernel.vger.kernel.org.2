Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFE3B1F20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFWRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 13:02:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49870 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWRCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 13:02:46 -0400
Received: by linux.microsoft.com (Postfix, from userid 1001)
        id 22BC220B7188; Wed, 23 Jun 2021 10:00:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22BC220B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624467629;
        bh=L5/H7FIrkz8GoqL+W/32b5NGry8n7J+n2NEMmYkG6jM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=h7y0rAKUyxJFDSCeiHCLM6LCm94bD1SnSwGrKLXNMlokmNBETkm1LwdXxqkczC2vs
         RM3Me+trkcLQvetAnKmpxcwWUsg5vfKFFu01SXXQk5bZBtFvhahBGZAW1zs1istIsb
         DO6fZsoueoVdMTDiEbQQGkLzsLMvo/mM9z19fgUM=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 21C203070324;
        Wed, 23 Jun 2021 10:00:29 -0700 (PDT)
Date:   Wed, 23 Jun 2021 10:00:29 -0700 (PDT)
From:   James Morris <jamorris@linux.microsoft.com>
To:     Stephan Mueller <smueller@chronox.de>
cc:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Haxby <john.haxby@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Simo Sorce <simo@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        hpa@zytor.com, tytso@mit.edu
Subject: Re: [PATCH v1] crypto: Make the DRBG compliant with NIST SP800-90A
 rev1
In-Reply-To: <9dbbf4e751cb4953fe63079cdc917a0bb3a91670.camel@chronox.de>
Message-ID: <a4e1c071-32af-9650-e6fd-8943b3a79bb0@linux.microsoft.com>
References: <20210623120751.3033390-1-mic@digikod.net> <9dbbf4e751cb4953fe63079cdc917a0bb3a91670.camel@chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021, Stephan Mueller wrote:

> 
> > These changes replace the use of the Linux RNG with the Jitter RNG,
> > which is NIST SP800-90B compliant, to get a proper entropy input and a
> > nonce as defined by FIPS.
> 
> Can you please help me understand what is missing in the current code which
> seemingly already has achieved this goal?

The advice we have is that if an attacker knows the internal state of the 
CPU, then the output of the Jitter RNG can be predicted.



-- 
James Morris
<jamorris@linux.microsoft.com>
