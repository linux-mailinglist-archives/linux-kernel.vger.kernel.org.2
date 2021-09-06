Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE375401C90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbhIFNp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:45:29 -0400
Received: from out2.migadu.com ([188.165.223.204]:25476 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242165AbhIFNp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:45:28 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630935862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9zfJ10Pfm6tY+NUZOqcgWvcDv4vFrvtIQI9BdSqbPs=;
        b=OnnX/Qj0r5o0v3kdWp+no17HLfKRBcUSCAhTVKXfWmBh4dm1RGic2llUiZ1ZjZCSvMTB4F
        zHkrwnKn3p7k7nqnGMq19IDvwYq2sKadJ29XTZIRxBfzGJKmD8k2x3Yw6tjTcwuIAIvRsm
        uV4BEg0PoEKdkQ5Sh1YLu+xMCrI+L08=
Date:   Mon, 06 Sep 2021 13:44:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Jackie Liu" <liu.yun@linux.dev>
Message-ID: <f5092b702487f29a245ec2b2725fe9e3@linux.dev>
Subject: Re: [PATCH] mdacon: fix redefinition of 'scr_memsetw'
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <YTXxaU+w0mTgeL2K@kroah.com>
References: <YTXxaU+w0mTgeL2K@kroah.com>
 <20210906102030.1659910-1-liu.yun@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg.=0A=0A=0ASeptember 6, 2021 6:46 PM, "Greg KH" <gregkh@linuxfound=
ation.org> =E5=86=99=E5=88=B0:=0A=0A> On Mon, Sep 06, 2021 at 06:20:30PM =
+0800, Jackie Liu wrote:=0A> =0A>> From: Jackie Liu <liuyun01@kylinos.cn>=
=0A>> =0A>> CONFIG_VGA_CONSOLE=3Dn and CONFIG_MDA_CONSOLE=3Dn will cause =
vt_buffer.h not=0A>> include <asm/vga.h>.=0A>> =0A>> But if we set CONFIG=
_MDA_CONSOLE=3Dm, mdacon.c include <linux/vt_buffer.h>=0A>> is in front o=
f include <asm/vga.h>. VT_BUF_HAVE_MEMSETW is not defined,=0A>> so vt_buf=
fer.h will define a scr_memsetw, after that, vga.h also define=0A>> a scr=
_memsetw, so the repeated definition of scr_memsetw appears, builds=0A>> =
error.=0A>> =0A>> We only need to make vt_buffer.h also contain vga.h whe=
n=0A>> CONFIG_MDA_CONSOLE=3Dm. This problem can be fixed.=0A>> =0A>> BTW,=
 mdacon.c no need to include vga.h forcibly, let vt_buffer.h do it.=0A>> =
=0A>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")=0A> =0A> As this has alway=
s been an issue, how is this really a "fix"?=0A=0AThe problem has always =
existed, but there will be no compilation errors.=0AThe driver needs to i=
nclude <asm/vga.h> at the beginning if we want build=0ACONFIG_MDA_CONSOLE=
=3Dm=0A=0AAfter ac036f9570a2, redefined 'scr_memsetw'. but they are not a=
rm and x86 architectures,=0Aso it's not very important. It can also be Fi=
xes: ac036f9570a2 ("vga: optimise console scrolling")=0A=0A> =0A> How can=
 the above config options be set in this manner, do you have to=0A> do it=
 manually or does a system really need that configuration?=0A=0AThis is a=
 problem reported by my CI, when doing make randomconfigs. Of course,=0At=
his is a very tiny fix.=0A=0A> =0A>> Cc: Greg Kroah-Hartman <gregkh@linux=
foundation.org>=0A>> Cc: linux-fbdev@vger.kernel.org=0A>> Cc: linux-kerne=
l@vger.kernel.org=0A>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>=0A=
>> ---=0A>> drivers/video/console/mdacon.c | 1 -=0A>> include/linux/vt_bu=
ffer.h | 2 +-=0A>> 2 files changed, 1 insertion(+), 2 deletions(-)=0A>> =
=0A>> diff --git a/drivers/video/console/mdacon.c b/drivers/video/console=
/mdacon.c=0A>> index ef29b321967f..5898d01bc492 100644=0A>> --- a/drivers=
/video/console/mdacon.c=0A>> +++ b/drivers/video/console/mdacon.c=0A>> @@=
 -42,7 +42,6 @@=0A>> #include <linux/init.h>=0A>> =0A>> #include <asm/io.=
h>=0A>> -#include <asm/vga.h>=0A>> =0A>> static DEFINE_SPINLOCK(mda_lock)=
;=0A>> =0A>> diff --git a/include/linux/vt_buffer.h b/include/linux/vt_bu=
ffer.h=0A>> index 848db1b1569f..3e71f879e7c0 100644=0A>> --- a/include/li=
nux/vt_buffer.h=0A>> +++ b/include/linux/vt_buffer.h=0A>> @@ -16,7 +16,7 =
@@=0A>> =0A>> #include <linux/string.h>=0A>> =0A>> -#if defined(CONFIG_VG=
A_CONSOLE) || defined(CONFIG_MDA_CONSOLE)=0A>> +#if defined(CONFIG_VGA_CO=
NSOLE) || defined(CONFIG_MDA_CONSOLE) ||=0A>> defined(CONFIG_MDA_CONSOLE_=
MODULE)=0A> =0A> If this really is needed, please use the correct define =
macro that=0A> catches both of these options.=0A=0ADo you have any sugges=
tions? =0A=0AI saw that this file is also written like this=EF=BC=9A=0A./=
arch/arm/mach-pxa/spitz.c:455:#if defined(CONFIG_LEDS_GPIO) || defined(CO=
NFIG_LEDS_GPIO_MODULE)=0A=0A> =0A> thanks,=0A> =0A> greg k-h=0A=0ABest Re=
gards.=0AJackie Liu
