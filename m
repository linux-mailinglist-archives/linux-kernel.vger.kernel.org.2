Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9302E3B1598
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFWIUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhFWIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624436281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byL4aNmZ1MXOtXz/cMDMruo6tQLqSeWl2qFyepat68A=;
        b=bG0pa+mvjX9mTIeSDghRuFLY2Kou5hV1B/OGAjJolXKfLBJwawn1OWbQvsycmUaKEhoiWw
        CR4WsxIowPlxVbvi16HmN/0SGXTEdzGdYT5/VWxyTQnN2+hr9x0pJZkaZFf1g4CF75ZkcG
        Jodjim5FSJFmuKQoqA0FQRLjEqu8+bc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-hfVFrB0DPSOgEICqP8k-AA-1; Wed, 23 Jun 2021 04:17:59 -0400
X-MC-Unique: hfVFrB0DPSOgEICqP8k-AA-1
Received: by mail-wr1-f70.google.com with SMTP id l2-20020adfe5820000b029011a64161d6aso776070wrm.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=byL4aNmZ1MXOtXz/cMDMruo6tQLqSeWl2qFyepat68A=;
        b=NUiTnj0gJVsBMqbEhrGuhGk/j0U7TxpsNReEwv07OipDPJfVWsmlt+amElvAD/G08p
         rVn0EtW0zzoKF1sJCd7lXwjdRARsZPqaMUmAW4O7fUZwKnB+w2WHGk0cUtaktZbv53hE
         WCuYsCfyRZrrrxy1I/20gpywYYYSFvMqpUUbclufmlq/B03puqpb1HESqul5Z6IkTVfi
         0IbXPh1Al4sXkvtl5gq2afuSm38iWS/lueiKkfGTZ1X4VaLW4b3A7K7XdjrUSWvZo2xg
         6D7HOwnZ8zn9KghRHbQuhNEF0Mp7Of4kNXv+EGmiTrHLAVj4fFxF1VerzbTNNNdPwTgR
         bqlA==
X-Gm-Message-State: AOAM5308vm5I4Fn+ZTdyGWHXullN08FYtsqcj7BqW6ZtaQsG8KNfcMux
        Vzf+5jt5zXBcyp1cWmaFPsCltBXTYYIp6WTvjFsPFLRwJUiHo9TSOtKm8Jnl175EVyrxlW12X4y
        7yQ6Vdw61nsSvylYIPJsqKgc=
X-Received: by 2002:a1c:1b10:: with SMTP id b16mr9479869wmb.130.1624436278925;
        Wed, 23 Jun 2021 01:17:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWVqSUz5VubNs6XYwTXH5DVyK/8PkzVz1RIafach8Fxe73xIFeXXoZPPaAdc9J/qwT8k1tzw==
X-Received: by 2002:a1c:1b10:: with SMTP id b16mr9479859wmb.130.1624436278788;
        Wed, 23 Jun 2021 01:17:58 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id c133sm4878187wmf.0.2021.06.23.01.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 01:17:58 -0700 (PDT)
Date:   Wed, 23 Jun 2021 09:17:57 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     gumingtao <gumingtao1225@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        nathan@kernel.org, ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        gumingtao <gumingtao@xiaomi.com>
Subject: Re: [PATCH v3] slab: Use __func__ to trace function name
Message-ID: <20210623081757.mfio55dq223m37jf@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <cover.1624355507.git.gumingtao@xiaomi.com>
 <31fdbad5c45cd1e26be9ff37be321b8586b80fee.1624355507.git.gumingtao@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31fdbad5c45cd1e26be9ff37be321b8586b80fee.1624355507.git.gumingtao@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-22 17:59 +0800, gumingtao wrote:
> It is better to use __func__ to trace function name.
> 
> Signed-off-by: gumingtao <gumingtao@xiaomi.com>
> ---
>  mm/slab_common.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

