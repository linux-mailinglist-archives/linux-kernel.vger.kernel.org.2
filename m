Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E320400CCD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhIDTOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 15:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236909AbhIDTOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 15:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630782825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WBSi8nTL2nbxE9L6Uzaa8E6icfUP8Id4bMZJ4LABMcs=;
        b=DKiLLvoZXv1GnAtNiT/Uo2voIut80cRh+0gLCvC2nOAkKQXunaI0zdu7/YBuvLcTLmr5zO
        NfCK5TerTZ6FWHi7BlnfuSb6ZKShzU1284hPTMD3ipgDEOSQ+oXCSJQ9TPgLkAQgOIWLqz
        +t8MJgbWiVGnfqamr1XPbZqKmPjmdc0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-9r1YOajCMPu01zfrVytBcw-1; Sat, 04 Sep 2021 15:13:43 -0400
X-MC-Unique: 9r1YOajCMPu01zfrVytBcw-1
Received: by mail-oo1-f70.google.com with SMTP id z23-20020a4ad597000000b0029174f63d3eso1643058oos.18
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 12:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WBSi8nTL2nbxE9L6Uzaa8E6icfUP8Id4bMZJ4LABMcs=;
        b=P/7yjn9OEY18gFdk0Lj+lQU2nJMsi7rN2najHNMqpNtqaM4EVoeAMvvzZQeXi8DdOA
         QU+tocmxIgb4lQnhWmsY3S0QXWana4QO9dAvcwMA+EzioQsskRWsuFp0qtYXX7M+/r59
         MCEVpfq19C7HMo2vw93dVGLOIOulIjdUo4a/jJPEJ0te884uPVoJq6SGo501VsE2RUVf
         6PCnrD57NlsPIg2IywKkfO++oesHO/NfrPW2bf0AsoEHqm1p4bVKUYfHjDtyK5tripzC
         AC2XF/MCTD0eHGcwcM0yDQaWZdiEKtulGv7i3q5BCBlMQNmDKw52FO7rn7V6XnXoZ9lE
         Z7ig==
X-Gm-Message-State: AOAM531eflZsyzisIWgti4in8A8kgONppsYjyIT1Wn/d18UW+ewbQ+j6
        uByG9y4meI0jIWAR8fbiEB61BTmxO46O57Oz0iMsRbCgyv1cGtsdHpOt87kB8toExI20hvPajrJ
        nzMIpd5KJQC+0NDsIjTUyf7Ms
X-Received: by 2002:a9d:720d:: with SMTP id u13mr4667151otj.14.1630782823070;
        Sat, 04 Sep 2021 12:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF5y2tVBMPpoLH4B70xM59WXmh/BXOSlAd/YoXQygqVdu/1nyQ3742hphAQN2uKBGNiPURcQ==
X-Received: by 2002:a9d:720d:: with SMTP id u13mr4667132otj.14.1630782822839;
        Sat, 04 Sep 2021 12:13:42 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id a11sm625630oiw.36.2021.09.04.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 12:13:42 -0700 (PDT)
Date:   Sat, 4 Sep 2021 12:13:40 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] kbuild: rebuild modules when objtool is updated
 for CONFIG_LTO_CLANG
Message-ID: <20210904191340.yuce2pnh4fahxfpf@treble>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-11-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-11-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:40:01PM +0900, Masahiro Yamada wrote:
> We rebuilt objects when objtool was updated, but only for non LTO
> builds.
> 
> For CONFIG_LTO_CLANG, the objtool step is postponed by the link time,
> and nothing happens even if objtool is updated.
> 
> Add the proper objtool dependency to the pre-modpost module link
> for CONFIG_LTO_CLANG.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Nice!

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

