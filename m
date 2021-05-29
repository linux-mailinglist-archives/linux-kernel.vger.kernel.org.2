Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6D394ABA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 08:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhE2GQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 02:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2GQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 02:16:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C1AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 23:15:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p39so4867550pfw.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 23:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GHVThfXai6EcZhid/DXWZyiSsfvshSYRLRK8aOHtaec=;
        b=jttOVb4xsB0T4CNPjL9W2+xexnk4ONWF9bBE80S873erVD6SycFb8deXXDys8Q+gM1
         Y+et7B4mzogXu4scO0i1xJbgLUpyQjLH9aO8uLsVVrTRwuOhonf5FzKJhumz6nWba83p
         jtnuj51+/vI1WvWdrRjvIDPgrfOZkL/06N6563R0EJg0TDPfLK36+2MWTYanLPbnZQil
         oPSvOD3TxREqZVvqcdShTmfJG0LtLpndrXJrE/CdmgUHBnK6sCnFv0X2hjeyUvxCqkh8
         ZTN5DCOqzETG8g06lbnLjrOAlX9xGDYyjzFmFybz4k0tWDpBGj3KXFbEtcH1XAX8pWci
         Dbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GHVThfXai6EcZhid/DXWZyiSsfvshSYRLRK8aOHtaec=;
        b=TWCatLlBpHbwWrD4Nrbo8AU7MS2JzzWOdMgBS+aeTKtY8cHyuFwilhSXRiyrqpU67B
         l9Il8bkHbSNzltei0AzhruTBzusBhiR2vsPhN8SIRr4X0pRnR7CtZxqAwleMa90WJ3dN
         K/QJf6uyJgNJrQLzOdQvOKNmv7aotpQ+dIT1pRdl55Y4Z//NRTYZuATi0rW5KBPJmnRl
         BfEmPO2VinMpKxyldSx7/NJ0J+QbHg5kNRGcwKrW8pggkFiLg7OUd5O/wv0kpfMRK7L7
         wNdk8ZlALgiE2viohONjjvdL6uJiuwLUFNlf3E/C8uVNhGjp9SgO+ntZCNRBV858r1nX
         cIJg==
X-Gm-Message-State: AOAM532R5PCFZO3/MZIq/OE4DlzGUiV4gXVXbkOm2oZ1JqeKsNzIJJ/k
        B2UjN6RVpviiroAniJDhE4k=
X-Google-Smtp-Source: ABdhPJzO7uiJjWnuGP4CgVyvoh7eXZi/FcyeQOfzqjn0fn2XY2Io403CC6f0ZBJ7a/Dc/PLSXoqWQQ==
X-Received: by 2002:aa7:8556:0:b029:2e2:45aa:d01e with SMTP id y22-20020aa785560000b02902e245aad01emr7276070pfn.14.1622268904221;
        Fri, 28 May 2021 23:15:04 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id o6sm5890528pfb.126.2021.05.28.23.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 23:15:04 -0700 (PDT)
Date:   Sat, 29 May 2021 15:14:59 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Add WARN_ON_ONCE when returned value is
 negative
Message-ID: <20210529061459.GB103954@hyeyoo>
References: <20210527171449.GA145584@hyeyoo>
 <20210529061423.GA103954@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529061423.GA103954@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, Sent it wrong format.
I think this is right format
