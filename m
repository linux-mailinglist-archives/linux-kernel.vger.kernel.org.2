Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF943BE94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 02:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhJ0At1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 20:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhJ0AtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 20:49:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BBC061570;
        Tue, 26 Oct 2021 17:47:01 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q124so1154625oig.3;
        Tue, 26 Oct 2021 17:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xB69BiQvruCUDzQOHPnB7DSueM5V+wuTZ2lx3/6o88=;
        b=k/WFPBeaDle6GpaxhQryQ8xKi5z911CVHoxJ666LxkcFYM8YQrcuReTOBsvTEKbGV3
         V4Dw6e3eSXiADD+e2k27qOzL6GYD5eaF9+nryW/PBeTtsp6g1ocnka9zR3YJfsm/i0HY
         1FALmHZ3ohohuKAgbKfWpGWY1xTAOsIU75LYK8dUbAr+IIHtRi4eqt6iBaNPMQJvrDUV
         e9kuVA8vYLYjkPR2vEoLa3N6AZhwjF9Cmq6wv4V7TugtcPLXsKZFTkqg5DYW+9CRC+sX
         ixJ4nwWIWwDL0R0b5YbWEhqijCCG8PWoUWuDz8bs/BLk9eqP2/34ui4gx5NX/xjtGJYG
         +5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xB69BiQvruCUDzQOHPnB7DSueM5V+wuTZ2lx3/6o88=;
        b=PqpAvRgVV30OfbtULK0MF+K5rUy5ImOgMsoP01vzwRbjuUWHunYzBJcMzHwabsFeGG
         S1n81XakpTxwLWH6XaNKj+WKomsxt6TsbBroi7ZJsTiSbUOnMti+LQ8oFFiFoq6ZKAVQ
         /SAP7Xlldf3YXwJBHcdkrdaaoYg5GYX+RZWlx1qPxeVfNKZqiM9jUrFpB+qDdsUQsTN/
         PC+1bT6MFN+HftLE4Btq7/QoxinsYgA3iRebdw3l1tbTRhERkcLPt9gO675auEEn84+o
         DkIx+HQmrGrCWeBKyDSlgD+I5UaOKviMBYq6ndyP+2pd/iA67hYKnOwodcenqmRevoE2
         k2jw==
X-Gm-Message-State: AOAM533A8hd0rZsZLrb2LSkDzBOrFFFokFgJf0PvKKmmLl/EXzJftCSB
        RGuYtiOqk8Hfa3oPDRB4Nkeuhm/AdLw5TPUK8zw=
X-Google-Smtp-Source: ABdhPJyCwSWEU5JCr0kqNNifxLVLrqFpncRArGWwYqB89CWL/wL711ci9pxXIChUPLzXYXMr8qnijsT5klOeBht3yJ0=
X-Received: by 2002:a05:6808:4d9:: with SMTP id a25mr1512698oie.33.1635295620839;
 Tue, 26 Oct 2021 17:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211020120726.4022086-1-pizhenwei@bytedance.com>
 <CANRm+CxAVA-L0wjm72eohXXWvh9fS7wVFzfKHuEjrsiRFuk9fg@mail.gmail.com>
 <YXB4FHfzh99707EH@google.com> <08757159-1673-5c7b-3efc-e5b54e82d6c3@bytedance.com>
 <CANRm+CzcTUWYJeaj3eWKH84YZYgeMZz3kbpn13c8i97iYGGHFQ@mail.gmail.com>
 <5b718b32-cd92-920e-c474-27b9cafeec60@bytedance.com> <ec014e8d-eb5f-03cc-3ed1-da58039ef034@bytedance.com>
 <YXgnDBOXh2v3gzU4@google.com>
In-Reply-To: <YXgnDBOXh2v3gzU4@google.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 27 Oct 2021 08:46:49 +0800
Message-ID: <CANRm+CygFFnvjrJc7U0zNrSVzH9nC=0Bh=SjhG2pjvRXo_zXgQ@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm: Introduce boot parameter no-kvm-pvipi
To:     Sean Christopherson <seanjc@google.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 at 00:04, Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Oct 25, 2021, zhenwei pi wrote:
> > Hi, Wanpeng & Sean
> >
> > Also benchmark redis(by 127.0.0.1) in a guest(2vCPU), 'no-kvm-pvipi' gets
> > better performance.
> >
> > Test env:
> > Host side: pin 2vCPU on 2core in a die.
> > Guest side: run command:
> >   taskset -c 1 ./redis-server --appendonly no
> >   taskset -c 0 ./redis-benchmark -h 127.0.0.1 -d 1024 -n 10000000 -t get
> >
> > 1> without no-kvm-pvipi:
> > redis QPS: 193203.12 requests per second
> > kvm_pv_send_ipi exit: ~18K/s
> >
> > 2> with no-kvm-pvipi:
> > redis QPS: 196028.47 requests per second
> > avic_incomplete_ipi_interception exit: ~5K/s
>
> Numbers look sane, but I don't think that adding a guest-side kernel param is
> the correct "fix".  As evidenced by Wanpeng's tests, PV IPI can outperform AVIC
> in overcommit scenarios, and there's also no guarantee that AVIC/APICv is even

Our evaluation is a dedicated scenario w/ big VM. The testing from
above is a one-sided view.

    Wanpeng
