Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7013A41F57C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 21:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355542AbhJATLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhJATLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 15:11:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1272C061775;
        Fri,  1 Oct 2021 12:10:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g2so8781014pfc.6;
        Fri, 01 Oct 2021 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hC2UBNs65Z8LHcHw5QkhAHkvVyU6e6QpHcC0iOHliZA=;
        b=JikkKp3sd2dAd7c1mNcj+ilWqZ4WMctWP+E0t9X4J304rifPDTbt0J/1Q0sdFy/t6F
         thmPrDc1rdcSCIXSMw6tyqZOxwi5vT/wOc80yiLIqu7BTAnhrd7AQ2omoyvmrQ1lsqKw
         gKSZ2VUHRCUk4l4Wx6Jsp+Qw69KDBkaKD0ijYk99937q2phAOf0gWXrIlWIed+mKjdDx
         cJehJhQPVi4PDGA4BqEwivDPYIO73iloA/K+BGLNF7OPsfGCPZifX1n/TThfap/5sVFO
         wizpbEyKf2xr0DWVQc1javH7LEE9zie2zxNpnyL8KtCMM0knrNkidLHgmVp9hLZByDN4
         2Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hC2UBNs65Z8LHcHw5QkhAHkvVyU6e6QpHcC0iOHliZA=;
        b=SrvCQuIorEhY/CbV4Fy/PRWkIDX05EwDlkYW+DWWKOlbhsiP7U4eSQwbCJPp7C2Ekx
         fLD+1BdBEe/Wt3bGzgowc0HYsMBUlCtF2P/KH+HO9gYrV7LngTp5QlIUWnPO1f2SpvK/
         6odrd+f1qju8sElYP7rchiPlYUTnSEk6RrWnx6yiYdKpQLP865ZpCbT/bYWHXd/Lt1WM
         Pi3lBY1tVn4PxlxHJrVrRF60t4kc13TlRjQQroeUqANe1iryotNsnW9tJJF8m18AKebO
         QqQD5OF+Yjfx05IhVaiL/CF3xbveIEn9xARYAbkGRMZ7ARNciSB8jma7cljbrYnGruuS
         HQ/A==
X-Gm-Message-State: AOAM530M89QvQWeehdMR/Xz0KRvwnzshVzUWmSmpftwhoDthx8VMoas9
        I0/kP9WZ/TLxEOsuNZ/eM4o7B1FE4FHDtfPT3+Q=
X-Google-Smtp-Source: ABdhPJyJXl1C8v1QKuUPEnkJrI2Xdx0cbewyJ7JUJIVSR4SCGfdjjyXCgAdyk6dXfnDztDA9S64nVA==
X-Received: by 2002:a63:f5e:: with SMTP id 30mr10809591pgp.283.1633115403318;
        Fri, 01 Oct 2021 12:10:03 -0700 (PDT)
Received: from uver-machine ([2405:201:6006:a148:c9bc:b8d0:c5af:34e3])
        by smtp.gmail.com with ESMTPSA id 3sm5578188pjb.19.2021.10.01.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 12:10:02 -0700 (PDT)
Date:   Sat, 2 Oct 2021 00:39:27 +0530
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: checkpatch: Document some more message
 types
Message-ID: <20211001190927.GA18097@uver-machine>
References: <20210925201746.15917-1-utkarshverma294@gmail.com>
 <875yulj4m8.fsf@meer.lwn.net>
 <06f4c72fefeedb5145a940e5a78d50e610acdcc4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06f4c72fefeedb5145a940e5a78d50e610acdcc4.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:53:05AM -0700, Joe Perches wrote:
> On Mon, 2021-09-27 at 11:43 -0600, Jonathan Corbet wrote:
> > Utkarsh Verma <utkarshverma294@gmail.com> writes:
> > 
> > > Added and documented 3 new message types:
> > > - UNNECESSARY_INT
> > > - UNSPECIFIED_INT
> > > - UNNECESSARY_ELSE
> > > 
> > > Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> > > ---
> > >  Documentation/dev-tools/checkpatch.rst | 47 ++++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > 
> > So...when you send multiple patches with the same subject line that's
> > always a bad sign.  We really want a "git --oneline" listing to give a
> > good idea of what the patch does, and that depends on more descriptive
> > subject lines.
> > 
> > In this case, something like:
> > 
> >   docs: checkpatch: add UNNECESSARY/UNSPECIFIED_INT and UNNECESSARY_ELSE
> > 
> > I can fix up these two patches, but please try to keep this in mind for
> > future work.
> > 
> > (applying the patches now).
> 
> The unnecessary_else description isn't particularly good as the
> checkpatch output doesn't describe multiple if/else if/else if type
> returns where the message should not apply.
> 
> For this type of use, the checkpatch message is not necessarily correct
> and because it could be a patch context, there's no way for checkpatch
> to know if it's correct or not.
> 
> 	if (foo) {
> 		...
> 	} else if (bar) {
> 		...
> 		return [val];
> 	} else {
> 		...
> 	}
> 

Sorry, my bad. I have sent a new patch for the UNNECESSARY_ELSE test.
So please do review it.

Maybe we should add a check for the continue statement also, because it is
similar to the break and return statements, and using else after continue
statement is unnecessary.

Regards,
Utkarsh Verma
