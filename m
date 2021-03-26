Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB834B0BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCZUoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZUo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:44:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B40C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 13:44:27 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso6434784otq.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaZsiof8k2Nsj0E+BzNEoPoEx7nmUs5gquVCswdhQ/Y=;
        b=WM5njHIFQpBKXBCUozY8WKxjAOrfj3VF3+FbJZpH/rUIHvO/x7HfHoNz/2kY5JN50i
         czuKfsYyj1xSHRxBRuzlDj3vtnru+V6UW9oGrB/v4iKA9L8TOUUPYgDSZoM91vQW/MD4
         8JwAfxAE70vFXSS7g8aVZml5Tv2RdEqe1SQUPw91MnhbeNnud+U5moKuHaeBFlH4WHDr
         fVyFTo3jSip3B8mva54/lJiR4mPbmhxHKzl+yblQ/7sKAQHoPUXui/NBxSJBqeQm2avv
         h8RfQOgqX5Ja2ptnLLb4c/3pLg3AhhVR4QdAiBayj3KmMk5xSG3cg8cVzJRs4o2rV0ne
         AToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaZsiof8k2Nsj0E+BzNEoPoEx7nmUs5gquVCswdhQ/Y=;
        b=q54JlV3U3wwxUyXU3ufoMI8TSQ6X99RhWvc+rtD1Iyz7u7Tbeml6NUenHo6g+Dgl2d
         TFibV//QvMFJg72Xg9cHm9w7nHe0FeWWTrvnW3YOXzOipcuKE5l37RG0rgocTJxer1fy
         n6XATfTEdXlcFywT1NYbIm0o6vxBKOOqycsyUjmjBMnGXCyDsVt7PPUZ/LXx3N0jA30W
         1FBrTCupeiP8UtPsrRydxjUl3v+3D5be5XIviXxEEc4PGqWLvKGzTPZ+LGuwYazZF+0+
         vWmPt/iyBGKNM5ZkKMcAOLcSFkIBvga4iWtru3BuAkJPsS+KAh9zIzrfjq0Aw4Tt1XFF
         IMiA==
X-Gm-Message-State: AOAM533v5OrrWK9HrWPaAM10sf1feJ4K4gcTkMltLwKqfSb04TaZqDYN
        2KEZ7E+UqDdkp42s3H9zHmIibsvCV3KG4lhMBgA=
X-Google-Smtp-Source: ABdhPJxO1p8gA3bgvG7L/wp9utF+Mnhs32CNzBHXk80UJs+BAuGYx87M7HYJOLl69n5/quEFQcW9jKBTg99B8eYx4go=
X-Received: by 2002:a05:6830:90c:: with SMTP id v12mr13024801ott.179.1616791467155;
 Fri, 26 Mar 2021 13:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
 <87a6qqi064.fsf@mid.deneb.enyo.de> <CALCETrUM1=Db3vmQAhPkt=SktL7+dtUrt5Ef6BP3T1Q6HY3Bmw@mail.gmail.com>
 <87blb5d7zx.fsf@mid.deneb.enyo.de> <CALCETrUXMnutTV=SEs6ot58j32_5=K5Z=G7_57gVZt_GFcuDiw@mail.gmail.com>
 <877dltd569.fsf@mid.deneb.enyo.de>
In-Reply-To: <877dltd569.fsf@mid.deneb.enyo.de>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 26 Mar 2021 13:43:51 -0700
Message-ID: <CAMe9rOp9S0A++Gf1hRoAL4tENk-xRk3yc=_Vx=V_+K63DOXspA@mail.gmail.com>
Subject: Re: Why does glibc use AVX-512?
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 1:35 PM Florian Weimer <fw@deneb.enyo.de> wrote:

>
> All this needs to work transparently without user intervention.  We
> cannot require firmware upgrades to fix the incorrect RTM reporting
> issue (the bug I referenced).  I think we can require software updates
> which tell glibc when to use RTM-enabled string functions if the
> dynamic selection does not work (either for performance reasons, or
> because of the RTM reporting bug).
>
> I want to avoid a situation where one in eight processes fail to work
> correctly because the CPUID checks ran on CPU 0, where RTM is reported
> as available, and then we trap when executing XTEST on other CPUs.

glibc can disable RTM based on CPU model and stepping.

-- 
H.J.
