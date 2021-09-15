Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2A40C7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhIOPA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhIOPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:00:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263BBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:59:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j13so4710720edv.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUyNTvwye+kPafaOnI2efXLTbx8D91gxZhFPaGgBa+k=;
        b=ain0M3hd5IPb69qG/03ea/REqMNY4Kp9RDkBg6Z4d9hYXfrWI2kFqsARfTjr0wCoVO
         xmiK20FF7bUui0ZXn5Xxw+UqPj514FqfBIP/C7k9nYOSIh0Pk3mjBBD6/6Qk9wRYPutM
         V9S8Au1toYSQCArfKQEEPr6AGJ9CARGPCpGQ5v2r4hV9u/0ddemK1sC4fAjEA+TO58Tx
         OoM/soU5y5zHD4x3xQR5HR4MUgA8l7q75c52k6n5geeUMpZhaC2fYwEboTFZkO6mh4ud
         ebQMAD/WjemqHpAmzaWgrNlecBjzr+EtivaD5VOz/h746n60/iMkQ1X3h2QteI047XTX
         QQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUyNTvwye+kPafaOnI2efXLTbx8D91gxZhFPaGgBa+k=;
        b=MTX1RvDRPKxC9ycH+xD53/uS3zINRwNsbW0PZAjTFxSROH3Blgxlzuk4uW1CfciQDR
         GU0zuZmsKcVcRZqnaf3ZBq0Mu8DqAq02RN0JAcsnTC4RQLv+me7Vyo0ZlHPjmpDvlBeu
         oJ5urRUksE+bitaWIfjZsAA49X9DnwXi8wEeDpxV7R55ffN1Au/Rs7EZ1z9GmGypdIJu
         XlonuHyo3NKXfCUxglu7t6wLNT1MnXOeP1wUrx8xcCb7reZ3t3J0hnp3xtyv6EVtExMq
         o/XIHgRG6ggRGTKSGS2sz0hbm3Rxs6Ict9vTvgvd55fUHBSx4wJ+lDq1FRe0wmKxi4xH
         fLHw==
X-Gm-Message-State: AOAM530/II6XUF1n28noaeEiFJgwn4I7jIHsXlr1MSgiogZspGqEfztK
        Go+tyHLTglCA9qFDoFcFpv9/b8kJm98=
X-Google-Smtp-Source: ABdhPJxMLnU3ZIJKNIZnhw9R15iaT5x3M37FMGTazy54fNU+vcmFffcZJ/v4fKVjDmfrZl6xoDNOHg==
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr490103edc.14.1631717946682;
        Wed, 15 Sep 2021 07:59:06 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id la17sm90688ejb.80.2021.09.15.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 07:59:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>
Subject: Re: [PATCH v5 15/19] staging: r8188eu: hal: Clean up usbctrl_vendorreq()
Date:   Wed, 15 Sep 2021 16:59:03 +0200
Message-ID: <3504293.VdliR8Xgxp@localhost.localdomain>
In-Reply-To: <20210915135301.GF2088@kadam>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com> <20210915124149.27543-16-fmdefrancesco@gmail.com> <20210915135301.GF2088@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 15, 2021 3:53:01 PM CEST Dan Carpenter wrote:
> On Wed, Sep 15, 2021 at 02:41:45PM +0200, Fabio M. De Francesco wrote:
> > Clean up usbctrl_vendoreq () in usb_ops_linux.c. Eventually this function
> > will be deleted but some of the code will be reused later. This cleanup
> > makes code reuse easier.
> >
> Thanks for removing the URL.  This commit message is no longer bad to
> the point where it has to be redone but it's still not great.
> 
> I explicitly told you to leave the irrelevant information out.  I'm
> trying to help you and it's frustrating that you're not listening.  I
> wish that you had just copy and pasted the commit message which I sent.

I'm sorry, seriously. It's hard to listen carefully when I need to do my 
*real* work while trying my best to contribute to the kernel. Sometimes I'm 
so tired that I forget something important or what it is said by reviewers. I 
know that this is not a good excuse, anyway please don't ever think that I 
don't mind of the time you spend on reviews and writing suggestions. 

> This relates the discussion we had about reviewing patches one at a time
> in the order they arrive.  Every patch should be self contained.  It
> should not refer to the past except in the case of explaining the Fixes
> tag and it should not refer to the future except in the case where it
> needs to excuse adding unused infrastructure.  Reviewing is stateless.
> We don't want to know about your plans.
> 
> On the other hand, the commit message doesn't list the changes the
> commit makes as part of the clean up process.  That would have been
> helpful information for me as a reviewer.
> 
> *Sigh*  Whatever...  I would have allowed this commit message but there
> is a bug in the code.
> 
> > +				memcpy(data, io_buf,  len);
> > +		} else {
> > +			/* errors */
> >  			if (status < 0) {
> > -				if (status == (-ESHUTDOWN) || 
status == -ENODEV) {
> > +				if (status == (-ESHUTDOWN || -
ENODEV)) {
> 
> This is a bug so you'll have to redo the patch.

This is the proof of what I was trying to convey with the words above. I 
perfectly knew, since days, that this line is wrong but for some reason that 
I really cannot understand why it's still there.

Thank you very much,

Fabio

> regards,
> dan carpenter
> 




