Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B50C3CAF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhGOWUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:20:18 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:42987 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhGOWUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:20:17 -0400
Received: by mail-pf1-f173.google.com with SMTP id y4so6906058pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 15:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sYsUMKSvqWPAQ3njdkYH0/qYvO4OJVaPT5aH905diOw=;
        b=hqUf4Ew+JemqjZsjkdWZS2oXlm7uJB7cj09OD9cIN10zf0yKo0+Qz+XajU2XjnHu9A
         P11iLgO9Xhvq2N9RohEBGvIKqv0o0XrXihKTQ/MAUYPEbyBPbis5KwVFsQD9aJIaqCsD
         y4/IqYKHiMnr1dYZSRq9wVCFMcXiXHWaFZjAWinM6opZQ3qWCDwtMsJKOYlOtZ5w40AC
         U2guPznWdWpWmtxEn8/HSmWbZS+yTWDCUtV3uVYYnTZnilNpDlw3MbHlKyNqyaUQl8Ld
         Ezf/6yzmaUEwiWnTnGuuY1WHxK1AdXGoWXnU4RZi3Px4+cbYRifkrzRLLD3x8B9HxmUb
         7lXA==
X-Gm-Message-State: AOAM530YarTmu0WlQlULJO7cDCZes15lWrRGU9dpSlis/oE+SHXq6Rcz
        oQH5i0JBrC4J4JalQOo5W/g=
X-Google-Smtp-Source: ABdhPJw5uqjDSXZUqz2ujuskUTdsL7+2Gg/VqwGr0DHX/VpXqYLLvFbVe9oYGsOHwSm2C3pgvhhUCw==
X-Received: by 2002:aa7:9a4a:0:b029:328:abeb:a339 with SMTP id x10-20020aa79a4a0000b0290328abeba339mr6892476pfj.29.1626387443410;
        Thu, 15 Jul 2021 15:17:23 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id j16sm8034354pfi.165.2021.07.15.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 15:17:22 -0700 (PDT)
Date:   Thu, 15 Jul 2021 15:17:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: remove unneeded 'comma' macro
Message-ID: <20210715221720.y47al7p54ixubjcv@garbanzo>
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
