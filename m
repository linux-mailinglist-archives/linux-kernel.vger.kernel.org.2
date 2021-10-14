Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A842D946
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhJNM2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:28:46 -0400
Received: from phobos.denx.de ([85.214.62.61]:35870 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231558AbhJNM2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:28:44 -0400
Received: from crub (pd95f1d7c.dip0.t-ipconnect.de [217.95.29.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: agust@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 486F283572;
        Thu, 14 Oct 2021 14:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1634214398;
        bh=h3d+7/o10dgcD7pQSvUh5MYsQC2GB4YO4Pb5D5tQVj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QJ3AvB+swCyUTTe+4Apkhltx3Vjvpwrg7wbW1tD+npZGf2SJNzHhS+UURxct9CVdi
         0HbSnlqIyuZe9aY1/Qa1X0PVNCJMwLAAZxbunFas5i7jjNvXdyM5Ed9lg6oLw+I3MR
         UU+4AUlaDZSf1UIW+BUdGhOI0tcwahiBEQ9EkMY3Ta7IiZS+aEdz3I2up5TFULRPEZ
         z7WwT7pPwV7ZtotWSHLrctaQqiznVRcSHqXTClaJNNAnjNA3ZaWDWOgZCHjvWRvvCd
         H0eyP5k641kEpNp/ig2v7agHaSwR4rKktl4K5bglZIBCFF80Wssi6/QDllKhXeSpcC
         0VdsamN+lQzcw==
Date:   Thu, 14 Oct 2021 14:26:37 +0200
From:   Anatolij Gustschin <agust@denx.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc: dts: Remove MPC5xxx platforms
Message-ID: <20211014142637.3fda421b@crub>
In-Reply-To: <20211013173808.7ab92035@canb.auug.org.au>
References: <20211012153456.2844193-1-robh@kernel.org>
        <20211013173808.7ab92035@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 17:38:08 +1100
Stephen Rothwell sfr@canb.auug.org.au wrote:

>Hi Rob,
>
>On Tue, 12 Oct 2021 10:34:56 -0500 Rob Herring <robh@kernel.org> wrote:
>>
>> The mpc5xxx platforms have had dts warnings for some time which no one
>> seems to care to fix, so let's just remove the dts files.
>> 
>> According to Arnd:
>> "Specifically, MPC5200B has a 15 year lifetime, which ends in
>> 11 months from now. The original bplan/Genesi Efika 5K2 was
>> quite popular at the time it came out, and there are probably
>> still some of those hanging around, but they came with Open
>> Firmware rather than relying on the dts files that ship with the
>> kernel.
>> 
>> Grant Likely was the original maintainer for MPC52xx until 2011,
>> Anatolij Gustschin is still listed as maintainer since then but hasn't
>> been active in it for a while either. Anatolij can probably best judge
>> which of these boards are still in going to be used with future kernels,
>> but I suspect once you start removing bits from 52xx, the newer
>> but less common 512x platform can go away as well."
>> 
>> Cc: Anatolij Gustschin <agust@denx.de>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Sending this out as a feeler to see if anyone cares. If anyone does, 
>> please fix the warnings.

I've sent patches to fix the warnings.
  
Thanks,

Anatolij
