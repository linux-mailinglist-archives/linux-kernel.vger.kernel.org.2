Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183DA35EE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhDNHlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhDNHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:41:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:40:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so9990559wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bu4zAf2jISjqqt34xkjaMJooW0UMSg6yw1pdyWLERQ4=;
        b=Rvw2CCqYnzRr0eG8NuAMtT86cq+1bEzMrsRbG6hbIXN7uJKWc0euT2+JOMt8ILTr4L
         Cd3eZiNGMOpl+4l7WqogGNJpv2074iCeVEU8cDxPdvxO+x1Y7VPk1VRy2SlZXVk9V2yi
         iHtpYqRgEPipjDh8y7qSza7EmcZd0CM6Im/M0JmEutemDYt6Dxv1gnYDLAbHs5jO19Gt
         SdmPcITVG2L0ZoynGmwkpTrX8FqsTIrAvHYhZt45oAG7Eb2RSUSl2qjj38bYYqsDCAi9
         8whp+sfHixF3ajigPqaK4BjtJfJS4N+avSx+hEXmeRPSsBOYn/NGAVl/ZxN8c2vhrAJ/
         YKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bu4zAf2jISjqqt34xkjaMJooW0UMSg6yw1pdyWLERQ4=;
        b=Hu7B20H6PPaWcRHkMT9L7fNrJpZirOr7PmR+5EOTW6TxHqMm/sn+qvfcCkI6oWi51T
         syfrJzB1zT8gmu94Che9kTBkZQ8Wq7s/O56nwv8OQOGQSVWIfyhYP0+9tVx0Yqyp8Ahm
         +LbM++ZMXFthG9XycQygL+9j3MJjpD41pjOzCgPGTDKvSIlnAp66koO9ZVIqnh+iR3AV
         E7gcpoyjlN7g2HZVuwmm54fCLa/ojKbOm6bME2pRJgQrpOAfMY3rItbJ1/pWxkHRI5Io
         QfUqcSwYUGrZjf5WVTEyAauItHLZxE3XuibN8cN+TefrkfOEskqUH83Mtz4qACK94480
         OI+g==
X-Gm-Message-State: AOAM530pKFjSi+l1Am5Vj3UAT6OdfcIdmOfeqG0eV17xy5koADDcyghW
        SvyCsh/J+IOnPPE+pp46Tj4=
X-Google-Smtp-Source: ABdhPJzicfqKXDTjyZzMw1BvPHy1tnZGdJKj/uotkVzEENtO4POGZ/pfbRJvrdpvvjD+VtmZJeJj4A==
X-Received: by 2002:a1c:1f92:: with SMTP id f140mr1585117wmf.108.1618386039509;
        Wed, 14 Apr 2021 00:40:39 -0700 (PDT)
Received: from agape.jhs ([5.171.25.35])
        by smtp.gmail.com with ESMTPSA id s8sm22226460wrn.97.2021.04.14.00.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 00:40:39 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:40:36 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210414074035.GA1880@agape.jhs>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com>
 <7008359.Jy8utYDuns@linux.local>
 <20210413194844.GR2531743@casper.infradead.org>
 <3505455.GpAHCVcAZI@linux.local>
 <20210414052150.GO6021@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414052150.GO6021@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:21:50AM +0300, Dan Carpenter wrote:
> On Tue, Apr 13, 2021 at 10:08:32PM +0200, Fabio M. De Francesco wrote:
> > On Tuesday, April 13, 2021 9:48:44 PM CEST Matthew Wilcox wrote:
> > > On Tue, Apr 13, 2021 at 09:45:03PM +0200, Fabio M. De Francesco wrote:
> > > > 1) The driver doesn't call that function from anywhere else than the
> > > > macro. 2) You have explained that the macro add its symbol to a slot
> > > > in an array that would shift all the subsequent elements down if that
> > > > macro is not used exactly in the line where it is.
> > > > 3) Dan Carpenter said that that array is full of null functions (or
> > > > empty slots?).
> > > > 
> > > > Unless that function is called anonymously dereferencing its address
> > > > from the position it occupies in the array, I'm not able to see what
> > > > else means can any caller use.
> > > > 
> > > > I know I have much less experience than you with C: what can go wrong?
> > > 
> > > Here's where the driver calls that function:
> > > 
> > > $ git grep wlancmds drivers/staging/rtl8723bs/
> > > drivers/staging/rtl8723bs/core/rtw_cmd.c:static struct cmd_hdl wlancmds[]
> > > = { drivers/staging/rtl8723bs/core/rtw_cmd.c:               if
> > > (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
> > > drivers/staging/rtl8723bs/core/rtw_cmd.c:                       cmd_hdl
> > > = wlancmds[pcmd->cmdcode].h2cfuns;
> > >
> > OK, I had imagined an anonymous call from its location in the array (as I 
> > wrote in the last phrase of my message). However, I thought that it could 
> > have been an improbable possibility, not a real one.
> > 
> > Linux uses a lot of interesting ideas that newcomers like me should learn. 
> > Things here are trickier than they appear at first sight.
> 
> One trick would be to build the Smatch cross function database.
> 
> https://www.spinics.net/lists/smatch/msg00568.html
> 
> Then you could do:
> 
> $ ~/path/to/smatch_data/db/smdb.py led_blink_hdl
> file | caller | function | type | parameter | key | value |
> drivers/staging/rtl8723bs/core/rtw_cmd.c |       rtw_cmd_thread | rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 | uchar(*)(struct adapter*, uchar*)
> drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread | rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 | uchar(*)(struct adapter*, uchar*)
> drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread | rtw_cmd_thread ptr cmd_hdl |           BUF_SIZE |  1 |            pbuf | 1,4,6,8,12,14,16,19-20,23-24,48,740,884,892,900,960
> 
> 
> Which says that led_blink_hdl() is called as a function pointer called
> "cmd_hdl" from rtw_cmd_thread().
> 
> Hm...  It says it can be called from either rtw_cmd_thread() function
> (the rtl8723bs or rtl8188eu version) which is not ideal.  But also
> basically harmless so whatever...
> 
> regards,
> dan carpenter
> 

very powerful tool.

I tried this:

fabio@agape:~/src/git/kernels/staging$ ~/src/git/smatch/smatch_data/db/smdb.py led_blink_hdl
Traceback (most recent call last):
  File "/home/fabio/src/git/smatch/smatch_data/db/smdb.py", line 725, in <module>
    print_caller_info("", func)
  File "/home/fabio/src/git/smatch/smatch_data/db/smdb.py", line 366, in print_caller_info
    ptrs = get_function_pointers(func)
  File "/home/fabio/src/git/smatch/smatch_data/db/smdb.py", line 53, in get_function_pointers
    get_function_pointers_helper(func)
  File "/home/fabio/src/git/smatch/smatch_data/db/smdb.py", line 38, in get_function_pointers_helper
    cur.execute("select distinct ptr from function_ptr where function = '%s';" %(func))
sqlite3.OperationalError: no such table: function_ptr

I run smatch version 1.71 on Debian Buster machine

what's happened?

thanks in advance,

fabio
