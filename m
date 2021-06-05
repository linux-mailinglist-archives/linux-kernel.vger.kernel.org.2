Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA539CA38
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 19:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFERfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 13:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFERfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:35:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B46C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 10:34:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o8so15949613ljp.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REtD3sQUY2CNZZ7L/kkisPb7LHWcDlAjQWErJEwmS9Q=;
        b=XpcgMspxhzm0fDb876MPwnlsxb3LwumDBMvd+lFxCaI/oqKyWJqxMXGB38pzA1N2F0
         /RT7qMH1jRkuKhvQ7T4AO7F7t0pYGd0v+VY+3L3mhLdSqitTqHnQVa+YlgKbxcRtnaxG
         Pe666dCCyAMurX8EBSpiBjTbF/z0K5UgOmjb9RUx+hPpcQWpBLMETLa8Dqe9ZbP/xcWb
         xy/ZTPGL9XZJngTCdhZ+YkF4yiP3UJRMbLgxyrhJ6rPfbjeVnH5XgfWi3Cc7Z0VwJzR3
         c5EpgxSafH6zZ2xibyUPomt/Zx/6QmjTqw+TnVMj3AUr31ViXXKdhiLRVsayDLAwGMjg
         rNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REtD3sQUY2CNZZ7L/kkisPb7LHWcDlAjQWErJEwmS9Q=;
        b=r93Uhkl6bh3m0aQhkVZMgp0F1TwtKV15H3mUVTmHuaGUjRRjvxN1Y4apzJYlNspxv9
         ghHktrApsZu++OerVHs1LxFh33IZCBUVUDM1CVo+LlsYRpqjSg0+w0etx5j0g6gUmfvI
         m299OnYHMZjtZOMBq64GCe5ArKJAzeDH4JDbqBPBpi0na85g7mQEW7d1/tsX4nF2fjlP
         8tpaUWajU576FLDNFTv2if1WjklxVIMXhjtdcuYGaHRpnZY3Yae6SnBi1/lbM6wizNdU
         G1u8uDz/9o/cUc7aayERZq78ccE3hcEEp1/MDLLKb7/wy2+D/XDN6ecgquebnyiLrgVJ
         tTrw==
X-Gm-Message-State: AOAM532T1sohTf40u3t5t034oLdpM7dt2P7154QPRE7DY555T7TChs2K
        7vGGGR0q2eLT7UN3SAnY+5PQTTBJl9WfjypG8MI=
X-Google-Smtp-Source: ABdhPJz20LKZAr9K35giDgoxRAqQQJnsSZ/D2Ae+bumOvQ8Gy8g9IFkbXn2KCe3cIMiukuU/jPWRtpgq2KSBrl09180=
X-Received: by 2002:a2e:8146:: with SMTP id t6mr2585941ljg.40.1622914443624;
 Sat, 05 Jun 2021 10:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210605161219.26421-1-dwaipayanray1@gmail.com> <eac3b988f4993a77f8eea3550a6dd5980b25e92f.camel@perches.com>
In-Reply-To: <eac3b988f4993a77f8eea3550a6dd5980b25e92f.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 5 Jun 2021 23:03:52 +0530
Message-ID: <CABJPP5B3jZHnAprT15uEkuAbYPUT49VXRFT+pkubVVep-2=XmA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Fix check for embedded filename
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 10:51 PM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2021-06-05 at 21:42 +0530, Dwaipayan Ray wrote:
> > When checkpatch is run on file contents piped through stdin,
> > it may generate false EMBEDDED_FILENAME warnings if the
> > --file flag is used.
>
> I think this is a "don't do that" scenario and this change
> is not necessary.
>

Okay then. I will drop this.
Sorry for the noise.

Thanks & Regards,
Dwaipayan.
