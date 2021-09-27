Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59E0419D87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhI0Rxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbhI0Rwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:52:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E1BC04A521;
        Mon, 27 Sep 2021 10:47:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12so2627267pjj.1;
        Mon, 27 Sep 2021 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F3l7V3cKIhysBnHdpVH14M5RU/mxGtsNtLzKsMdIqDU=;
        b=ABZjUsGBg25hUmnJgTeXUXIctBBZpjyzlZuFDjzyt8H3juc6Zd1DnLzHP9AJepEu+d
         zvfOzeW7+kMfquQ32zz8ReBzI3CcuX/MRi/spdaDli2/hJbxL7Ss7kK45HqchJAhIVY5
         Gn5ZIrqJ5RCmstP+6qFCR2SOhgAUaBR0UgWt90+mmnDsQmhdy2GdxOuiby58/ypM3aFw
         zgYS2gsBBPsz90r/Q625/1IB1H2ak62Ks5rqeSWNGracXpls98i9y3p2BVsfTyxmxRBW
         6Z+EYB0S7B38ULZ2ZnKFn2XmWKpHDvApztLBkHhhyC9FjRy5yl0kQl61osyeOW5d+M5+
         94Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F3l7V3cKIhysBnHdpVH14M5RU/mxGtsNtLzKsMdIqDU=;
        b=Nl1ruQrQhTFtjIOKeVo2KOacE8nBMQWMu5s/+6VguB9JeDCaXerwenV+qzbwo+AAOC
         l6j3+XtOwPhMfBl3W1Qb05fuLQAiSUzbrKo+3lvY0FvvUoIKY+En6Vc1rLJNiWaNUxjD
         wHPEH7zoGJt07xCJWy2bBw/V5JoxpEqSvGfSAMYprQkKwe7ZcisQtMw3O0peRlk1aHTB
         RMEXv1/cb24JrD/oiaswS3BytbyEo2j8ye04RNPP8HZZawjYmzd0iJmg3urpKdtS9DqO
         ga+25ndatbxlHvGYbqnyK2EJVZROUyZ6MyR438N2XOxydDYdXK8ilveSiHDOkAJgIMHx
         PazQ==
X-Gm-Message-State: AOAM533RgrCXuJvgdnsmWViE/jHACMSOrQywON/fOYfneyFrMgzE8j6N
        LC1B50fwhdzsTS+X2ii6DWdB+nnX/sOjqzBSH6dU7w==
X-Google-Smtp-Source: ABdhPJyPO8HQKXTSh640OJ/4s8nf600vJPeY6ow+QQX6WuS/7TcoihZFXoqyqoMr3ZqDUcK9bg0h4w==
X-Received: by 2002:a17:90b:1b0f:: with SMTP id nu15mr337515pjb.181.1632764873772;
        Mon, 27 Sep 2021 10:47:53 -0700 (PDT)
Received: from uver-machine ([2405:201:6006:a148:34d5:ef42:47e8:23a3])
        by smtp.gmail.com with ESMTPSA id d14sm18389970pfq.61.2021.09.27.10.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 10:47:53 -0700 (PDT)
Date:   Mon, 27 Sep 2021 23:17:47 +0530
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: checkpatch: Document some more message
 types
Message-ID: <20210927174727.GA5527@uver-machine>
References: <20210925201746.15917-1-utkarshverma294@gmail.com>
 <875yulj4m8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yulj4m8.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:43:59AM -0600, Jonathan Corbet wrote:
> Utkarsh Verma <utkarshverma294@gmail.com> writes:
> 
> > Added and documented 3 new message types:
> > - UNNECESSARY_INT
> > - UNSPECIFIED_INT
> > - UNNECESSARY_ELSE
> >
> > Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> > ---
> >  Documentation/dev-tools/checkpatch.rst | 47 ++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> 
> So...when you send multiple patches with the same subject line that's
> always a bad sign.  We really want a "git --oneline" listing to give a
> good idea of what the patch does, and that depends on more descriptive
> subject lines.
> 
> In this case, something like:
> 
>   docs: checkpatch: add UNNECESSARY/UNSPECIFIED_INT and UNNECESSARY_ELSE
> 
> I can fix up these two patches, but please try to keep this in mind for
> future work.
> 

Alright, I will keep this in mind.

> (applying the patches now).
> 
> Thanks,
> 
> jon
