Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E83F3DB27A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 06:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhG3EtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 00:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233648AbhG3EtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 00:49:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 999BE60F01;
        Fri, 30 Jul 2021 04:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627620506;
        bh=Pp7+dBUFA4aPuj+OQStSsCe/e0+MY3BbuCDuHi9mzb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuJ8XCVsTJi1YUbInAGFJAJ6qlW8Y8ZVHgQm9sNj/iiNOw8jd519gRVHgjLFzvMPV
         FMquW2UMYqqAcl9aq6MsHapzhhNRynXkdq+T3UJdQ0gYS9+wMQY+tnbSxAORmyPXAD
         4kNuNErOLsyYe5Fb+xssSGJs9OfXr8x5pUM3SQhU=
Date:   Fri, 30 Jul 2021 06:48:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     qiaoyanbo_310 <qiaoyanbo_310@163.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] kobject: kobject_add_internal cleanup
Message-ID: <YQOEl0SQY/WpE1dK@kroah.com>
References: <20210727143212.39142-1-qiaoyanbo_310@163.com>
 <YQEtJkPFDWMSAd/C@kroah.com>
 <3be7ce57.62f6.17af280a47f.Coremail.qiaoyanbo_310@163.com>
 <YQK0JuI1w1zsEHeC@kroah.com>
 <54cc7e43.808a.17af32725d9.Coremail.qiaoyanbo_310@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cc7e43.808a.17af32725d9.Coremail.qiaoyanbo_310@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:44:26AM +0800, qiaoyanbo_310 wrote:
> Hi Greg KH,

Sorry, but html email is rejected by the mailing lists.  Please try
again after fixing up your email client, and I will be glad to respond.

thanks,

greg k-h
