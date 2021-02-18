Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F358131E3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 02:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBRB1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 20:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBRB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:27:45 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB00C061786
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 17:27:04 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id w19so654093qki.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 17:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WIYnlQd69xhjP1KtpqKWaiv6gup5kuEJgY01j5TiFII=;
        b=RGT33ivGgyP3f+7nIxfhdZMgSmkX4zKjS6ljUR7Jp1t8fqCxWvc/FNlFBaiVJy5rh1
         LQz+xzZkl4PpVBfgrBBcY+B/APBQaevBRxNxRTu45gY1lY3KLrNPgyn9bJI8vepnWZ2R
         +CXSlcwj9BYt+EtSsljX60dxmo0LRJQoWEs//F4smFq6z4R4Ta7B8mX+Arq5EPUiIMD3
         7bwQ81EMU5hqzDIhbb/8eg+uHHgHq0AlnILlGn7zCu7IxoTzGVBFdWf0cB/7UIRFoMOy
         oQAEdJ/4yToXyB35zNbbEIL0OFzTs/fVZiLeAuG92cgwaV2+2ELqmK74OEDKeoT1pw4L
         haRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIYnlQd69xhjP1KtpqKWaiv6gup5kuEJgY01j5TiFII=;
        b=XfUGNex0Tec02Gi2dMVfF1ZM6l5/0+dQCVCCLcpVYbXLOB5R5y4vdQmkFKmtU9R2+C
         P101bdbAAdL/HCy92UI6WqvZweU9cBZLmz9D85KRoIi7++E58BLXg2B5SCIwMICNuU7Z
         efxnaS1H7CFC+eOKbDcJnXy4GIjZ5cdEGEglEGYTjKquuUXYwLieuhUXh7lAINkS+Bg8
         8vkXifQrnbizRvkMIlYd9XyEfqS1KEHdsVirpV9nyuW26rx4ddFMcdEPWyE1Vx6zWUYp
         SIWGDauvPOXPBOyCkyB0yioDy1gdryuya5gCkRy44oQys5tc3t/dPwp+yxQooJSTuDrF
         Ddhg==
X-Gm-Message-State: AOAM530N3AliESjvQrbsOw8ZVCDaI6LzbdRLgpyzR/lgf1K++/QVpaLl
        mJqcA3Pr9pZ4iqnia2M3F0ALKA==
X-Google-Smtp-Source: ABdhPJxAl17zqIA9kjH7kORlbxNrQ4Zp5oEk6/EN2OItHfxsXghzUOOOFljISpMc/iKRP55OIkNRHg==
X-Received: by 2002:a05:620a:2044:: with SMTP id d4mr2147952qka.93.1613611624232;
        Wed, 17 Feb 2021 17:27:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 76sm2992813qke.95.2021.02.17.17.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 17:27:03 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lCY5u-00AGCk-SA; Wed, 17 Feb 2021 21:27:02 -0400
Date:   Wed, 17 Feb 2021 21:27:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4] tpm: fix reference counting for struct tpm_chip
Message-ID: <20210218012702.GX4718@ziepe.ca>
References: <1613435460-4377-1-git-send-email-LinoSanfilippo@gmx.de>
 <1613435460-4377-2-git-send-email-LinoSanfilippo@gmx.de>
 <20210216125342.GU4718@ziepe.ca>
 <YCvtF4qfG35tHM5e@kernel.org>
 <74bbc76260594a8a8f7993ab66cca104@AcuMS.aculab.com>
 <YC2VM1JI0tECPs7g@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC2VM1JI0tECPs7g@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:14:11AM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 16, 2021 at 04:31:26PM +0000, David Laight wrote:
> > ...
> > > > > +	get_device(&chip->dev);
> > > > > +	chip->devs.release = tpm_devs_release;
> > > > > +	chip->devs.devt =
> > > > > +		MKDEV(MAJOR(tpm_devt), chip->dev_num + TPM_NUM_DEVICES);
> > > 
> > > Isn't this less than 100 chars?
> > 
> > Still best kept under 80 if 'reasonable'?
> > 
> > Really it is just split in the wrong place:
> > 	chip->devs.devt = MKDEV(MAJOR(tpm_devt),
> > 					chip->dev_num + TPM_NUM_DEVICES);
> 
> 
> Well it looks crap IMHO. Would be more reasonable to have it in a single 
> like. And it is legit too, since it is accepted by checkpatch.
> 
> You might break the lines within 80 chars if it is somehow "logically"
> consistent.

FWIW, I've become kind of tired of the style wishywashyness I've
mostly been happy to accept anything that clang-format spits out for
ordinary C constructs.

It is good enough and universally usable. If devs don't have it linked
to their editor to format single expression or format selected blocks,
they are missing out :)

The community consensus on style is quite unclear. Is 1 or 2 above the
majority preference? Does this case fall under the new "use more than
80 cols if it improves readability?" I have no idea.

Frankly, for most people writing driver code, if they consistently use
clang-format their work will be alot better than if they try to do it
by hand. It takes a lot of experiance to reliably eyeball something
close to the kernel style..

Jason
