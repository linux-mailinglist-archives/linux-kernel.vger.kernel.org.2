Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A597A405DB1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbhIITnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344940AbhIITnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:43:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF06C061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 12:41:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s10so5848923lfr.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MiAwSJkdlM3q7lW+2NIC84mnJlfIO/+1BlMfwRFcbeE=;
        b=J6FGIE9uwbqL0+rvyHSZgUsLZy+pRuAap5jTMgiujb4M3LUmi8mHutaAPxSCTMSL1o
         phmkIqJVCwT62rAPr92VTQRpZapgWuL8kTorowvcKtvXLMsOYh2HHK2YZi36zROAidpW
         GaQ7cWDOf/cROEeVmcFUg4BpmB3F39KDNox2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MiAwSJkdlM3q7lW+2NIC84mnJlfIO/+1BlMfwRFcbeE=;
        b=utH4lK/T5yOdgRuEybrfgq5Fk4E2VtVzSByBQv4fMPekzyoiC4bMmwMoDxqlxsOySV
         i0lTjmlmZHQUmS027j9xvlhBmCV5OAODYDQ+KDGK/ueHVMV0omokFkMdn04FSlnylthM
         ASob2DRDYDhJuRLS6BYAzFqD07/iAldQsPIacHyiSixO930OYZhHkdEXbnfW1Pip8BKj
         PfqoY4c1SB+Q92BGnY0ExmLOFNioSUcxosN7GelCyuM5CTs8MCkQAaKJRh8i0fVZRq6f
         diVBy8pHNKNvEZG9u35MDCu1KtSijbW3zDbv/Mp/ep1lUo8wIKHD8tysoQhq16uaJbYF
         g6/Q==
X-Gm-Message-State: AOAM531atTYraTT5sciLKxvcDamCR7CLHAc7I85n67xdDNP2AlEPqoVN
        CTCNbF+c8FBRwthmMecwco0bNayoeHtw5c7CNgw=
X-Google-Smtp-Source: ABdhPJz7+gHVD2tD3B0OJkCy0CWnKvCNq6p9zEcRscJ584f2PJ1UB1aNdIu4h51qxyvvK0/bxZIRdA==
X-Received: by 2002:a05:6512:33d4:: with SMTP id d20mr1091006lfg.57.1631216510508;
        Thu, 09 Sep 2021 12:41:50 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d14sm293520lfl.148.2021.09.09.12.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 12:41:49 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id c8so5916201lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 12:41:49 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr1152936lfg.150.1631216509673;
 Thu, 09 Sep 2021 12:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <YTmNE6/yK5Q+OIAb@zeniv-ca.linux.org.uk>
In-Reply-To: <YTmNE6/yK5Q+OIAb@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 12:41:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOch3=4Nh4tmiAO9UYJZVEeO0UUq8Hegh3JK+pnM9Upg@mail.gmail.com>
Message-ID: <CAHk-=wjOch3=4Nh4tmiAO9UYJZVEeO0UUq8Hegh3JK+pnM9Upg@mail.gmail.com>
Subject: Re: [git pull] gfs2 setattr patches
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 9:27 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.gfs2
>
> for you to fetch changes up to d75b9fa053e4cd278281386d860c26fdbfbe9d03:
>
>   gfs2: Switch to may_setattr in gfs2_setattr (2021-08-13 00:41:05 -0400)

Explanation for what this series actually does?

I can see the shortlog, I can look at the commits, but I really want a
summary in the pull request.

                Linus
