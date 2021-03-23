Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B759346826
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhCWSxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhCWSw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:52:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:52:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c8so8984917wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VWSxZIz3cwMZsTJkss2dyZVTNsTZ66MdeBljOOjgHOs=;
        b=j6IRExAhRqDGX8+9XatTRZjgraIv/8h3eEOtlpQwWij2J9lTMZs6C9g+NBPsp4LW8/
         54wtgVJLFmraQ915O2x+XsZC83DiDWYxNlBbOAxtzwi4yWJ+vAoz5aLVgNSjwfJU83Ok
         O0xaS7PA2Md6vMXT8Ac6Vx9S+AacGMUDuz2qdV8YpQLzc0AcWsumsDHlwmVJKEKJjxCr
         VdJudFppEJxQ5PTS7bne71bfS7imUTElQUDEIPBQM21WVZ6QjwQkCLJfI57ZZiDzHnzW
         13YHYwv5RkeGjbCumNjr3+SwVxovCwytisO6EiV5nuAXZKCdd2fS8CFggOJgH7+gGh6H
         4jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VWSxZIz3cwMZsTJkss2dyZVTNsTZ66MdeBljOOjgHOs=;
        b=gEw9SI7b3L+CqPqlOwdyS/9GfMatoGLh+7Pt1Ptfw5fnVCEPgWPTcV5Lnzu5YlL1EL
         6quh3Kyo78/scmxB/MGh0LMNiwBq1upK1daBLZGZsD4YA7ODX0fuHmh19HJ/KN45BGWj
         Z8rbsHLUrY5q+Z363JWLbCynN5BBTUjyy+oSG+v8V6fI3SfyDqpjaMf2r3WF2WPvwo0v
         F01hzQBXOM9x+1YuzrKBSyuPWKDlf+ccnbPttVXwuKQobz19uAPlZMzGFq28f0Bvljop
         TKixlnDSW1YbQggI31qHIzyOqvt7rN4i8b6Cz7qMgIYfzfH6/1xVs/KbAQVLu42o/rdh
         fOrA==
X-Gm-Message-State: AOAM532Z8y8VGbtDHbSo2VFc7MV56R82HmaD7FXv6CExuKR6rbOdYg1X
        WuGOJYY5DvYX5KrIYqbXMZmgexoonZqrCg==
X-Google-Smtp-Source: ABdhPJzA8aepXuO7Z/cO2zg/VbCUyGDlDTADU3F3ureU3R8JOZLmZXvyLX9SP9bXCiD5Jcx4osKhyg==
X-Received: by 2002:a5d:6052:: with SMTP id j18mr5453394wrt.295.1616525577617;
        Tue, 23 Mar 2021 11:52:57 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id k12sm24600828wrx.7.2021.03.23.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:52:57 -0700 (PDT)
Date:   Tue, 23 Mar 2021 18:52:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210323185254.GZ2916463@dell>
References: <20210308212952.20774-1-andreas@kemnade.info>
 <20210310094821.GB701493@dell>
 <20210311184033.GJ4962@sirena.org.uk>
 <20210322145925.GY2916463@dell>
 <20210323171143.GA5490@sirena.org.uk>
 <20210323172002.GY2916463@dell>
 <20210323174841.GD5490@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323174841.GD5490@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021, Mark Brown wrote:

> On Tue, Mar 23, 2021 at 05:20:02PM +0000, Lee Jones wrote:
> > On Tue, 23 Mar 2021, Mark Brown wrote:
> > 
> > > On Mon, Mar 22, 2021 at 02:59:25PM +0000, Lee Jones wrote:
> > > > On Thu, 11 Mar 2021, Mark Brown wrote:
> 
> > > > > If there were more users it'd be better to have this in the core so that
> > > > > problems we can detect like cache stuff if that's used but if it's just
> > > > > one broken device it's probably not worth it, this seems like something
> > > > > you'd have to try to end up with and which is going to cause timeout
> > > > > problems with a lot of I2C controllers which would tank performance
> > > > > enough that people would notice.
> 
> > > > So Yoda, is this to go into the core, or stay where it is?
> 
> > > Well, nobody's sent me any patches.
> 
> > Code is still in the driver in v4.
> 
> > My question is; should these functions really live in the SS?
> 
> Perhaps we could avoid using that particular abbreviation.

Too soon?

> Like I say it depends on how common this is - are we seeing other
> devices with the same problem?

I'm not witness to any.  If this is your first encounter too then
maybe just leave it where it is.  At least for the moment.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
