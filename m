Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886AB44D88F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhKKOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhKKOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:52:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD1EC061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:49:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j21so24942120edt.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=otJAuqwbOuooouXjNVurvOLbz7r6CL+tJT8AOOGqIeo=;
        b=V1jxHRCd0a5hUUfCEA5j+DT/iPPZRMmBeK6eqgUu2A/LAi/faiEEa7aU+uXoCMQ2o3
         djHcKYBTiY8VN//fAQwCHqtDxitKdyuySHRv5uhy3E934ob/Nack5KOLEsGs/ilqVp/i
         8MMhuzY98QdClrCjOcwmGeCqbN7WJm9u36NdPeTlTvFIpK9hC4nfy80fHbKee0KwlEsA
         lEAvk0S64dXOwrK7kkvvl6Z4tp/OhesGHS4NRz/7JVVkgNorHURWdEY3W7m8pxX+syVn
         LOX/OXkdglmBQdItwEngc8SwRo3CAaT/tf1Q9cLVgE/wv6d9vQimOpb22fg3f2Ez3qjw
         tUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=otJAuqwbOuooouXjNVurvOLbz7r6CL+tJT8AOOGqIeo=;
        b=4LsvzX3OAow+2qW8omKqpLXMWFU/L4AzZ9bBLVmdSoUFufRlfDx/yoHk7FuoXnZkB1
         Oxz/dMeWsgtg3jtsylTXArTOuzpHHDjNwOtMoFumbBfZ34uvxkxq4NYUALEcBWc0R3ea
         KLZRufX3wSj8Ch0oJXOzh9x12w6JxQlx/mcdATA0sCzzwTjXD0xmvX82jv0+47lUvNy4
         o+d+pMkBkT/bZDBSzooWGagYetQn45VlDPd3td3VDzUrv7h/zCf3pIiXAkuXLUD+R7bx
         7b1eGcDvugLATwmb7kEKhSE3q5PJhunUIn2HjUrJj63Av5Dp+7UAPPVwwkXnfkwQUgbU
         50KA==
X-Gm-Message-State: AOAM5332gPVbdnYHXmbiCTQXMI6+jBycX0v2vssiQF1sjwUAe+8vL6Ph
        UCbRQo7AYgilXie6olpoO0FMAmGn7v4=
X-Google-Smtp-Source: ABdhPJxxZIjbB14Kps3ji0c3J1YMtxBsgnwbuIi+8mCFYZ11qEolevncxP1B/wn2NdGROtFS286DTg==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr10608941edt.177.1636642173681;
        Thu, 11 Nov 2021 06:49:33 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id bd12sm165311edb.11.2021.11.11.06.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:49:33 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:49:33 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] regmap: allow to define reg_update_bits for no
 bus configuration
Message-ID: <YY0tfZze+kltD9gb@Ansuel-xps.localdomain>
References: <20211111014138.15645-1-ansuelsmth@gmail.com>
 <YY0O+yHo9ZSYgj83@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY0O+yHo9ZSYgj83@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 12:39:23PM +0000, Mark Brown wrote:
> On Thu, Nov 11, 2021 at 02:41:38AM +0100, Ansuel Smith wrote:
> > Some device requires a special handling for reg_update_bits and can't use
> > the normal regmap read write logic. An example is when locking is
> > handled by the device and rmw operations requires to do atomic operations.
> 
> Please allow a reasonable time for review and remember that it's the
> merge window right now so no new patches are being applied.

I'm so sorry. I had some problem last time with sending v2 that got
rejected automatically by patchwork and I thought it was the same for
this. Again sorry.

-- 
	Ansuel
