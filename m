Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F7F3241BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhBXQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:08:47 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:47619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbhBXQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:01:41 -0500
Received: from [192.168.1.155] ([77.2.19.91]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MiZkX-1liTkl2TDD-00fjwv; Wed, 24 Feb 2021 16:58:24 +0100
Subject: Re: [PATCH] init/Kconfig: make COMPILE_TEST depend on HAS_IOMEM
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        KP Singh <kpsingh@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20210224140809.1067582-1-masahiroy@kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <fa9d393d-1bc3-fc08-52dd-88e76ead97af@metux.net>
Date:   Wed, 24 Feb 2021 16:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210224140809.1067582-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vTdvZhm2Rl294gyLpqHXKDI6Ou9wxvwQ/QLWa6O0tt3iAi5CRkn
 fWuKRxFiB9bOZlAj+xuYTOtvvNhSg2lW7NWMVrX5QmIcXf1nGkSywMJo61QV1BN1JHZv+Gb
 W+7mZsCdtYueEmPJCXO1GdvSt2zN4Mxa5d+Fgix8iIK/6PoY8ITRmcFY4rlHIq9s9CX78cZ
 1oguP8LCwO42/JQuZ/s+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RY4LF7WJ854=:0gTeAuSG66I95i1cbY4egQ
 6dxeid7UgjvHtaFgAHkuDvfRPpjh9GsLHeCmbYVd0NryOF6bRyshCLBKaioOqqmshHl32nmDL
 8NxX3OCETDDX2rZ+DtJYCSsWs0OiTjftq6E89sLVSNybRhf71daww56WEWxVkYa7zmWW9BgSY
 wHmcqQJ4z/iyTEvsbDTaaQbtT9ZjHouuEZM/a0SFTBWuidmnkcM60jo8+q6IpEuIVqb03uHrI
 +vAGE/5F2IN2DjjiHJeOnzYj5KEYMEFAbShuYGZvGNMMa8/AzpaSinrVgYUABRVyGLFG1+EdP
 ET6Egkxf86t33Q6BmPf+/pM0L+4cRfwXK3/RTMkDFQYPfqMgQEjetQq4b+OslNhqwWz32mAbF
 K/idfuPj6siK0SL2KdZ+5Wv3y9Fh1spYeatWRIccO90MTCQzc1tbzM80TgPyU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.21 15:08, Masahiro Yamada wrote:
> I read the commit log of the following two:
> 
> - bc083a64b6c0 ("init/Kconfig: make COMPILE_TEST depend on !UML")
> - 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390")
> 
> Both are talking about HAS_IOMEM dependency missing in many drivers.
> 
> So, 'depends on HAS_IOMEM' seems the direct, sensible solution to me.

I don't like idea of hidden indirect dependencies. If a driver needs
iomem, then it should depend on it. Yes, a lot of drivers might need
to be fixed, but IMHO we should do that, instead of covering 'em up.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
