Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5763A3831
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFKAEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:04:33 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:45972 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhFKAEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:04:32 -0400
Received: by mail-pf1-f169.google.com with SMTP id d16so2937478pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sYsUMKSvqWPAQ3njdkYH0/qYvO4OJVaPT5aH905diOw=;
        b=exAqhib6DxTrFPGXdsePvOhwiUUyh5beiMu8qUySUe74u9rHyq/6mC8HysGg0BGyDx
         7dRra1A06RnBF85rmQuU3GEsCBt+t9vUzmQOayU6Y2kKSPTWV0N+IO/r7YMm9pUNdRAr
         wqJUZPRDGa5Gn5dlnQxlmxA38mt+tTrqCdQLiU93et2KuIblUKxX9r2VsnnRDt+TcV8S
         RHPyQB22iw4p0HAvojFldKr0ARn5gqZcrQFclZogIiHRP8T+qqvYLUBSNb2epwO2vL4B
         dUY8uXKebw5SH4BBreD3RyTmikcBuzfCukmEsRwb7mX20c+0GMj+Iz1255xsTB3Eo7pi
         aEKg==
X-Gm-Message-State: AOAM533+X3mPsAsiiBkJeCZmESQirOwYR19i3mhcJGYOKgPtXKXb6nPB
        Hml7Fg8UvBqUWLaA35tDGFacWTR23JM=
X-Google-Smtp-Source: ABdhPJwGERVzvf/zi+NZp+EaokN7n+KmmO0lAZ0K5/6iGH+tvis8ItiHDzSNzhcIDrQ4YdqYoc5ZkQ==
X-Received: by 2002:a63:a44:: with SMTP id z4mr808801pgk.379.1623369742095;
        Thu, 10 Jun 2021 17:02:22 -0700 (PDT)
Received: from garbanzo ([173.239.198.56])
        by smtp.gmail.com with ESMTPSA id w63sm3321920pfw.153.2021.06.10.17.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:02:21 -0700 (PDT)
Date:   Thu, 10 Jun 2021 17:02:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: remove unneeded 'comma' macro
Message-ID: <20210611000218.febksto45bandz3m@garbanzo>
References: <20210528173404.169764-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528173404.169764-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 02:34:03AM +0900, Masahiro Yamada wrote:
> Commit 553671b76859 ("firmware_loader: Fix labels with comma for builtin
> firmware") added this line, which was unneeded.
> 
> The macro 'comma' is defined in scripts/Kbuild.include.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
