Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175DC3ECEE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhHPGzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhHPGzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:55:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A92EC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 23:55:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v2so14414048edq.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 23:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfKkgUk+Apjti+wmBqAANKJPESjaM1t1n6XEwFETrrk=;
        b=KmfHxFn+cx223iBTzA1hrU3nLvjqcvAicFzcsZX6JyL4vlmUeMIseF0R9c6nP9eiPg
         pojJCScSzIdFPF5F8+LW4CcOUXuURYMtf1Clo05GitDYSsANzygqTm7xS/HuTnS1JQtL
         o+m4KqXI/BMW3A9TOty84yskSVvahd4oi2QC8TGyX93nIlQ3JJ4k1p4muMy4ezc2tETa
         0QWsiBDULJHrSCieSdCwHludI6tww49x8elnNKkQvj6ThDJacY2AkhGZnK5KMfrayIyR
         tiQofnd4qoMV6eTL7UvEZ8NcPcwhxgdsrUFrey/JGTE/rQiuAnER1AG2KRCSRr4MpvEu
         bsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfKkgUk+Apjti+wmBqAANKJPESjaM1t1n6XEwFETrrk=;
        b=gEhC3yp4XGt/YIV3WuZGZFYK40h1jOCDoSG3x8FkY+8oyEi9te7Z/J52tg8Y/ddiez
         9Sqz1JC6dZbFbMxWyiJan8dxYrvQeX/9iSMK18HsAtww6YGMLhsBQd9RREGXtw8dteJt
         B3NkRBsncZZK0h5XDOq1g+UEEY/0JUIYRT2jhwkS3Zi85clpvnHfVwtHLMHPdvikV1YQ
         J0um446hSbzrJTAcTMxu1tKiC/A4u/lraDlMKr4rddkWlxAJ5x7CM/RBBomYZviuPEm6
         bc7setFcCbDjnT0Mb8ktDkBbFTyEHxVqKAf4LSYqbqbQQbeFf69YWGN7pUSqsdfmrop/
         wu+A==
X-Gm-Message-State: AOAM532ZTE9mPLILF5m4iqbrL4FJ9QEf3Sna45pyqKCL/WJn49DqMPHH
        i3zq5QTsNkoY33Vbj2Xfgds=
X-Google-Smtp-Source: ABdhPJxRypmhaluD8ShSffomEQ0+aN2E5PH1fccvvWG3s21MWDizGeekMb7OsvJyRcfodW/GmFhjhA==
X-Received: by 2002:a05:6402:2936:: with SMTP id ee54mr18057284edb.70.1629096908868;
        Sun, 15 Aug 2021 23:55:08 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id i10sm4347636edf.12.2021.08.15.23.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 23:55:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused variable and DBG_88E in hal/rtl8188e_cmd.c
Date:   Mon, 16 Aug 2021 08:55:06 +0200
Message-ID: <11475165.p2zfeMNkXv@localhost.localdomain>
In-Reply-To: <20210815230518.91656-1-phil@philpotter.co.uk>
References: <20210815230518.91656-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 1:05:18 AM CEST Phillip Potter wrote:
> Remove set but unused variable init_rate from rtl8188e_Add_RateATid
> function in hal/rtl8188e_cmd.c, as it fixes a kernel test robot warning.
> Removing the call to get_highest_rate_idx has no side effects here so is
> safe.
> 
> Also remove the DBG_88E macro call in this function, as it is not
> particularly clear in my opinion. Additionally, rename variable
> shortGIrate to short_gi_rate to conform to kernel camel case rules,
> and improve general spacing around operators, some of which triggers
> checkpatch 'CHECK' messages. These are not related to the test robot
> warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
Dear Philip,

I'm sorry but, although every change here is fine, I cannot ack your patch as-
is. It shouldn't address so many different issues all at once, according to 
the best practices in patching and the kernel development rules.

I understand that you think that, while you are at the removal of "init_rate", 
why shouldn't I address all other trivial issues at once? 

Even if the patch is short and it probably doesn't require particular hard 
effort to review it, that mix-up of different works shouldn't be done, mainly 
because this attitude could potentially lead you to add more and more 
different work in future patches. Where is the limit? Why not add some more 
different works next time you find some more problems into the same file/
directory?

If I were you I'd, at least, prepare a series of two or three patches:

1/3 - Remove init_rate as reported by KTR;
2/3 - Remove unneeded DBG_88E macro;
3/3 - Do some clean-up of rtl8188e_cmd.c;

Perhaps patches 2/3 and 3/3 could be merged into one, but I'm not really sure.

Thanks,

Fabio


