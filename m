Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1A39DBE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFGMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:05:25 -0400
Received: from ozlabs.org ([203.11.71.1]:35997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhFGMFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:05:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FzBpr0y35z9s1l;
        Mon,  7 Jun 2021 22:03:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623067412;
        bh=4VIaLxdE94V49Ugi/DzDUyEZSXbSah/t7XDQwEdLyak=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fEs7IubWd3DEqBc0yGDeXPkqBGVIjOhfvYMh1NQweGdz9J10MTG/lhb2iE3Kj2PlX
         VP3mwYYV8qu5KN2td68MsckOs2pp1rRArcf5NWOcDcqTTBXHqOeqiQPtkNR2CKXm1o
         b1v7cIzOUxpegSuxIF9e71t3Wb2EHM3lWD/XQ4nGE3lfYugQJuwPOmZDYtYUk6uWFB
         u2olW6vsDmt/QaICTGf5QIxmGK9UaolwhVb/1etvGLw8dnHmm+bZimJXUjDPf0Cchw
         SAGOfgNcGrpEv81XZgcX8tqbTtK3CEEZYyiubN9PZxM/X/QVXRk15+TZtRgoEdb5yX
         PdE2fwyONNLgw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixup for "[v2] powerpc/8xx: Allow disabling KUAP at
 boot time"
In-Reply-To: <db70d1b3-440b-a612-f04b-f7bfabc6f945@csgroup.eu>
References: <b175c35ce1596603bf321a5193e89400ae180057.1623001343.git.christophe.leroy@csgroup.eu>
 <db70d1b3-440b-a612-f04b-f7bfabc6f945@csgroup.eu>
Date:   Mon, 07 Jun 2021 22:03:31 +1000
Message-ID: <877dj5g9v0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 06/06/2021 =C3=A0 19:43, Christophe Leroy a =C3=A9crit=C2=A0:
>
> Michael, I sent it as a Fixup because it's in next-test, but if you prefe=
r I can sent a v3.

That's fine, I squashed it in.

cheers
