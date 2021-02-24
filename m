Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7688D324078
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhBXPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:06:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235096AbhBXOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:12:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A2A964E7A;
        Wed, 24 Feb 2021 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614175879;
        bh=BpYruk68R6kEq7xF24RrqNtwpV+CW2aJPPDU8jzgAT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zk+epHjJBrdH00f9FVkblXRodT6Lfd8mxT1WJMGWIPy6IYQr7VuAAY1O8pmYZlbq1
         JzSKh1yqqDoR+yc0x/eS76/0Y8CYsZyVeuLPb1HnQXpLbrXcv6TixCRbz/uxppnwMK
         qxBgf344XsL3afsoJduMVjX8gxf64Ssh0OLWyh1A=
Date:   Wed, 24 Feb 2021 15:11:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Lan Zheng (lanzheng)" <lanzheng@cisco.com>
Cc:     "security@kernel.org" <security@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] Kernel Config to make randomize_va_space
 read-only.
Message-ID: <YDZehClJ+FaX9RC4@kroah.com>
References: <99738B18-C4E2-4DBA-A142-8F20650D7ADC@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99738B18-C4E2-4DBA-A142-8F20650D7ADC@cisco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:53:37AM +0000, Lan Zheng (lanzheng) wrote:
> From ba2ec52f170a8e69d6c44238bb578f9518a7e3b7 Mon Sep 17 00:00:00 2001
> 
> From: lanzheng <lanzheng@cisco.com>

<snip>

You are still sending html email, which is rejected by the kernel
mailing lists.

And no need to cc: security@kernel.org, that is only for reporting
security issues, not new kernel changes like this.

good luck!

greg k-h
