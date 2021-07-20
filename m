Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA73CFE42
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhGTPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbhGTOd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:33:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06EBC0613DB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:11:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m2so26424863wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=alVWn+YR6gcK5cf4rQehWcE5XnNnR1NqonO03dRE9FU=;
        b=Rc8/zJWW/fMbNGmZylmNpRTNWo05la7B+ETXbUYL1Kek45WXIPKOdy7uMJeNPLcEUP
         75QqVcvVMLt+iDB5ZbKM19C7uoqN9SSi+cykffHKD4AFw8xOrCxetzQZ2abSma0bfxBC
         ApErF7GUTzou4KpJxPAupoI+IB9EoDcVvCT4obTlC8nDJ5rGugtguyjRt0ttoEl8LmBV
         pgd4K5zB1EMrW+r4uKbuGL0+XW3fmZQEqYWsO4HPrCb4RXg/IvC0aq4nyC77418Do0IG
         3Xb9dA0eMiqVNfgw8l26NPktsNibSMsQp/hgqRn/OZZ5rLezQlQSg+sZ37A1c4CRvASz
         s7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=alVWn+YR6gcK5cf4rQehWcE5XnNnR1NqonO03dRE9FU=;
        b=Oj+ezM8YT2OEY3CS/haLbKA9YSZtX55WEhD40gI268dIAjHpTD7ObxLswTfr1jUa43
         sozCyfsIf8VEzTWwWVnbG0xauAbSneDa7hGOh53/qS1F6pdkEY1JnWDBYyFpm/TvhI+q
         YQxsMP/sn1JqwBcu2GlqsC9Hz9O8EElJ24wExiiV3RAAq7CRdD6lUQHM4lpjSEIcl7rk
         eSx8bmgf0/w4sQs4IOpP9KJhMgSqSZY7i99Tb3GIxU8NgYpZtyDjrsmrQ8h6dgTDD+xx
         m2f8qjPzBnKeTxy9OBRsmLqW2/Yi1OqFxDj9F/jYSXM/7lmvsO4Nv0Hd7sOqXxI9Ssx4
         LhBw==
X-Gm-Message-State: AOAM533BeBRhqiiGK89tRLwfWrIm31aZ4Z3RAUTCCv0933wsMz8SMEWG
        tFv6WROZvFMw76xnnf6YnOG8IQ==
X-Google-Smtp-Source: ABdhPJzlxjM3mgGkaNZlE5qAL978sWz9QKAxT8Msa5umyFpfGIRrKnusBhAFzFNG1BbW0Y4mruD/nw==
X-Received: by 2002:adf:fbce:: with SMTP id d14mr36703002wrs.236.1626793909440;
        Tue, 20 Jul 2021 08:11:49 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id a64sm19284065wme.8.2021.07.20.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 08:11:48 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:11:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Add Intel Cannon Lake ACPI IDs
Message-ID: <YPbns593mDDSzUrZ@google.com>
References: <20210603165128.46586-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603165128.46586-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jun 2021, Andy Shevchenko wrote:

> Some of the machines, like Dell Precision 3630,
> may expose LPSS devices via ACPI.
> 
> Add their IDs to the list.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-acpi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
