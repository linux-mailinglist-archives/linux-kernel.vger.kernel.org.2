Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CEE38103E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhENTFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhENTFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:05:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CFFC061760
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:03:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x188so404591pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWunAqK+FZyoTV2vjU3HeNB9kZQfJxaL+p7FRXpB3v8=;
        b=JBsuXKPLey+XhgBL4O0cJdva2yDe7zLMx/jjM8bSnpRVxLrwz2JcMgo+bObx71S2GS
         cheyla6heHxUN0y0Nfx+LRGrcoXwQ9l5JKZKt37SyBvhyfrW02F62BJPBxUWghGz/REM
         psf5IE5vtuOIlUlEI6YoCQGUvYecvNq4icPpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWunAqK+FZyoTV2vjU3HeNB9kZQfJxaL+p7FRXpB3v8=;
        b=Fb0TSO6OCcS2eYioocSkjenK9AKuc4X8cAAguVDHsUWMSF1Z4WcYIJ7br0utEXK9go
         1k5TdNrseryhttpG4DRwmNdsnC2yyvZ0LG+kNHIbZf6Tj6J9NErvRLZQWjN1w34GbqHc
         CaYBJ5eanqq3bqgMdCAmreAZavyQ9DUVwYLsu0WtW0N6lM9lxhD1dgEpZecPDtSwo8c2
         4mjPGRJMPV0Clg+IfG82nWeQIzgNkeveB5qtCKQHi23XrvwDVphrXmA57dGT0kmjHuf3
         mg0//ifM5gq9IgijRWh3RljY6jYpa15nwhqOS1Bl3OBHwfnoHQWu9X5dwChow66QJKwq
         MASg==
X-Gm-Message-State: AOAM530pjVv8qqFZmxbuuBESuo6FxErZpnU9y3y3lOsrKiqbVghCoat7
        l59wk6ZkczUsTOJw0bJaryH0Kw==
X-Google-Smtp-Source: ABdhPJy/2ssb8xICyRpzUdXDJOa7C5xielVPk0SjlrBIAD2a+w+docVTMCOrVjaCXs6HLij/mumypA==
X-Received: by 2002:a65:6549:: with SMTP id a9mr24482406pgw.213.1621019032283;
        Fri, 14 May 2021 12:03:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c201sm4624403pfc.38.2021.05.14.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:03:51 -0700 (PDT)
Date:   Fri, 14 May 2021 12:03:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v26 07/25] LSM: Use lsmblob in security_secctx_to_secid
Message-ID: <202105141203.60B0435@keescook>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513200807.15910-8-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:07:49PM -0700, Casey Schaufler wrote:
> Change the security_secctx_to_secid interface to use a lsmblob
> structure in place of the single u32 secid in support of
> module stacking. Change its callers to do the same.
> 
> The security module hook is unchanged, still passing back a secid.
> The infrastructure passes the correct entry from the lsmblob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

This looks like sane refactoring into the new blob type.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
