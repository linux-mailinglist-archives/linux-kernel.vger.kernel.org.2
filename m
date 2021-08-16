Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5D93ED4E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhHPNGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhHPNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:05:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557ABC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:04:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h9so31658749ejs.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvCfNxoZ3Ryu9UQ+39HeycOmf+nzV/nDWwq7unBedQ0=;
        b=tMyMtPLtp4vZi77oVlcLk8a/yyX/a7YBAa8QRDosX6Lc9txL8RVxhogmBQrbflH/Sq
         L9qOlxSHyceoROKGSxG/VpG+wVZ4BfaB24vRjXeJwaVRv71j0PK9xk6Rie09nI0ohBL1
         aqVWpqcZms9wVr+p4UPVYRZ6ameZ8juMd7sUxSVqOmuYzPxO4jkROh9TtAot3wJUc8WT
         iL5Ui9i1ERktNPMJ4dfVEu4uWWtycd7zP6bVPxeFLPl3+XF8pTGt8XEFkK504D+ccO/9
         b7KPms0f6G8Muw0pKYiDhC5zwL5PB10DlzGvN72qaNu+yPA7xgNMOtlkFGTO9x+hG6d+
         esDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvCfNxoZ3Ryu9UQ+39HeycOmf+nzV/nDWwq7unBedQ0=;
        b=Aa0fYcrLrJRKlnmdvqjcR44j/I5HNRE/+GXKKhp/M8roFG11GtiszBa4u1IwkQdvsG
         /LVmkmSwbbvmygBNodzqPZXZJ3NhEDDSZMT6zFYCF7Vu5R4lkdXqrVF1PpD0mxajHHbG
         56KCuWsEQL+XG3Gf3baMpZg2XN/Ke/zrtiaFUW5VQZvYSmlwDUz3yOj1LggPQH2vcN0T
         2orZ9x5JbJMYwQwJ9WziPJ/4JC4sG5MeeIoERwILCKxfa6Mms8U14BLw4XksxMM1Wcsw
         FpzgrV6MPzECKPyV0Jmel3WFUttMl6TRVn6e7aBhG6ptXtYK2RPLdPKz+by+d/FxQrtI
         fFvg==
X-Gm-Message-State: AOAM5320NjPLzQBCLT6NkUlrk8PPKe14JqGNW4n5wzzCwleaq5stlmDq
        3VfpIqITJN29sX6/MWgJNwo=
X-Google-Smtp-Source: ABdhPJySviFnoT2Za0+D0LH8HciYPfW9vf+N9+GQUsqtN4Dy2R5rWJ7amDAK8SNIIZj1Drxs+UqqMg==
X-Received: by 2002:a17:906:e291:: with SMTP id gg17mr16191722ejb.477.1629119075975;
        Mon, 16 Aug 2021 06:04:35 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id m13sm3658987ejg.76.2021.08.16.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:04:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: [PATCH v2 4/4] staging: r8188eu: convert rtw_is_cckratesonly_included() to bool
Date:   Mon, 16 Aug 2021 15:04:33 +0200
Message-ID: <14046781.rP7JVETYk7@localhost.localdomain>
In-Reply-To: <20210816115430.28264-4-straube.linux@gmail.com>
References: <20210816115430.28264-1-straube.linux@gmail.com> <20210816115430.28264-4-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 1:54:30 PM CEST Michael Straube wrote:
> Function rtw_is_cckratesonly_included() returns boolean values.
> Change the return type to bool to reflect this.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v1 -> v2
> Rewritten to apply with v2 of patch 3/4.
> 
>  drivers/staging/r8188eu/core/rtw_ieee80211.c | 2 +-
>  drivers/staging/r8188eu/include/ieee80211.h  | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio



