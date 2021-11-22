Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD54590C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhKVPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhKVPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:03:56 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B9CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:00:50 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id j14so27320075uan.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmP2bXFruojw8kAtSj6UqlL7SjSwWnqcFws6u5CPCIc=;
        b=RV2PJLQSLxWJZ05lnNtM5IHsLgLmaoeBTTm6NuL2w3SH0Ok11sJvC5PDbs5wklpr3i
         uLtbywpCHvJHACFy/KiDjZwylIjxsrPQL4Coc6wynIX9+DDwvZlXS7C5BdGq5xTVCaMt
         /lhUWQUgk75mXD6JJBcE//LoxodQkrKHzDk6bgDZesP7l9MR/muMaIqS9blW/nR4xEfE
         yxME9JiDv8Z+FbgT9Galn0N77rBOFNfeiKuqH3E+89Ga+1HS62Bq+KU1dvblnM+1IHpb
         LoRC8fC3fzDsZaXguVfEhdfdhUv5tJ9ZGQyXjKtUqc2nizxTr96kIlDdqM2uUsofyCcg
         O8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmP2bXFruojw8kAtSj6UqlL7SjSwWnqcFws6u5CPCIc=;
        b=xv6e+71HcHk08YRl/otlK2ISRfwKS5JNyTUF5dqnMWCY0ldxQ1/Vr/cADQzmQwAW/e
         oUWpHiLwamdkKjqIbxpIBxwOOJOQYUHnKeYW6fMJmvkfVEubqfQaYaxvKI9S0nU8UqDW
         gUw85rKBHmTHLDyNmzW+o+g6SW6GSYeu2Ujq8o2m6910CtL5ShDmxekjnhWfO48PzLuc
         x4NQJsUHQxTVxDcQojy+yWT0F53JuSelJxfZ0bZTOfXPwSM0mawXFI+ixs5WU1TqlOxU
         VmSMAOXXpaV1XZ/FXG6Hjjb0zMtCe4jQ1DauZfzwZbWdJft7zOWoOsWbjvqaKzKO8itU
         y2lw==
X-Gm-Message-State: AOAM532yx6SnnZwcFgUz561QUSHZcWWvnyqhhuQLXCLrdlMcbErucGff
        0tjQt2q7/F7allBqQoAI8sg=
X-Google-Smtp-Source: ABdhPJz9tzowrWuZIQ3HOMTaJtFV2Ir4Q64/HuLIOszlDfJP6qTyEx83/hpiSV7n7aFklOsDmdramQ==
X-Received: by 2002:a67:846:: with SMTP id 67mr53758720vsi.7.1637593249362;
        Mon, 22 Nov 2021 07:00:49 -0800 (PST)
Received: from localhost.localdomain ([181.23.85.46])
        by smtp.gmail.com with ESMTPSA id o5sm476798vsa.4.2021.11.22.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:00:48 -0800 (PST)
Date:   Mon, 22 Nov 2021 12:00:31 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, arnd@arndb.de,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] staging: vchiq_core: remove superfluous
 static_assert statement
Message-ID: <YZuwj0mhn3qEgQbW@localhost.localdomain>
References: <20211122130926.342128-1-gascoar@gmail.com>
 <20211122135031.GB6514@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122135031.GB6514@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:50:31PM +0300, Dan Carpenter wrote:
> On Mon, Nov 22, 2021 at 10:09:26AM -0300, Gaston Gonzalez wrote:
> > After removing the BITSET_T typedef in commit d8a364820e01 ("staging:
> > vchiq_core: get rid of typedef") the static_assert statement becomes superfluous
> > as now we are checking if the size of the u32 type is 4 bytes. Hence, just
> > remove the static_assert statement.
> > 
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> > ---
> 
> You sent the first version after the merge window had just started.
> It's too early to be resending stuff.  Leave it for two weeks after the
> end of the merge window at least.
> 
> regards,
> dan carpenter
>

Ah, ok. I thought it was ok to resend after one week once the merge
window was closed.

Sorry for the noise.

Gaston
