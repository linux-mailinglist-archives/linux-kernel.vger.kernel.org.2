Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3393592A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhDIDKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhDIDKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:10:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96124C061763
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:09:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t22so1720988ply.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 20:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+nMIbA331gZ017Kv1DaJC+x8jGEIptaSKcTZoI0JL0=;
        b=BdwR1wCgFydJCUmPE+JRM63bwWPQb6enrE4kOSOAsyfeDithJlPJ4em7RY+EwKvSiv
         7BGHC59v+Nt0QVRFMvxdUcip3s5wGm9xUwuZxSbxJZqnXUBlrCWxvGIhd+gZJ2WsKl4z
         fbv700bUkw9/yj8+Nyt7n23U0VTczP89QQMfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+nMIbA331gZ017Kv1DaJC+x8jGEIptaSKcTZoI0JL0=;
        b=TcaWTLhXGU4ZGBvRvsjcrh8Y8yPg4xWo/+Nz5jefvYfNEh0VsdULmmNiiPRgimgl4s
         m9l0Qqmc32Q5WLJORBPRuQRrTNGWbfA/x/XFSYB7SbhxUjEqIswm+BTeoQmt8vfIMYnJ
         zoZvd4CbKOICTSXSX+BUIJHRzTzguw1v9IHA4Z9b8ljEcX6SBO2AdFmYX6OP0Ywa+wPx
         cUU4hK+JWQYpVs6U86uCtOgAcd5nomb3TVwIpXlEfuursoKuFqzf/hT8RRVMusKioWeP
         BK3PG3VbCsDEXgIDt8HEAQeXYRD0TKHDeohz1trEeFRDlsY+++UytXHk62DIOGJ8Xfyo
         7YQw==
X-Gm-Message-State: AOAM533o38kV2QH5bVAlMugeuLVRqaU/3NDK5XKTyPZ4kegDcDOZUsW5
        VmGkJy+ekYEAaCa8WzUJqDqBkQ==
X-Google-Smtp-Source: ABdhPJwKBOO9LJs6QqDup2F8LEFV9/9U2LnFQcD0hU8EBR42JzBpo+AZPQAGhoCJ0SS+hywMaacuhw==
X-Received: by 2002:a17:902:d64f:b029:e7:1f02:5741 with SMTP id y15-20020a170902d64fb02900e71f025741mr10668144plh.48.1617937796244;
        Thu, 08 Apr 2021 20:09:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z18sm686667pfa.39.2021.04.08.20.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:09:55 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:09:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: Re: [PATCH 14/20] kbuild: nios2: use common install script
Message-ID: <202104082009.59171B9E0C@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-15-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-15-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:13AM +0200, Greg Kroah-Hartman wrote:
> The common scripts/install.sh script will now work for nios2, all that
> is needed is to add it to the list of arches that do not put the version
> number in the installed file name.
> 
> With that we can remove the nios2-only version of the install script.
> 
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
