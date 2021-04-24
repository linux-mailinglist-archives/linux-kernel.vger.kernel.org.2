Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C189A36A02B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhDXI16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 04:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbhDXI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 04:26:44 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F4C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 01:26:05 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id k18so46595223oik.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6/Lgj2H0ed/XrbAD6J3l5Bl7Ju8l+PqTifcTlzDYqAw=;
        b=pC+E2E7fwVBRG4i8kwWyhwApWasHomUai+dhJFxCiW2CspTjBmsRgsI3V2JX//Gjp8
         Tcz/BjeBZPP7+qELv9hWrOfQzjeDCcv3JU2AvCZVM/hwn/8ENVv20YE4WcLFjo/a/ONR
         Bi7bnZWItgKCgswvLZFCS+tOgxdZvmsEnQUvXefJ7e2Wlzwrfk83l041y9pV6P49Qr5j
         8yTeig3RXUotyTH3e5gJ9gYKUwHB4+33mK0I7zWqwgpgt+sK2Am3ZdtASPTqo98oLX4P
         rT12veJk9NgZeZi7/BtyYJKTBnihSmsv2yFKPPeZg3U0AkwKK/zuT2haGEXREMmzUN4p
         plDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6/Lgj2H0ed/XrbAD6J3l5Bl7Ju8l+PqTifcTlzDYqAw=;
        b=SlTNK63f0Xs2s7qWzOBLG1SnSLp+xQ89Qc3/65gPQHYC2e+V69EPV1Oln+UlawZu28
         1ZmtbJlHz5IVMy4ww8dXiXqLr1SBaZlUUwL1EpZCj08FmzGTHwP7njGJxEmDa+5OOVil
         ne3KBhMlHMltImlomfLp6or7sAPj0yl7FKctL4FLudS/jMBbI31sKo2eHkO3fi8yBtUL
         XKAUX76NLPf6c/8mI/bSela/Ytxkeg0qqk9d+d4FPbJzhyTWMO36M34gal0w68ozIIdD
         V0QGcR3HBC1xuJnPJ2sKZILzXikur1BpS0nNoaG5me2ow8R+6Zh3jW/eW3Xe4TcXM8m4
         fDaQ==
X-Gm-Message-State: AOAM533DJqxP0b07R1xNTkrgQZnYct93MtAWHSCUi/LWFKF6Bol1gbfy
        ChQX0aoqM2CFFDAEATeGWe6Oq5igeELjNbp1
X-Google-Smtp-Source: ABdhPJybGksZKUlk+stxmZH1m3GigZn8eCjxU4jOZ28zBZJn3L3kM3UjrkTUcN97YagNjlgvPqmjGw==
X-Received: by 2002:a17:90b:198c:: with SMTP id mv12mr8930796pjb.51.1619252135213;
        Sat, 24 Apr 2021 01:15:35 -0700 (PDT)
Received: from ubuntu ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id ne22sm9631736pjb.5.2021.04.24.01.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 01:15:34 -0700 (PDT)
From:   Ashish Kalra <eashishkalra@gmail.com>
X-Google-Original-From: Ashish Kalra <ashish@ubuntu>
Date:   Sat, 24 Apr 2021 13:45:29 +0530
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ashish Kalra <eashishkalra@gmail.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Romain Perier <romain.perier@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces) warning
Message-ID: <20210424081529.GA1731@ubuntu>
References: <20210420090142.GA4086@ashish-NUC8i5BEH>
 <YIE3IffGcjrkz4ZE@kroah.com>
 <20210423152619.GA2469@ashish-NUC8i5BEH>
 <YIOz6o8gwHv+cAN7@kroah.com>
 <bc8873a274bf489ad856386a9d9ee1110de4c4d3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc8873a274bf489ad856386a9d9ee1110de4c4d3.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:11:05PM -0700, Joe Perches wrote:
> On Sat, 2021-04-24 at 08:00 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 23, 2021 at 08:56:19PM +0530, Ashish Kalra wrote:
> > > On Thu, Apr 22, 2021 at 10:43:13AM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Apr 20, 2021 at 02:31:42PM +0530, Ashish Kalra wrote:
> > > > > Upon running sparse, "warning: incorrect type in argument 1 (different address spaces)
> > > > > is brought to notice for this file.let's add correct typecast to make it cleaner and
> > > > > silence the Sparse warning.
> []
> > >  struct p80211ioctl_req {
> > >         char name[WLAN_DEVNAMELEN_MAX];
> > > -       caddr_t data;
> > > +       void __user *data;
> > > 
> > > Does this looks ok to you and is there any other check possible if this is ok?
> > 
> > Wait, what is "caddr_t"?  Try unwinding that mess first...
> 
> Might not be that simple.
> 
> include/linux/types.h:typedef __kernel_caddr_t  caddr_t;
> include/uapi/linux/coda.h:typedef void * caddr_t;
> include/uapi/asm-generic/posix_types.h:typedef char *           __kernel_caddr_t;
> 
> 
data is part of p80211ioctl_req and is used at two places only inside p80211knetdev_do_ioctl
it seems both places it will be used as void __user* only

	msgbuf = memdup_user(req->data, req->len);
        
	if (result == 0) {
                if (copy_to_user
                    ((void __user *)req->data, msgbuf, req->len)) {
                        result = -EFAULT;
                }
        }

Will it still be problem if we change it from char * to void *.?
is there any way to check how caller of this function will be using it?

