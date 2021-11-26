Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D245EF5F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377685AbhKZNsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348777AbhKZNqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:46:50 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E4BC061746
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:02:39 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 13so18570221ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TXOwpLv7KDX/kwKg8NXTBcWSQI5gKaFisLYfaSk/F6g=;
        b=SUdbpVmqbbzQ7GMGk5ybLBcdUOA8DYSC2v6K5Tuaxkogxu2DNLA4ClyRinwEuhHJAJ
         mctyH3gQW+gUfkKjDY2mFEhquFNAmjYC60OhMIAOsh921be6Z0RZaak/Ilanf1igyEhX
         nwNb/g+aGgtFVtjXE2WGR/kuzy4dEn8Y3NG8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TXOwpLv7KDX/kwKg8NXTBcWSQI5gKaFisLYfaSk/F6g=;
        b=dEi7kWg2paLAuLvXFLpImJSmQKkZCntcOBDt6TnZtRrBYHXjM8bv95tq3qAFJi+t+V
         8yEFrke61cMpPCUgj+CFmBf5Bp3CbgK7bEK64fOI1S9ty90HlfDeTGW7g4JYlhbWhILH
         XXYThtW4/3QZIj7IZaAhY6XOxkZVSc4zSWPqKXems/Q0r/716pBIDDYzSOaCrPMTyq++
         e0viv+zCaqqMjstNtSW38l5vHf7vuQZQhaDvL8v0eroRmeU1uaS4AZTYXX4FmvdAc0QH
         wMTBZ1EVgm2MdcKPWuRKzTHcbMBJJjNGAWok9gvh6GS5maLyo6PJq0b4nU7rwcYHRecI
         kAvg==
X-Gm-Message-State: AOAM533kRMCj+GJ+2mD4viJiwlmF34xAOCVez2R9AlWbpnlgJN3TroSL
        9NL81wE9mU/YqSoAk7T/NCl/6zu4j3u6Rw==
X-Google-Smtp-Source: ABdhPJxUIahQRLbelSRGX08f9pSLdmcbvpjLK0Wt0SB+d6q+QgKmvzsKL3CRC0Q1NgyqKJbbE8NRFA==
X-Received: by 2002:a2e:9ecb:: with SMTP id h11mr31283952ljk.212.1637931757336;
        Fri, 26 Nov 2021 05:02:37 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id 18sm490378ljr.17.2021.11.26.05.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 05:02:36 -0800 (PST)
Date:   Fri, 26 Nov 2021 14:02:33 +0100
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdchar: prevent unbounded allocation in MEMWRITE ioctl
Message-ID: <YaDa6Znbms3tVkr/@larwa.hq.kempniu.pl>
References: <20211025082104.8017-1-kernel@kempniu.pl>
 <20211122103122.424326a1@xps13>
 <YZ98sDJZIqdhP0NF@larwa.hq.kempniu.pl>
 <20211126103116.5bef6bc0@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126103116.5bef6bc0@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

> >  5. The above causes the driver to receive 2048 bytes of data for a page
> >     write in raw mode, which results in an error that propagates all the
> >     way up to mtdchar_write_ioctl().
> 
> This is definitely far from an expected behavior. Writing a page
> without OOB is completely fine.

Could it be a nandsim quirk?  Sorry, I do not feel qualified enough to
comment on this.  I prepared a code flow analysis below, though.

> > The nandsim driver returns the same error if you pass the following
> > request to the MEMWRITE ioctl:
> > 
> >     struct mtd_write_req req = {
> >         .start = 2048,
> >         .len = 2048,
> >         .ooblen = 0,
> >         .usr_data = 0x10000000,
> >         .usr_oob = NULL,
> >         .mode = MTD_OPS_RAW,
> >     };
> > 
> > so it is not the driver that is broken or insane, it is the splitting
> > process that may cause the MEMWRITE ioctl to return different error
> > codes than before.
> > 
> > I played with the code a bit more and I found a fix which addresses this
> > issue without breaking other scenarios: setting oobbuf to the same
> > pointer for every loop iteration (if ooblen is 0, no OOB data will be
> > written anyway).
> 
> You mean that
> 	{ .user_oob = NULL, .ooblen = 0 }
> fails, while
> 	{ .user_oob = random, .ooblen = 0 }
> works? This seems a little bit fragile.

That is indeed the behavior I am observing with nandsim, even on a
kernel which does not include my patch.

> Could you tell us the origin of the error? Because in
> nand_do_write_ops() if ops->oobbuf is populated then oob_required is
> set to true no matter the value set in ooblen.

Correct - and that is what causes the behavior described above (and why
the tweak I came up with works around the problem).

nand_do_write_ops() calls nand_write_page() with 'oob_required' passed
as the fifth parameter.  In raw mode, nand_write_page() calls
nand_write_page_raw().  Here is what happens there:

 1. nand_prog_page_begin_op() sets up a page programming operation by
    sending a few commands to the chip.  See nand_exec_prog_page_op()
    for details.  Note that since the 'prog' parameter is set to false,
    the last two instructions from the 'instrs' array are not run yet.

 2. 'oob_required' is checked.  If it is set to 1, OOB data is sent to
    the chip; otherwise, it is not sent.

 3. nand_prog_page_end_op() is called to finish the programming
    operation.

At that point, the ACTION_PRGPAGE switch case in ns_do_state_action()
(in drivers/mtd/nand/raw/nandsim.c) checks whether the number of bytes
it received so far for this operation (ns->regs.count, updated by
ns_nand_write_buf() as data is pushed to the chip) equals the number of
bytes in a full page with OOB data (num).  If not, an error is returned,
which results in the NAND_STATUS_FAIL flag being set in the status byte,
triggering an -EIO.

This does not happen for any other MTD operation mode because the chip
callbacks that nand_write_page() invokes in those other modes cause OOB
data to be sent to the chip.

> Plus, the code in mtdchar is clear: .oobbuf is set to NULL if there are
> no OOBs provided by the user so I believe this is a situation that
> should already work. 

Correct, though current mtdchar_write_ioctl() code only looks at the
value of the 'usr_oob' field in the struct mtd_write_req passed to it,
so even if you pass { .usr_oob = <something non-NULL>, .ooblen = 0 }, it
will still set ops.oobbuf to the pointer returned by memdup_user().

-- 
Best regards,
Michał Kępień
