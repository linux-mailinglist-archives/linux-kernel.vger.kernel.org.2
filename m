Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57441160A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbhITNqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhITNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:46:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:45:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v24so61586656eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1fz617FZ3CZyoLN1u3s3Wze+6FtaWEfk02uKFUzgMTk=;
        b=FKSC4DiBL/YSUdvsLwD0FAWYopH7G36rBl0vqnxFN7kYbIFHbkaqnZ0fabtOvWysBq
         Ah3us2z+G3yUC1VpsrBI7GM6C3qZ0lUkIgGK638gOu3VYWUNDFEvxGmEux3ai4y0IeVy
         YEt9p5/FA6Kka0UZOP4aqZFXS7/9AdgkYG9fP6sKFf5zRWE2oRb8FFFtvnOGS1Ohwh5m
         LOFAp0XuQxdNuBe81yJ2rTdniaKJMvMPBpFfIM1ghXlYwa2Y55vuRepyM6n8R8zh+zNN
         lwwrZ3bmCih9riyXsmzkWA+ZqbJb4FzSLb8/gTeQrMX9Ko8fJcBGVfLzu1cLHf6zuE7u
         p5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1fz617FZ3CZyoLN1u3s3Wze+6FtaWEfk02uKFUzgMTk=;
        b=h7xk2ZWqsFlZW3HBRbnmqkVoQhPWP6DngrZgVZC8EbbuMJL+VffbzbPLvw0aM5+RqG
         OzKp2Tq1hbBepfzEUd1E/6+Qn36aoP/jHyQML3oQcyFMCG9lhPwLkA0ldLHBZLVJndLi
         /sTtPyYbi3RbQM9R1zcMWtkNuLTh1P71KLKSp5LtnRaMTE4NnCTDnw/J6KvOVPE1omzS
         oKmpW+LJWJ7Kyikz8B5AE46Q5pynCbQNGN82bhVfnaH2uk1DKhpK5QbySuNLXcBHo9UW
         Rs/8yAPwWm1kXLMQncZXFGfV+BhOADb8qlZA//tN4Ww0gpOq8XXdAjoENntBruAtMZYl
         mvdg==
X-Gm-Message-State: AOAM533uhX909xM2EaZ6dfbUu6lXE6k+M1HJNqE32a/boVypXWU9IXpb
        t6x6YDNr5JK/ZP4dSJWW+34=
X-Google-Smtp-Source: ABdhPJwdQQIO8V4P4wb//Jn+F929PCNJEx3jkfY598Y1f2/TPz8LrB0CD9JiDKOJ0kEpC2F1KAJBXQ==
X-Received: by 2002:a17:906:c2c6:: with SMTP id ch6mr29007292ejb.76.1632145496162;
        Mon, 20 Sep 2021 06:44:56 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id p23sm7308408edw.94.2021.09.20.06.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:44:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 00/19] staging: r8188eu: shorten and simplify calls chains
Date:   Mon, 20 Sep 2021 15:44:53 +0200
Message-ID: <17555679.WE2PrEGejU@localhost.localdomain>
In-Reply-To: <YUh2vtxNxNBmpKHQ@kroah.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com> <YUh2vtxNxNBmpKHQ@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 20, 2021 1:55:42 PM CEST Greg Kroah-Hartman wrote:
> On Mon, Sep 20, 2021 at 01:53:37AM +0200, Fabio M. De Francesco wrote:
> > --- Preface ---
> > 
> > This is v8 of "shorten and simplify calls chain". The first 14 patches
> > have already been applied to staging-testing, so we have been requested
> > to reset the numbering of the remaining patches to 01/19, while 
discarding
> > from this new submission the above-mentioned 14 patches (otherwise we 
would 
> > have submitted a series containing 33 patches).
> > 
> > The following commit message is provided as it was in v7, both for the 
> > purpose of presenting the whole picture to Maintainers, Reviewers, and to 
> > anybody else who may be interested in knowing the entire design and the
> > evolution since v1 to the current v8.
> > 
> > --- Commit message ---
> > 
> > io_ops abstraction is useless in this driver, since there is only one ops
> > registration. Without io_ops we can get rid of indirect calls mess and
> > shorten the calls chain.
> > 
> > Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
> > For this purpose unify the three usb_read8/16/32 into the new
> > usb_read(); make the latter parameterizable with 'size'; embed most of
> > the code of usbctrl_vendorreq() into usb_read() and use in it the new
> > usb_control_msg_recv() API of USB Core.
> > 
> > Shorten the calls chain of rtw_write8/16/32() down to the actual writes.
> > For this purpose unify the four usb_write8/16/32/N() into the new
> > usb_write(); make the latter parameterizable with 'size'; embed most of
> > the code of usbctrl_vendorreq() into usb_write() and use in it the new
> > usb_control_msg_send() API of USB Core.
> > 
> > The code with the modifications was thoroughly tested by Pavel Skripkin
> > using a TP-Link TL-WN722N v2 / v3 [Realtek RTL8188EUS] and by Fabio M.
> > De Francesco using a ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 
Nano].
> > 
> > --- Changelog ---
> > 
> > v7->v8 (old numbering):
> > 	- 1-14:
> > 		Patches applied to staging-testing, so they are 
dropped
> > 		from the current v8;
> > 
> > 	- 15-19:
> > 		Split into 19 patches. Numbering reset to 01. After 
this
> > 		reset, 15-19/19 become 01-19/19 (so we have a total of 
33
> > 		patches in this series. 
> 
> Better, still needs a bit more work.  I took 2 of these to shorten your
> load a bit :)
>
Thanks, Greg. I've already seen that you took those other 2 from the series. 
We are about half way to destination: 14 + 2 already taken. :)

I've not replied to the other messages of yours because they are easy to 
understand, fix or change commit messages, and resend as v9.

Instead I'm replying to this particular message because I'm not able to see 
where "a bit more work" is needed.

Maybe that you don't like that in paragraph "v7->v8 (old numbering" I only  
said that the old 15-19/19 (4 patches) are now split into 19 without further 
information about each logical group within those 19?

Please notice that, immediately after the above-mentioned section there is 
also the "v7->v8 (new numbering for the old 15-19/19):" new section where 
everything is detailed to a level that we considered sufficient.

For your convenience I copy-paste the lines that immediately follow the "old 
numbering" section:

v7->v8 (new numbering for the old 15-19/19):
        - 1-15:
                Old 15/19 and 16/19 are split into 15 patches (as it is 
                required by Greg Kroah-Hartman) in order to make them
                more easily reviewable and for checking that the logic
                is not broken; no significant changes to the resulting
                code;
        - 16-17:
                Old 17/19 and 18/19 become 16/19 and 17/19: There are 
                no significant changes to the code, with the sole
                exception of moving the acquiring of a mutex before
                the test for "bSurpriseRemoved" being 'true';
        - 18-19:
                Old 19/19 is split into new 18/19 and 19/19. The changes
                are split into a first patch that remove a shared buffer
                and a second that remove the mutex protecting the receiving 
                (in usb_read()) and sending (in usb_write()) of the
                USB control messages. 

If it is not what you require, can you please provide some more hints about 
what you would consider the "perfect" approach to rework this changelog?

It would help a lot, because at the moment I cannot see what I'm missing and 
I've been unable to reach Pavel and ask him if he saw something wrong that I 
can't see.

Thanks,

Fabio
> 
> thanks,
> 
> greg k-h
> 




