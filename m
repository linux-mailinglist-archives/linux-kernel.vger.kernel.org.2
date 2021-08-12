Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3D3EA24F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhHLJqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbhHLJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:46:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D0C061765;
        Thu, 12 Aug 2021 02:45:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qk33so10302917ejc.12;
        Thu, 12 Aug 2021 02:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKokAdcSKF80baLZQ7+koBLNIJ4LERzZEALxoHGCtwk=;
        b=bdb3EBJxeKjk0N89T7GmOcuih2cpttFaNCtlbIni0OZLUIsc3lqZHatEBj6nZC/Pll
         qRIm7PuNj0UiG3VOFCPWBzZ1Bn/wcWhq06fJ8q2KLXqLku95oRZZFHofxKFKNN9c97UG
         iciJ7mr4xOH4aoXeBjY+3Id905ixOa3mWoLVM7e7vaMm6TPswSydq2y884VbxBUWcYit
         1makX8bwSSiJl56XieOfsy71jIgHG0/zasFQ/dWPbfZCXPWwIYMg6nJD7Z1TQdHjSqei
         3HTJ2BIASfKbVaNvrswgABp7Df/31wa6lyZxx52DAzchHpoxEJlT+JjPH1P+24O8YfL3
         Ca8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKokAdcSKF80baLZQ7+koBLNIJ4LERzZEALxoHGCtwk=;
        b=TBKwXAlpqpeBZ7WR5A/zR1zk/f/7q7x+wJDnbQSGlvEsQo2BwvwgwBoIjAAgU6xQUB
         PI0VYJdTiNb4O/iBIX7dEtP+2AEAFvPPtJRHZaEscx8GG2KA0MiVM2BgcFpIWiR+9CVn
         iSCU06ruk7B+aEuMSlBTnccLn1SBEO8oK0INAMeE+vYc8ff4ZKOEYqfC6T6Hg2HxAoNM
         dSzXL3XbXhg69lszwkpkFPGJq8LNO8YwOF7Njbzuw1wZT5g9RR4ZFx1hFqn/CwtsNwAO
         1P8xAHoUzpOQmKJ41RLEOLKw4TA5s3HY9BDz78bt0pTKZdHb8S6tvE7tedtID/t2RoyS
         ubaQ==
X-Gm-Message-State: AOAM530x2Y4U/8OTmOtC/ZK/dEnAVR8QjcVtzq1EMUpuXCkr+vBqaLfV
        AWkK3V87AzMDXS3feIiVnMI=
X-Google-Smtp-Source: ABdhPJyoXZ+Mh1K1XcvbgQRCI/JqbxTgKCvUC7yHKp6mKox+3ojxJ8qqIPck2NaQN9EMKNRm5Bxixg==
X-Received: by 2002:a17:906:140e:: with SMTP id p14mr2937931ejc.235.1628761547185;
        Thu, 12 Aug 2021 02:45:47 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id q14sm865866edr.0.2021.08.12.02.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:45:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Muni Sekhar <munisekharrms@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: LDD 3rd ed. - It was: Re: read() via USB bus
Date:   Thu, 12 Aug 2021 11:45:45 +0200
Message-ID: <13470108.apdoE9Qb8s@localhost.localdomain>
In-Reply-To: <YRDq530N/9uu2J0x@kroah.com>
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com> <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com> <YRDq530N/9uu2J0x@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Monday, August 9, 2021 10:44:23 AM CEST Greg KH wrote:
> On Mon, Aug 09, 2021 at 10:15:29AM +0200, Oliver Neukum wrote:
> > On 09.08.21 09:58, Muni Sekhar wrote:
> > > Hi all,
> > > 
> > > PCIe memory mapped registers can be read via readb(), readw(), readl()
> > > kernel API's. Similarly what are the kernel API to read the device
> > > registers via USB bus
> > 
> > [...]
> >
> > I hope this list stays friendly to newcomers and we will answer
> > specific questions, but at this point I must advise you to first
> > read an introductory book.
> 
> Along these lines, take a look at the book, Linux Device Drivers, third
> edition, which is free online, as it has a chapter about USB drivers and
> how they work.  That should help you out to understand the issues
> involved with USB devices.
> 
I've heard that your book, LDD 3rd edition, has become obsolete a long time 
ago and most sample code cannot anymore build. Reading what you wrote above 
seems to contradict what I've been told by others... I must admit that I've 
just had a print copy of it that I have not yet opened for reading, therefore 
maybe that I'm totally wrong in assuming the above.

Do you mind to elaborate a bit more on this subject, please? I mean: can you 
point out which chapters, which content, should be skipped (if there's really 
something which is no more correct/relevant to today's practice of drivers  
development and kernel hacking?

One more question, please... if after carefully studying its content, someone 
wanted to change and update part of the book content to reflect the changes in 
Linux API and in the current best practices, would it be (legally) allowed to 
publish a v4 on GitHub for the convenience of everyone interested in learning 
for free? However, I understand that it would be not so easy to come up with a 
good and error free text if not addressed as a public long term project and 
I'm also not sure of what tools are needed to edit PDF files. (At the moment 
my question is for a hypothetical scenario, just to know whether or not it 
would be technically and legally doable). 

I suppose that the answers to the above questions might be of interest to a 
lot of newcomers like me, so please, if you have time, I'd appreciate to read 
your reply.

Thanks,

Fabio
>
> If you have specific questions after looking at that, and reading the
> basic usb-skeleton.c driver in the kernel source tree, please let us
> know!
> 
> thanks,
> 
> greg k-h




