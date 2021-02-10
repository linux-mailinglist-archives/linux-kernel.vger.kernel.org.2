Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0D316FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhBJTTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:19:16 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:38728 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhBJTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:19:02 -0500
Received: by mail-pf1-f169.google.com with SMTP id d26so1917126pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ApR99pDrW0uAH2QCJrOY4mI9PKbNjGr+XzltIVVOrH0=;
        b=PMSDa2kbSxgh4N/wIHtKZWzfYUOGthnQoHPZ6H3CCt0B+CPP3zi6FYSSCZddW69yo8
         oSl/xNORIWJX1yXejC7bVNNb8uT8dRqmLlivVxxkJm1e66flf2qe8FXvN0OGSAZTMlJE
         pgyZiWQF5x3uJAUHY8lonhT/SNqvy+1cdhchOQpr7efTY9XWOyEjo5uBweQjZ9yiddjU
         RHktbdz0+vpCcKOShWf0p9kZvVfQmAbcPcUyUULgGm/kjNUWC2InphFl/LdjN683lrWP
         vblpdVd+EK4DUUCpnUs1+tiDIEd42qfYigrJqW2HXlzk3/kwc4oob5oAyOQMsP8VPWak
         zSqw==
X-Gm-Message-State: AOAM531QKEwQAU49j3BTUOBCEcmFWDkA2m7chDdiAtdFQzZHcrq82B2W
        GrhlQQmStDtIYPQBMzCyCmM=
X-Google-Smtp-Source: ABdhPJwkC3L69KJkl7AP00x+IiPAZ4VJSYzZaVpUK9qBrgTzg2ejJvJWOHTNUKAIwuZl13eWtkGLrA==
X-Received: by 2002:a62:2702:0:b029:1d1:b92a:ef2a with SMTP id n2-20020a6227020000b02901d1b92aef2amr4379607pfn.5.1612984701793;
        Wed, 10 Feb 2021 11:18:21 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.38])
        by smtp.gmail.com with ESMTPSA id g17sm3283647pfq.135.2021.02.10.11.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:18:21 -0800 (PST)
Date:   Thu, 11 Feb 2021 00:48:16 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix function comments to follow
 kernel-doc
Message-ID: <YCQxeMVM92dtfEpO@karthik-strix-linux.karthek.com>
References: <YCQvl3+KviQNh2JI@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQvl3+KviQNh2JI@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check this out
