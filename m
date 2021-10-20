Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162704348C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhJTKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTKRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:17:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3F0361260;
        Wed, 20 Oct 2021 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634724935;
        bh=TBXK+5pXDxxF4rKwtXGrGQl+CTmrlwmLpTHbFPsrUwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtN249TpUD4Rdfj1BqqM7zJg5ZuWvDq0BMVUV83o4MFQ9l37QALdsP9CyW4+TjQsQ
         Rmgf4fZrWD+LXcEv/hXegPSjMepq5J170PQw2IGAGQgFjbbJW2BmPLGgSf4/nsf6mj
         /4/VXTlifVUjMHfGfQ2z6Ssj/yv4ZJGm6fJvXaQzHT6kJlij5vis7dLYFYL/LB3Z/Z
         Q0mRWMnUl5Tm6+VvsjH2WfsLTOytQW1lidq32HKwTMGttO2Q9Q3AY62d3uS76KHfvt
         HUoh04bo2motNjJGSfqw+FcWO+RsMQniO8Djp7Llj3jbLOei6v3YHJr60PFF0Hdkvg
         cWbNBosjHoRMg==
Date:   Wed, 20 Oct 2021 12:15:31 +0200
From:   Simon Horman <horms@kernel.org>
To:     cgel.zte@gmail.com
Cc:     dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] crash_dump: fix boolreturn.cocci warning
Message-ID: <20211020101531.GA22371@kernel.org>
References: <20211020083905.1037952-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020083905.1037952-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 08:39:05AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> ./include/linux/crash_dump.h: 119: 50-51: WARNING: return of 0/1 in
> function 'is_kdump_kernel' with return type bool
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Reviewed-by: Simon Horman <horms@kernel.org>
