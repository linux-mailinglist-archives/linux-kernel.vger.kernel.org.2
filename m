Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD5F420611
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhJDGxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:53:52 -0400
Received: from smtpcmd0987.aruba.it ([62.149.156.87]:57443 "EHLO
        smtpcmd0987.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhJDGxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:53:49 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Oct 2021 02:53:48 EDT
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id XHiamOL5RFA2gXHiamR1vn; Mon, 04 Oct 2021 08:44:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1633329897; bh=ZXd24EC2NVel/nggpn8N0jza7n3fZ/Wk9GcF8zceENc=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=Rn7oJvxLoiAV5Aww/InhElfmrWCOpUrYTbQUgPwm7oPf++ioSykvu+psY93iK8jce
         NS9ZZsjugZywgnOpljxohbInepglkcd2apDomG3cC30jDmaaaWClxmhnIyMm9zd8KT
         P8j6GAqNF/Ue1n3jysWxv8cYbMGTnvOHB6/sUOd54YJIWjvklKs0XolSInoOge5hKi
         a+pupAkfitbXq3MnNlVK6GJHdA+ND6CR1Tcnzzedoir3GaROM/4u86i19J7U0hS5j2
         9cc1pNIYuCP5eGs9eIg4DyxPPklgDS9O7lJfA6TyR+wCrri97IfSc+zzXC5h0KTQZ6
         uieammQeuG+/g==
Subject: Re: [PATCH v2 1/1] pps: generators: pps_gen_parport: Switch to use
 module_parport_driver()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <lasaine@lvk.cs.msu.su>
References: <20211001150316.12545-1-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <2bee95f7-d54d-5d65-3c9b-91d8db228b09@enneenne.com>
Date:   Mon, 4 Oct 2021 08:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001150316.12545-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDjUKSpNMZEH/2xJ0/GFxE0lKESYrw4+3Fv5vuTTlinfcL0G5IgfijC/KF2QEgSJUu7mPFd5J1VsFanO5L5EYMl+aacs//ArfHunKPWm/xwgSDYS5BZT
 nvHAANLonst6Iq2Y+BKTTOhiqo+vD3cL/3+vbf8QYNmrtM5ghw4rSVioss0I0RaWQIJ1Kt+TawOqveiBEh1JDbonpxDKEtRSB1GhieNTy5Ynrq1Cpgcj3tN/
 OhwWLw2c39ZgVtBqoo8JDpLfF9PpdfUpnXwdsFVd8LY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/21 17:03, Andy Shevchenko wrote:
> Switch to use module_parport_driver() to reduce boilerplate code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: remove useless message (Greg), Cc to the original (hopefully) author
>  drivers/pps/generators/pps_gen_parport.c | 42 ++++--------------------
>  1 file changed, 7 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
> index 6a1af7664f3b..fba6c490977c 100644
> --- a/drivers/pps/generators/pps_gen_parport.c
> +++ b/drivers/pps/generators/pps_gen_parport.c
> @@ -20,8 +20,6 @@
>  #include <linux/hrtimer.h>
>  #include <linux/parport.h>
>  
> -#define DRVDESC "parallel port PPS signal generator"
> -

I suppose this is not so important to be able to switch to use
module_parport_driver(), isn't it?

However, aprat this silly note, the patch is OK for me. :)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
