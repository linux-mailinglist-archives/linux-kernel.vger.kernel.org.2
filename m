Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF9440B4D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhJ3Sjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 14:39:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:55161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhJ3Sjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 14:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635619020;
        bh=wiYpOvpuZekWIhIUwDTxtt1QLcrdcdDO39b0AOLyb40=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cNsFYMSj4129pr6FwmFHnjqWUIJDA80Lzq4QM8nYR5Y+W+jpdGpft5TZ1yfJ+nEgT
         IHtv16wr5Nudcyfyayia9WxiHGrPwbza3jJP3aapu+U+EV5ehyRPLQPjKj5zYDna13
         1brBbIb+MsCvF5DtEL6YzZB1vXrDgmKh45/gEYwk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.175.185]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFvp-1mWksz2bAr-00AHHJ; Sat, 30
 Oct 2021 20:37:00 +0200
Message-ID: <0bbb74dc-d39a-c8ef-d0d2-5fefb55822b3@gmx.de>
Date:   Sat, 30 Oct 2021 20:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] parisc: decompressor: remove repeated depenency of
 misc.o
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-parisc@vger.kernel.org, patches@arm.linux.org.uk
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
References: <20211030175721.1716841-1-masahiroy@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20211030175721.1716841-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h2jBWOfutNxR4xyaYVhn1P+97SrP961UzTBJ/INTIw+7jLp9sFy
 ImHKxuhBdd12qsNyArtwkGWWKWrxiwjb1e64D+9Gjwn1M0ArG25DrwTje9riHX/Vy4YLbmn
 zp3a80QwQqaHkNdidSGTe/kesICjWs7OF5eJV//O7BXcdcEZPqEoEVaVnkQUMRtaZvThxe2
 jfHkV+cW30m13i3q43CdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nCnxTn9kPJg=:qct6dAKr8l2aj6OtbjUcX9
 Nq7ncoBLR7e5W1SJhPLMlolyDPJfEpeSAdj30eSWJNRrEg/KY6ERbZPm83vWElxRZO/YrnA48
 n8ZJQZI1T9gOAOSmJBmUdYHJ+svAX2HlTm98fcOd86RP8WR+7EnnaqGQTwvpbFPxcq1rmn9Bq
 3OsfHSGz5nny+7Emm0qo5oa/OD37HudG6cDwlNqCHNN1gRYHRCr7Ji+9i+dSDP9E+o2KIOBaM
 JXJt9v5XUsngM0kflW+maK3yyMVfHvmoHx86CWMatdfQjI2EXZSRBfOcyFmHTBZEd0NhwnCJS
 keF1RO5tmXJoTeR1BdA9nH0Bw4OC/8+y1hC2gYvEUY6Am8ywwMDdHN2C/tWlG7h77cHv3SI0s
 Ox9rFZQiJzDprKgtYS5dfFcj+XMKD7UgPLBjy2M3Mmeiy+eATKCMNYs8lb7oONuxfO6hY57Fz
 gXr/K6bUpkXKAyUCn9w4MR+il+g5GerNaCoKRNZVz0wtez/Yyi2Oozc/Z52DeWmAvGNbwlBSM
 OgLrQoZ1A49ebfU5ijQ6t5Zyqw4LfZ8Ivyu74zy8EEBH5gEmgDvTbjJpLXEXW8CJa+i1SWKve
 HQ5c4l0fFlUxcvIBRwfe9gLkYSuPQndrHtSvKqapbAxe2BZfah/qcG+FiZEPqsZR/kYcok4IZ
 aV4IU4pmcfg5VpYgcBgDV6rWpIyWYbdUTC1yeRbutk4/83aXWIUWX3uGWSorkP+LUUmKn5j9+
 n0GtW9F2MLlWdT8pbCPyCIpaBU6GYIR0ACJuTNYJKRwCkh6ZDWh2fMe5bHaQS/Y/h+rXSwCsN
 2dwR0jgc5v8hx8S4Mw1sv0QQn3eHW6TxLJgvsGLyKu/TSOK0bQqe2DTBOADBLyRhSwD+/lsqT
 9zLnT8J5M5V4t2LXF/I/BF8vqrTz/FnxdMV5GJhq/PlS/kNWGfyk56RwgjWfAg+l0YsUGreai
 XvPGXyFHFuodXgroGE4+3plpewcr1xWSFpaytWCnzamK1kqj5Msnj8ls7lZkG0fZhxrWKvw01
 mxUBPHoPWRUJpsHnWsrR7qfH76rs9RRTgEiRZnpAtR0Te4CAhUmI9r1oujRslUgENj6YxiIFX
 SAwacg8hA8jZHU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/21 19:57, Masahiro Yamada wrote:
> The same dependency
>
>     $(obj)/misc.o: $(obj)/sizes.h
>
> ... appears twice, at line 29 and line 55 in this Makefile.
>
> Remove the second one.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I've appplied both patches.
Thanks!

Helge

> ---
>
>  arch/parisc/boot/compressed/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/com=
pressed/Makefile
> index 9fe54878167d..f7ed79e23c2c 100644
> --- a/arch/parisc/boot/compressed/Makefile
> +++ b/arch/parisc/boot/compressed/Makefile
> @@ -52,8 +52,6 @@ $(obj)/real2.o: $(obj)/real2.S
>  $(obj)/real2.S: $(srctree)/arch/$(SRCARCH)/kernel/real2.S
>  	$(call cmd,shipped)
>
> -$(obj)/misc.o: $(obj)/sizes.h
> -
>  CPPFLAGS_vmlinux.lds +=3D -I$(objtree)/$(obj) -DBOOTLOADER
>  $(obj)/vmlinux.lds: $(obj)/sizes.h
>
>

