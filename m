Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC743B76A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbhJZQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbhJZQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:42:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E7DC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:39:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f11so14824922pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WxWNa+lAPDWrUIRM78ei9cESplUz+wMsR6fjtR7jUYI=;
        b=JXJ6Fa5RrschvJo/8A0DRih2MQmteS3PQAhrlYtLguRjZzErL/uTIcB1myeD/jJCI6
         rRIfin44MaWU3o+Hd9+Js4R3MuzoYBxzoZC843el7eImRcuazffV8ib0mGsy2D/Z8MrW
         8HnG5Yu1DCenEEd6PVXK61SFnNdiLCzrMzq3ZC/ajEBO8SFtCPmuo2gLxcmbyEgxm8h8
         2hlxb7eOh4ebIWSjf0K3lEcP5D5x/xswRCEjA+phzi3PT5ZxGlo3CEHm3i92Z6uVtSOv
         VnSRHxwIp70F6RtpzFBHc5FIko0XdzthgihmFCfVag/fB15mnhO3x/Zu/E05Tk4WaqY2
         Y8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WxWNa+lAPDWrUIRM78ei9cESplUz+wMsR6fjtR7jUYI=;
        b=LlPj5573xmXUP1C2A2qw6MXsY8qsuQ1et08x1NGOB5Lx5Ig7k9viC/4oKjN8RpIcfQ
         8ffretnWrMcBXll3P5dCmBA/7ysOCfOzkmJQ9klGKPNrmojKX36kEywNNKZFE87USFJo
         wrUHcurrdT8H9NA4dwct0prwiL+zJpYo8uJZs7VmN11xF/JlLpTBfh/4G4fY0IYDH26G
         nrXT7qof942cYuFKZ79fWUPsn07463/suKx3m+VJ6V+/3425B1s2gNbRYoCBwdKubomG
         fpdO9aLZD6W07JqkV9C6Pxh+a9KH1sZNV44aEUJYzscVTzC2nFrX7JcoBp3IPlbaABfU
         QTaQ==
X-Gm-Message-State: AOAM532UwRcE/ZgpADnCb41dh2zIiizwIwimjp+pOnXfiGz1Hf3/0/UQ
        Vfgcov2yAv62OJC2wG+H50eR6Q==
X-Google-Smtp-Source: ABdhPJxvvXfSS7LanheQGKgqFMP+7gv1q96fj5EDXDf4ZN0IHpo1RuaTCOHgZNGPDckYjKYLc+HHHw==
X-Received: by 2002:a63:d14:: with SMTP id c20mr19883904pgl.118.1635266386659;
        Tue, 26 Oct 2021 09:39:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l3sm8278824pff.4.2021.10.26.09.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 09:39:46 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:39:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: Avoid shadowing a local in search_memslots()
Message-ID: <YXgvTnhVWZ0gJdFs@google.com>
References: <20211026151310.42728-1-quic_qiancai@quicinc.com>
 <YXgib3l+sSwy8Sje@google.com>
 <60d32a0d-9c91-8cc5-99bd-7c7a9449f7c1@quicinc.com>
 <7e3fb7c6-265c-d245-dd97-24ab401a8ea3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e3fb7c6-265c-d245-dd97-24ab401a8ea3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021, Paolo Bonzini wrote:
> On 26/10/21 18:14, Qian Cai wrote:
> > > Maybe "pivot"?  Or just "tmp"?  I also vote to hoist the declaration out of the
> > > loop precisely to avoid potential shadows, and to also associate the variable
> > > with the "start" and "end" variables, e.g.
> > Actually, I am a bit more prefer to keep the declaration inside the loop
> > as it makes the declaration and assignment closer to make it easier to
> > understand the code. It should be relatively trivial to avoid potential
> > shadows in the future. It would be interesting to see what Paolo would say.
> 
> You both have good arguments, so whoever writes the patch wins. :)

LOL, KVM's version of Thunderdome.
