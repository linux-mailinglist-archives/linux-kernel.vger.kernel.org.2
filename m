Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C7362FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhDQMaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDQMav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:30:51 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBD3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 05:30:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FMsqJ1ckGz9vG3;
        Sat, 17 Apr 2021 22:30:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1618662620;
        bh=mtQXXNJfragy4YQoBiwVomNkLwmcNxRqSSFA0RO5LCo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aCXQ421yZApjtSXo4wDJS5qyT1JaMFSEi8NEckR1sYexHW87ktiqBKTQh9rp4jq4B
         b3RAJU5OL25nzAG9tJ/ylT8EjLNhIJeahLFUNn5ZaCnS6FES6iHeBq0pk4wPjiYnx6
         iNwXBy/HK60pJlzELKvX1eyq8QWlGZOMjxAB7XSamDg7JqbFawr9Is+d6i4jNvqKiP
         n41xrIzhRWrwW5XFQ6oobgw0u66Qz+LouPxrvvuv//RrfLT4aln0SI206UUVgWkTJs
         /RJ+8l7g6MGSVIxx8L0/odoo8YM041S2FV3bD4zfpnH4Zbl4JaEGK+9LPn0//nSdqH
         bSJUoxa3H5cGg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: Add shutdown() to vio_driver and vio_bus
In-Reply-To: <f326def4-0db0-f924-1700-dd7be3154153@linux.ibm.com>
References: <20210402001325.939668-1-tyreld@linux.ibm.com>
 <f326def4-0db0-f924-1700-dd7be3154153@linux.ibm.com>
Date:   Sat, 17 Apr 2021 22:30:14 +1000
Message-ID: <87im4ldrft.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> On 4/1/21 5:13 PM, Tyrel Datwyler wrote:
>> Currently, neither the vio_bus or vio_driver structures provide support
>> for a shutdown() routine.
>> 
>> Add support for shutdown() by allowing drivers to provide a
>> implementation via function pointer in their vio_driver struct and
>> provide a proper implementation in the driver template for the vio_bus
>> that calls a vio drivers shutdown() if defined.
>> 
>> In the case that no shutdown() is defined by a vio driver and a kexec is
>> in progress we implement a big hammer that calls remove() to ensure no
>> further DMA for the devices is possible.
>> 
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>> ---
>
> Ping... any comments, problems with this approach?

The kexec part seems like a bit of a hack.

It also doesn't help for kdump, when none of the shutdown code is run.

How many drivers do we have? Can we just implement a proper shutdown for
them?

cheers
