Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D163321CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhBVQTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhBVQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:18:48 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC035C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:17:56 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l18so9391130pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0oTXE9HVvDGBzY+kLMPkfFY7CNArufakj02yyUEBmno=;
        b=i2eLFEYtrH5/NOdWQgdMxO6XM8eLfaIS9LJvKXZSM7PbjDjMHqzHltePB9u1NHtObE
         FUa3176Ox5VlOmH9Ofsemis8eM5xkxLkxpRHn3AzD+qe2J+X1G4+P1AViF+czhL+Kjg7
         7Kb91jgGSZh3VB+ssjnbVdip8eabWswa5+ON899RdjuUuqzM8AzaUC8ow1MT171yRWoB
         yox9sZHMQAnczIS7DpBNqrPJ6H4Agy5IhBc9g837YJbd7RT34QI/fS6qd8K8r0DzaVrf
         gcA/cPWsvh6S6K9tsgyj23ejw9cOCajinDZ8b9uVRqRlzJYOLSi8zr3b6E+C7GoiaN1z
         hkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0oTXE9HVvDGBzY+kLMPkfFY7CNArufakj02yyUEBmno=;
        b=e4le9wEA0xhw4MgEI59zgakRRiYXB04R0yvLFtDy/Y4pWJLdMhhRthPLZuto6QqkKB
         91o36dBnpDfKss3jwHKSjsmCO7qF1nYva056s7Kbdusp2l/vReAGZ8PLQeWQV9nU2dG1
         F0YDZIEgq1tnkvOEijYVLsSJKVqGJpxx0lfQpVFNtS/MemqoQfX/qS9S0kBBg2W2MuEv
         k+1Lv26Hxif8+HRSeKfgSI/RF+oIdHn6h0Qo0HVJHqziDqxcFO3VrAUMRIn1zqJ1+oGo
         DQyIJ9DZzzBUz9ks+uTwo+VieNW0jXlD7cmApYXVayavrMFdcDDG2bwYhwkfNAH5Od4K
         ohkg==
X-Gm-Message-State: AOAM5339r/1mIkl5O52eTyS31GQRCxiK7AYwp7mhS/n9RmwMDKZaYZ4/
        t/9TdjYuZPtbQCi9Ms9QZ4bfFVtUuVYpZfVO
X-Google-Smtp-Source: ABdhPJw6D3qE+/uQHgJBtNurxFxZfoOXiXjC7C10ymQXt0Sq4JgqsmuZC0WuHVUE/aLz0I2GeOZmUQ==
X-Received: by 2002:a17:90a:4dc1:: with SMTP id r1mr24490758pjl.12.1614010676264;
        Mon, 22 Feb 2021 08:17:56 -0800 (PST)
Received: from nuc10 (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id ml7sm14216393pjb.28.2021.02.22.08.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:17:54 -0800 (PST)
Date:   Mon, 22 Feb 2021 08:17:49 -0800
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ntfs: check for valid standard information attribute
Message-ID: <YDPZLTZ/eLEw9rLT@nuc10>
References: <20210217155930.1506815-1-rkovhaev@gmail.com>
 <42B686E5-92C1-4AD3-8CF4-E9AB39CBDB7B@tuxera.com>
 <20210219104956.09e869c36f065a78d1901725@linux-foundation.org>
 <A4498E63-33DC-4DAA-837D-D97B8F29F70C@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A4498E63-33DC-4DAA-837D-D97B8F29F70C@tuxera.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 02:18:50PM +0000, Anton Altaparmakov wrote:
> Rustam would you like to resubmit with an improved/extended description?
sure thing, no problem!

> when resubmitting with better description, please also add the 
> "Cc: stable@vger.kernel.org" line together with the "Signed-off-by", 
> etc lines (note no need to actually put this in CC: field of the email 
> iteslf).
i will do that, thanks Andrew and Anton

