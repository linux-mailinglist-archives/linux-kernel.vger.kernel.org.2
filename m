Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E3E3D7E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhG0TM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhG0TM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:12:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BCBC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:12:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b7so16787149edu.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRkgBmb5lzfe4Hlal/Pv7E6WEWM5a1jmj8pFy4dSgsA=;
        b=DxveKnIun/w3M8tKtwl1ZWwd6hI5DhWiwmZuarvWeDvpYPodXlKjYWoJMciSaYLIMH
         Ur26JsNO8IFDK/mvaI0GPuHgqlQUstFt8X8gXP1cBspUT7BHplZGQyu05i5lLiFkZ9Lf
         pPReF6aUrqaU/3g6BtNVRmMW61d/YuHlMuUh9uCBeTvAUt2FSU//XASIy2RWXUNnDw0Y
         Rz18W03G1V3nT6eJtNEwWshe+juc0+inycDxo0hHq9cBQ/1uph8WtvMScY8lBjUKvxiC
         nWGatM/C0PeBwwoZ25PjtMn0G1sr/krLuLsIAE/TRahCnVikA1c+rBAaCQs1fUQH31AZ
         YFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRkgBmb5lzfe4Hlal/Pv7E6WEWM5a1jmj8pFy4dSgsA=;
        b=LILplnnsbD4Lht/QAISPMrCkWs+kDd5fta4QKMkFP3CeykZ4uSvqKWoaoibTUEYpx3
         Lhx28kXoRSKBCF4tVi2As4bmdjPx2P9FlhnU0iO2G+3bGMM5Y30TvQspM2kxeeNcM5wj
         ZOATJ1jbGwhq+KUGrbEYwHADdqXCuaSumC141shkvth+qTBx4ZC3MChM0qsbrbGZFJr0
         KzLl3f04l9eL7M0+fpPE8H/kqkS6+uM4h8YyzbKsKkRTUlKBG5VeRs8PutxwWMeAikJ3
         geOCZqBSJsZDk+ciCcaJMHV3Jh0lUS8CGJlBg0/Szc2jh3US/u+7IIziwa/53rnH3z/D
         va2g==
X-Gm-Message-State: AOAM532YEWG1NUmaPADMUH7PXXYXwRxrZf6gbUaFYOtlVBL5AgnDoqov
        djYEsmLK2klpCyT57hRoBiPpM9wt7hoXse8e2XXa
X-Google-Smtp-Source: ABdhPJyG+/OuPadqagaupcUDSN3hvYsoqEsGLIubSQ2n8Jdp64B/1dGFnfPy3YkM2lyDnjewbJ3jo4Gf5/9y0I3Sn7A=
X-Received: by 2002:a50:eb88:: with SMTP id y8mr12668309edr.70.1627413144739;
 Tue, 27 Jul 2021 12:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com> <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
 <0fcf5740-2e0f-4da7-be58-77822df54f81@kernel.org>
In-Reply-To: <0fcf5740-2e0f-4da7-be58-77822df54f81@kernel.org>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 27 Jul 2021 12:12:13 -0700
Message-ID: <CAGG=3QXbnK7q2JOkXre5iZLjK3DLUgb0ACaQCZsr1_98unumag@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 7/27/2021 10:39 AM, 'Nick Desaulniers' via Clang Built Linux wrote:
> > Isn't -Wunused-but-set-variable enabled only for W=1 builds?
>
> Maybe Bill's tree does not have commit 885480b08469 ("Makefile: Move
> -Wno-unused-but-set-variable out of GCC only block"), which disables the
> warning for clang just like GCC for regular builds?
>
Ah! I don't have that. It would technically make this patch
unnecessary. Use that information as you see fit.

-bw
