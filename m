Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394563185D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBKHpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhBKHpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:45:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D96AE64E25;
        Thu, 11 Feb 2021 07:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613029476;
        bh=GxQpwrHmjZ0outHvupJoP+bBOQB9tALJFiyhoW9Q4VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGOiOZ7nw+eAW/K0qqGoABRBbxcdWvGVGcsbSQ8rOWQNxF7EBlTLdv26pnQGmJLYb
         WR++Ujr/VDBrTkeP3DuXxVjCU9GXYqZtVQWMC1lFdyrqoNDfWDkRj+WeUj0umdVAln
         S5Suq9nVMFXMGHVrXywDbSlB0GWdSoD5PyLghWXk=
Date:   Thu, 11 Feb 2021 08:44:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] driver core: auxiliary bus: Fix calling stage for
 auxiliary bus init
Message-ID: <YCTgYWEAxiBgq3xz@kroah.com>
References: <20210210201611.1611074-1-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210201611.1611074-1-dave.jiang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 01:16:11PM -0700, Dave Jiang wrote:
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Auxiliary Bus");
>  MODULE_AUTHOR("David Ertman <david.m.ertman@intel.com>");

As this code can not be built as a module, can you remove these lines as
well?  I don't think they do anything, and were never needed.

thanks,

greg k-h
