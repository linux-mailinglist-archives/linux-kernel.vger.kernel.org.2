Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113B5421444
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhJDQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbhJDQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:40:41 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4662FC061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:38:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d207so6494482qkg.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nD/CqNzR9E4HGpSddngZ7NQXINMID609Z0nuYAzxVQ=;
        b=EhHEBOBGv3jAdd0eEwTEevENTAb2AhyLvwesYd92iZLWqj7mTTdpBBgs4KL47AQ0oH
         ZwglecIE1krknfq1btMK26sMK70sIco+nuL8EtgDkDN9ePohB2tzfYyBZi//yhabNZMZ
         QP2aeujeABcZR46+NAT9doCWdbaRbYrX5zVHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nD/CqNzR9E4HGpSddngZ7NQXINMID609Z0nuYAzxVQ=;
        b=z3J5z2bQNdD/q4anm8n7rEaP1Q+54qB3QKcAoxvj0q1YTRFSOWRmaLh5NQFHme3vIs
         L723kXCGAxuBheJt4QHgSDXOl2Ikl4DcHH/PHSguUkqnkTg5flOEqcHk3kSDjOqgFpDw
         eXsrnE2qIpor6wpLSbFgGhs1VRsp64WSgIYoAwkQ95acvKqtYeh9/fQOpoAbYRQIXcqL
         DSLjJ8xyqkXfCx/6W+O6mppzyvaUAduucu++ybe3Ly8fWHc05YI3y2hpcrCJbY0GUCiR
         Q2K8BcHZPGM5c3J764eVCrlfRDUV6XXDL6D4T+1ZVF+zh/Kamfcfm9jPY4Bfi/uAKI7e
         z34Q==
X-Gm-Message-State: AOAM532+P62ziXnxMKfUKIgUVGYYqOu9rHfjzTz3YANgnz5Ywi4jt5cs
        k4SWj5RoyZLUsUwEsPM0DyZ6CNS9MlatKHkv
X-Google-Smtp-Source: ABdhPJzq/r8e69CW3mWs2BGSTZC867hdMlpuMU9Lng43ZAuXI77W4G6yhpRoEAUjsGUfn51CshJF1Q==
X-Received: by 2002:a37:a394:: with SMTP id m142mr10538919qke.62.1633365531276;
        Mon, 04 Oct 2021 09:38:51 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x6sm8563181qts.79.2021.10.04.09.38.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 09:38:51 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id j5so69130467lfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 09:38:51 -0700 (PDT)
X-Received: by 2002:a2e:1510:: with SMTP id s16mr16602800ljd.56.1633365528411;
 Mon, 04 Oct 2021 09:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <270324.1633342386@warthog.procyon.org.uk>
In-Reply-To: <270324.1633342386@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Oct 2021 09:38:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-ANpwDnAJ0HAdbwyti7Z6aBBJT6JEbkta9VjaF30Tcw@mail.gmail.com>
Message-ID: <CAHk-=wj-ANpwDnAJ0HAdbwyti7Z6aBBJT6JEbkta9VjaF30Tcw@mail.gmail.com>
Subject: Re: Do you want warning quashing patches at this point in the cycle?
To:     David Howells <dhowells@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 3:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Do you want patches that quash warnings from W=1

For W=1? No.

The kerneldoc ones might be ok, but actual code fixes have
historically been problematic because W=1 sometimes warns for
perfectly good code (and then people "fix" it to not warn, and
introduce actual bugs).

           Linus
