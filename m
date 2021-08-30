Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8575A3FBF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhH3Xv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhH3Xvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:51:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2F5C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:51:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id bg1so4228738plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=QpDnj/gbTSlTTI+0Cuvf+c8ybTVj1MAA1MmBoMrdPKQ=;
        b=QA3kvRJDOHzrFYi1FTE+M1ulgPLkGVSCeHPwSWVtPySWqHl6yRUzMFr23po46UqpMA
         cNVwlfgbrwZAj5/mwupStlXxlA3T2sBUXQCohzqeKJ/N/zaP0AI3ZlWsopxMWTWTl06t
         9+Ch/8lig/aJ5cobVV5vvtjVJoDeFgghLjMg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=QpDnj/gbTSlTTI+0Cuvf+c8ybTVj1MAA1MmBoMrdPKQ=;
        b=D0pvFFnVcMHSQyiuZPxhxcbGWlf0jA/qoo7TvZR64sM32P/0teOtb4BdyxKqCQiE0i
         8XTHo20O6aceRYD+K3F5SgEqsgFquaiW3F0KSQvgOpmjXO2lkKV9DOjmLADFyVSHjE0n
         XZpHRa0WSJ5FXJbLwvyYwG41uICDX5HrAEfgn2LkmcwZ2H0ImBY3bG3bcF9HmRFNAVEq
         riLk50iFOpisDHqPgDqyJ4RSguJzump+nfAJg5o/hg+XfADcBP0fG4PYmgV1YQAFVwyN
         L0f3oAD8y48RpmxkkbRFURD4krcjfxLXi/i4uCW00D6C5G6rxUEAeOBlhuPvirz5Vt0Z
         vc0w==
X-Gm-Message-State: AOAM530uPG7HEaJ7gXW7/18QKdU2pCtCD+gzGuvWtohxQu1bfNK1cLMG
        YjaXnO6zFk8W+FcrWy1qRTHrjA==
X-Google-Smtp-Source: ABdhPJx9TtoJCj+nJXhLjMh8BIclMcgzag6XdRaQ4nesAWyW/7VRkZiSBRpwzLchk706OV68aRQu/g==
X-Received: by 2002:a17:902:e801:b0:138:b813:f928 with SMTP id u1-20020a170902e80100b00138b813f928mr1969667plg.16.1630367461242;
        Mon, 30 Aug 2021 16:51:01 -0700 (PDT)
Received: from [127.0.0.1] (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 17sm60842pfm.172.2021.08.30.16.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 16:51:00 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:50:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, edmund.j.dea@intel.com
Subject: Re: linux-next: build warning after merge of the kspp tree
User-Agent: K-9 Mail for Android
In-Reply-To: <20210830184429.1ee4b4d8@canb.auug.org.au>
References: <20210830184429.1ee4b4d8@canb.auug.org.au>
Message-ID: <E98E0D1B-4865-4177-A98F-8274B699E25E@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 30, 2021 1:44:29 AM PDT, Stephen Rothwell <sfr@canb=2Eauug=2Eorg=
=2Eau> wrote:
>Hi all,
>
>After merging the kspp tree, today's linux-next build (powerpc
>allyesconfig) produced this warning:
>
>drivers/gpu/drm/kmb/kmb_plane=2Ec:135:20: warning: array subscript 3 is a=
bove array bounds of 'struct layer_status[1]' [-Warray-bounds]
>  135 |   kmb->plane_status[plane_id]=2Ectrl =3D LCD_CTRL_GL2_ENABLE;
>      |   ~~~~~~~~~~~~~~~~~^~~~~~~~~~
>In file included from drivers/gpu/drm/kmb/kmb_plane=2Ec:17:
>drivers/gpu/drm/kmb/kmb_drv=2Eh:48:23: note: while referencing 'plane_sta=
tus'
>   48 |  struct layer_status  plane_status[KMB_MAX_PLANES];
>      |                       ^~~~~~~~~~~~

Hi!

Ah yes, thanks for the report=2E I encountered this too, and have been tol=
d the warning will go away soon:
https://lore=2Ekernel=2Eorg/lkml/BY5PR11MB4182ABD607EB99C1F68777928CC69@BY=
5PR11MB4182=2Enamprd11=2Eprod=2Eoutlook=2Ecom/

-Kees

