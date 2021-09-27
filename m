Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5D4198AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhI0QP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbhI0QP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:15:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CA7C061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:13:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 194so37108254qkj.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3GGkyrom3DTgS/bGXMlfCPlY5tmhfbrDIfBJ3BlpmI=;
        b=FnU5pasGnw/t6IG/Vr00DXAOFAT91ktkE8GSkjIDWDGd4el/SSeNGKwBhAJyJws1d1
         0JSayD7mKqUReGauA3ZZARDRXop/4eWNyewtHi+aTI52mqipxHWeAl5ZeYOOgQQH+2Y8
         2ukDTTOHVOIp7BCmhCh50qQ7Rmm1wKipOgAmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3GGkyrom3DTgS/bGXMlfCPlY5tmhfbrDIfBJ3BlpmI=;
        b=3hQgq3wGKF85pyHVG+C+Qz3nm4G6u69kr3D6LqX78AnD2vgpwqpUug73QS9x/OEdV0
         /G596NC7K3GJdS+JSeDWoOsFDCABzBhPKwvxTID6Am6z4pSmE+TUIt9EPWFosLRZUB4L
         N4Wi5fYhCb9vtXdT8FeKLJJOahkbHfUgihqDU/73kR1rJnSP3YQj9QuSTKftP47QGHEZ
         nytQuOYRL3HdF5x+SLkmwZvu9EmFA+63rvh5OSVN5q1gwvw+g4rW+qB99Qb65iWM2lyD
         5Rfe7PlMDSDC1YInq573qSTz3JcmRKof/QBX9xPteLEGgJotfEzAe5lNVUcZCYZAYPHD
         J40w==
X-Gm-Message-State: AOAM532SVser3Vm9Ihjd5wZ2O2QNxrkcW9n6kClAKo5XJgaR5r1D/70O
        bCFnntCUZq73YfqhRRPhUs/IjA==
X-Google-Smtp-Source: ABdhPJzUroZeu4A0rF6c09CMGFFjlCShBOW4fzZGusJgcCXEuy8+TEU0EDJ0qgrs7Ht4b4Dxf8qxYA==
X-Received: by 2002:a37:44ca:: with SMTP id r193mr804368qka.190.1632759227376;
        Mon, 27 Sep 2021 09:13:47 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id j14sm11375353qtv.36.2021.09.27.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:13:47 -0700 (PDT)
Date:   Mon, 27 Sep 2021 12:13:45 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>, warthog9@kernel.org
Subject: Re: [PATCH RESEND bpf] bpf, s390: Fix potential memory leak about
 jit_data
Message-ID: <20210927161345.vh6w3jffo5w2z6t7@meerkat.local>
References: <1632726374-7154-1-git-send-email-yangtiezhu@loongson.cn>
 <e9665315bc2f244d50d026863476e72e3d9b8067.camel@linux.ibm.com>
 <c02febfc-03e6-848a-8fb0-5bd6802c1869@iogearbox.net>
 <0cc48f4d-f6c0-ab11-64b0-bc219fbfe777@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cc48f4d-f6c0-ab11-64b0-bc219fbfe777@de.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 05:58:54PM +0200, Christian Borntraeger wrote:
> Interestingly enough b4 cannot find the patch email on lore.
> Looks like Tiezhu Yang has indeed connection issues with vger.
> CC Konstantin, in case he knows something.

I'm not actually in charge of vger, so I'm not able to help any further than
adding John to the cc's.

-K
