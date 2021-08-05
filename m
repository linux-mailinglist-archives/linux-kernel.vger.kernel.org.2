Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4F3E1398
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbhHELLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240712AbhHELLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:11:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E076610FF;
        Thu,  5 Aug 2021 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628161894;
        bh=H7Gfg1h2kqOSCtljjCenctXs9o/KyG2TYbz/k0+uHlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1EN7yDioncoECmYcGjLBeF3frrYI7C2/+xtWZ9LMPHolC7r0tgSFmJ+iYMaz70+i
         8d6zQTnm1aekNwdo6vsHgS3p9fXE6KzwFLPMlFXHU02DdyUb5OCQ+nHFEUeSjJErmp
         FbbFSdX+N0LGN9tr4Af0nNwr4XGtJXT9XYGxqtIs=
Date:   Thu, 5 Aug 2021 13:11:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 0/4] staging: r8188eu: Fix clang warnings
Message-ID: <YQvHY88v5X/tzLpn@kroah.com>
References: <20210803223609.1627280-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803223609.1627280-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 03:36:05PM -0700, Nathan Chancellor wrote:
> This series cleans up all of the clang warnings that I noticed with
> x86_64 allmodconfig on the current staging-next. This has been build
> tested with both clang and gcc with x86_64 allmodconfig.

Can you rebase on my staging-testing branch and resend this series?
There is a lot of churn in this driver right now, and your series does
not apply anymore.

thanks,

greg k-h
