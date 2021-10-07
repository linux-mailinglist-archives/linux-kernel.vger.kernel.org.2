Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7E7424CB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhJGFZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGFZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:25:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EFBD61053;
        Thu,  7 Oct 2021 05:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633584215;
        bh=OJWLSXs7WMHf5W8p7Um+O8pjpdMLATkfdV9BJF09A88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4bJZR66/3+KLZiTTfuSH0PEuGPh8NzU5/o7ZuB8ALz0IWqOvUHRgX5BF1VzVgbCC
         Bw8upTF0XFaBnNVAPhx6H39Ux1p6mozrl6iKYIcusg2sU6bxqh+4p6WSDpO/3pb0Jv
         RKUoNPS9CJYt4n6HHJIt7srnIebbyxEYbc/O6Hj4=
Date:   Thu, 7 Oct 2021 07:23:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] sysfs: add sysfs_remove_bin_file_self() function
Message-ID: <YV6EVcKUQj5DNiXZ@kroah.com>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007000954.30621-2-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:09:46PM -0700, Zev Weiss wrote:
> This is simply the bin_attribute analog to sysfs_remove_file_self().

No, no binary sysfs file should be triggering a remove.

binary sysfs files are "pass-through-only" from userspace to hardware,
the kernel should not be even knowing what is read/written to them.

What do you think this is needed for?

thanks,

greg k-h
