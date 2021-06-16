Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF53A9B79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhFPNIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:08:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48199 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhFPNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:07:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G4lmb4k9Cz9sWF;
        Wed, 16 Jun 2021 23:05:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623848752;
        bh=32+NpGgu8WipadP+MIdPGsq6RjRcWDCP1ZmI2iSTa6M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Qj438s/EvGlaqyPz3IXIGaa507+ewXJtgfQcTlMmg3N+YqNZeozZO2po00HKxn7yk
         S1p4Rf0eyU1x66K93nmCl1JnZn5dguWdv/F/Cn0AQ8N2n9SkAxnvj9xP5SttFQlPTh
         pqyrBOSyOM/yIZTXDEFjkv2bYc4cSq5hzIdgkwdfvxmVeMCMhOl8M77wLenr3BBX7u
         Zr+kZinASd7NGDPAwbdwsuymihoQ8j0xYMAhbeWy3VfR1RarFmIq93zMdCSWIRCDBP
         Nda8YKiB97VzDE2f0YYfNz4Venl4FwIl2n0ANUVtJEBPSo47+HzTWiBOKHPrwPATH+
         cIXj19dUdAeQg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/12] powerpc: Cleanup use of 'struct ppc_inst'
In-Reply-To: <0c2b2eb4-f58d-9ec3-4b98-af22cef188e2@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
 <87r1h3tx3a.fsf@mpe.ellerman.id.au>
 <0c2b2eb4-f58d-9ec3-4b98-af22cef188e2@csgroup.eu>
Date:   Wed, 16 Jun 2021 23:05:46 +1000
Message-ID: <87eed2rmc5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 15/06/2021 =C3=A0 09:18, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> This series is a cleanup of the use of 'struct ppc_inst'.
>>>
>>> A confusion is made between internal representation of powerpc
>>> instructions with 'struct ppc_inst' and in-memory code which is
>>> and will always be an array of 'unsigned int'.
>>=20
>> Why don't we use u32 *, to make it even more explicit what the expected
>> size is?
>>=20
>
> I guess that's historical, we could use u32 *

Yeah I think it is historical, we just never thought about it much.

> We can convert it incrementaly maybe ?

I've still got this series in next-test, so I'll go through it and
change any uses of unsigned int * to u32 *, and then we can do another
pass later to change the remaining cases.

cheers
