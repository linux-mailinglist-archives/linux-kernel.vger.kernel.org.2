Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C116B457ECF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbhKTPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 10:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbhKTPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 10:08:13 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9D6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 07:05:10 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r11so55584241edd.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 07:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iVLtIj0z+sM3WgovleoFBIP0c50JJg8mtp+yr52u/PU=;
        b=M1TCdw9CGQNYrKQjkChApKrGYi/91T/YSF5PHEdfN/Vdj+bKSkX5nmewDBk4N8mXSD
         jqaFgteNlLnv1CrrqczskWR90nqE8ckaPwormQE5hva9RmH8TTnZqek+Mqr++2daCiVZ
         4mjzk+Nnz+YIyYsGvJ8CGcUl08mTMG9bVvnzXITJv+UbC9rEo6dHZDSLEI/7Kq6piQQ7
         25TMh8S6xZSpe/X3nzrmywsaWF6pfGVPFuuqUXuZ+oG1xZ1RJCB2gW8ISO1i0DsJEpOg
         lJQ0rv3rOedvYyCCo9NMXXPrS80nwBnMrSzidqQ4tsGwNPBYNZDHN2GypHwvJ5VcVaXM
         b6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iVLtIj0z+sM3WgovleoFBIP0c50JJg8mtp+yr52u/PU=;
        b=NU0mSKP5aJECYaAV5ECAE4S5v16J3gUmL5T2HyT1nuWdMSWgCDXuqJ22huXJ0nFDfw
         hA8NmC9U3U2ra/zZZkHqsAL9QLsBr+r4y0ftrwSWJWyNpUCREGokapdosCE9r7nzSEjD
         1xI9SvlBGFi08PnS4srU2pp4zi6KIYI6w0fmNK08/ZlC9pudT41bXOLyjcognG8afSxY
         NUMPObESppj+cThDSWlSx2uGli31/8HO9CEI391F5DDh+/fwoavqHtPCs472AlS8ro6M
         iB+2uW1kW0ti6bq6alYjetnW3D/E7atY1EPtEjU/N5gNvJn1SlxCqQ7BMwWdVL3fFOuQ
         JPkg==
X-Gm-Message-State: AOAM533mVn7SwU+dZHizIyf8ZcdDJUSy7vcwwmjc4B4CtfUfAaHiBpAs
        bnn4TRfM0eSjGkB4n9BR8H2iKd3vnA==
X-Google-Smtp-Source: ABdhPJwZ9FVU3g+JyvdyBDMguZscD/iwPNr99yO2waMi62X8t6um/NgqZX+ZjAtwwFnOK57dlKnsgw==
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr20383961ejw.472.1637420708775;
        Sat, 20 Nov 2021 07:05:08 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.178])
        by smtp.gmail.com with ESMTPSA id hd15sm1300179ejc.69.2021.11.20.07.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:05:08 -0800 (PST)
Date:   Sat, 20 Nov 2021 18:05:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 12/20] linux/must_be.h: Add must_be() to improve
 readability of BUILD_BUG_ON_ZERO()
Message-ID: <YZkOolX1SBsqXAsP@localhost.localdomain>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-13-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211120130104.185699-13-alx.manpages@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 02:00:55PM +0100, Alejandro Colomar wrote:
> Historically, BUILD_BUG_ON_ZERO() has been hard to read.
> __must_be_array() is based on BUILD_BUG_ON_ZERO(),
> and unlike BUILD_BUG_ON_*(),
> it has a pretty readable name.

The best name is assert() which userspace uses and is standartised.
