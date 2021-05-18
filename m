Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0514387F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351468AbhERSR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351374AbhERSRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:17:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E4FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:16:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gm21so5947415pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UAbLkWm6PRRnI0f/YBcd2UnkYh5PZhxMV22HzCqG9iY=;
        b=DPYgBj+73e0pasxsML7im5ea4VAJoi02gipo68L3TdlhW/+DCyAHJXhS4zTX+S/UmD
         OYldY/FtwdF3YjIauraTvd6MIaaRJEO5NcDdYKJ7ZHOSPhf4WE1ejPQKdJu3MKk1mqmw
         mrmDgpypKCYv39mshPjlUt0+3pN/fsv9ZGfw2hctrk0AF5TZtWbbHG/xgkMHg1ffqtwQ
         r3eoXsPm2dvnCzC9E0YSEjSJdLbdUEqeZGp4E//52PBZbmM/glLc4sU6di0HP5WKT43u
         +AtX0ntamTgeoRrfhR85iBx6UhIbug6fKL3O5KsbourHnDQ+SNUcjo2PEgjZHEoCWx9G
         7TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UAbLkWm6PRRnI0f/YBcd2UnkYh5PZhxMV22HzCqG9iY=;
        b=VIUcSYwo+msAC09fPcD2hj7AWkV7+yzY+qIyd5hgl3mbvBagZfzbdRq2W+aPSbEW7V
         DioygK2RZQuQiCY/Z+Rc+GWhR6PDOHmUOqiBK72/rBTPCK9jWo+89u2wij7wZzP1PDsv
         lqgBYr5lPDfp3IxqgeQQ3IYKMya759rvhQkosi2TSvRDNSYYnbmUsvZ8GiUmdZ90F6Mc
         0Ms+WWI1POPYy2HHIYcEOLt0asom7fyTyN5gl7bOvuTLptPX/fJLahNe9W3rEe78oX2P
         H3DJrxibHMjH9n45yXcMohcQWVWSxPRHOO7RclY9/0j/oJJDx6hS+rqGYbBIgAYW2YGp
         KH+w==
X-Gm-Message-State: AOAM531c3gKmrLn9iHEqtEKhyGjasbUW3Av8IT4nBswJcSGJENcZ46Mh
        fvCS6wdPPPG6GwwhncoaryI=
X-Google-Smtp-Source: ABdhPJxQZTyQb9yEfiUPcaNrhsoNeyUUjhYnM3XIGLtrOf1FEQSLr7CoW2xvTyC2aG/dx1W3Bd4Tjg==
X-Received: by 2002:a17:902:c112:b029:f0:d571:b0d2 with SMTP id 18-20020a170902c112b02900f0d571b0d2mr5997817pli.21.1621361795798;
        Tue, 18 May 2021 11:16:35 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id j189sm12851452pfd.21.2021.05.18.11.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:16:35 -0700 (PDT)
Date:   Wed, 19 May 2021 03:16:29 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] mm, slub: Fix support for clang 10
Message-ID: <20210518181629.GA10380@hyeyoo>
References: <20210518181247.GA10062@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518181247.GA10062@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan, Thank you for suggesting the idea and allowing me to write the patch.

it compiled and booted without problem when compiled with gcc-10.2.0,
clang-10.0.1, clang-11.0.0 with x86_64 default config.

Thanks,
Hyeonggon
