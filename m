Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5397A3FBA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhH3QkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhH3QkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:40:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4286DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:39:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m4so8897537pll.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BA68ktopdfpL/Ye+gOyDT28sdjcO26jU5gO9nU3QSkk=;
        b=OHckqUPMIjVLHTGciUDNy0R2v9aZ2EfGtOEMLQGyIwDXfBdSog8tSj3jLCAqoO2dsl
         XensebSUSD8fSI0pHCYo0pRWnV/hOW6Y1uOW+PfeCxTm9IFkUVsx2xcq2ZSCQetHqvsM
         RwdPvv9bpE4Xvn2Qdc101YzHU0s/nyojxnhYKGHao5KAVxVLKtlowjzbUdV+4XRU7IFU
         KUGjnG/IioBA//IVLCSuMnRpLS5eVg12d2ZDZ9/LP3M400WIPjblczgklQZYsXVNFhYy
         Fb4RLfpavdlzgirDcPhcpe7r1T6A2oOVv+HMKH93Ovv1Qy8QlR6REQvZvw5b+eB6aIOK
         Rm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BA68ktopdfpL/Ye+gOyDT28sdjcO26jU5gO9nU3QSkk=;
        b=uHkI80KQL63lOfyz/xbkeQvtQ2CRctid7TcACIONqtOa/yKBY4vvBgLX+piyxsxoIe
         B3N7mvupAmQRMju7bSfd/Ehc3v1KoIwZPJot2MTJwpVzr8vCM7YENvMN7xracAjD9Cgk
         AMxYrn2acgZH5+8cCG1hciLFgPb8LssMKyeof5FsuO7t5xxmMi4dsXfP6ryImgeFHfXB
         LzR7Du4ZOM7bzLKWEQyLs9jL5jxawxmr0HgP4hFLbMQGxLVZEIDtX7XEFQWfbXXuPe5J
         HHeGDJw5Aq06SduflRdE4DDAwAUVj0N7iBJtWcsRYpMeqSsFh9HNzWvAP7+F6XeiVIWz
         kwrg==
X-Gm-Message-State: AOAM532OHdQHAGG5ATzBGcsxHouW4uoEqMeAD9P4T6v6PBqZ4guAdmgt
        LSVPNvSE3u7H56ReS+OwQZ/cmvWvNChlFMTcJRQ=
X-Google-Smtp-Source: ABdhPJxUCYVZ7UUz7nk2TCye0DdUfBOma2aa9Bk61cmbJ8vdP8vQ+ODYFt53YF/vPm54TqLhv8kfi+gOKjHTGlTBwHA=
X-Received: by 2002:a17:902:82c6:b0:136:59b0:ed17 with SMTP id
 u6-20020a17090282c600b0013659b0ed17mr462549plz.61.1630341558511; Mon, 30 Aug
 2021 09:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAK+bU8e_mue_-a4cm85THkg=MyNOf6O2so4D+22wzG_LPu=4LA@mail.gmail.com>
In-Reply-To: <CAK+bU8e_mue_-a4cm85THkg=MyNOf6O2so4D+22wzG_LPu=4LA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 30 Aug 2021 09:39:07 -0700
Message-ID: <CAADnVQKNNcj_2U_E=3NPgbO76JB4MPZ131zd4ykE4jOt6TAVkg@mail.gmail.com>
Subject: Re: Question related to ( commit 9f691549f76d "bpf: fix struct
 htab_elem layout" )
To:     Etienne Martineau <etmartin101@gmail.com>, yonch@yonch.com
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Chenbo Feng <fengc@google.com>, sashal@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 7:17 AM Etienne Martineau <etmartin101@gmail.com> wrote:
>
> Hi,
>
> I've been staring at this commit for some time and I wonder what were the
> symptoms when the issue was reproduced?
>   "The bug was discovered by manual code analysis and reproducible
>     only with explicit udelay() in lookup_elem_raw()."
>
> I tried various stress test + timing combinations in lookup_elem_raw() but no
> luck.

That fix was a long time ago :)
afair the issue will not look like  a crash, but rather an element
will not be found.
That's what lookup_nulls_elem_raw() is fixing.

> I believe that one of our production boxes ran into that issue lately with a GPF
> in the area of htab_map_lookup_elem(). The crash was seen on an outdated
> 4.9 stable.

Would be great if you can reproduce it on the latest kernel.
