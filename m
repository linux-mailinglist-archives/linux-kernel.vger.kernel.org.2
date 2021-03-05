Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C885932E757
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCELo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:44:29 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhCELoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:44:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DsQqj0TBXz9sWL;
        Fri,  5 Mar 2021 22:44:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1614944641;
        bh=SFTN3pvD7WygrPK8345qUzj/Yiy79Aui/vKNcyYo1LU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YCW3yOV5cOUSmUMmyms3tOismZLI9sjylaqzifzV7Obbez3s6noEcH1EItlJ2FtO7
         59C5rksyJB2tF5TxHrCeVwR8sDItttmQ+vwXfUo2EBjMAJNqa2D3Dr1ObN0CX3OaVX
         R7fZ0V8FR3GxSu/Z3ANBcrAqYCB20hRGyz/4U2Fm4QsYjOqg0ET5d1JUHnKHYSaNqX
         bvOaCyI1He1BYYs77/73rQC0lGKR8zYVbO2i13A3523xx7JIDPT67CfVjmeoThqijf
         p9Kv0JPRNTY5M2mFPqTeyffX9ycAsHZv8vFr2loJywXoMbrtnUoX05eCh/zNHwp7su
         IloIeuJoxDwLQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Cc:     nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: export LPAR security flavor in lparcfg
In-Reply-To: <2c67c119-c1ec-b079-da54-0bf2f316c734@linux.ibm.com>
References: <20210304114240.54112-1-ldufour@linux.ibm.com>
 <871rcuruee.fsf@mpe.ellerman.id.au>
 <2c67c119-c1ec-b079-da54-0bf2f316c734@linux.ibm.com>
Date:   Fri, 05 Mar 2021 22:43:55 +1100
Message-ID: <87wnulrfk4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> Le 05/03/2021 =C3=A0 07:23, Michael Ellerman a =C3=A9crit=C2=A0:
>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>> This is helpful to read the security flavor from inside the LPAR.
>>=20
>> We already have /sys/kernel/debug/powerpc/security_features.
>>=20
>> Is that not sufficient?
>
> Not really, it only reports that security mitigation are on or off but no=
t the=20
> level set through the ASMI menu. Furthermore, reporting it through
> /proc/powerpc/lparcfg allows an easy processing by the lparstat command (=
see below).
>
>>=20
>>> Export it like this in /proc/powerpc/lparcfg:
>>>
>>> $ grep security_flavor /proc/powerpc/lparcfg
>>> security_flavor=3D1
>>>
>>> Value means:
>>> 0 Speculative execution fully enabled
>>> 1 Speculative execution controls to mitigate user-to-kernel attacks
>>> 2 Speculative execution controls to mitigate user-to-kernel and
>>>    user-to-user side-channel attacks
>>=20
>> Those strings come from the FSP help, but we have no guarantee it won't
>> mean something different in future.
>
> I think this is nailed down, those strings came from:
> https://www.ibm.com/support/pages/node/715841
>
> Where it is written (regarding AIX):
>
> On an LPAR, one can use lparstat -x to display the current mitigation mod=
e:
> 0 =3D Speculative execution fully enabled
> 1 =3D Speculative execution controls to mitigate user-to-kernel side-chan=
nel attacks
> 2 =3D Speculative execution controls to mitigate user-to-kernel and user-=
to-user=20
> side-channel attacks
>
> We have been requested to provide almost the same, which I proposed in=20
> powerpc-utils:
> https://groups.google.com/g/powerpc-utils-devel/c/NaKXvdyl_UI/m/wa2stpIDA=
QAJ

OK. Do you mind sending a v2 with all those details incorporated into
the change log?

cheers
