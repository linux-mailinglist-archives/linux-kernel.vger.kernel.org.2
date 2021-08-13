Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAA93EAFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 07:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhHMFiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhHMFiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 01:38:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:37:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id by4so13746611edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=suCL3YjNMQtPKfchSOwl+0iVVLdItZKK5YO5Elt5gzk=;
        b=V2IzV5wVWW4PnkBRNTdsopX/EN275oF7xJoSfShS+A+HQSV3OLa5Ao8iZRH2PG3Ql0
         r1anD56lxiruOvse43iSGyFJ89UKdzZGk+Bi742mY/FniDILLejY2uTsjKDAYbr1TiO/
         SWh3lUgqR7CPZ32qRt+nRWBE8ADij6T5gg6G7Uy2TurX8oih7D/B/VC3gh1lqvWyH9Eu
         fTkexNcmI1ZP2EbWI2ihVFFyJahXspLANbDlB6j0ir5WTUsNPV3e7BcgxVK5naqBOigd
         JOKYpxkfFc+oAL13GHPQnMSYKGDpcT0ALaDO93KSpoBupEPzO4g2aJr9bW+iDFaUf0um
         j0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suCL3YjNMQtPKfchSOwl+0iVVLdItZKK5YO5Elt5gzk=;
        b=GWLxKfVuppYyVbLl669nLDmt1pzUebROkVEa13DXsVlHvcEZ6X6fmdmC2TSGlf+2xF
         W/ItTYdw/gcaEBRlUPo4s4vBwr6A96xSG/ApoL4BplVsn8nliD7cf2RGHch2wtr5gd7/
         ZdF0MUcoUkmLp2pDrekBdW9Lzf79NbQDqggiPmtPnjz2se1QykeQb7yX0oecWxO24iry
         xj1Qye7jgd7c6qFgJwr0z2iEHUsgf4cCi+p6hKK8+grWhUBWJN1gw63zgGnWmcRaWUyf
         dvWfU8F77C4FSgncDyrzL5cp9N0ip5JLz2XoPMXIQTIyTquJ74t6rVkDdroV0Rvg4Ofz
         gtUw==
X-Gm-Message-State: AOAM531zFG2qJMA70KDynDbTB4azgws/6WWbxC54v0S9kvSBv/d/mZlY
        w7cZHuYL22Lau5E1PyL34MYMlwi/TN82C3Bnhzk=
X-Google-Smtp-Source: ABdhPJwb3oq+7vDZvlVLZdbZGxduYUGJhdL9mgmIQyKqz21mL1JsvAenurz17ab15RXLl5j7hXIaWhHO3cdDfvW5yeI=
X-Received: by 2002:a05:6402:10d9:: with SMTP id p25mr851140edu.51.1628833063070;
 Thu, 12 Aug 2021 22:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210811163731.186125-1-masahiroy@kernel.org> <20210811163731.186125-3-masahiroy@kernel.org>
In-Reply-To: <20210811163731.186125-3-masahiroy@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 12 Aug 2021 22:37:31 -0700
Message-ID: <CAMo8BfKh=bh_Hfo=dZT6urNPBkXVJ_kNXu=a7ZdtwR1RMOV7qw@mail.gmail.com>
Subject: Re: [PATCH 3/4] xtensa: build platform directories unconditionally
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 9:38 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> All of arch/xtensa/platforms/*/ have Makefile. You do not need to
> check the presence of Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/xtensa/Makefile | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Thanks, applied to my xtensa tree.

-- 
Thanks.
-- Max
