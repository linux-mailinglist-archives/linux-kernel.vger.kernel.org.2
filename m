Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C218316FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhBJTU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:20:27 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:37530 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhBJTUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:20:16 -0500
Received: by mail-pj1-f54.google.com with SMTP id t2so1731689pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1NYKRTvAN3DT6BY7g4xrc4D6eus62Tfv/hC6A6biJHY=;
        b=sSm65AmO1lJJ6+yICJdGa5IcFA22FQNUbqj0zO1Ky2tDINS0JSN/zDfkodE3Rc5bir
         v8rc/3zgg3tAfesE0AbF4kmlb7ola9zoARRwdTgFdusIjFqSJ7f1v/E7Sd1D9pAtevrk
         6/fo6NXknt1zBPi1LDT/ovcV38VtDyC3DrFWUwCKUzTZvRL6dIP2TSg9MKUvevYFq+Yd
         2Uo8j3he2neNOZxGn87pL64WQench4I2ikVG7J4/XKEBdNx7SmmcFFYe2ffyST+xlAf2
         kPRMR3S1ORVHiGb8w0ExeydJ2I+wL6S0ixWAhO6inZ5cZh4xRAQTXeC17/XFRjjKLuqH
         Dm6A==
X-Gm-Message-State: AOAM530n1RB5PzCDJ5OKnsrcp3g56zlfu2j8+v0iA0ZBMzx+f98FnvWR
        3wiuns2QZczTqsjz+m3vvIQ=
X-Google-Smtp-Source: ABdhPJwdbe31MNFtu0tdkA0sU1KZrblEEOUigDFXW1ByxSVgvKys89Od9lGUc/yw0lXBQgORvbYSDg==
X-Received: by 2002:a17:902:8342:b029:e1:1465:4bf0 with SMTP id z2-20020a1709028342b02900e114654bf0mr4348963pln.76.1612984775802;
        Wed, 10 Feb 2021 11:19:35 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.38])
        by smtp.gmail.com with ESMTPSA id v19sm2832369pjg.50.2021.02.10.11.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:19:35 -0800 (PST)
Date:   Thu, 11 Feb 2021 00:49:30 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: rtl8723bs: remove obsolete commented out code
Message-ID: <YCQxwl6yfHGeDrAn@karthik-strix-linux.karthek.com>
References: <YCQvsdlnbnQN4Ruf@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQvsdlnbnQN4Ruf@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey dan,
check this out too
