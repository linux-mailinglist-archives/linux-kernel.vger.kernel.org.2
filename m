Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3794368B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhJURIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhJURHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:07:44 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9738DC061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:05:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s136so897239pgs.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7rSlILWSLtNm1l/dt0JGZldq939/2rynRrUJ8zKeXI0=;
        b=Na/vDPjgNlUzBFN4GMNIo3Shs5X6jSidKQISyssc1oT1WZZKdpKmy7O6AP6kNzB37C
         MRItv1idJFk6vxcNVM8YVNM/Lrnh/CmkC0RRngCO/jWtB9rY/j3tN+VEJE9qooifV0QA
         EOu3swvOtOuEojO2uvMd06RceQRYd4JwoosKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7rSlILWSLtNm1l/dt0JGZldq939/2rynRrUJ8zKeXI0=;
        b=kQm5S8EbS2ak8Wr+SjwcK/2jSeuz+A2xT2Um0cm+fvyG3utKr1GcCr3UksOB70nMF9
         w19EZgV/50QRdeCbdE/rHEKF4Y/W6l21RoFv/NzzRnBfqrD2/wBZLwzM5CFIIq7E8hvU
         kdwZdOQKTYO7CrZsKmXf5GQkiptLOSTkQ3ZKun2fWDH3z+1xtCRKXh/jRcPC9PaBvQhE
         53o4lE9/6VPdx/W2nDTKnxk0m7Gblj7KR5Ya/bJXWAS8c8dDfDCDmyGDBFSA03C2VqWP
         DtobJ6dbL4u1lsMPY58tJm+6OITwikBJLJeWVPpMUzSpe1a7LBWq2VyMJQ58CyIkv3e4
         QaGA==
X-Gm-Message-State: AOAM533X+7y+aqGH8atig00eZY/zoE+420vFJTy4EkptBmTgOCzcwTa3
        cWTYo0HszvUt4ah82OA5sL+0Aw==
X-Google-Smtp-Source: ABdhPJxmNKBuSkVoniTw8LzyJ+Fy1Bl7BtYgxDGsoPz2D7Gsganf5l6nVApI7jU/y9OwrwP8onE3/Q==
X-Received: by 2002:a62:61c3:0:b0:44d:2518:cdf1 with SMTP id v186-20020a6261c3000000b0044d2518cdf1mr6805487pfb.31.1634835926105;
        Thu, 21 Oct 2021 10:05:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oa4sm7004169pjb.13.2021.10.21.10.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:05:25 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:05:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ice: use devm_kcalloc() instead of devm_kzalloc()
Message-ID: <202110211004.6CF2B2C5D@keescook>
References: <20211006180908.GA913430@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006180908.GA913430@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 01:09:08PM -0500, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

Similar patch state here, it seems? Who needs to Ack this?
https://patchwork.kernel.org/project/netdevbpf/patch/20211006180908.GA913430@embeddedor/

Thanks!

-- 
Kees Cook
