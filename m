Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E39036C8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbhD0Pcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbhD0Pc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:32:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:31:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h36so40184616lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRPmVW+l8hNmuKSneUNYdhg6EPkPkT9qOMTPIVf8vaQ=;
        b=WvECQx1Lb6QUA9eLy2mj3gWKTvRi2qlDxWJvxkBthHBDfZ1k6fJ+CL1hGO00/dVrWw
         wPIWvoBw+wlYADN0Me7iKLqFSjyRkWlX93t/vKXur51a404hExsx0Fi9/arh1Zx8jWgw
         RyXZ+PeJ9wrOnOw1TFy8SXg+p4uruoka+RSxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRPmVW+l8hNmuKSneUNYdhg6EPkPkT9qOMTPIVf8vaQ=;
        b=I6eZBEcMPFEACc9TmAtcwUYloVlfR/Z0dRbdyg6vpOQW41CVziFnkxC0HjQZAzZVLq
         LA0x+vDojCitobYJMbKmV/BthylsndGU7VS2+mIvPcnUge3YcB9ebnlWZks0FDlfJn2o
         T48zPKGrybcAAidjIJzlwdU+1HdkX31V8Rk065p3GcbDFtzyTB0dslpUjAnoBs49QB9b
         NEIKwD3WWo74ll7YQYL+o7zCgv0cc1u+AvjM0lZcHigB7PiWrpb6w+79HP5C8BmFbsMv
         5rdJVrcuHqXdBGbF1YKgPlKxYzsKDHgJKKnbF6Fcy/Y0U+HpqXlPXofY6rLEw25dupNQ
         MH9Q==
X-Gm-Message-State: AOAM530MV0vJAXnwheOlGyqnCdvIn5eiuPQ0TnpEUDNyjNzk4G0Hh4Ea
        IszeD73+xRE06wH91e5HaznwwJtEAp8DsHpF
X-Google-Smtp-Source: ABdhPJwQRYGGT43GxbqJRURU7T5HZCcj0hBA8gfIa2he/LZ2T0rIoCit1wbCqmy3WIwTrjJWwyOsRw==
X-Received: by 2002:a05:6512:1022:: with SMTP id r2mr17095102lfr.191.1619537501158;
        Tue, 27 Apr 2021 08:31:41 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id n3sm53383lfe.77.2021.04.27.08.31.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 08:31:40 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id y4so54125554lfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:31:40 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr16619989lfu.201.1619537500295;
 Tue, 27 Apr 2021 08:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210427114946.aa0879857e8f.I846942fa5fc6ec92cda98f663df323240c49893a@changeid>
 <4ae9835c535db4f9c0c78f1615f16d56c7083640.camel@sipsolutions.net>
In-Reply-To: <4ae9835c535db4f9c0c78f1615f16d56c7083640.camel@sipsolutions.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 08:31:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsCHfM2XY_0sbXjFKwS5Zzi76w_cErQHg=yAyPKZYuLA@mail.gmail.com>
Message-ID: <CAHk-=whsCHfM2XY_0sbXjFKwS5Zzi76w_cErQHg=yAyPKZYuLA@mail.gmail.com>
Subject: Re: [PATCH] cfg80211: fix locking in netlink owner interface destruction
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Harald Arnesen <harald@skogtun.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 2:59 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Though then again, I'm not sure I have a good pathway into the tree
> right now (pre rc1), so if you want to throw it in sooner that's fine
> too.

Ok, applied with Harald's tested-by added.

Thanks,
           Linus
