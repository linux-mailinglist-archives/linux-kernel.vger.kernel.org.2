Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFBF40B4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhINQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhINQdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:33:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDABC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:32:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c21so13019056edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uU34i+EgJe3tqn17AWoGwVGTTIh0KVlY0SraTTmp6T0=;
        b=VZdty0cyn24mKo+cOeBnS1zUwWEVr/Aq14PaZvBBUD6vKS7TpA6mbyHIis/pVaXAaf
         SJ1YKxtYZYsZj/EY0JHr31tuvOq/g1o7mjxt6H1zfFHVSNCDSLB6nO1xycpBsN8+GLla
         CROAP4iHjqNA3Dw+oLPHZ225XyXcBn1WLfKpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uU34i+EgJe3tqn17AWoGwVGTTIh0KVlY0SraTTmp6T0=;
        b=6txFyndrvcaQFxk7nC6MPlA0KQEeL8GASyvCrErUoh3d8t8MngPA3J4yT8WCId3Zyg
         ztS3q9R6cy15GdWHicCoM1BeZZTxN0VQJElh8Z5W8JPGTfTvHsqP0YKqrgjN9vSjI1EH
         2Qo4JV1MsECPMySgRNF0L7uw3LQvKxaU51FptbbkRI1dt2+aV846LRuctBd7dvWhHKQJ
         Sh0TeosOP4IQV9SEsu8ePQNcBJ5eUNYmq9Df2Yw+A9Qpy4Q8YQIl7DUtg+mNh4KjFGbE
         c2/7yFhEuXanYyRdXsI0XgNPQHJTX18wUjpzsf//ZeAkFfBCBVlp02nYKkBr1fmFE9Ln
         RN3A==
X-Gm-Message-State: AOAM531hn+t8iO/u0djFGO4TEN3Xd1sNvpkIoA2mWHuaVYTCcCP4ODsl
        P6bPekGI+jQAZEQDmet9mvuVArQY43tnpyHmnKg=
X-Google-Smtp-Source: ABdhPJzNAPLhc4PSxoAh9Q3/TP3QzazF8YPgKdZmZ2+Pz/c8pCtO02MvZjci0CIPb02vXbNqK+G+QA==
X-Received: by 2002:a05:6402:5c2:: with SMTP id n2mr20332567edx.239.1631637125784;
        Tue, 14 Sep 2021 09:32:05 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id o7sm5641047edt.68.2021.09.14.09.32.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 09:32:05 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id z24so222190ejf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:32:05 -0700 (PDT)
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr15485756ljm.95.1631636661566;
 Tue, 14 Sep 2021 09:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
 <CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com>
In-Reply-To: <CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 09:24:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgR_unCDRZ+8iTb5gBO6bgRkuS4JYBpi25v12Yp6TzWVA@mail.gmail.com>
Message-ID: <CAHk-=wgR_unCDRZ+8iTb5gBO6bgRkuS4JYBpi25v12Yp6TzWVA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fscache: Replace and remove old I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 9:21 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Call it "fallback" or "simple" or something that shows the intent, but
> no, I'm not taking patches that introduce a _new_ interface and call
> it "deprecated".

Put another way: to call something "deprecated", you have to already
have the replacement all ready to go.

And if you have that, then converting existing code to a deprecated
model isn't the way to go.

So in neither situation does it make any sense to convert anything to
a model that is deprecated.

          Linus
