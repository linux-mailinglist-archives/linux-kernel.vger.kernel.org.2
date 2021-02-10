Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F05317237
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhBJVWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhBJVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:21:58 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053AC061788
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:21:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 8so1924898plc.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VmbmOG1RvWgMmrfMbgNf26feXFao3UuT1VTN22bup7c=;
        b=DX0dBvf4d+R7lQL1Ms5GhYCTcBz2ZuWktobEUOjmyGUOZaB4wueIuhiYutLJlarVl5
         N57PH6CnMoyo4mtoUf6OB3LCfdwPTKVrDt9Vs0yDAk5rnANFl8U6YU6ofHlNTLoxSBuQ
         2rbTFgn4Q++/Nlhkmd6Z/gKXl/84cTWwPFEzm+Bx1hsazB6qhHIfX3al1/GirfXMXTCy
         MIB0HRkfGuSyeQprW6LJG0fWHYL6FE7Bw9MxxEIb5joy1c3HF6B5AE9xukxtYZRPSNTk
         E11JjmwVqul6Gv62mS/AreNj8V1arybgM10A40W6djXI+irCsSUHcI6nGBxAzKF/2ZXY
         lGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VmbmOG1RvWgMmrfMbgNf26feXFao3UuT1VTN22bup7c=;
        b=C5XqMk6jPlPN6k7EQL8bJ+PljOrC8noio0A6nDvqChIeUXF9f/OsYKZ7H5B6rQafoH
         I8xYbtIw5Uqkg4eoHXf9XX93pmGPZGhUmwculoToOUlHXUJoOtWsEszNsScq27s+DIQ0
         sHMF2qNVDeVLIFdtd7MP0Tkka6TN6PwX/QcA6EsT5dw1ywvmtrAK4Wh7GlqTgDbsG/Ux
         I63AK8aReirjqte88bweHffQr2P0A+RorD+qbCljHQasoB8x8+vQOb1V9LgcFpSjWFkV
         +1/xhaHGRRVUgXYfrSJLyC2fY7EaNYxV3VSP1uD2w+1zIw68XdArdX2fwOEirMVh9TAw
         Q7Gw==
X-Gm-Message-State: AOAM532b6uSg2qkXu5hHeGuNuzL3P1LlFmd4QFplrD6xp/zoRpEZAPBS
        t2MLunoieWyfdA7E9TiDqUzREQ==
X-Google-Smtp-Source: ABdhPJwpZ7D8Q9O5u4cv8uREKEYN+Xq8fqH7QuuqPQ5opKBvtMaT3UctwRa5RB/sAFK8vqT1HSflDQ==
X-Received: by 2002:a17:902:9a92:b029:e2:dbb6:7442 with SMTP id w18-20020a1709029a92b02900e2dbb67442mr4776919plp.50.1612992078158;
        Wed, 10 Feb 2021 13:21:18 -0800 (PST)
Received: from x1 ([2601:1c0:4701:ae70:7b19:df69:92d6:528e])
        by smtp.gmail.com with ESMTPSA id d10sm3089068pfn.218.2021.02.10.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 13:21:17 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:21:15 -0800
From:   Drew Fustini <drew@beagleboard.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>
Subject: Re: [PATCH v2 1/2] pinctrl: use to octal permissions for debugfs
 files
Message-ID: <20210210212115.GA216435@x1>
References: <20210210074946.155417-1-drew@beagleboard.org>
 <20210210074946.155417-2-drew@beagleboard.org>
 <87437daafdd86fa5c765ff9b17b6c7b097f0c317.camel@perches.com>
 <CAHp75VeJT0dPATD-Ux+JCEYxNTigbOn_6D_F1VQkfL=vuiCBPQ@mail.gmail.com>
 <ef9bc69ea67b70557265f117ce2a09f8019bb17d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef9bc69ea67b70557265f117ce2a09f8019bb17d.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 04:36:00AM -0800, Joe Perches wrote:
> On Wed, 2021-02-10 at 12:18 +0200, Andy Shevchenko wrote:
> > On Wed, Feb 10, 2021 at 10:30 AM Joe Perches <joe@perches.com> wrote:
> > > On Tue, 2021-02-09 at 23:49 -0800, Drew Fustini wrote:
> > 
> > > > -     debugfs_create_file("pinctrl-devices", S_IFREG | S_IRUGO,
> > > > +     debugfs_create_file("pinctrl-devices", 0400,
> > > >                           debugfs_root, NULL, &pinctrl_devices_fops);
> > > 
> > > NAK.  You've changed the permission levels.
> > 
> > NAK is usually given when the whole idea is broken. Here is not the
> > case and you may have helped to amend the patch.
> 
> NAK IMO just means the patch should not be applied, not that the
> concept is broken.
> 
> > ...
> > 
> > > And you have to keep the S_IFREG or'd along with the octal.
> > 
> > Perhaps time to read the code?
> > https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L387
> 
> Then the commit message is also broken.
> 
> > > checkpatch does this conversion using this command line:
> > > 
> > > $ ./scripts/checkpatch.pl -f --show-types --terse drivers/pinctrl/*.[ch] --types=SYMBOLIC_PERMS --fix-inplace
> > 
> > NAK! See above.
> 
> The command line above is for octal conversion of the symbolic permissions.
> 
> Any other conversion would be for a different purpose and that purpose and
> should be described in the commit message.
> 
> 

Thanks for review comments from all.

I will change from the incorrect 0400 to 0444.

As for S_IFREG, it does seem like leaving off S_IFREG is the most common
case when using octal permissions with debugfs_create_*():

$ git grep debugfs_create drivers/ |grep 0444 |grep -v S_IFREG | wc -l
302
$ git grep debugfs_create drivers/ |grep 0444 |grep S_IFREG | wc -l
9

As noted by Andy, this is okay as the S_IFREG flag is added to the mode
__debugfs_create_file() inside fs/debugfs/inode.c. I will note this in
the commit message.

Thank you,
Drew
