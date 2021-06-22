Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E643B0F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFVVFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFVVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:05:41 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EA3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 14:03:24 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 91D30C01B; Tue, 22 Jun 2021 23:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1624395802; bh=HMR4unNIvosEkM7YP6TmchXmd0KH3uqdRi9sNvieci0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXisU0e1ptgLwIoro3Scw6OGxd8eKu3UrK6nfJ+4GoKc1GFCzMUMPtBveeVIlq05U
         7vusR6f3ccsqDwh5tHrehqgallNGnVCvIljpFK1lykePFnrsVAswJ91T7ZJ70OPDdI
         7F5gpDuXvzqRGF2RbGhoJDk+s+6p/+4munKzfpVTrL04XZjsSU3by2xPn7vFdlSm6H
         yD+covM9C2PhSVI5u/FbnuE/yfXr1E596QlYOFAA3yNQ706mMZyehNdZ3MyAxvYKwd
         m0sFJc/XeQ6IhbHdZ73jIRbFo5Vm5yVks5Vqodm22+SJx8emzEn3lkDrhKa2SDrw68
         +2iVp9zq95yEQ==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C7643C009;
        Tue, 22 Jun 2021 23:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1624395802; bh=HMR4unNIvosEkM7YP6TmchXmd0KH3uqdRi9sNvieci0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXisU0e1ptgLwIoro3Scw6OGxd8eKu3UrK6nfJ+4GoKc1GFCzMUMPtBveeVIlq05U
         7vusR6f3ccsqDwh5tHrehqgallNGnVCvIljpFK1lykePFnrsVAswJ91T7ZJ70OPDdI
         7F5gpDuXvzqRGF2RbGhoJDk+s+6p/+4munKzfpVTrL04XZjsSU3by2xPn7vFdlSm6H
         yD+covM9C2PhSVI5u/FbnuE/yfXr1E596QlYOFAA3yNQ706mMZyehNdZ3MyAxvYKwd
         m0sFJc/XeQ6IhbHdZ73jIRbFo5Vm5yVks5Vqodm22+SJx8emzEn3lkDrhKa2SDrw68
         +2iVp9zq95yEQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 963b3b99;
        Tue, 22 Jun 2021 21:03:16 +0000 (UTC)
Date:   Wed, 23 Jun 2021 06:03:01 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jim.cromie@gmail.com
Cc:     kasan-dev@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [V9fs-developer] KCSAN BUG report on p9_client_cb / p9_client_rpc
Message-ID: <YNJQBc4dawzwMrhn@codewreck.org>
References: <CAJfuBxxH9KVgJ7k0P5LX3fTSa4Pumcmu2NMC4P=TrGDVXE2ktQ@mail.gmail.com>
 <YNIaFnfnZPGVd1t3@codewreck.org>
 <CAJfuBxywD3QrsoGszMnVbF2RYcCF7r3h7sCOg6hK7K60E+4qKA@mail.gmail.com>
 <CAJfuBxw-JUpnENT9zNgTq2wdHqH-77pAjNuthoZYbtiCud4T=g@mail.gmail.com>
 <CAJfuBxxsye593-vWtXz5As0vBCYEMm_R9r+JL=YMuD6fg+QGNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfuBxxsye593-vWtXz5As0vBCYEMm_R9r+JL=YMuD6fg+QGNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

let's keep the lists in Cc :)

jim.cromie@gmail.com wrote on Tue, Jun 22, 2021 at 02:55:19PM -0600:
> heres a fuller report - Im seeing some new stuff here.

Thanks, the one two should be the same as p9_client_cb / p9_client_rpc
and p9_client_cb / p9_virtio_zc_request are very similar, and also the
same to the first you had, so the patch didn't really work.

I thought after sending it that it probably needs to be tag =
READ_ONCE(req->tc.tag) instead of just assigning it... Would you mind
trying that?

> Im running in a vm, using virtme, which uses 9p to share host filesystems
> since 1st report to you, Ive added --smp 2 to my testing, it seems to
> have increased reporting

I'm ashamed to say I've just never tried KCSAN... I can give it a try over
the next few weeks* if that patch + READ_ONCE doesn't cut it

(*sorry)

Thanks,
-- 
Dominique
