Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8D3191BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhBKSAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:00:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232330AbhBKRdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:33:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2963E64E79;
        Thu, 11 Feb 2021 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613064739;
        bh=g3aDZrIhmyhz9ptKOHtOl4NL3Bblw7qxcTfasIsoh30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/r3cSUs1tC8TZsEboRMkhVYJZXY0Eau/j2v6it9Vsl5JpJuiHi54gAKWK4hg0Jvn
         DSKiZWnGOX5Xsb3/rbz+nyAfOanoAlDAbtsKTM+E2obrQ+cK5JvDYeb0xvQLkxdP0N
         hJYFPqIMP5gA/toAdvYsRzEcp+Tbb249BeDKK2os=
Date:   Thu, 11 Feb 2021 18:32:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] coresight: Patches for v5.12 (part 2)
Message-ID: <YCVqGYwyw3zlAebK@kroah.com>
References: <20210211172038.2483517-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211172038.2483517-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 10:20:35AM -0700, Mathieu Poirier wrote:
> Good morning,
> 
> My previous submission had the wrong baseline and as such was missing a patch.
> This set applies properly on [1].

Much better, thanks, now queued up.

greg k-h
