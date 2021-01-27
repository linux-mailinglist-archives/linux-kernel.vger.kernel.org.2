Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629EF305967
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhA0LQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhA0LOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:14:31 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D93C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:13:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t29so960535pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZfcEs6t2I7R15rozZkMFZBuCR3007oZ60LC3nYyYyfM=;
        b=PrhiFimKySrCNEjADxP/RoxYWeWD/L0CCG4KTMobkd8rB/K8aLVA/SbyTdUeVfn1KU
         SYfRXG55iqgTfw9JIY5xhGSl3fqdDBYmvX/hwqHUxoXyHVtzOiGJNIh5BFx+xb8uqdwc
         szmINFJmsWqgs5bb6a5D9XWfoY+NMZ/JpvnQpuyxQcwW1Q3KuMo2D1BarQzUiVqh1n/R
         nRfagxCKEBdyaXGs4SXuOAKezOaoNL8rCyXqmy4vPYy2tLUmCbV+1TxzoIIBnIzX09on
         aPZBg+07YNZG2JkuGyaqrHHoFmHkv00NAR/+UD76G/FS8hXXfAALd+5+UvwmynnItmkr
         klcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfcEs6t2I7R15rozZkMFZBuCR3007oZ60LC3nYyYyfM=;
        b=pBA0cRKlsOI3auyCEn7hYQOoTx5TIOp10QrvdZAtJaDgbn5OZEYOcOYPc/UH2xLQ0X
         CSO3yWCIEbzmzHTEkYRcs1qhPXC0K8mEovTxPB61FHxK7YzPdDzxrkqKJITMdGrLU6jQ
         tq5U5zXngugxA+9hoPmRxTzwB0d+yOr809ZPZSSURIdRrU9rIjZtzVm/irISIl/ZWnSA
         U01RWR0gwB/inM+KbaBI2nrt5ODL3Pq2kaueBRNgp+yI5OaG6H6Sg6YQHCHKtXt5fy9T
         s78ieDCxI/x8yQaKbpvH33eUEkze6B+nZcEyFGUbnv79FwALbgJJqWByhLTIwUl7CO8U
         BGfw==
X-Gm-Message-State: AOAM530CulpRxjwklXB3Uxl/20X+4Mz0+Ye1i0Z6OyJTsaMyLMBJmkgK
        LgowcxI2r8QfBIzALb/wXYXRu/7tkShQNWPQ
X-Google-Smtp-Source: ABdhPJzvFv7V4OnBdJNNGa0ilBF4e/fqIC4G/7GRtB+rXKvqUa35xVgqRQPYxZL4zkzCV68mWf3ECw==
X-Received: by 2002:a62:f207:0:b029:1c0:434b:cc14 with SMTP id m7-20020a62f2070000b02901c0434bcc14mr10117882pfh.11.1611746030607;
        Wed, 27 Jan 2021 03:13:50 -0800 (PST)
Received: from localhost (61-68-227-208.tpgi.com.au. [61.68.227.208])
        by smtp.gmail.com with ESMTPSA id n2sm2058354pfu.42.2021.01.27.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:13:49 -0800 (PST)
Date:   Wed, 27 Jan 2021 22:13:46 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     sblbir@amazon.com, davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid
 status
Message-ID: <20210127111346.GB59838@balbir-desktop>
References: <20201217170009.GA29186@192.168.3.9>
 <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
 <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 10:07:50PM +0800, Weiping Zhang wrote:
> Hello Balbir Singh,
> 
> Could you help review this patch, thanks
> 
> On Mon, Dec 28, 2020 at 10:10 PM Weiping Zhang <zwp10758@gmail.com> wrote:
> >
> > Hi David,
> >
> > Could you help review this patch ?
> >
> > thanks
> >
> > On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> > <zhangweiping@didiglobal.com> wrote:
> > >
> > > If a program needs monitor lots of process's status, it needs two
> > > syscalls for every process. The first one is telling kernel which
> > > pid/tgid should be monitored by send a command(write socket) to kernel.
> > > The second one is read the statistics by read socket. This patch add
> > > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > > then kernel will collect statistics for that pid/tgid.
> > >
> > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

Could you elaborate on the overhead your seeing for the syscalls? I am not
in favour of adding new IOCTL's.

Balbir Singh.
