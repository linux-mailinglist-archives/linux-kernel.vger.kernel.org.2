Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66977397A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhFATWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhFATW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:22:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34535C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:20:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f22so324160pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e8Ludc7+SRdC4P/GvfuW5pve9HdBju2sXZN9m9IZG0w=;
        b=QlFaI5TSMl7bx3+oJ7+7FCToZ007kP6DYaQnxVVxXTVvLgW1vXP5ldrI70BJqaHhIn
         E3A4tgiUYgEHFdbgAZfIh1R7hGpWO8HkenAuHMA5+UAwOp9P52HwqWpPX5ESon6sgFYz
         WHSf8UV5OtWk1pZU2BE+a2dx1ZeE/w9HTdcYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e8Ludc7+SRdC4P/GvfuW5pve9HdBju2sXZN9m9IZG0w=;
        b=cNkAcikK0B7lsoKF4Plr4ZEbEGdZvTeZrQtXLYGyRci5sUlvfsGNtDFxBRbOBGD/2J
         0mDjoieEcjMRRNjyj30F1SOOqvzgoxi/FhiHJC+68w45xslplOIoJf8utKKZH2+Esh2F
         +qP1X89VVP49I5yWI+9GZWz+6EYA73e5nUPIPazb/qEE3jsdV5mVbTo036n3ab3g/JfK
         PvVSWHIqoss55FztpLAKnGXI5PC/wy5AH7QTVxX/3q4DAwrJGFOfdDZXt2uEBB1vBWWG
         lFMoMfogwKGDjEWkyJ8pEpkay/lMmlRFCg9m0+2nF3UeWMeXgeOPWtll9d9CPzKH9xkE
         aSIw==
X-Gm-Message-State: AOAM531Pka4+KHG/N0bUYM2n8sdKbvT1X+N3Ttlzf0GzmGeXS3BOo7jb
        OVkUsn1XG8Lx8NqB50bMYHl+xw==
X-Google-Smtp-Source: ABdhPJwbxztlQ1QzCwxed9H51atEgwLlgUDY24XP2IBHwlNqCDjrOO3+Kp1oj8gKUUmoHKdqC3hpgg==
X-Received: by 2002:a63:451f:: with SMTP id s31mr7591039pga.209.1622575246796;
        Tue, 01 Jun 2021 12:20:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u13sm9789021pga.64.2021.06.01.12.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:20:45 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:20:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: mpt3sas: Fix fall-through warnings for Clang
Message-ID: <202106011220.97EF373@keescook>
References: <20210528200828.GA39349@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528200828.GA39349@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 03:08:28PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
> of warnings by explicitly adding break statements instead of just letting
> the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
