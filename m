Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F3B310105
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBDXt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhBDXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:49:27 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ACEC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 15:48:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so5545332wre.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 15:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+Q2uu3mtJ218GEh+NneAkHcQuIWLoAibVLNNnrJdfE=;
        b=mbdtuBQrIF7f3POD+AzUG3U1qpgi1DQcg/y/2DlRgeTlRjCdPgBivfC38oVMs8r6zJ
         xaRjgU4BXPvtuLeXU0zZsrlHeMNLvRMq2g/myiOekb2peUtDCbtfCkVNZCQuiI31RbgV
         hQh2cm0VVNGL3jes/7symOYkLM8aKlvwnA7WrnIc7DABrI4fTwdbhLb7tshTCakVskBd
         UrB+MBJ74yiADMT9PmHoTHNrvliNfvd/3R4Kcl3nhdHyydIiTHhU0L2zQHZRRpfkOgld
         rpHlUj0YJcKelAKSk6VCDIhgz6RXJNvKlSH+QgXVjKFV9+6ic3Dz2LwEnT1fahZfnyNP
         qsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+Q2uu3mtJ218GEh+NneAkHcQuIWLoAibVLNNnrJdfE=;
        b=P9D0zmFmNZDTr+eKA9TDkuBZF5+yW+5Z82g4DCobD6McUxmyvmG4/t1X0nKdTey0lo
         i5kAxvbyHId2K96LrUj74a9qKe1opVpffSNyJR6d2oaCnWLBOD+D5pJxq7JKthtn6g6k
         cS7E6eC3nMWpAnZGI9HbqFjN/tIHkaUMUQhH7/X912pcftwtwXgInexuoIpDzxaTIf9P
         Q9JdQeJw2N6KdgV/rDnqcEj5UdSTU/an0F1RUM0jUVHCCHuGxWhpJ+LfTNC1rL8HwTfu
         yc3duVxTDZBzWFuS3VXEedmSr+waQbnFqtftXUwsVBaru2eg8VsB/tlFVG0vKMIIk3Cc
         /Gow==
X-Gm-Message-State: AOAM530U+KP5b5f2GVLM+3OcSbdohtEcGR08FWwWGzduEjMXoUoyr+T/
        K9TILCa3ytKuSfcp1t0DREF4Kz5Lglu1Xg==
X-Google-Smtp-Source: ABdhPJy18vZLH/ZELwQPE5pvoEkmF+U8yvZ9YDbEiV/e2jmo6TKlyeSEuiu0f60mdaHlVWCptBo9jQ==
X-Received: by 2002:a05:6000:1364:: with SMTP id q4mr1822415wrz.335.1612482525672;
        Thu, 04 Feb 2021 15:48:45 -0800 (PST)
Received: from p4 ([151.82.81.135])
        by smtp.gmail.com with ESMTPSA id m22sm11173232wrh.66.2021.02.04.15.48.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 15:48:45 -0800 (PST)
Date:   Thu, 4 Feb 2021 23:48:42 +0000
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        penberg@kernel.org, geert@linux-m68k.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        rppt@kernel.org, giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210204234841.GA19339@p4>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
 <20210201160838.GH1463@shell.armlinux.org.uk>
 <20210201200734.GC15399@p4>
 <20210201201633.GJ1463@shell.armlinux.org.uk>
 <20210201202742.GA17243@p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201202742.GA17243@p4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Feb 01, 2021 at 10:18:26PM +0000, Giancarlo Ferrari wrote:
> Russell,
> 
> On Mon, Feb 01, 2021 at 08:16:33PM +0000, Russell King - ARM Linux admin wrote:
> > On Mon, Feb 01, 2021 at 08:07:37PM +0000, Giancarlo Ferrari wrote:
> > > Hi,
> > 
> > Hi,
> > 
> > > Why we should align 3 ? For the fncpy I suppose.
> > 
> > Slightly arbitary really - it gives a nice 8-byte alignment to the data.
> > .align 2 would also be sufficient.
> > 
> > > I don't know now how to proceed now, as you (Mark and you) do completely
> > > the patch.
> > 
> > Please can you test my patch and let us know if it solves your problem
> > (or even if it works! I haven't tested it beyond build-testing.)
> >

I have tested your patch and it works. I have tested using kexec -l/kexec -e.
Considering that .text var are no more written, I assume the issue is gone.

> 
> sure, unfortunately due to restriction, I hope to test it by the end of the
> week. I hope there will be no rush. Otherwise, please let me know.
> 
> > > You see is my first kernel patch submission :) .
> > 
> > Yay. Sorry for giving you a different patch - Mark is quite right that
> > there's a better solution to this problem, which is eliminating the
> > set_kernel_text_rw() call. The only reason I cooked up the patch was
> > doing that would be more in-depth (as you can see from the increased
> > size of the patch.)
> > 
> 
> I definitely agree with you.
> 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
> 
> Thanks again,
> 
> 
> GF

Can I ask about having it integrated ?

Thanks in advance,


GF
