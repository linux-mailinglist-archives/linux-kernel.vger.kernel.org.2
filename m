Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644BF4384E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 21:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhJWTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 15:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJWTUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 15:20:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C80AC061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 12:18:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s24so1090765plp.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iusnW8LyX48emfkYiOdYVBbD1X7DC6XhQSttfD8Gqis=;
        b=g/g3MV05++LaBbUi9D6865UMJWpw+cEnId7lT6KIRMqo1avnuXfYWNiEYc8efnFxT6
         wrXeE8g4PE8yGEbR2FuGO6KI9ye0vTnvEYpulGNnXL3sIsl/0b/wpByCG2dBElGl4hQr
         DSeDpHFRDffE4CVHViz+SwOL7i4V4jY32NhpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iusnW8LyX48emfkYiOdYVBbD1X7DC6XhQSttfD8Gqis=;
        b=WLsQuadHbzyRcngdjRNFx38IcWFevMoitf2PRxbZVt7BFbcImtWhbKIAszX23dlOyQ
         k/NBuubGnz5S4jUkaXxOKopwibrR7soH/EOk9LVkXqU3a4nFCSUUMRdPTrfs+IZKIsds
         YyN8a1iwAMO4dZ7/15svgcBxYvMda3iFgI7uVqhKzvZwQ+t+WM9TquKJ5NXhBMfGMVwo
         cNfCiPAiSmcYju8xQSXtovqnhVbot9+9Q/+11mDoVFp6quYwT/7hY4NX1T/0UoRfpEyQ
         IQXW3414Ve+UhWkw4dOCsOhJZgFehlWabJ1YSLsRd7Fqdaafhw1hCvOVrxr3Wk8Y55bM
         ayeA==
X-Gm-Message-State: AOAM530ARccDuX3Px1ZqM5F6rTTQ4xgSzEhQOfHoi5DGqAHaET2l94ie
        HaxYZFvZB0/+XWNxdooDXzQ+5A==
X-Google-Smtp-Source: ABdhPJz7cJMv3ORC3LX8UqExQ0osjmHKclF9f3qtqX7yiDSwSYdsQXHHtRqFhooHQi+ugi9LIQIgFQ==
X-Received: by 2002:a17:903:2304:b0:13f:2457:11dd with SMTP id d4-20020a170903230400b0013f245711ddmr7173973plh.57.1635016703678;
        Sat, 23 Oct 2021 12:18:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h1sm6921309pfh.118.2021.10.23.12.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 12:18:23 -0700 (PDT)
Date:   Sat, 23 Oct 2021 12:18:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Joe Perches <joe@perches.com>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, Kees Cook <kees@outflux.net>
Subject: Re: [PATCH v2] coccinelle: update Coccinelle entry
Message-ID: <202110231218.45D0EDB@keescook>
References: <alpine.DEB.2.22.394.2110231908290.21613@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2110231908290.21613@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 07:10:06PM +0200, Julia Lawall wrote:
> Update mailing list, website, and tree.  Drop Michal Marek as a
> maintainer, who has not participated in a long time.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
