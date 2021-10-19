Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2730F4337F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhJSOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230487AbhJSOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634652190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxnmlxy+BaLSH+N4pHJPdEHRlGFL6UvTVG5CDeMc9oY=;
        b=Zae1wk5rD2a+0om2V9HzTvX12VKLLK9ZwPnPDypBVI6E8SiEW6uqoYlefrcBuvZa5yXThi
        JxFbi0Ld0xhbz4Esz4vxX0r0RVN5TcrQHWsgnV7EjgTS4IN3o0j1K/G4rAX2NGtps/0NFg
        f2jDjI6KeF4YxWmWRcEQ77Bz3ByY5GY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-EUk16eQCNWq-QXroxWQMyw-1; Tue, 19 Oct 2021 10:03:07 -0400
X-MC-Unique: EUk16eQCNWq-QXroxWQMyw-1
Received: by mail-ed1-f71.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso17718519edn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dxnmlxy+BaLSH+N4pHJPdEHRlGFL6UvTVG5CDeMc9oY=;
        b=YUTdg26/PjlrAPvyVSDSiBKc6PkyUAMNanmIZtSU2QMaqORwWdN7E1G6kYSXJEahA/
         uI5Q/YB8TJh1ynwje1X2+sMBSiFl7CQ67tuFQuXF4hb4V5Go/w1l4MtVMZlYVw+JGj0I
         NB36vRu2KMacAkeyAGzZ4f/PJ33cY0NEnw7hA86lHTjwoqdG3AEEzQPN61X7ugeQZ76X
         jJcxob7VD6AzdiUzVZzjyFE9IKLk4PQhCdYCEvHKzHlgKprPmQPJDZJcZMHghz4yApT3
         vpezP6PgGHxJxW5TaP+dk5njbSHb095deTj4/S8tksXoxDAacIsFsSSowX401zRwyyGX
         ZMzw==
X-Gm-Message-State: AOAM533HtHve+mOPCM5/P3oiYOlL2fZhINr25Db9qtV5A4JSWLByZCri
        NDjLPPqE1wX39Z+kXtJua9+PpSGqH6aIp4uCj+RPVZDByFopVDodhXyMzav6EcovmCpZHxLvyze
        PefZxNZKzLFxBcsYr5oSSZV4A
X-Received: by 2002:a05:6402:358d:: with SMTP id y13mr54934702edc.343.1634652186414;
        Tue, 19 Oct 2021 07:03:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXHhs7gQpZDYN3Tc71banDnKgRQcWlAbGHbDXahYmDAeiA61WKUcTYbGx5d9Mv6Hb2H198DA==
X-Received: by 2002:a05:6402:358d:: with SMTP id y13mr54934621edc.343.1634652185654;
        Tue, 19 Oct 2021 07:03:05 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id j1sm604288edk.53.2021.10.19.07.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:03:05 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:03:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <YW7QFzXrJwoFHkct@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
 <20211008091336.33616-8-jolsa@kernel.org>
 <20211014162819.5c85618b@gandalf.local.home>
 <YWluhdDMfkNGwlhz@krava>
 <20211015100509.78d4fb01@gandalf.local.home>
 <YWq6C69rQhUcAGe+@krava>
 <20211018221015.3f145843@gandalf.local.home>
 <YW7F8kTc3Bl8AkVx@krava>
 <YW7HfV9+UiuYxt7N@krava>
 <20211019093216.058ec98b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019093216.058ec98b@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 09:32:16AM -0400, Steven Rostedt wrote:
> On Tue, 19 Oct 2021 15:26:21 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > when trying to apply on top of my changes  
> > 
> > I updated my ftrace/direct branch, it actually still had the previous
> > version.. sorry, perhaps this is the cause of fuzz
> 
> I just pushed it (including your patches) here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> 
>   ftrace/core
> 
> 
> This is where I keep my WIP code. It should not be used to base anything
> off of, as I rebase it constantly. But it has the current version I plan on
> testing.
> 
> You can make sure the patches in there have your latest version, as you can
> review my patch. I'll update the tags if you give me one.

I'm getting error when compiling:

  CC      kernel/trace/ftrace.o
kernel/trace/ftrace.c: In function ‘modify_ftrace_direct_multi’:
kernel/trace/ftrace.c:5608:2: error: label ‘out_unlock’ defined but not used [-Werror=unused-label]
 5608 |  out_unlock:
      |  ^~~~~~~~~~

looks like out_unlock is nolonger needed, I removed it

jirka

