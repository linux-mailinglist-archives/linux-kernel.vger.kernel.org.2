Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B67E43390D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhJSOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhJSOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634654878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QitIDAaB6JPlOQL4BIGgtdEL9A4rgBCBZ9HTFk1cbE=;
        b=aLcF2rS+kYji2FXQtFIhmutE2oFgHrVZuC5ySsyRJgnwksHXX0vFsvmq/X8LqXiQV/+ReN
        XF15I655POmIikAHd6SnhS9I4pfQInYZu1/FMLbJyaR6aOoUNPw5uJWjETNATncNNnmTq1
        a6bdAGwJeDMlwu45t21Khoa0tDABqVc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-gy_-3f-FMxyOcvQV2bnAiA-1; Tue, 19 Oct 2021 10:47:56 -0400
X-MC-Unique: gy_-3f-FMxyOcvQV2bnAiA-1
Received: by mail-ed1-f72.google.com with SMTP id i7-20020a50d747000000b003db0225d219so13207903edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7QitIDAaB6JPlOQL4BIGgtdEL9A4rgBCBZ9HTFk1cbE=;
        b=SGKs3S/r0eEM3jsVOi6kkRHYUj0IDhUTaDn1xw30th23GVBo4Uh8RSWR2sicE5+qlz
         1E7wLQvpFkdSlGfv1OaYaafPDh9TbWEJRmV6lRv1q+trmoH6SVUl6pRDFnlnkisx0Ot/
         Qwr7M2HhDhJ+kwAPaZguhJbrK/YvXi3U1DkjG/ulWI+IGDrpPFl4bx1c7G/v4ZyAxr5D
         nZ2GYVtaO2Jh7CJ5O4xVCEsxIDla39Yz46nm0zpUODCrBkdmz9yb5aXjpOXyVpvSzCCR
         E2/cpdEhPlDKAIu7B1Rz9P2WW6K2MUaRRZT+HVG6wBuIIdkN22m2nosKPbbrb4G8KjW9
         jisg==
X-Gm-Message-State: AOAM533ApRZW8S8RRtOAmrCxv+yN3Ula5qV+XgMOcSJwsnqRk37XRJnE
        GEigLdkE5VnZMDQ5kULYnFr7SoTxkJYS259Ly18DAhArbVeesihRYCLe+3II4erfSC5Ia7p7ZvA
        U8KyfvqTjE9nMu7Cfl6WbIm0e
X-Received: by 2002:a17:906:7fd8:: with SMTP id r24mr38039464ejs.80.1634654875572;
        Tue, 19 Oct 2021 07:47:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx9fxcScXURO3ssPLUJyeNE+stSJqLagoSf0g8cAZHm+YTrdvGHIthlMvdQcsD8fbSeH/b1w==
X-Received: by 2002:a17:906:7fd8:: with SMTP id r24mr38039444ejs.80.1634654875352;
        Tue, 19 Oct 2021 07:47:55 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id m18sm7600493ejn.62.2021.10.19.07.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:47:55 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:47:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <YW7amQa2DviKapl8@krava>
References: <20211014162819.5c85618b@gandalf.local.home>
 <YWluhdDMfkNGwlhz@krava>
 <20211015100509.78d4fb01@gandalf.local.home>
 <YWq6C69rQhUcAGe+@krava>
 <20211018221015.3f145843@gandalf.local.home>
 <YW7F8kTc3Bl8AkVx@krava>
 <YW7HfV9+UiuYxt7N@krava>
 <20211019093216.058ec98b@gandalf.local.home>
 <YW7QFzXrJwoFHkct@krava>
 <20211019104411.18322063@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019104411.18322063@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:44:11AM -0400, Steven Rostedt wrote:
> On Tue, 19 Oct 2021 16:03:03 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > You can make sure the patches in there have your latest version, as you can
> > > review my patch. I'll update the tags if you give me one.  
> > 
> > I'm getting error when compiling:
> > 
> >   CC      kernel/trace/ftrace.o
> > kernel/trace/ftrace.c: In function ‘modify_ftrace_direct_multi’:
> > kernel/trace/ftrace.c:5608:2: error: label ‘out_unlock’ defined but not used [-Werror=unused-label]
> 
> Ah, I don't think I've been hit by the "-Werror" yet ;-)
> 
> 
> >  5608 |  out_unlock:
> >       |  ^~~~~~~~~~
> > 
> > looks like out_unlock is nolonger needed, I removed it
> 
> My tests would have found this, as it has a check for "new warnings".
> 
> Anyway, was this in your latest patch, or did I pull in and older one?
> 
> That is, should I expect a v2 from you?

it's on top of your ftrace/core, in your change:
  e62d91d8206e ftrace/direct: Do not disable when switching direct callers

just removing the label will fix it

also you can add my ack

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

