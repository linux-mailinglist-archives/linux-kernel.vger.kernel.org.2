Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D573537BA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 12:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhDDKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 06:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhDDKIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 06:08:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0ED6610CB;
        Sun,  4 Apr 2021 10:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617530885;
        bh=YyFWNQbFjzqQMXREpTHaLfKBIJsSJScF8WfbAhO4hJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reXhkqEHty7WHp9aNF6kuyLl339Ua3ZUmBohwVFOpOXewmXA1eHXdg2uu4zN71AgE
         gxUrXsfLBAJlvgXLUHtqOxDFMMIG4jYWew1MWArbu0zf2HahwaOzdiM4cF4nRYAB0k
         Wj7xrumCgiVReGYhXnQj+h71zuM8P7K6XTvHcct8=
Date:   Sun, 4 Apr 2021 12:08:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arend van Spriel <arend@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix use-after-free in
 debugfs_create_devm_seqfile()
Message-ID: <YGmQAWBN4+uQCIUa@kroah.com>
References: <20210404004504.5547-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404004504.5547-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 07:45:04PM -0500, Samuel Holland wrote:
> This function uses devres to clean up its allocation, but it never removes the
> file referencing that allocation. This causes a use-after-free and an oops if
> the file is accessed after the owning device is removed.

What in-kernel user of this is having this problem?

The driver should clean up the debugfs file, it is not the debugfs
core's job to auto-remove the file.

The resource is what is being cleaned up by the devm usage in debugfs,
that's all, not the file.

Please fix up the driver that is creating the file but then not removing
it.

thanks,

greg k-h
