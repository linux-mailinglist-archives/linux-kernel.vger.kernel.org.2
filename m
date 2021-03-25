Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA7734863E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhCYBKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbhCYBKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:10:23 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:10:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F5RqF5LH1z9sWX;
        Thu, 25 Mar 2021 12:10:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616634618;
        bh=ZW+d7kU0Risnr9sA0Xrow6G2y6serwV4IO6IYGM/EHQ=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=ZaAExu5G5EHRvfCFWIlGfPIGJXs7Zus8026qfM8tQ0XazFMVwrAL3KgxCye2W5i4N
         etEWZ7Oqv9u8UWwPMG+ZyjZr+LGwZoohZQGnyNQm4T/ZHBIQs3Ta081CFtBYmVXY9T
         ao/N1sK/2aQ2xtBhpSWIG/jqGPQvn9CTkVrCX+MJV6h1C9BIuYXDQdZiyHMQ6QfGxb
         c4EbvWbapRIDhnoXQBgXXt+jXDCU3DSS4pM3wcG93GZmHNJv4YjpaUQ3mJsiU9IFsi
         2EXUsPRpd2CrsqfjptLJiDaQuEq0g4a+oIOUdOmaMnsrFipNTB0UP6ao/umAJUYBOy
         kGKpbzjJSY0VA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND 1/1] powerpc: asm: hvconsole: Move
 'hvc_vio_init_early's prototype to shared location
In-Reply-To: <20210324103854.GK2916463@dell>
References: <20210303124603.3150175-1-lee.jones@linaro.org>
 <20210324103854.GK2916463@dell>
Date:   Thu, 25 Mar 2021 12:10:13 +1100
Message-ID: <87h7l0ghsa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:
> On Wed, 03 Mar 2021, Lee Jones wrote:
>
>> Fixes the following W=3D1 kernel build warning(s):
>>=20
>>  drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for =
=E2=80=98hvc_vio_init_early=E2=80=99 [-Wmissing-prototypes]
>>  385 | void __init hvc_vio_init_early(void)
>>  | ^~~~~~~~~~~~~~~~~~
>>=20
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/include/asm/hvconsole.h     | 3 +++
>>  arch/powerpc/platforms/pseries/pseries.h | 3 ---
>>  arch/powerpc/platforms/pseries/setup.c   | 1 +
>>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> Any idea who might pick this up please?

I will. I have it in my next-test branch.=20

cheers
