Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190903D9FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhG2Ink (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 04:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhG2Ing (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 04:43:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA0C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 01:43:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r2so5925159wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPTCnJ4gyvwc9DQOseujq1D/JB5vw8YW/dq0zpq/Br0=;
        b=rMqsUnQZHfAUEkHXc708tLDKwpfqq2jjJUUKXp976OoCoHwSsKJleWAryuJ1ZLw5/0
         V/70T83UHVqwUsqk357uQeohbENGoYr7aWkEmexnfSxxC3UarodO1xhIncY1cy/NZQWK
         nO/1GLiAm08RsqobRliQU75KfC79D6E3RIdW5FFxtZSAB/XCSh6IVKaoZ8viiUSicPY/
         oMUR1As6911P96A7JMw6JC4sO8Dru17TWgEA+medWVHExAoXLwrHbavjtHjGLEfWAuGx
         8EzchaRbjA0U+Hr/nE5szbM1GI74KnDZzBXX/cltw2CimQFXXMCG83EObE5uDoUVnZCk
         hxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPTCnJ4gyvwc9DQOseujq1D/JB5vw8YW/dq0zpq/Br0=;
        b=qO1lBOtNIV1rznwsWS0mBuIwYB2s+4RdCV5VvPHMzGuYvJeZZEntW4ZMgTlUpX4ARh
         ++SswxDx63RNaa4mS0hznzZ4ZB/YF2OktfT13NoUdd/L8q6mK2TYl07RPqXl89kil4Zy
         0vevjYUIU6KRopPh10c29kxqmA27F6fUsJfTHJJJ57e95jHZrqQGN3yga/hM/90SYcts
         ZhmbA7E1t8o5JM8/uif3ck5MiaTZnN97U62/Qo7eILIdJOmJ5qoIGdyaoLiOSn9OeDMy
         ZrBvzT0O/i8Up1gT2Pp82m43U0Z6Bl+aRwemKk1aaGUw4SzrHXMN22CgeqRQmzT5W6uf
         iaJA==
X-Gm-Message-State: AOAM531xrPXGwBKO6YVN0licI99P3ouRLJ9DvsCd+L0RfWaZ4qNrFk+O
        LVexYvv/fnIRimxidjUhYC4=
X-Google-Smtp-Source: ABdhPJwyI2mpbeD5KjAT5uDNOcnhrod8MvIA27dob5i8NSoxI+A3HAQ1wqUPslgBBN1aWQglmJVuCw==
X-Received: by 2002:a5d:5905:: with SMTP id v5mr3539666wrd.205.1627548212485;
        Thu, 29 Jul 2021 01:43:32 -0700 (PDT)
Received: from debian (host-2-99-153-109.as13285.net. [2.99.153.109])
        by smtp.gmail.com with ESMTPSA id v12sm2607202wrq.59.2021.07.29.01.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:43:32 -0700 (PDT)
Date:   Thu, 29 Jul 2021 09:43:30 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] parport: Use string_upper() instead of open coded
 variant
Message-ID: <YQJqMlLHDyPT94cO@debian>
References: <20210518133458.20403-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518133458.20403-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy and sorry for the extreme delay in replying.

On Tue, May 18, 2021 at 04:34:58PM +0300, Andy Shevchenko wrote:
> Use string_upper() from string helper module instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Greg for taking this.


--
Regards
Sudip
