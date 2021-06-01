Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB44397A9D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhFATWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhFATWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:22:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58FEC061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:20:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x10so6506979plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bFNYi6m++gbCXTaIyGQySmm0f86eYc/Qr6XGD1RfsTo=;
        b=nEqGKcRi6N4t0IegL+8HbfXnUJ+QjBc/I85UjwK8r+2W1OajAAHtMS52fDLvCq5I42
         VQf1aq9ltt4QTVpgYd8h00ZVL5ORJBjfBrIgvpKvAODbvgtZqYI0k2qAWnP7QvmYhjzE
         yzlvivuoc8Ey5s/YsQJXDgWJv/8i7HS9xfmQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bFNYi6m++gbCXTaIyGQySmm0f86eYc/Qr6XGD1RfsTo=;
        b=mB3oVnNgSiek46Uukce7+uGMWx8yFCyfD9vt905IectYeQMFkFy3rpBHRoqM40ykD1
         yXGKbNmBDgqG/eAup6Xrlaj8CI4kql68Lpvvl6ovNYX71RiDNwEiT7oaIndsS5VlZ/Fp
         jiUZ3bfS6Vh2c9qBsgKihO4ZXsKyxmGdP9Z7zHGWag+QVRhsq/uAl3+GUc34yuEWlPlu
         YxGRQsnC6Al8Z1FtErAKBh1GDIomPryRzetMEaw210F/yP0Ou12pFiqdnqyxWUFwPSJ7
         MBH06EX/RRfh190OGS9M88/Qp0NrGB8HmhVhixpjNdwdfR70nAESBBKtRND1Jico+zNh
         5hqg==
X-Gm-Message-State: AOAM530yRY7vaJJxynZKGAK3riS9qmBFKZGHKQIsel64wu+uvtBYwVpq
        a5RefJrdFy6/144EjJ4ho3ffwA==
X-Google-Smtp-Source: ABdhPJztxg/Xb8nFH28NC2W6Go33m7YavRvXsBAZ8lVlyjBoR2+/cOoRZPSGfs0lDQpJjGA2LHCwxg==
X-Received: by 2002:a17:90a:9f02:: with SMTP id n2mr1451581pjp.190.1622575240135;
        Tue, 01 Jun 2021 12:20:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c134sm13949779pfb.135.2021.06.01.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:20:39 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:20:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: rtl8188eu: Fix fall-through warnings for
 Clang
Message-ID: <202106011220.C226177E0@keescook>
References: <20210528200650.GA39289@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528200650.GA39289@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 03:06:50PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead
> of just letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
