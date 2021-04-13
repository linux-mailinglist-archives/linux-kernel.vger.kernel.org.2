Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79EA35E127
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhDMOOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346468AbhDMOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:14:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F25BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:14:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h4so7601313wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SjgV5385CX2e5+OWSQrXWQJFfcA9bCZwhTPE5sMFetc=;
        b=iO5Xx4d4eAZO68cB3l0JjGqMRQ6AxbP/OBiWZKDBD4OTn+eI7tbT0HlW0XPjeaUYvm
         ixN2NnU2d92l4Tpy/+Shyphc01Al0M+YbUVcbLHHWi0OHx0VUqvPjw8fbk+4qGP5mYiC
         uW+F/W2rYWHlj1y33PCS432zZGsUDNeXW3BIA3Ag1S6VhZ7AoWJRJh8/NkMWU2LN6H7Y
         C4DX1uIMEsZ5g8baQZvboShWd2NH/McsNzkylTb+m8EsxQVgGW7T9JRjdzuMqbWbVVmn
         DekzyNaeuDE599jfsQkXxHFfqNW195Fe3Udc2l+pTuMli4hY6H3V8NrBawo8yKYsyhcI
         0zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SjgV5385CX2e5+OWSQrXWQJFfcA9bCZwhTPE5sMFetc=;
        b=P9NcG93/zo2uAWZf6nYqbu/sh2zEx7l2awM6JfBYe0EfLNHNkqpeNq1iyMySmcl16W
         kJFdn5HgjaQk9fvDFF/PDDwJKGTbdPreEIsZ9cxYpRLD4v3o/Awj9cjcwpkkX6PVlt9R
         9U4mh6/vKjkztzZVQuLIBGWO2l92N3tlUM/0shFBeZwnYuulJPiEpoYYTgu0hGQjHuNY
         XCQek3wo5tFHkRn8bSz+I3EMP8TqTXRUWapEQKvxPKDbqRI0A3u5fdWp+0PlmzDBCykv
         84uPvRww09Wc2MAnMb5EHJNj4cfwrqDlC0NgTSKiKpzWfPUcqt7jUVXQKEQ1SQihKpnl
         Q3PQ==
X-Gm-Message-State: AOAM531mLaEVnvzw7DxZcGixeUx3ElpEIMm7N9yCbopnjqev5X+fqd1W
        l5YcmzcF7MAvTEqRyTHstjweYXOVYAEn8w==
X-Google-Smtp-Source: ABdhPJwGPcl+/TVw1SwXvFhY9ZoO0gyZOKBTo/RwlOYDs6i77Xjwxp0UcBPWkzo2971wtaLLl1tnVg==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr19574532wrp.173.1618323245394;
        Tue, 13 Apr 2021 07:14:05 -0700 (PDT)
Received: from agape.jhs ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id c18sm17169268wrn.92.2021.04.13.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:14:05 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:14:02 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org, julia.lawall@inria.fr, joe@perches.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] staging: rtl8723bs: replace DBG_871X_SEL_NL macro
 with netdev_dbg()
Message-ID: <20210413141401.GA1400@agape.jhs>
References: <cover.1618322367.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618322367.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:10:35PM +0200, Fabio Aiuto wrote:
> This patchset replaces DGB_871X_SEL_NL macro with the driver
> recommended log function netdev_dbg().
> 
> Macro DBG_871X_SEL_NL indeed executes a raw printk call as
> default behaviour. The other behaviour is doing a seq_printf()
> call which never occurs.
> 
> First patch replace dump_drv_version with a netdev_dbg() call.
> Second patch remove an unnecessary dump_drv_version() usage.
> Third patch removes dump_drv_version() now unused and
> 	unused dump_log_level() as well
> Fourth patch apply the following coccinelle script for macro
> bulk replacement:

please ignore this patchset this was a typing error, I will send
soon with right recipients.

sorry for noise,

fabio
