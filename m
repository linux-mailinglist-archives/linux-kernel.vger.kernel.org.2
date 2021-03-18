Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF5340E66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhCRTjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:39:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:32949 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhCRTip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:38:45 -0400
Received: from [192.168.1.155] ([77.4.36.33]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUXYs-1lED2o2U40-00QPj6; Thu, 18 Mar 2021 20:38:10 +0100
Subject: Re: [PATCH] init/Kconfig: make COMPILE_TEST depend on HAS_IOMEM
To:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
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
 <fa9d393d-1bc3-fc08-52dd-88e76ead97af@metux.net>
 <c609139d-2df6-dd68-a80e-19b531adda78@roeck-us.net>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <fd9f0b40-136e-7518-7e0b-c4a7d21fe5a4@metux.net>
Date:   Thu, 18 Mar 2021 20:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <c609139d-2df6-dd68-a80e-19b531adda78@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nKDWHDfiCtsxfLqQnOueQkCg2bBWe+TYDCQALHPQWqvwvkTHqjb
 rYYtIgoqrLf0EpEgxJW1bE3qQYOnuhPVvbabI/xPty/xEwkMhLtDBIIckOoDmTVeJTolCuM
 8qBDWgG43mYQG7I0g6+TBKWG1xzGEIkZqviaYo9WMOYtLgBywxd6AzsSb+cJXNXHN8sX3wy
 q2qO3U4ABBd+S8hdqZbXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OqEyc+vmQB8=:axQqGoABnTo/APizdc2PqZ
 FQrOqPK0gA608iAxd0/1leg46pKixQe0K/vT6O7DXfprpJRS/qPIxiBp/A/D78pDAyilatmxk
 KuRCoyiQsSpJ3Vhcoh1uDpoHY7gQwi3JgdAS2Zi4v0yIbfH5SzsMdhIYJwQcN3jZodw26T/nG
 KxqlQF4/7WXttszG1gkKHE5OX0OyXkmyddRcnvi7Uj9Mv6e/zEQzhf+Mi25f9bgp0NVj9ha4o
 qsJDfBg4KtEGk1uo6vLVmWaGGNjJEa60cYnadyN5nBw1XgLOoR1CaPSdZP4s9gUTwSBGY+IlP
 pbmqCeYtYBBK5AXEg/z2rZeil/YCTqqW0SDi4YSLgtVU6lC1lwuI6g3kylRK0QMEWPD8ImU5l
 kRESauVAISJvBeKwM57dc4JjIfeRLsqDyg8rYvIMIJ6X+biLnFddjq/d25fv4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.21 17:23, Guenter Roeck wrote:

> Unfortunately that does not reflect reality, which was the reason
> for the above two commits. Problem here is that the cost is not paid
> by the driver authors, but by architectures which don't support HAS_IOMEM,
> specifically s390. Driver authors tend to enable COMPILE_TEST but never
> test on a system with HAS_IOMEM=n (and/or ignore test results provided by
> build robots).

Still, I believe the bug should be fixed at the source.

Maybe these bots do so much traffic that nobody really cares about them.
Do they directly address the author and the corresponding maintainer ?
(if that ever happens to one of my drivers, please let me know)

> To a lesser degree, we see the same happen with 32-bit targets. Driver
> authors often don't compile their drivers in 32-bit mode (just look
> at 32-bit i386 builds in next-20210224 to see an example). Then it is
> often up to others to track down and fix the problems. Fortunately,
> there are still more than a few people who are still interested in
> 32-bit builds, and problems with those builds tend to get fixed quickly.
> This is not the case with HAS_IOMEM related issues, where the burden
> is on very few people.

Could we set up a separate build bot for those configurations, with a
different from: address and an a special warning text, so maintainers
quickly see they *should* pay attention.

IMHO, this is primarily a problem of handling the massive traffic
on lkml and sorting out whats relevant for oneself.



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
