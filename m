Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53C1430277
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhJPLmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 07:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235006AbhJPLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634384399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tjS9YFlVGwtcWTbzJnOhWSoY+8PFA5sGYT0gTfsGBcw=;
        b=ZdpTbFNszwAvkmv6ltNfNQwPTWMqkUcWZccM5V0hNdxRg27w9//7ZtlyAjxYoVKbyb+BTw
        wdkq4b4yxgC4YjSz+CfM5a30kMhDaWWify95INUiVLcCfn66MDKPPB3xzLj7MUWQR8rpnd
        V3OzoeAXfKGqpYOged4IURGDSL06H1A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-j55KhDaxM420diviVA7Ltw-1; Sat, 16 Oct 2021 07:39:58 -0400
X-MC-Unique: j55KhDaxM420diviVA7Ltw-1
Received: by mail-wm1-f69.google.com with SMTP id p12-20020a05600c204c00b0030da46b76daso1608610wmg.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 04:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tjS9YFlVGwtcWTbzJnOhWSoY+8PFA5sGYT0gTfsGBcw=;
        b=DRahKjfIasNWiPcYXXQ2SnWt2yHTp5qfenlMF4dVrwt6G1f5jyxG4d8a+F9hZcpduL
         A10p8Ilk5+q5K9XOyKPsLmNpdQrAcpP5918fEwvV1+gOjteI1rRHqxF8p4Xq8i9vUA2i
         YS9oLO8zJX7iL5pvIEwEorItOxkZRvPoYLnPzeKjHv3nX7qfYKetaYd5OF/Qg3yATsjW
         9JYAssG6hR8VyyH8GCONCvkqzYsX6aoh6sTQjxXcpZ9ChD4GDvQQeoSj392ejqE8+xzW
         jcjRybQjCL1Vssnnk1Gh8kqX7xY5QfMxRfaRLb/nal8K8d3/HOeGyrGU85fDy9EDT4aY
         TWwQ==
X-Gm-Message-State: AOAM5311yXPR33FtqAvc0sx0SjIV4/lXzxpg1dsfzUgTP5hd/zBX9ZFM
        MaO5gbZD1mdarCzC3S63yN6EBjPY7BX3UGBr5WdmbA3TkQYsW6Jst4TQliLPY1kIJCpx31XWG8u
        vUKs4Rmgw05V49pwK019Mf8jK
X-Received: by 2002:a5d:47ac:: with SMTP id 12mr20371854wrb.352.1634384397271;
        Sat, 16 Oct 2021 04:39:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMbnFqzfoci5oeFVy4BTnkfciAlNCmyxciKO8osAJkH83DA6kseDTUUvad29VpBWcw3rw/Vw==
X-Received: by 2002:a5d:47ac:: with SMTP id 12mr20371836wrb.352.1634384397087;
        Sat, 16 Oct 2021 04:39:57 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id d24sm6867737wmb.35.2021.10.16.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 04:39:56 -0700 (PDT)
Date:   Sat, 16 Oct 2021 13:39:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <YWq6C69rQhUcAGe+@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
 <20211008091336.33616-8-jolsa@kernel.org>
 <20211014162819.5c85618b@gandalf.local.home>
 <YWluhdDMfkNGwlhz@krava>
 <20211015100509.78d4fb01@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015100509.78d4fb01@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:05:09AM -0400, Steven Rostedt wrote:
> On Fri, 15 Oct 2021 14:05:25 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > ATM I'm bit stuck on the bpf side of this whole change, I'll test
> > it with my other changes when I unstuck myself ;-)
> 
> If you want, I'll apply this as a separate change on top of your patch set.
> As I don't see anything wrong with your current code.
> 
> And when you are satisfied with this, just give me a "tested-by" and I'll
> push it too.

sounds great, thanks
jirka

