Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632E435B206
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhDKGhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhDKGhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:37:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF9BF61074;
        Sun, 11 Apr 2021 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618123056;
        bh=tOHvDuMAXXJQXqYCynFIajbrhi0Vc0ah+1ALFrZkLwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNz6/wzjz8nqhPTQ287a+aT47Hdj3k6Q5LTb/gu0/fp3IHA5wrqM2gKgVH1JAIunm
         pNWeWsQ/dETx8Q8pJ7uAToSBiwd538FRHew8aoW6+cHxfHMjclvsASituD2YLOa3Ts
         rcEN4L1FOihF8DMxZlgT+2/astx263k3KRzC6p1o=
Date:   Sun, 11 Apr 2021 08:37:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH v4] staging: rtl8192e: fixed pointer
 error by adding '*'
Message-ID: <YHKZLVJRqgO8ni5e@kroah.com>
References: <YHG8qARLUX2KPWwI@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHG8qARLUX2KPWwI@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 08:26:40PM +0530, Mitali Borkar wrote:
> Fixed pointer error by adding '*' to the function.

That really does not describe this at all.  I'll go fix this up...

greg k-h
