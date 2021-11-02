Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD5F443539
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhKBSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhKBSQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:16:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA750C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 11:13:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o18so245827lfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aAa2g6F5cEPDJn1H2dtRZP1YIEtghO4gfoLlk3Pcbw=;
        b=GfYlX9OX1sXNX3bqVCRC2BllZhiCQ8NlGee8f88VSWYP2ig7CAf2Utra5o2oD74c2m
         +LjbuarZU+QVe8722G9iG/Teg9V+KcqsX7jhPWSWsrMbt/+96RWuBKMlxbX1mZC6qwJL
         8y5WE3+1DVmd5KG7eWHV5sNzPGKyrj+Xzf3WdLkvC/FYsEJtUniSvAYJm7MX6ewTxgOy
         FDC2VdZZVY1yQ2bbhwySRoE9HsQ2vLGfsXW80jdTrOFsJ6EKRLaPDzinyL9R8o9A2CJL
         nUvoPS7fgisBAp0eYwymB/TozwaXgxlAMK4KJ6zTIv36tvXmIoyBh1R/s72FpjxvNflN
         aa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aAa2g6F5cEPDJn1H2dtRZP1YIEtghO4gfoLlk3Pcbw=;
        b=cBQoaotdMNW4Js9pHMGDJxLKOoINV1rv/sRr0chqoioJpqXCIKn6ukHPZ2MzgOag0F
         VxBIU5CMqHLhB1w1WUHoxJX4oiFQB6l3PvYkqtXeqqSj35fd6zLh/wnQPvuMAa1IPksS
         RWZ14oIlopLv8lvfJWbz7Sc5q0sAa9OJ/pOvtuzMkOBrX0Uc3iW38Yjhq7OvSrUxI+jO
         Ztar50Y/1RqD8Pi/wNmeuWGJy87k4f6eu78mMv3hy5ITEblUOzFUTF0poa6VE9MOs0/B
         ZulnOcRxnfp/I4S+454IcmncSa+8T0RXeonB9t46m3/cb+Fe66Lxww35fVYxWwgFyHxg
         cpMQ==
X-Gm-Message-State: AOAM531UuB5/tp/TIctKAhjatDr/mQ05YpLrLVLbxyseYC7NsorzIvjE
        v7Dzl5mMd78i/kYMtvQ4cmEIXhyIunc31QsZmOm3GA==
X-Google-Smtp-Source: ABdhPJzQPbuMorJmK9nCRvVx6XoY1VFFKPA5GSxKNeEFkMIqDPnhiabLHyeOXvMUuFZ9AiY07W2nVcpOLfoYU8dKgiA=
X-Received: by 2002:a05:6512:3c9e:: with SMTP id h30mr5245802lfv.93.1635876810700;
 Tue, 02 Nov 2021 11:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211011194615.2955791-1-vipinsh@google.com> <YWSdTpkzNt3nppBc@google.com>
 <CALMp9eRzPXg2WS6-Yy6U90+B8wXm=zhVSkmAym4Y924m7FM-7g@mail.gmail.com>
 <YWhgxjAwHhy0POut@google.com> <CALMp9eQ4y+YO7THjfpHzJPmoODkUqoPUURaBvL+OdGjZhAMuTA@mail.gmail.com>
In-Reply-To: <CALMp9eQ4y+YO7THjfpHzJPmoODkUqoPUURaBvL+OdGjZhAMuTA@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 2 Nov 2021 11:12:53 -0700
Message-ID: <CAHVum0eMByJA5Yc0iom6w5+Web105cYoJ-94jxzLPTLVpYOHSw@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Add a wrapper for reading INVPCID/INVEPT/INVVPID
 type
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply.

On Thu, Oct 14, 2021 at 10:05 AM Jim Mattson <jmattson@google.com> wrote:
>
> On Thu, Oct 14, 2021 at 9:54 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Mon, Oct 11, 2021, Jim Mattson wrote:
> > > On Mon, Oct 11, 2021 at 1:23 PM Sean Christopherson <seanjc@google.com> wrote:
> > > >
> > > > On Mon, Oct 11, 2021, Vipin Sharma wrote:
> > > > > -     if (type > 3) {
> > > > > +     if (type > INVPCID_TYPE_MAX) {
> > > >
> > > > Hrm, I don't love this because it's not auto-updating in the unlikely chance that
> > > > a new type is added.  I definitely don't like open coding '3' either.  What about
> > > > going with a verbose option of
> > > >
> > > >         if (type != INVPCID_TYPE_INDIV_ADDR &&
> > > >             type != INVPCID_TYPE_SINGLE_CTXT &&
> > > >             type != INVPCID_TYPE_ALL_INCL_GLOBAL &&
> > > >             type != INVPCID_TYPE_ALL_NON_GLOBAL) {
> > > >                 kvm_inject_gp(vcpu, 0);
> > > >                 return 1;
> > > >         }
> > >
> > > Better, perhaps, to introduce a new function, valid_invpcid_type(),
> > > and squirrel away the ugliness there?
> >

I might not have understood your auto-updating concern correctly, can
I change these macros to an enum like:

enum INVPCID_TYPE {
        INVPCID_TYPE_INDIV_ADDR,
        INVPCID_TYPE_SINGLE_CTXT,
        INVPCID_TYPE_ALL_INCL_GLOBAL,
        INVPCID_TYPE_ALL_NON_GLOBAL,
        INVPCID_TYPE_MAX,
};

My check in the condition will be then "if (type >= INVPCID_TYPE_MAX) {}"
This way if there is a new type added, max will be auto updated. Will
this answers your concern?

> > Oh, yeah, definitely.  I missed that SVM's invpcid_interception() has the same
> > open-coded check.
> >
> > Alternatively, could we handle the invalid type in the main switch statement?  I
> > don't see anything in the SDM or APM that architecturally _requires_ the type be
> > checked before reading the INVPCID descriptor.  Hardware may operate that way,
> > but that's uArch specific behavior unless there's explicit documentation.
>
> Right. INVVPID and INVEPT are explicitly documented to check the type
> first, but INVPCID is not.

It seems to me that I can move type > 3 check to kvm_handle_invpcid()
switch statement. I can replace BUG() in that switch statement with
kvm_inject_gp for the default case, I won't even need INVPCID_TYPE_MAX
in this case.

If you are fine with this approach then I will send out a patch where
invalid type is handled  in kvm_handle_invpcid() switch statement.

Thanks
Vipin
