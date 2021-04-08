Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD7357CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhDHGlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhDHGlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:41:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A41261139;
        Thu,  8 Apr 2021 06:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617864072;
        bh=MGM3GA2UhFPlTglyNRnEfcAx8khpllAl806BLf2kZew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctmW25pg2AhGIYpWlPQGWCUYImFRCj7g61Z9V1Vk87qW8HI3QYKKg0OS4ecyqoHYw
         OffpLh2sPKFZvmepGS7kAgaYNufQYBQlYREcr1LkB9cKqGFfRqemhp1p3FzOgCNn6F
         RJs8lBJRrld7Ow6gIRxXjwENhyGwQhye4NuYue/g=
Date:   Thu, 8 Apr 2021 08:41:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] driver core: Add dev_set_drv_sync_state()
Message-ID: <YG6lhT7vuiCNvvDg@kroah.com>
References: <20210407034456.516204-1-saravanak@google.com>
 <20210407034456.516204-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407034456.516204-2-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 08:44:54PM -0700, Saravana Kannan wrote:
> This can be used by frameworks to set the sync_state() helper functions
> for drivers that don't already have them set.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
