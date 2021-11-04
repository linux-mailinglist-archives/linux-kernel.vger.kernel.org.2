Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF0444BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhKDAP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhKDAPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:15:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB283C06127A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 17:12:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y4so4075336pfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 17:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aiFlDDoPphFdax8t3+vgi2ejhvKpRDh7/No/Q/VIr2I=;
        b=BAEynWMdMRlkSSJY0srpBlBYJednmmqF1G63NosmIWMc0Q+4AJMFCNhqfAA76CdAnd
         CcNTmdL8gzyOISWADvYFLtFUQ0nGsMVl2CLvzGTVmznszFkr5aNbQy/B8JBL58X3OprP
         WxabcSYcDyX1quSThfoypWjtfjH5u0Eswijcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aiFlDDoPphFdax8t3+vgi2ejhvKpRDh7/No/Q/VIr2I=;
        b=TXbfo2egUgOhSuHEFdIhZU04S/4dmMTYM4EpD9PE+ssGU94WfXMY4Me/AvJd47edmY
         dvIPWcmGwIREtpFT4DzMNQmaxKNdQonJwvqZF1knZhruNwVKbrAZLX85Fmv7vP/K7QZq
         bRlu+8TyxA+KmNy8HuJdw6/8jo9ZFuwrECy8rybpsBQZTgA+UmLWorfBJwqvRHGZFivT
         0aRqgTPYPBA4LbfA9IkwnG1CEh7I9pPbIzKeQi/IctIxs9hkjtDtt1rbR/v2Eb0j/XWv
         VMf0agj6TLMuejvp4HG9IRbNNbBgv0zf7a2muKfR0Pqyae0G4uOPhRvneROa7+y5OrSc
         vvFQ==
X-Gm-Message-State: AOAM533AovneHB5BnfkwvpcvhL0ac+Vemd2YxkBwsGj6IKp1DxxWgQUr
        ROC76KTvzCjLA+ooXKLigngqnQ==
X-Google-Smtp-Source: ABdhPJzBJoVbv76VuMfMN12dqt6obL+TqZohnLnrn1g1oB1WAOtxkRDgcTnQgY3Mdh8HUJU/6MlJ9A==
X-Received: by 2002:a63:8bc3:: with SMTP id j186mr23601334pge.250.1635984768491;
        Wed, 03 Nov 2021 17:12:48 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:1f56:281c:d78b:3f3a])
        by smtp.gmail.com with ESMTPSA id f11sm3831765pfc.116.2021.11.03.17.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 17:12:48 -0700 (PDT)
Date:   Thu, 4 Nov 2021 09:12:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: use ATTRIBUTE_GROUPS
Message-ID: <YYMle7jh+i5j+b5q@google.com>
References: <20211028203600.2157356-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028203600.2157356-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/10/28 13:36), Luis Chamberlain wrote:
> Embrace ATTRIBUTE_GROUPS to avoid boiler plate code.
> This should not introduce any functional changes.
> 

Cc-ing Andrew  (20211028203600.2157356-1-mcgrof@kernel.org)

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
