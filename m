Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8542EFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhJOLsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbhJOLsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:48:20 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4872C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:46:13 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d11so6776130ilc.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihfz0jXlZwuHL87l5wK9+AFSx48nUR+ukAj9B84W2nc=;
        b=qKte9AhEalyQcx/QqP8xB9EOeoqrRNJsInfq+8x9T/9gWvJT8spvXicxCHAfIzmgtx
         hCMrg62Z3KcGSVHA5xAW3SWOim7rGsDhdya/C359OEwtNEuF1eFQWDYPRBZiY26sI3p0
         jOr6hAOixjOYoLd8Xars3R+bxTA+Rfzm3X5etdOhifXfGrtTS37S0caKpqz81ipoqRFK
         tIpw5b0q7/IxKMGRaTpB+JZmCUadzKs84l4/nDSeOOcv0KKTT6bYhVIU41yKdFaM43Zu
         6ZYwka3HVOW7VSECmqZ4QZQtlfDRfISN2upoCKdly9fAUmkLvAsdwNflNKwjGlGNFfgW
         kVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihfz0jXlZwuHL87l5wK9+AFSx48nUR+ukAj9B84W2nc=;
        b=yQ0qrrIPiqg7YxS3Ak30bYWCNIsW93sAnbwmtZjSqPmNNuhWbMWCx3fMwwUv09Qapn
         CbcKJQIKmPNawJCG2GLuHtVYdQYFuIdh6oJtB5Hy1pVV+Ntm/8p16zWTyCqCExujWg/s
         fkUEpy3hXGdsLhUiq4xj6BfgNhFRcDHzySWd/pW7MemdvDC7pIpAqoiYJ1Ooy+719Zbr
         nhwNqKZiPHQJmeKFvNmCJv5xrvpn1k0eosftPFcwbIAtJaKp0i6I52anpVM0L1hIyB48
         WrxuKMxy8VTdZn501bi7eqWoXU3zkCHpyMC6UIYJ7vAb5BDSnKPjkuj421XdX/9S4a4G
         v0rg==
X-Gm-Message-State: AOAM533Rgc4+hqwycRosHgx7aE+OTMg1AlVpMHWwFJJCsUxzMjxk6Fh5
        v8nzoWNXTCfmxwQMCdFojI6d7hIFDcdknmUlSPU=
X-Google-Smtp-Source: ABdhPJxw9M8P2YG3RHxR176KGoEBQFdYF3ZoFZuof+CboFCHd/YKS31/5PT1576OGsMu/sRy+Wyrb0aGq7t2YPOVx50=
X-Received: by 2002:a05:6e02:2141:: with SMTP id d1mr3508167ilv.5.1634298373292;
 Fri, 15 Oct 2021 04:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211015083144.2767725-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20211015083144.2767725-1-linux@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 15 Oct 2021 13:46:02 +0200
Message-ID: <CANiq72nJSUMA=97ioFO_4WV9xPMpFjYrGSHZDM1gW_6mo+YkOw@mail.gmail.com>
Subject: Re: [PATCH] tools: compiler.h: remove duplicate #ifndef noinline block
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:31 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> The same three lines also appear a bit earlier in the same file.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Looks good to me -- they also appear to be at the same level.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
