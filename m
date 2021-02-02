Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53DE30B4E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhBBBxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhBBBxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:53:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B30C061573;
        Mon,  1 Feb 2021 17:52:51 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b145so6489744pfb.4;
        Mon, 01 Feb 2021 17:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=4dPB0xdozLnJ4HtFbULqQeJT3HtsViC+HjWIT7oeuiI=;
        b=A596Ysvq014L9mFKZs37S5/W5bTE2ckwYfmpCpJ9nK27wUnTGUHfcS4olYHh1lwEYi
         OG/cmNrMZ26tasIl3Q05IDWl/L7kDiv6u0J6SksFwo9iFK2K6lc9PpwLmyCnDho+mehZ
         AYBbibs05MBm8Z6SI6sJrBe/I9tVoQnacJWdZH3O3fANifne1TFM/clp/0CFlVvuDBLz
         Qk2bF3qevUtqIag/7tnISR7FZ6TkzhH+oFCeAaL99nzf33V/4dcm6ET4hCE9epWFKHFh
         5bHuvJwOh1oKv3pKEGkFwRwA4DJ9G+Rt3XsCWjTgn+a7fqsUHVabiv9qYDTlufjtZfmL
         8IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=4dPB0xdozLnJ4HtFbULqQeJT3HtsViC+HjWIT7oeuiI=;
        b=uR9fwtxKanOLzQ9oGClmWw9o6tsavsJXprn88LxkxNgcbX/x2lCz8XnLE8K0iZ5fGJ
         GcoL+gOzy9JkW3D2jPRlHLTA7JKTzd/+UihKtPFomaKKP6ZU3yRq3nxZxImKu3S3cR7f
         mW2kQ0siYOEvdJpc682MCfCvFnbXYLGnhx4k3lt0SkOeeKSC5or7CikNzKJCDGqUkhpS
         y2wJsY8I/Co2NpaQz2pBpsdG1cOznMfEclmQV+V8Sg459G2h4melV7hZTrszJIaW2OJG
         kzLP/P9mZ9nqlEteo+lMlMZ10E1DOluROoqkJNlaj3GsBuVol8BMy8r1wbV9VAyuMQDV
         dSZg==
X-Gm-Message-State: AOAM533UMLGP7zlZObS/5DbWEheRLNBJdmxDVOkHv3R4Uy3mpLaEuPmL
        urVvz7VqmzUrSFU+m9mwV9w=
X-Google-Smtp-Source: ABdhPJzpk7F4glgCPjEUcr5K297Ke5ORCshoB5cX9ev1Y19QQXM9NU6F/FQlje3ynVyzVGfMyxYuvg==
X-Received: by 2002:a63:a542:: with SMTP id r2mr19669741pgu.211.1612230771093;
        Mon, 01 Feb 2021 17:52:51 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id fs14sm712574pjb.46.2021.02.01.17.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 17:52:50 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:52:34 +0800
From:   Carlis <zhangxuezhi3@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12] staging: fbtft: add tearing signal detect
Message-ID: <20210202095234.000059ca@gmail.com>
In-Reply-To: <CAHp75VenJVOSbAXryGK_BWytRJF=T1zwk5xDimRQOTojoXbMFQ@mail.gmail.com>
References: <1611838435-151774-1-git-send-email-zhangxuezhi3@gmail.com>
        <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
        <20210129130110.00003bb1@gmail.com>
        <CAHp75Vdi4H_zY3+QPSq_wmdf20B9xPeqsOT10JHfMLJESX77gA@mail.gmail.com>
        <20210129215638.000047b0@gmail.com>
        <CAHp75VcdOibSRuSBZYhFtEcVxuammYMfcnrUQGvS6ttArFxj6g@mail.gmail.com>
        <20210130143924.00005432@gmail.com>
        <CAHp75VenJVOSbAXryGK_BWytRJF=T1zwk5xDimRQOTojoXbMFQ@mail.gmail.com>
Organization: Coolpad
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 19:40:21 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Jan 30, 2021 at 8:39 AM carlis <zhangxuezhi3@gmail.com> wrote:
> > On Fri, 29 Jan 2021 16:26:12 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Fri, Jan 29, 2021 at 3:56 PM carlis <zhangxuezhi3@gmail.com>
> > > wrote:  
> > > > On Fri, 29 Jan 2021 12:23:08 +0200
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> 
> ...
> 
> > > > Hi, I apologize for what I said in the previous two emails. I
> > > > missed one email you sent before, and now I probably understand
> > > > what you meant. Here is a version I modified according to your
> > > > suggestion:  
> 
> I have realized that you are mocking stuff in the generic fbtft
> structure for all drivers while only a single one is going to use
> that. Consider moving everything to the driver in question.
> 
> 

hi, 
   Do you mean that i define the TE completion and irq_te in the
   fb_st7789v.c as i did before?
