Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBCC309F17
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 22:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhAaV3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 16:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhAaV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 16:28:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75711C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:27:56 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i63so10253653pfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k5gknQGkGUzASx8c3sQWwxyHAwGAxQHJHYAYO85lVuM=;
        b=jR8CKT6tJsirIhnvYN4jIKMqMJ5kgouxgnU+gsy8J9L7J00WudqhIbr/bzhJlw8if6
         8rqEOkiJTqo+IUEsjxMzvLTMpeIuiILKnop7H0zgb6yn/nxI8QZU/hwP0Tb16TQFc/Y1
         JoTCtPYqRyM4irT6cuvt/Y62A7021eP1V7vjy8PV8eE7syjahvL4DJee9LzfePcBM0aR
         NwWRHIG1HENOyrubWckByn6zLfAz6tBXJ2HCs6O3hDPwh0kpFBD/QFwcHegvyiobuXI4
         ZjXvO0yoKPj1cZwHoVzCRr2uCZ1C5rzEXR8Z83y+NolssZfexd3s3A+5b5QD8/QOSBuR
         Lv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k5gknQGkGUzASx8c3sQWwxyHAwGAxQHJHYAYO85lVuM=;
        b=Y61pcaReyxhXtZlvTgGcIzXPaySWLUStPJi2fBRZCRpUvJrV6Wg0FZibwlHJ1ljA7D
         elWCha1zDD2kPTUbH+2FXNjXa2YfGrINh+4TsVMgRXNkuaUp/vyb5fxRNFX3iOJVhC1i
         KWThZdnKIbTU//Mw59hJqE1KVq+j8lTQA391p0raWSS05ivBpXx0r3hecovNWnBqDQFn
         d6j9O5jFp3dDUQ9F5M07ZZxtsZzULtXEnLCGGUfVf3uYciKhX2mt/sMelQta7PJl1vix
         hs1pwyAKXh8p/cTgtAKszFthzTcPUGPqLs0WOtgrKY2Lpn+E0Xwhe906BaEvuJf/mFmq
         fxPw==
X-Gm-Message-State: AOAM5311uRrofmgoHOrnv5JEKjaAJnyFjd7Hm4bnc8B6GeK6yYrCwwLF
        8eqLZg7ZB3kkcHJeIKqjlsY=
X-Google-Smtp-Source: ABdhPJzpmAvoiBMdL2XIITF8BpfFJkRXIBGtcZpfq2wf+YwUfFGAwfP3D5oSIIK87UmHHlj+TLIyYQ==
X-Received: by 2002:a05:6a00:148a:b029:1ae:6d20:fbb3 with SMTP id v10-20020a056a00148ab02901ae6d20fbb3mr13231343pfu.55.1612128475890;
        Sun, 31 Jan 2021 13:27:55 -0800 (PST)
Received: from localhost (g186.222-224-165.ppp.wakwak.ne.jp. [222.224.165.186])
        by smtp.gmail.com with ESMTPSA id v9sm13175294pju.33.2021.01.31.13.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 13:27:55 -0800 (PST)
Date:   Mon, 1 Feb 2021 06:27:52 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Cc:     geert@linux-m68k.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: use device tree to determine present cpus
Message-ID: <20210131212752.GG2002709@lianli.shorne-pla.net>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
 <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:22:31AM +0100, Jan Henrik Weinstock wrote:
> On 31/01/2021 00:03, Stafford Horne wrote:
> 
> > This looks good, one small comment below.  Can you send the next patch as a v2?
> > 
> > Using 'git format-patch -v2 ...'
> 
> Sorry, was not aware of that, will do better next time!
> 
> > Should we warn on the else case?
> 
> I think it is fine for the kernel to have room for more CPUs than are
> actually present (i.e. NR_CPUs > present_cpus is OK). Other Archs do not
> show a warning in this case either, therefore I also omitted it.

Fair enough.

Reviewed-by: Stafford Horne <shorne@gmail.com>

I can queue this for 5.12 when you send v2.

-Stafford
