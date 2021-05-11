Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C742A379BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhEKBRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhEKBRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:17:17 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B838C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:16:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FfKkH06Vyz9sWq;
        Tue, 11 May 2021 11:16:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1620695769;
        bh=ZlOYJ/K88RGErXDxsltfMc0YfqZAWgaqHSNl1cnZGC0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GvhRElQp8+mOHrM1yCGl+p/QoTgqHIp+fRT04XMKu+ylifnof4/W2aVacKpoHGQnH
         PZdJPfAf3YAXTCa+MmMwsuSGMEeq8+gZmj/wiLhBT16WNuMltL75QwWn1PgK4zo3dO
         MDRYji2n9cwHYVKGOz/gdIxtYcDPOCmACjl5jrxlEwxwcsNovIh6mEXztay4XdqqiE
         XjtacZfXZnqsRVkv5gCZl7GShh3zWyXm6hQA4aIEDtb8fB/bTFqefopvLngdZVlj9V
         /OBfvTVtcLb1cSaFgPniCoiv4HjUtg20M4nzItxIu0PEcm4AKjladm65f257uEAeZ1
         X1rCEaV399XCQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, pmenzel@molgen.mpg.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/legacy_serial: Fix UBSAN:
 array-index-out-of-bounds
In-Reply-To: <20210510211444.GE10366@gate.crashing.org>
References: <d5e3c8e66bad3725d7d48d0e45c4b7eb7c02631d.1620455671.git.christophe.leroy@csgroup.eu>
 <20210510211444.GE10366@gate.crashing.org>
Date:   Tue, 11 May 2021 11:16:02 +1000
Message-ID: <87sg2uxe7h.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Sat, May 08, 2021 at 06:36:21AM +0000, Christophe Leroy wrote:
>> UBSAN complains when a pointer is calculated with invalid
>> 'legacy_serial_console' index, allthough the index is verified
>> before dereferencing the pointer.
>
> Addressing like this is UB already.
>
> You could just move this:
>
>> -	if (legacy_serial_console < 0)
>> -		return 0;
>
> to before
>
>> -	struct legacy_serial_info *info = &legacy_serial_infos[legacy_serial_console];
>> -	struct plat_serial8250_port *port = &legacy_serial_ports[legacy_serial_console];
>
> and no other change is necessary.

Yeah I sent a v2 doing that, thanks.

cheers
