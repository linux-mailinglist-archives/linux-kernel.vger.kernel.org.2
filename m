Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8128B39CDB4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFGxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 02:53:00 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:34375 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhFFGw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 02:52:58 -0400
Received: by mail-ej1-f52.google.com with SMTP id g8so21263196ejx.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 23:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ygb6AseoKvTeCmuWez+WnMGc8cXkovwO+NvwpnOyNU=;
        b=DLFo/uw/u59+/GZfoZm7PytLFoWU7BT7lunqz3zydjjAwIJtL1w2LGNHyBlVjBF7pH
         EGdExU+z1KFhOqmcQOXKcSUekfFp0CSwtY0V1paAH7UowbsQxm66dEbvbqKrkpjVs7Bi
         QYmH87j2EkLIYGenqEpdomj18vDwGGpItrLc8a5cdo68nyo4RWtMIVwZw+HKHfzDz3LS
         eO37aUX3rrUXVqx4qa4sZCA/VVDQVtq8666hOfbucOWeCR+I80xLTvOKXroDJW+KzZ/E
         4QFzd1GICMDTTMKxJ++m7NbgIO4L+nviSr8LsulzxnkqemUHHK3nN2cE7TLJyC73Ty4d
         FN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ygb6AseoKvTeCmuWez+WnMGc8cXkovwO+NvwpnOyNU=;
        b=DOnMFUcpA8AET+V7Sa0kbxBAtHaOR55TjAIwHubNIXsgiBNdNfsfhGxduQmfSNVaIi
         MwTI4U6WLrWqpxqce53EJ20QR76WslEQjw6iFnUQK4xETdR0LpX7qAYVjrYMzNaigp4C
         tl4Nah1fY/AUVq3iLbb9M1VbveCfRXB3KZ8+k8QbkBAiIi2WVpQJWkrVdj2kDvOXZuE7
         oJMoKLm2/YkvMTGZsFhNsdh02zR4AqfwUaTxE+MFipzbIo8J+R0gU8bXoHO6AGXO0BCC
         BJ3cxW20x9jIGhNA/tjd0/z5qHs4YUoBIfByXgqKX91/jS7J/pch5PZ5JfCh2kgnG0Hp
         9Vhg==
X-Gm-Message-State: AOAM531RGXMQ7sEAuThx3AUmQvztpcb7BOD1rZS0S0ZYmIZxCiLXZws4
        GGoyb2YiMc4d8L3644UGaRkiPsmX6boDDQ==
X-Google-Smtp-Source: ABdhPJyew04RSuj0qQbnLfXk1PKEjvCEyBd4wxSa0o0QDjZ4We6m3QED0N5nZWSEwENe+cSdXj6+xA==
X-Received: by 2002:a17:907:1c9e:: with SMTP id nb30mr3748001ejc.0.1622962193840;
        Sat, 05 Jun 2021 23:49:53 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id x4sm5876751edq.23.2021.06.05.23.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 23:49:53 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: Remove conditions with no effects
Date:   Sun, 06 Jun 2021 08:49:52 +0200
Message-ID: <4661119.G1Uu3eHz2z@linux.local>
In-Reply-To: <1c87140c6e580b443de5d4abafb7872c8ee3efef.camel@perches.com>
References: <20210606043552.31785-1-fmdefrancesco@gmail.com> <1c87140c6e580b443de5d4abafb7872c8ee3efef.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, June 6, 2021 7:56:32 AM CEST Joe Perches wrote:
> On Sun, 2021-06-06 at 06:35 +0200, Fabio M. De Francesco wrote:
> > Removed conditions with no effects. Detected by Coccinelle.
> 
> It's be good if you researched how this came to be and noted it
> in the changelog.
> 
> try:
> 
> commit dc365d2cc579200bc3752ddb941e046e3a16962c
> Author: Fabio Aiuto <fabioaiuto83@gmail.com>
> Date:   Tue Mar 16 15:04:11 2021 +0100
> 
>     staging: rtl8723bs: remove unused code blocks conditioned by never set
> CONFIG_AP_WOWLAN
>
I've just read the commit you pointed out. It seems that the conditions with 
no effects came out while removing code that was conditionally compiled by the 
unused definition CONFIG_AP_WOWLAN.

However, I don't understand why those "conditions with no effects" have been 
left there. 

Now I'm not sure of what you asked me to do: should I leave them there as they 
are (perhaps because I missed something) or should I explain in my patch that 
they were overlooked by commit dc365d2cc579?

Thanks in advance,

Fabio



